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


--- Implements the subtitle menu GUI.


local S = subtitles.S;


local MAX_HEIGHT = 10.5;


--- Creates a menu formspec for the specified player.
-- @param player The username or ObjectRef of the player.
-- @param embedded This should be true if the menu is being embedded in another formspec.
-- @param options A table of extra options: width, height.
-- @return A formspec string.
function subtitles.get_menu_formspec(player, embedded, options)
    local agent = subtitles.get_agent(player);
    player = agent.username;
    options = options or {};

    local _esc = minetest.formspec_escape;
    local natural_height = 3.75 + #subtitles.SubtitleDisplay.implementations * 1.25;
    local width = options.width or 8;
    local height = options.height or math.min(natural_height, MAX_HEIGHT);
    local display_name = agent:get_display_name();

    -- Style:
    local style = {};
    local selection_colour = '#80808040';
    local panel = 'subtitles_panel.png;4';
    local disabled_mod = '^subtitles_slash.png';
    local state_icon = 'subtitles_icon.png';
    local footsteps_icon = 'subtitles_footsteps.png';
    local circle = 'subtitles_circle.png';

    if minetest.get_modpath('rp_formspec') then
        -- Repixture style:
        table.insert_all(style,
        {
            'background9[0,0;0,0;ui_formspec_bg_short.png^[resize:384x192;true;24] bgcolor[#00000000]',                               -- Background
            'style_type[button,image_button;border=false]',                                                                           -- Reset buttons
            'style_type[button,image_button;bgimg=ui_button_1w_inactive.png^[resize:48x48;bgimg_middle=21,18,-20,-24]',               -- Passive button image
            'style_type[button:pressed,image_button:pressed;bgimg=ui_button_1w_active.png^[resize:48x48;bgimg_middle=21,21,-20,-21]', -- Active button image
        });
        selection_colour = '#33333340';
        panel = 'ui_itemslot.png^[resize:72x72;32';
    elseif minetest.get_modpath('mcl_core') then
        -- MineClone style:
        panel = 'subtitles_mcl_panel.png;4';
    elseif embedded and minetest.get_modpath('i3') then
        -- i3 style:
        panel = 'subtitles_i3_panel.png;4';
        state_icon = 'subtitles_icon_flat_hd.png';
        footsteps_icon = 'subtitles_i3_footsteps.png';
        disabled_mod = '^[multiply:#9F9F9F';
        circle = 'subtitles_i3_circle.png';
    end;

    -- State:
    local enabled = agent:get_enabled();
    local state_label;
    local toggle_tooltip;
    if enabled then
        state_label = S'Subtitles enabled';
        toggle_tooltip = S'Click to disable subtitles';
    else
        state_label = S'Subtitles disabled';
        toggle_tooltip = S'Click to enable subtitles';
        state_icon = state_icon .. disabled_mod;
    end;

    local footsteps = agent:get_footsteps_enabled();
    local footsteps_tooltip;
    if footsteps then
        footsteps_tooltip = S'Footsteps enabled';
    else
        footsteps_tooltip = S'Footsteps disabled';
        footsteps_icon = footsteps_icon .. disabled_mod;
    end;

    -- Main menu:
    local formspec =
    {
        ('size[%f,%f] real_coordinates[true]'):format(width, height),
        table.concat(style, ''),
        -- Toggle button:
        ('image_button[0.25,0.25;1,1;%s;toggle;]'):format(_esc(state_icon)),
        ('tooltip[toggle;%s]'):format(_esc(toggle_tooltip)),
        -- State label:
        --('label[1.5,0.75;%s]'):format(_esc(state_label)),
        ('hypertext[1.5,0.5;%f,1;state_label;<big><b>%s</b></big>]'):format(width - 1.75, _esc(state_label)),

        -- Mode panel:
        ('image[0.25,2.0;%f,%f;%s]'):format(width - 0.5, height - 3.5, panel),
        ('label[0.25,1.75;%s]'):format(_esc(S'Display mode:')),

        -- Footsteps button:
        ('image_button[0.25,%f;1,1;%s;footsteps;]'):format(height - 1.25, _esc(footsteps_icon)),
        ('tooltip[footsteps;%s]'):format(_esc(footsteps and S'Footsteps enabled' or S'Footsteps disabled')),
        -- Exit button:
        ('button_exit[%f,%f;3,1;done;%s]'):format(width - 3.25, height - 1.25, _esc(S'Done')),

        -- Mode list:
        ('scroll_container[0.25,2.0;%f,%f;mode_list_scrollbar;vertical;]'):format(width - 0.5, height - 3.5),
        ('scrollbaroptions[max=%d]'):format(math.max(0, natural_height - height)),
        ('scrollbar[%f,2.0;0.5,%f;vertical;mode_list_scrollbar;]'):format(width - 0.5, height - 3.5),
    };
    if embedded then
        formspec[1] = '';
    end;

    -- Display modes:
    for index, impl in ipairs(subtitles.SubtitleDisplay.implementations) do
        local y = 0.25 + (index - 1) * 1.25;
        if impl.NAME == display_name then
            local colour = enabled and '#00FF00' or '#BFBFBF';
            table.insert_all(formspec,
            {
                ('box[0.125,%f;%f,1.25;%s]'):format(y - 0.125, width - 0.75, selection_colour),
                ('image[%f,%f;1,1;%s^[multiply:%s]'):format(width - 1.75, y, circle, colour),
            });
        end;
        table.insert_all(formspec,
        {
            ('image[0.25,%f;1,1;%s]'):format(y, _esc(impl.ICON)),
            ('button[1.5,%f;%f,1;display_%s;%s]'):format(y, width - 3.5, impl.NAME, _esc(impl.TITLE)),
            ('tooltip[display_%s;%s]'):format(impl.NAME, _esc(impl.DESCRIPTION or impl.TITLE)),
        });
    end;

    table.insert(formspec, 'scroll_container_end[]');

    return table.concat(formspec, '');
