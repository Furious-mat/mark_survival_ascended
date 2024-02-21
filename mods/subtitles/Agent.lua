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


--- Provides the Agent class, which represents a player.


local S = subtitles.S;


local function toboolean(value)
    if value then
        return true;
    else
        return false;
    end;
end;


--- Represents a player.
-- Each player gets one Agent object.
-- @type Agent
subtitles.Agent = subtitles.Object:extend();

--- Constructor.
-- @param username The name of the player.
function subtitles.Agent:new(username)
    self.username = username;

    self.display = nil;

    self:load_settings();
end;

--- Loads settings from the player's metadata.
function subtitles.Agent:load_settings()
    local player = self:get_player();
    if not player then
        return;
    end;
    local meta = player:get_meta();

    self._enabled = subtitles.util.get_meta_bool(meta, 'subtitles:enabled', subtitles.settings.default_enable);
    self._footsteps = subtitles.util.get_meta_bool(meta, 'subtitles:footsteps', true);
    self._display_name = meta:get('subtitles:display');
end;

--- Returns the player's ObjectRef, or nil if the player has disconnected.
-- @return An ObjectRef or nil.
function subtitles.Agent:get_player()
    return minetest.get_player_by_name(self.username);
end;

--- Returns the user's currently active display object.
-- This creates the display if necessary.
-- @return A SubtitleDisplay object.
function subtitles.Agent:get_display()
    if not self.display then
        self.display = self:create_display();
    end;
    return self.display;
end;

--- Creates a display object according to the user's current preferences.
-- @return A SubtitleDisplay object.
function subtitles.Agent:create_display()
    local display_name = self:get_display_name();
    local display_type = subtitles.SubtitleDisplay.get_by_name(display_name) or subtitles.CornerSubtitleDisplay;
    return display_type(self.username);
end;

--- Checks if the player has subtitles enabled.
-- @return true if subtitles are enabled.
function subtitles.Agent:get_enabled()
    return self._enabled;
end;

--- Enables or disables subtitles for the player.
-- @param enabled true to enable, or false to disable.
function subtitles.Agent:set_enabled(enabled)
    enabled = toboolean(enabled);
    self._enabled = enabled;

    local player = self:get_player();
    if not player then
        return;
    end;

    local meta = player:get_meta();
    subtitles.util.set_meta_bool(meta, 'subtitles:enabled', enabled);

    if not enabled then
        if self.display then
            self.display:destroy();
            self.display = nil;
        end;
    end;
end;

--- Toggles subtitles on/off.
function subtitles.Agent:toggle_enabled()
    self:set_enabled(not self:get_enabled());
end;


--- Checks if footsteps are enabled for this player.
-- @return true if footsteps are enabled.
function subtitles.Agent:get_footsteps_enabled()
    return self._footsteps;
end;


--- Enables or disables footsteps for the player.
-- @param enabled true to enable, or false to disable.
function subtitles.Agent:set_footsteps_enabled(enabled)
    enabled = toboolean(enabled);
    self._footsteps = enabled;

    local player = self:get_player();
    if not player then
        return;
    end;

    local meta = player:get_meta();
    subtitles.util.set_meta_bool(meta, 'subtitles:footsteps', enabled);
end;


--- Toggles the footsteps enabled state on/off.
function subtitles.Agent:toggle_footsteps_enabled()
    self:set_footsteps_enabled(not self:get_footsteps_enabled());
end;


--- Returns the player's selected display name.
-- @return A display name string.
function subtitles.Agent:get_display_name()
    return self._display_name or subtitles.DEFAULT_DISPLAY_NAME;
end;

--- Sets the player's display type.
-- This recreates the display if necessary.
-- @param name A display name string.
function subtitles.Agent:set_display_name(name)
    assert(subtitles.SubtitleDisplay.get_by_name(name), ('Invalid display mode: ‘%s’.'):format(name));

    self._display_name = name;

    if self.display and self.display.NAME ~= name then
        self.display:destroy();
        self.display = nil;
    end;

    local player = self:get_player();
    if player then
        local meta = player:get_meta();
        meta:set_string('subtitles:display', name);
    end;
end;

--- Detects footsteps around the player and simulates sound effects.
function subtitles.Agent:handle_footsteps()
    if not (self:get_enabled() and self:get_footsteps_enabled()) then
        return;
    end;

    local player = self:get_player();
    if not player then
        return;
    end;

    local display = self:get_display();
    local player_pos = player:get_pos();
    local objects = minetest.get_objects_inside_radius(player_pos, subtitles.FOOTSTEP_HEAR_DISTANCE);
    for __, object in ipairs(objects) do
        if subtitles.util.object_is_walking(object) and object:get_properties().makes_footstep_sound then
            local feet_pos = subtitles.util.get_feet_pos(object);
            local under = minetest.get_node(vector.add(feet_pos, vector.new(0, -0.25, 0)));
            local above = minetest.get_node(vector.add(feet_pos, vector.new(0,  0.25, 0)));
            local spec = subtitles.util.get_node_sound(above.name, 'footstep')
                      or subtitles.util.get_node_sound(under.name, 'footstep');
            if spec then
                local params =
                {
                    to_player         = player;
                    max_hear_distance = subtitles.FOOTSTEP_HEAR_DISTANCE;
                    duration          = subtitles.FOOTSTEP_DURATION;
                    pos               = feet_pos;
                };
                local sound = subtitles.Sound(spec, params, nil);
                display:handle_sound_play(sound);
            end;
        end;
    end;
end;

--- Called every game tick.
-- @param dtime Seconds since this method was last called.
function subtitles.Agent:step(dtime)
    if self.display then
        self.display:step(dtime);
    end;
end;

--- Shows an introduction message to the player.
function subtitles.Agent:show_intro()
    local command = minetest.colorize('#FFFFBF', '/subtitles');
    local message = S('Subtitles are available on this server. Type ‘@1’ to manage your preferences.', command);
    minetest.chat_send_player(self.username, message);
end;

--- Called when the player first joins.
function subtitles.Agent:on_first_join()
    if subtitles.settings.show_introduction and not minetest.is_singleplayer() then
        self:show_intro();
    end;
end;

--- Called when the player leaves the game.
function subtitles.Agent:on_leave()
    if self.display then
        self.display:destroy();
    end;
end;
