--[[
    Subtitles — adds subtitles to Minetest.

    Copyright © 2022‒2023, Silver Sandstone <@SilverSandstone@craftodon.social>

    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the "Software"),
    to deal in the Software without restriction, including without limitation
    the rights to use, copy, modify, merge, publish, distribute, sublicense,
    and/or sell copies of the Software, and to permit persons to whom the
    Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
    THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
    DEALINGS IN THE SOFTWARE.
]]


--- Provides the BaseTextSubtitleDisplay class, a base class for subtitle displays using text HUDs.



local S = subtitles.S;


--- A base class for subtitle displays using text HUDs.
-- @type BaseTextSubtitleDisplay
subtitles.BaseTextSubtitleDisplay = subtitles.SubtitleDisplay:extend();

subtitles.BaseTextSubtitleDisplay.DYNAMIC = true;

function subtitles.BaseTextSubtitleDisplay:init()
    self.entries_by_slot  = {};
    self.entries_by_sound = {};
    self.entries_by_merge = {};

    self.margin    = 56;
    self.size      = {x = 360, y = 40};
    self.font_size = 2.0;
    self.style     = subtitles.util.TextStyle.REGULAR;
    self.position  = {x = 1, y = 1};
    self.alignment = {x = 0, y = -1};
    self.z_index   = 100;
    self.spacing   = 0;
    self.direction = -1;
    self.offset    = {x = 0, y = 0};
end;

function subtitles.BaseTextSubtitleDisplay:add_sound(sound)
    local player = self:get_player();
    if not player then
        return;
    end;

    local merge_key = sound:get_merge_key();
    local entry = merge_key and self.entries_by_merge[merge_key];
    if entry then
        entry:ref();
    else
        local slot = self:get_free_slot();
        entry = self.Entry(self, sound, slot);
        entry:show();
        self.entries_by_slot[slot]   = entry;
    end;
    self.entries_by_sound[sound] = entry;
    if merge_key then
        self.entries_by_merge[merge_key] = entry;
    end;
end;

function subtitles.BaseTextSubtitleDisplay:remove_sound(sound)
    local entry = self.entries_by_sound[sound];
    if not entry then
        return;
    end;
    entry:unref();
    self.entries_by_sound[sound] = nil;
end;

function subtitles.BaseTextSubtitleDisplay:update_sound(sound)
    local entry = self.entries_by_sound[sound];
    if not entry then
        return;
    end;
    local player = self:get_player();
    if not player then
        return;
    end;
    entry.relative_pos = sound:get_relative_pos_for_player(player);
    entry:show();
end;

--- Removes a subtitle entry.
-- @param entry The `Entry` object to remove.
function subtitles.BaseTextSubtitleDisplay:remove_entry(entry)
    self.entries_by_slot[entry.slot] = nil;
    local merge_key = entry.sound:get_merge_key();
    if merge_key then
        self.entries_by_merge[merge_key] = nil;
    end;
end;

--- Returns the next available slot.
-- @return The slot index, starting from 1.
function subtitles.BaseTextSubtitleDisplay:get_free_slot()
    local slot = 0;
    while self.entries_by_slot[slot] do
        slot = slot + 1;
    end;
    return slot;
end;

--- Generates the HUDs to display a subtitle entry.
-- @param entry The `Entry` object.
-- @return A table of {hud_key1 = hud_def1, hud_key2 = hud_def2}.
--         HUD keys can be strings or integers.
-- @abstract
function subtitles.BaseTextSubtitleDisplay:get_huds(entry)
    error('Not implemented.');
end;

--- Returns the default properties for a HUD for the specified entry.
-- @param entry An `Entry` object.
-- @return A partial HUD definition.
function subtitles.BaseTextSubtitleDisplay:get_hud_defaults(entry)
    local hud = {};
    hud.position  = self.position;
    hud.alignment = self.alignment;
    hud.z_index   = self.z_index;
    hud.direction = subtitles.util.HUDDirection.LEFT_TO_RIGHT;
    return hud;
end;


--- Represents a single subtitle.
-- @type BaseTextSubtitleDisplay.Entry
subtitles.BaseTextSubtitleDisplay.Entry = subtitles.Object:extend();

--- Constructor.
-- @param display The `SubtitleDisplay` object.
-- @param sound The `Sound` object.
-- @param slot The integer subtitle slot.
function subtitles.BaseTextSubtitleDisplay.Entry:new(display, sound, slot)
    self.display = display;
    self.sound   = sound;
    self.slot    = slot;

    self.ref_count = 1;
    self.huds = {};
    self.hud_ids = {};
    self.hud_defaults = self.display:get_hud_defaults(self);
    self.relative_pos = self.sound:get_relative_pos_for_player(self.display:get_player());
    self.max_fade_distance = self.sound:get_max_distance() / 2;
end;

--- Shows or updates the subtitle.
function subtitles.BaseTextSubtitleDisplay.Entry:show()
    local player = self.display:get_player()
    if not player then
        return;
    end;

    local huds = self.display:get_huds(self);
    for key, hud in pairs(huds) do
        local old_hud = self.huds[key];
        if old_hud then
            local hud_id = self.hud_ids[key];
            subtitles.util.update_hud(player, hud_id, old_hud, hud);
        else
            hud = subtitles.util.update({}, self.hud_defaults, hud);
            self.hud_ids[key] = player:hud_add(hud);
        end;
        self.huds[key] = hud;
    end;
end;

--- Hides the subtitle.
function subtitles.BaseTextSubtitleDisplay.Entry:hide()
    local player = self.display:get_player();
    if player then
        for __, hud_id in pairs(self.hud_ids) do
            player:hud_remove(hud_id);
        end;
    end;
    self.hud_ids = {};
    self.huds = {};
end;

--- Gets the entry's offset based on its slot.
-- @return A table of {x: integer, y: integer}.
function subtitles.BaseTextSubtitleDisplay.Entry:get_offset()
    local base = self.display.offset;
    local offset =
    {
        x = base.x;
        y = base.y + (self.slot - 1) * (self.display.size.y + self.display.spacing) * self.display.direction;
    };
    if self.display.direction < 0 then
        offset.y = offset.y - self.display.size.y;
    end;
    return offset;
end;

--- Returns a shade representing the distance of the sound from the player.
-- @return A number from 0.0 to 1.0.
function subtitles.BaseTextSubtitleDisplay.Entry:get_distance_shade()
    local distance = 0.0;
    if self.relative_pos then
        distance = vector.length(self.relative_pos);
    end;
    local shade = 1.0 - distance / self.max_fade_distance;
    return subtitles.util.clamp(shade, 0.0, 1.0);
end;

--- Calculates which direction the sound is in from the player's perspective, and how far.
-- @return A number from -1.0 (far left) to 1.0 (far right).
function subtitles.BaseTextSubtitleDisplay.Entry:get_pan()
    local rel_pos = self.relative_pos;
    if (not rel_pos) or vector.length(rel_pos) < 1.0 then
        return 0.0;
    end;

    return vector.normalize(rel_pos).x;
end;

--- Increases the entry's reference count.
function subtitles.BaseTextSubtitleDisplay.Entry:ref()
    self.ref_count = self.ref_count + 1;
end;

--- Decreases the entry's reference count, possibly removing it.
function subtitles.BaseTextSubtitleDisplay.Entry:unref()
    self.ref_count = self.ref_count - 1;
    if self.ref_count <= 0 then
        self:hide()
        self.display:remove_entry(self);
    end;
end;
