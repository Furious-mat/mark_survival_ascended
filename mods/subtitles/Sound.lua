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


--- Provides the Sound class, which represents a playing sound effect.


local ORIGIN = vector.new(0, 0, 0);


--- Represents a playing sound effect.
-- Sound objects should be treated as immutable, as they are shared between
-- all players.
-- @type Sound
subtitles.Sound = subtitles.Object:extend();

--- Constructor.
-- @param spec The sound's SimpleSoundSpec, as a table or string.
-- @param parameters The sound's parameters, or nil.
-- @param handle The sound's numeric handle, or nil if the sound is ephemeral.
function subtitles.Sound:new(spec, parameters, handle)
    if type(spec) == 'string' then
        spec = {name = spec};
    end;
    self.spec = spec or {};
    self.parameters = table.copy(parameters or {});
    self.handle = handle;
    self.ephemeral = not handle;

    local params = subtitles.registered_parameters[self:get_name()];
    if params then
        for key, value in pairs(params) do
            self.parameters[key] = self.parameters[key] or value;
        end;
    end;
end;

--- Checks which players the sound is audible to.
-- @return A sequence of player ObjectRefs.
function subtitles.Sound:get_players()
    if self.parameters.to_player then
        return {minetest.get_player_by_name(self.parameters.to_player)};
    elseif self.parameters.exclude_player then
        local players = {};
        for __, player in ipairs(minetest.get_connected_players()) do
            if player:get_player_name() ~= self.parameters.exclude_player then
                table.insert(players, player);
            end;
        end;
        return players;
    else
        return minetest.get_connected_players();
    end;
end;

--- Checks if this sound is within the player's range.
-- @param player The player's ObjectRef.
-- @return true if the sound is in range.
function subtitles.Sound:is_in_range_of_player(player)
    local sound_pos = self:get_pos();
    if not sound_pos then
        return true;
    end;
    local distance = vector.distance(player:get_pos(), sound_pos);
    return distance <= self:get_max_distance();
end;

--- Returns the sound's maximum subtitle distance.
-- @return The maximum distance in metres.
function subtitles.Sound:get_max_distance()
    return tonumber(self.parameters.max_subtitle_distance)
        or tonumber(self.parameters.max_hear_distance)
        or subtitles.DEFAULT_MAX_HEAR_DISTANCE;
end;

--- Returns the sound's expected duration
-- @return The duration in seconds.
function subtitles.Sound:get_duration()
    local duration = tonumber(self.parameters.subtitle_duration)
                  or tonumber(self.parameters.duration)
                  or tonumber(self.spec.subtitle_duration)
                  or tonumber(self.spec.duration);
    if duration then
        return duration;
    end;

    if not self.parameters.loop then
        return subtitles.DEFAULT_DURATION;
    end;

    return nil;
end;

--- Returns the sound's description.
-- @return A human-readable description string.
function subtitles.Sound:get_description()
    -- Description specified in spec or parameters:
    local desc = self.parameters.subtitle
              or self.parameters.description
              or self.spec.subtitle
              or self.spec.description;
    if desc then
        return desc;
    end;

    -- Registered description associated with sound name:
    desc = subtitles.registered_descriptions[self:get_name()];
    if desc then
        return desc;
    end;

    -- Fallback — just show the technical name:
    local name = self:get_name();
    subtitles.report_missing(name);
    return '<' .. name .. '>';
end;

--- Returns the sound's technical name.
-- @return A sound name string.
function subtitles.Sound:get_name()
    return self.spec.name or '';
end;

--- Calculates the sound's current position.
-- This may change if the sound is attached to an object.
-- @return An absolute position vector.
function subtitles.Sound:get_pos()
    local pos;
    if self.parameters.object then
        local object_pos = self.parameters.object:get_pos();
        if object_pos then
            self.last_object_pos = object_pos;
        else
            object_pos = self.last_object_pos;
        end;
        pos = object_pos or ORIGIN;
    end;
    if self.parameters.pos then
        pos = vector.add((pos or ORIGIN), self.parameters.pos);
    end;
    return pos;
end;

--- Returns the sound's position from the player's perspective.
-- @param player The player's ObjectRef.
-- @return A vector relative to the player's position and rotation.
function subtitles.Sound:get_relative_pos_for_player(player)
    local pos = self:get_pos();
    if not pos then
        return nil;
    end;

    local player_pos = player:get_pos();
    local player_yaw = player:get_look_horizontal() or 0.0;
    pos = vector.subtract(pos, player_pos)
    pos = vector.rotate(pos, vector.new(0, -player_yaw, 0));
    return pos;
end;

--- Returns the key to use for merging this sound with other sounds.
-- Multiple sounds with the same merge key will be merged into a single
-- subtitle.
-- @return A table key, or nil to not merge.
function subtitles.Sound:get_merge_key()
    local key = self.parameters.merge_subtitle
             or self.spec.merge_subtitle;
    if key == true then
        return self:get_name();
    elseif key then
        return key;
    end;

    if self.ephemeral then
        return self:get_name();
    end;

    return nil;
end;

--- Checks if this sound should be exempt from subtitles.
-- @return true to disable the subtitle.
function subtitles.Sound:is_exempt()
    return self.spec.no_subtitle
        or self.parameters.no_subtitle
        or self:get_name() == ''
        or self:get_description() == '';
end;

--- Checks if this sound is dynamically positioned (attached to an object).
-- @return true if the sound is dynamic.
function subtitles.Sound:is_dynamic()
    return self.params.object ~= nil;
end;
