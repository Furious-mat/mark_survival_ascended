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


--- Generic utility functions.


local S = subtitles.S;


subtitles.util = {};


--- An enumerator of HUD directions.
subtitles.util.HUDDirection =
{
    LEFT_TO_RIGHT = 0;
    RIGHT_TO_LEFT = 1;
    TOP_TO_BOTTOM = 2;
    BOTTOM_TO_TOP = 3;
};

--- A bitfield of HUD text styles.
subtitles.util.TextStyle =
{
    REGULAR   = 0;
    BOLD      = 1;
    ITALIC    = 2;
    MONOSPACE = 4;
};


local NODE_SOUND_DEFAULTS = {dig = '__group'};
local DIG_GROUPS = {'cracky', 'choppy', 'crumbly', 'snappy', 'fleshy', 'oddly_breakable_by_hand', 'dig_immediate'};


--- Returns the sound spec for a particular action on a node.
-- @param name The name of the node.
-- @param keys A key in the sounds table, such as 'dig' or 'footstep', or a list of such keys.
-- @return A SimpleSoundSpec or `nil`.
function subtitles.util.get_node_sound(name, keys)
    if type(keys) == 'string' then
        keys = {keys};
    end;

    local def = minetest.registered_nodes[name] or {};
    local sounds = def.sounds or {};

    for __, key in ipairs(keys) do
        local sound = sounds[key] or NODE_SOUND_DEFAULTS[key];
        if sound == '__group' then
            sound = subtitles.util.get_dig_sound_for_groups(def.groups or {});
        end;
        if sound then
            return sound;
        end;
    end;

    return nil;
end;


--- Decides which sounds to use for a node with the specified groups.
-- @param groups A group table.
-- @return A SimpleSoundSpec or `nil`.
function subtitles.util.get_dig_sound_for_groups(groups)
    local best_group = nil;
    local best_score = 0;
    for __, group in ipairs(DIG_GROUPS) do
        local score = groups[group] or 0;
        if score > best_score then
            best_group = group;
            best_score = score;
        end;
    end;

    if best_score <= 0 or not best_group then
        return nil;
    end;

    return {name = 'default_dig_' .. best_group, gain = 0.5};
end;


--- Describes how a player was damaged.
-- @param reason A damage reason table, as passed to on_player_hp_change callbacks.
-- @return A human-readabable description
function subtitles.util.describe_damage(reason)
    if reason.type == 'fall' then
        return S'Hits ground';
    elseif reason.type == 'punch' then
        return S'Punched';
    elseif reason.type == 'drown' then
        return S'Drowning';
    else
        return S'Person hurts';
    end;
end;


--- Updates a table, overriding existing keys.
-- @param tbl The table to update.
-- @param ... Any number of additional tables to update from.
-- @return A reference to the original table.
function subtitles.util.update(tbl, ...)
    for __, updates in ipairs{...} do
        for key, value in pairs(updates) do
            tbl[key] = value;
        end;
    end;
    return tbl;
end;


--- Checks if a player or entity is moving at walking speed.
-- This function does not check if the object is on ground.
-- @param objref An ObjectRef.
-- @return true if the object is moving at walking speed.
function subtitles.util.object_is_walking(objref)
    -- Check controls:
    local controls = objref:get_player_control();
    if controls.sneak then
        return false;
    elseif (not minetest.features.direct_velocity_on_players) and (controls.up or controls.down or controls.left or controls.right) then
        return true;
    end;

    -- Check velocity:
    local velocity = objref:get_velocity();
    return velocity and vector.length(velocity) >= 0.99;
end;


--- Returns the position of an object's feet based on its collision box.
-- @param objref A player or entity.
-- @return An absolute position vector.
function subtitles.util.get_feet_pos(objref)
    local pos = objref:get_pos();
    local properties = objref:get_properties();
    return vector.add(pos, vector.new(0, properties.collisionbox[2], 0));
end;


--- Updates a HUD, only settings attributes that have changed.
-- @param player A player ObjectRef.
-- @param hud_id The id of the HUD to update.
-- @param old_def The old HUD definition table.
-- @param new_def The new HUD definition table.
function subtitles.util.update_hud(player, hud_id, old_def, new_def)
    local function _compare(old, new)
        if type(new) == 'table' then
            for key, value in pairs(new) do
                if value ~= old[key] then
                    return false;
                end;
            end;
            return true;
        else
            return old == new;
        end;
    end;

    for key, value in pairs(new_def) do
        if not _compare(value, old_def[key]) then
            player:hud_change(hud_id, key, value);
        end;
    end;
end;


--- Clamps a number to within a specified range.
-- @param value The value to clamp.
-- @param min The lower bound.
-- @param max The upper bound.
-- @return min, max, or value.
function subtitles.util.clamp(value, min, max)
    if value < min then
        return min;
    elseif value > max then
        return max;
    else
        return value;
    end;
end;


--- Reads a boolean value from metadata.
-- @param meta The MetaDataRef to read from.
-- @param key The name of the metadata entry to read.
-- @param default The default value. Not necessarily a boolean.
-- @return A boolean value or the default.
function subtitles.util.get_meta_bool(meta, key, default)
    local value = meta:get_string(key):lower();
    if value == 'true' then
        return true;
    elseif value == 'false' then
        return false;
    else
        return default;
    end;
end;


--- Writes a boolean value to metadata.
-- @param meta The MetaDataRef to write to.
-- @param key The name of the metadata entry to write.
-- @param value The boolean value to write.
function subtitles.util.set_meta_bool(meta, key, value)
    meta:set_string(key, value and 'true' or 'false');
end;


--- Converts a colour from RGB to a number for HUDs.
-- @param red The red component, from 0 to 255.
-- @param green The green component, from 0 to 255.
-- @param blue The blue component, from 0 to 255.
-- @return An integer in the form 0xRRGGBB.
function subtitles.util.rgb_to_number(red, green, blue)
    red   = subtitles.util.clamp(math.floor(red),   0, 255);
    green = subtitles.util.clamp(math.floor(green), 0, 255);
    blue  = subtitles.util.clamp(math.floor(blue),  0, 255);
    return red * 65536 + green * 256 + blue;
end;
