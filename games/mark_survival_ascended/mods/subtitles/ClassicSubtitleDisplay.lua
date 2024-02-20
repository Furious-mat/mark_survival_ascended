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


--- Provides the ClassicSubtitleDisplay class, which displays subtitles at the bottom of the screen.


local S = subtitles.S;


--- Displays subtitles at the bottom of the screen.
-- @type ClassicSubtitleDisplay
subtitles.ClassicSubtitleDisplay = subtitles.BaseTextSubtitleDisplay:extend();

subtitles.ClassicSubtitleDisplay.NAME        = 'classic';
subtitles.ClassicSubtitleDisplay.ICON        = 'subtitles_mode_classic.png';
subtitles.ClassicSubtitleDisplay.TITLE       = S'Classic subtitles';
subtitles.ClassicSubtitleDisplay.DESCRIPTION = S'Displays outlined subtitles at the bottom of the screen.';

function subtitles.ClassicSubtitleDisplay:init()
    self.super.init(self);

    self.margin = 80;
    self.font_size = 3.0;
    self.size = {x = 640, y = 60};
    self.offset = {x = 0, y = -self.margin};
    self.position = {x = 0.5, y = 1.0};

    self.pan_amount = 0.0;
end;

function subtitles.ClassicSubtitleDisplay:get_huds(entry)
    local offset = entry:get_offset();
    local huds = {};
    local radius = 3;
    local shade = entry:get_distance_shade();
    --local border_colour = subtitles.util.rgb_to_number(0, shade * 64, shade * 255); -- Disabled because the rapid HUD updates lag too much.
    local border_colour = 0x003FCF;
    local description = entry.sound:get_description();
    local pan = entry:get_pan() * self.pan_amount;

    local z_index = self.z_index;
    for x = -radius, radius do
        for y = -radius, radius do
            if (x == 0 and y == 0) or math.floor(math.sqrt(x ^ 2 + y ^ 2)) == radius then
                huds[x .. ',' .. y] =
                {
                    hud_elem_type = 'text';
                    name          = S'Subtitle';
                    text          = description;
                    offset        = {x = offset.x + x + pan, y = offset.y + y - 2};
                    scale         = self.size;
                    number        = border_colour;
                    size          = {x = self.font_size, y = self.font_size};
                    z_index       = z_index;
                    style         = self.style;
                };
                z_index = z_index + 1;
            end;
        end;
    end;

    local text_hud = huds['0,0'];
    text_hud.number = 0xFFFFFF;
    text_hud.z_index = z_index;

    return huds;
end;

subtitles.ClassicSubtitleDisplay:register();
