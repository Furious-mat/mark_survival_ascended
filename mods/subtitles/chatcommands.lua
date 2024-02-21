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


--- Provides the `/subtitles` command.


local S = subtitles.S;


local usage = '[on|off|modes|footsteps|version|help|<mode>]';
local help =
{
    '/subtitles ' .. usage,
    '',
    'on         ' .. S'Enables subtitles.',
    'off        ' .. S'Disables subtitles.',
    'modes      ' .. S'Lists available display modes.',
    'footsteps  ' .. S'Toggles subtitles for footsteps.',
    'version    ' .. S'Shows version information.',
    'help       ' .. S'Shows this help message.',
    '<mode>     ' .. S'Sets the display mode.',
};

--- Runs the `/subtitles` command.
-- @param name The username of the player running the command.
-- @param param The command parameter string.
-- @return Success boolean.
function subtitles.run_chatcommand(name, param)
    local function _chat(message)
        minetest.chat_send_player(name, message);
    end;

    param = param:trim();
    local agent = subtitles.get_agent(name);
    if param == '' then
        -- /subtitles
        subtitles.show_menu(name);

    elseif param == 'on' then
        -- /subtitles on
        agent:set_enabled(true);
        _chat(S'Subtitles enabled.');

    elseif param == 'off' then
        -- /subtitles off
        agent:set_enabled(false);
        _chat(S'Subtitles disabled.');

    elseif param == 'modes' then
        -- /subtitles modes
        _chat(S'Available display modes:');
        for __, impl in ipairs(subtitles.SubtitleDisplay.implementations) do
            _chat(('%-12s%s'):format(impl.NAME, impl.DESCRIPTION));
        end;

    elseif param == 'footsteps' then
        -- /subtitles footsteps
        agent:toggle_footsteps_enabled();
        _chat(agent:get_footsteps_enabled() and S'Footsteps enabled.' or S'Footsteps disabled.');

    elseif param == 'version' then
        -- /subtitles version
        _chat(subtitles.ABOUT);

    elseif param == 'help' or param == '--help' or param == '-h' then
        -- /subtitles help
        for __, line in ipairs(help) do
            _chat(line);
        end;

    elseif subtitles.SubtitleDisplay.get_by_name(param) then
        -- /subtitles <mode>
        agent:set_display_name(param);
        _chat(S('Set display mode: @1', agent:get_display().TITLE));

    else
        -- ☹
        _chat(S('Invalid option: ‘@1’.', param));
        _chat(S('Usage: /subtitles @1', usage));
        return false;
    end;

    return true;
end;

minetest.register_chatcommand('subtitles',
{
    description = S'Manages your subtitle preferences.';
    params      = usage;
    func        = subtitles.run_chatcommand;
});
