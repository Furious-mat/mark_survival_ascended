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


--- Provides the CornerSubtitleDisplay class, which displays subtitles in a corner of the screen.


local S = subtitles.S;


--- Displays subtitles in a corner of the screen.
-- @type CornerSubtitleDisplay
subtitles.CornerSubtitleDisplay = subtitles.BaseTextSubtitleDisplay:extend();

subtitles.CornerSubtitleDisplay.NAME        = 'corner';
subtitles.CornerSubtitleDisplay.ICON        = 'subtitles_mode_corner.png';
subtitles.CornerSubtitleDisplay.TITLE       = S'Text in corner';
subtitles.CornerSubtitleDisplay.DESCRIPTION = S'Displays a list of subtitles in the corner of the screen.';

function subtitles.CornerSubtitleDisplay:init()
    self.super.init(self);

    self.margin    = 56;
    self.size      = {x = 386, y = 40};
    self.offset    = {x = -(self.margin + self.size.x / 2), y = -self.margin};
    self.alignment = {x = 0, y = -1};
end;

function subtitles.CornerSubtitleDisplay:get_huds(entry)
    local function _value_to_shade(value)
        local shade = math.min(255, math.floor(127.5 + value * 127.5));
        return subtitles.util.rgb_to_number(shade, shade, shade);
    end;

    local offset = entry:get_offset();
    local huds = {};
    local text_offset = -2;
    local min_pan = 0.125;
    local text_colour = _value_to_shade(entry:get_distance_shade());
    huds.text =
    {
        hud_elem_type = 'text';
        name          = S'Subtitle';
        text          = entry.sound:get_description();
        offset        = {x = offset.x, y = offset.y + text_offset};
        scale         = self.size;
        number        = text_colour;
        size          = {x = self.font_size, y = self.font_size};
        style         = self.style;
        z_index       = self.z_index + 1;
    };
    huds.background =
    {
        hud_elem_type = 'image';
        name          = S'Subtitle background';
        text          = ('subtitles_subtitle_background.png^[resize:%dx%d'):format(self.size.x, self.size.y);
        offset        = offset;
        scale         = {x = 1, y = 1};
    };

    local relative_pos = entry.relative_pos;
    if entry.relative_pos then
        local pan = entry:get_pan();
        local arrow_offset = 16;
        huds.direction =
        {
            hud_elem_type = 'text';
            name          = S'Subtitle direction';
            text          = '';
            offset        = {x = offset.x, y = offset.y + text_offset};
            scale         = self.size;
            number        = _value_to_shade(math.abs(pan * (1 + min_pan)) - min_pan);
            size          = {x = self.font_size, y = self.font_size};
            style         = self.style;
            z_index       = self.z_index + 1;
        };
        if pan < -min_pan then
            huds.direction.text = '<';
            huds.direction.offset.x = offset.x - self.size.x / 2 + arrow_offset;
        elseif pan > min_pan then
            huds.direction.text = '>';
            huds.direction.offset.x = offset.x + self.size.x / 2 - arrow_offset;
        else
            huds.direction.number = nil;
        end;
    end;

    return huds;
end;

subtitles.CornerSubtitleDisplay:register();
