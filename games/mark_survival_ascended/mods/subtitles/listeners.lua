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


--- Implements hooks and patches to detect when sounds are played and various other things.


-- Sound start:
local old_sound_play = minetest.sound_play;
function minetest.sound_play(spec, parameters, ephemeral)
    local handle = old_sound_play(spec, parameters, ephemeral);
    subtitles.on_sound_play(spec, parameters, handle);
    return handle;
end;


-- Sound stop:
local old_sound_stop = minetest.sound_stop;
function minetest.sound_stop(handle)
    old_sound_stop(handle);
    subtitles.on_sound_stop(handle);
end;


-- Place node:
function subtitles.on_placenode(pos, newnode, placer, oldnode, itemstack, pointed_thing)
    subtitles.on_node_action(pos, newnode, 'place');
end;
minetest.register_on_placenode(subtitles.on_placenode);


-- Dig node:
function subtitles.on_dignode(pos, oldnode, digger)
    subtitles.on_node_action(pos, oldnode, 'dug');
end;
minetest.register_on_dignode(subtitles.on_dignode);


-- Punch node:
function subtitles.on_punchnode(pos, node, puncher, pointed_thing)
    subtitles.on_node_action(pos, node, {'dig', 'dug'});
end;
minetest.register_on_punchnode(subtitles.on_punchnode);


-- Player damage:
function subtitles.on_player_hpchange(player, hp_change, reason)
    if hp_change < 0 then
        local params =
        {
            pos         = player:get_pos();
            description = subtitles.util.describe_damage(reason);
        };
        subtitles.on_sound_play('player_damage', params, true);
    end;
end;
minetest.register_on_player_hpchange(subtitles.on_player_hpchange, false)


-- Player join:
function subtitles.on_joinplayer(player, last_login)
    local agent = subtitles.get_agent(player);
    if not last_login then
        agent:on_first_join();
    end;
end;
minetest.register_on_joinplayer(subtitles.on_joinplayer);


-- Formspec interaction:
function subtitles.on_player_receive_fields(player, formname, fields)
    if formname == 'subtitles:menu' then
        subtitles.menu_receive_fields(player, fields);
    end;
end;
minetest.register_on_player_receive_fields(subtitles.on_player_receive_fields);


-- Global step:
local footstep_timer = 0.0;
function subtitles.on_globalstep(dtime)
    local footsteps = false;
    footstep_timer = footstep_timer + dtime;
    if footstep_timer > subtitles.FOOTSTEP_INTERVAL then
        footstep_timer = footstep_timer - subtitles.FOOTSTEP_INTERVAL;
        footsteps = true;
    end;

    for username, agent in pairs(subtitles.agents_by_player) do
        if agent:get_player() then
            if agent:get_enabled() then
                agent:step(dtime);
                if footsteps then
                    agent:handle_footsteps();
                end;
            end;
        else
            agent:on_leave();
            subtitles.agents_by_player[username] = nil;
        end;
    end;
end;
minetest.register_globalstep(subtitles.on_globalstep);
