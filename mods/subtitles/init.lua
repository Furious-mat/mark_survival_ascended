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


--- Mod entry point.


local S = minetest.get_translator('subtitles');


subtitles = {S = S};

subtitles.TITLE   = 'Subtitles';
subtitles.VERSION = '0.3.0';
subtitles.AUTHOR  = 'Silver Sandstone';
subtitles.ABOUT   = S('@1 v@2 by @3', subtitles.TITLE, subtitles.VERSION, subtitles.AUTHOR);

subtitles.DEFAULT_DISPLAY_NAME = 'corner';

subtitles.DEFAULT_DURATION = 3;
subtitles.EPHEMERAL_DURATION = 1;
subtitles.FOOTSTEP_DURATION = 0.5;
subtitles.DEFAULT_MAX_HEAR_DISTANCE = 32;
subtitles.FOOTSTEP_HEAR_DISTANCE = 16;
subtitles.FOOTSTEP_INTERVAL = 0.25;


--- Mod settings.
subtitles.settings =
{
    default_enable_singleplayer = minetest.settings:get_bool('subtitles.default_enable_singleplayer', true);  -- Subtitles enabled by default in singleplayer.
    default_enable_multiplayer  = minetest.settings:get_bool('subtitles.default_enable_multiplayer',  false); -- Subtitles enabled by default in multiplayer.
    default_enable              = nil;                                                                        -- Subtitles enabled by default in the current mode.
    show_introduction           = minetest.settings:get_bool('subtitles.show_introduction',           true);  -- Show introduction message to new players.
    inventory_integration       = minetest.settings:get_bool('subtitles.inventory_integration',       true);  -- Enable subtitles button in supported inventories.
};

if minetest.is_singleplayer() then
    subtitles.settings.default_enable = subtitles.settings.default_enable_singleplayer;
else
    subtitles.settings.default_enable = subtitles.settings.default_enable_multiplayer;
end;


local modpath = minetest.get_modpath(minetest.get_current_modname());

--- The root of the class hierarchy.
-- @type Object
subtitles.Object = dofile(modpath .. '/classic.lua');

dofile(modpath .. '/util.lua');
dofile(modpath .. '/api.lua');
dofile(modpath .. '/listeners.lua');
dofile(modpath .. '/descriptions.lua');
dofile(modpath .. '/chatcommands.lua');
dofile(modpath .. '/menu.lua');
dofile(modpath .. '/Agent.lua');
dofile(modpath .. '/Sound.lua');
dofile(modpath .. '/SubtitleDisplay.lua');
dofile(modpath .. '/BaseTextSubtitleDisplay.lua');
dofile(modpath .. '/CornerSubtitleDisplay.lua');
dofile(modpath .. '/ClassicSubtitleDisplay.lua');
dofile(modpath .. '/ChatSubtitleDisplay.lua');
dofile(modpath .. '/WaypointSubtitleDisplay.lua');
