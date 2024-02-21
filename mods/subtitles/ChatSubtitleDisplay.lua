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


--- Provides the ChatSubtitleDisplay class, which displays subtitles in the chat.


local S = subtitles.S;


--- Displays subtitles in the chat.
-- @type ChatSubtitleDisplay
subtitles.ChatSubtitleDisplay = subtitles.SubtitleDisplay:extend();

subtitles.ChatSubtitleDisplay.NAME        = 'chat';
subtitles.ChatSubtitleDisplay.ICON        = 'subtitles_mode_chat.png';
subtitles.ChatSubtitleDisplay.TITLE       = S'Log in chat';
subtitles.ChatSubtitleDisplay.DESCRIPTION = S'Writes subtitles into the chat console.';

subtitles.ChatSubtitleDisplay.TEXT_COLOUR = '#FFFFBF';
subtitles.ChatSubtitleDisplay.CHAT_PREFIX = '∗ ';

function subtitles.ChatSubtitleDisplay:add_sound(sound)
    local message = self.CHAT_PREFIX .. minetest.colorize(self.TEXT_COLOUR, sound:get_description());
    minetest.chat_send_player(self.username, message);
end;

function subtitles.ChatSubtitleDisplay:remove_sound(sound)
end;

subtitles.ChatSubtitleDisplay:register();