end;


--- Shows the subtitle menu to the specified player.
-- @param player The username or ObjectRef of the player.
function subtitles.show_menu(player)
    local formspec = subtitles.get_menu_formspec(player);
    if type(player) ~= 'string' then
        player = player:get_player_name();
    end;
    minetest.show_formspec(player, 'subtitles:menu', formspec);
end;


--- Handles receiving fields from the menu formspec.
-- @param player The username or ObjectRef of the player.
-- @param fields A table of fields.
-- @param embedded If this is true, the menu will not be re-shown.
function subtitles.menu_receive_fields(player, fields, embedded)
    local function _reshow()
        if not embedded then
            subtitles.show_menu(player);
        end;
    end;

    local agent = subtitles.get_agent(player);

    if fields.toggle then
        agent:toggle_enabled();
        _reshow();
        return;
    end;

    if fields.footsteps then
        agent:toggle_footsteps_enabled();
        _reshow();
        return;
    end;

    for __, impl in ipairs(subtitles.SubtitleDisplay.implementations) do
        if fields['display_' .. impl.NAME] then
            agent:set_display_name(impl.NAME);
            _reshow();
            return;
        end;
    end;
end;


if not subtitles.settings.inventory_integration then
    return;
end;


-- Unified Inventory integration:
if minetest.get_modpath('unified_inventory') then
	unified_inventory.register_button('subtitles',
	{
		type      = 'image';
		image     = 'subtitles_icon.png';
		tooltip   = S'Subtitles';
		hide_lite = false;
		action    = subtitles.show_menu;
	});
end;


-- i3 integration:
if minetest.get_modpath('i3') then
    i3.new_tab('subtitles',
    {
	    description = S'Subtitles';
	    image       = 'subtitles_icon.png';
	    formspec =
	    function(player, data, fs)
		    fs(subtitles.get_menu_formspec(player, true, {width = 10.25, height = 12}));
	    end;
	    fields =
	    function(player, data, fields)
	        subtitles.menu_receive_fields(player, fields, true);
		    i3.set_fs(player);
	    end;
    });
end;


-- SFInv integration via SFInv Buttons:
if minetest.get_modpath('sfinv_buttons') then
	sfinv_buttons.register_button('subtitles',
	{
		image   = 'subtitles_icon.png';
		tooltip = S'Configure your subtitle preferences';
		title   = S'Subtitles';
		action  = subtitles.show_menu;
	});
end;


-- Repixture integration:
if minetest.get_modpath('rp_formspec') then
    rp_formspec.register_page('subtitles:subtitles', 'label[1,1;?]');
    rp_formspec.register_invpage('subtitles:subtitles', {});
    rp_formspec.register_invtab('subtitles:subtitles', {icon = 'subtitles_rp_icon.png', tooltip = S'Subtitles'});

    local old_set_current_invpage = rp_formspec.set_current_invpage;
    function rp_formspec.set_current_invpage(player, page)
        if page == 'subtitles:subtitles' then
            subtitles.show_menu(player);
        else
            old_set_current_invpage(player, page);
        end;
    end;
end;
