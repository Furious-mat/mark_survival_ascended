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


--- Provides the SubtitleDisplay class, which is the base class for subtitle displays.


--- The base class for subtitle displays.
-- @type SubtitleDisplay
subtitles.SubtitleDisplay = subtitles.Object:extend();

subtitles.SubtitleDisplay.implementations = {};

subtitles.SubtitleDisplay.NAME = nil;
subtitles.SubtitleDisplay.ICON = 'subtitles_mode_unknown.png';
subtitles.SubtitleDisplay.TITLE = nil;
subtitles.SubtitleDisplay.DESCRIPTION = nil;
subtitles.SubtitleDisplay.DYNAMIC = false;

--- Constructor.
-- @param username The username of the player.
function subtitles.SubtitleDisplay:new(username)
    self.username = username;
    self.sounds = {};
    self._timers = {};

    self:init();
end;

--- Initialises the display.
function subtitles.SubtitleDisplay:init()
end;

--- Registers the display, making it available to use.
function subtitles.SubtitleDisplay:register()
    assert(self.NAME, 'This subtitle display does not specify NAME!');
    table.insert(subtitles.SubtitleDisplay.implementations, self);
end;

--- Handles a call to `minetest.sound_play()` or an equivalent event.
-- @param sound A `Sound` object.
function subtitles.SubtitleDisplay:handle_sound_play(sound)
    if sound:is_exempt() then
        return;
    end;

    self.sounds[sound.handle or sound] = sound;
    local duration = sound:get_duration();
    if duration then
        self._timers[sound] = minetest.after(duration, function() self:handle_sound_stop(sound); end);
    end;
    self:add_sound(sound);
end;

--- Handles a call to `minetest.sound_stop()` or an equivalent event.
-- @param sound_or_handle The sound's numeric handle, or the `Sound` object
--                        if it's ephemeral.
function subtitles.SubtitleDisplay:handle_sound_stop(sound_or_handle)
    local sound;
    if type(sound_or_handle) == 'table' then
        sound = sound_or_handle;
    else
        sound = self.sounds[sound_or_handle];
    end;

    if not sound then
        return;
    end;
    local job = self._timers[sound];
    if job then
        job:cancel();
    end;
    self.sounds[sound.handle or sound] = nil;
    self:remove_sound(sound);
end;

--- Destroys the display.
function subtitles.SubtitleDisplay:destroy()
    for __, sound in pairs(self.sounds) do
        self:handle_sound_stop(sound);
    end;
    self.sounds = {};
end;

--- Returns the display's owner.
-- @return The player's ObjectRef, or nil.
function subtitles.SubtitleDisplay:get_player()
    return minetest.get_player_by_name(self.username);
end;

--- Handles a subtitle being added.
-- @param sound A `Sound` object.
-- @abstract
function subtitles.SubtitleDisplay:add_sound(sound)
    error('Not implemented.');
end;

--- Handles a subtitle being removed.
-- @param sound A `Sound` object.
-- @abstract
function subtitles.SubtitleDisplay:remove_sound(sound)
    error('Not implemented.');
end;

--- Handles a sound changing.
-- @param sound A `Sound` object.
function subtitles.SubtitleDisplay:update_sound(sound)
end;

--- Called every game tick.
-- @param dtime Seconds since the last tick.
function subtitles.SubtitleDisplay:step(dtime)
    if self.DYNAMIC then
        for key, sound in pairs(self.sounds) do
            self:update_sound(sound);
        end;
    end;
end;

function subtitles.SubtitleDisplay:__tostring()
    return ('[Subtitle display %q for player %q]'):format(self.NAME, self.username);
end;

-- Static methods:

--- Returns the subtitle display class with the specified name.
-- @param name A display name string.
-- @return A subclass of `SubtitleDisplay` or nil.
function subtitles.SubtitleDisplay.get_by_name(name)
    for __, impl in ipairs(subtitles.SubtitleDisplay.implementations) do
        if impl.NAME == name then
            return impl;
        end;
    end;
    return nil;
end;
