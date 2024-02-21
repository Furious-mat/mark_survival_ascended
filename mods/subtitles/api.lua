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


--- Public API functions.


local S = subtitles.S;


subtitles.registered_descriptions = {};
subtitles.registered_parameters = {};
subtitles.agents_by_player = {};
subtitles.reported_missing = {};


--- Handles a call to minetest.sound_play(), or an equivalent event.
-- @param spec A SimpleSoundSpec.
-- @param parameters The sound parameters.
-- @param handle The sound's handle, or nil if the sound is ephemeral.
function subtitles.on_sound_play(spec, parameters, handle)
    local sound = subtitles.Sound(spec, parameters, handle);
    if sound:is_exempt() then
        return;
    end;
    for __, player in ipairs(sound:get_players()) do
        local agent = subtitles.get_agent(player);
        if agent:get_enabled() and sound:is_in_range_of_player(player) then
            local display = agent:get_display();
            display:handle_sound_play(sound);
        end;
    end;
end;


--- Handles a call to minetest.sound_stop(), or an equivalent event.
-- @param handle The sound's handle.
function subtitles.on_sound_stop(handle)
    for username, agent in pairs(subtitles.agents_by_player) do
        agent:get_display():handle_sound_stop(handle);
    end;
end;


--- Returns the Agent object associated with the specified player.
-- The agent is created if necessary.
-- @param player A username or `ObjectRef` of a connected player.
-- @return An `Agent` object.
function subtitles.get_agent(player)
    if minetest.is_player(player) then
        player = player:get_player_name();
    end;

    local agent = subtitles.agents_by_player[player];
    if not agent then
        agent = subtitles.Agent(player);
        subtitles.agents_by_player[player] = agent;
    end;
    return agent;
end;


--- Handles a node action.
-- @param pos The position of the node, as a integer vector.
-- @param node The node table or node name.
-- @param action A key in the `sounds` table, such as 'dig' or 'footstep'.
function subtitles.on_node_action(pos, node, action)
    if type(node) ~= 'string' then
        node = node.name;
    end;

    local spec = subtitles.util.get_node_sound(node, action);
    if spec then
        local parameters = {pos = pos, duration = subtitles.EPHEMERAL_DURATION};
        subtitles.on_sound_play(spec, parameters, nil);
    end;
end;


--- Registers a description associated with a sound name.
-- When this sound is played, it will have the specified description unless a
-- description is explicitly specified.
-- @param name The technical name of the sound, without the extension or index.
-- @param description The human-readable description of the sound, or nil to not associate a description.
-- @param parameters A table of parameters to override when playing this sound, or nil.
function subtitles.register_description(name, description, parameters)
    if description then
        subtitles.registered_descriptions[name] = description;
    end;
    if parameters then
        local old_params = subtitles.registered_parameters[name] or {};
        subtitles.registered_parameters[name] = subtitles.util.update(old_params, parameters);
    end;
end;


--- Reports a missing subtitle to the debug log.
-- @param name The technical name of the sound.
function subtitles.report_missing(name)
    if not subtitles.reported_missing[name] then
        subtitles.reported_missing[name] = true;
        minetest.log('warning', ('[Subtitles] No description available for sound ‘%s’.'):format(name));
    end;
end;
