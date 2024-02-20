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


--- Provides the WaypointSubtitleDisplay class, which displays subtitles floating in the world.


local S = subtitles.S;


--- Displays subtitles floating in the world.
-- @type WaypointSubtitleDisplay
subtitles.WaypointSubtitleDisplay = subtitles.SubtitleDisplay:extend();

subtitles.WaypointSubtitleDisplay.NAME        = 'waypoint';
subtitles.WaypointSubtitleDisplay.ICON        = 'subtitles_mode_waypoint.png';
subtitles.WaypointSubtitleDisplay.TITLE       = S'Floating text in world';
subtitles.WaypointSubtitleDisplay.DESCRIPTION = S'Displays subtitles floating in 3D space.';

subtitles.WaypointSubtitleDisplay.ASCEND_SPEED = 0.25;

function subtitles.WaypointSubtitleDisplay:init()
    self.hud_ids = {};
end;

function subtitles.WaypointSubtitleDisplay:add_sound(sound)
    local player = self:get_player();
    if not player then
        return;
    end;

    local pos = sound:get_pos() or player:get_pos();

    local hud =
    {
        hud_elem_type = 'waypoint';
        name          = sound:get_description();
        precision     = 0;
        number        = 0xFFFFFF;
        world_pos     = pos;
        offset        = {x = 0, y = 0};
        alignment     = {x = 0, y = 0};
    };

    local hud_id = player:hud_add(hud);
    self.hud_ids[sound] = hud_id;
end;

function subtitles.WaypointSubtitleDisplay:remove_sound(sound)
    local hud_id = self.hud_ids[sound];
    if hud_id then
        self.hud_ids[sound] = nil;
        local player = self:get_player();
        if player then
            player:hud_remove(hud_id);
        end;
    end;
end;

function subtitles.WaypointSubtitleDisplay:step(dtime)
    local player = self:get_player();
    if not player then
        return;
    end;

    for sound, hud_id in pairs(self.hud_ids) do
        local hud = player:hud_get(hud_id);
        if hud then
            local pos = vector.add(hud.world_pos, vector.new(0, dtime * self.ASCEND_SPEED, 0));
            player:hud_change(hud_id, 'world_pos', pos);
        end;
    end;
end;

subtitles.WaypointSubtitleDisplay:register();
