local S = minetest.get_translator("tph_spyglass")

tph_spyglass = {
  verify_s = 0.2, -- verify seconds (how long between each minetest.after to check if a player is still using a spyglass)
  fov = 0, -- global FOV for players (what spyglass will default to when exited)
  fov_add = 10, -- how much should FOV zoom in
  -- crafting settings
  crafting = { -- used for determining global crafting recipe
    glass = {"quartz:quartz_crystal"},
    metal = {"paleotest:hide"},
    stick = {"default:wood_stick"}
  },
  crafting_recipe = true,
}
local spyglass_users = {}

-- check if player is using spyglass
local function is_spyglassing(player)
  local name = type(player) == "string" and player or minetest.is_player(player) and player:get_player_name() or nil
  if name and spyglass_users[name] then
    return true
  end
  return false
end
tph_spyglass.is_spyglassing = is_spyglassing

-- remove spyglass HUD from player
local function remove_scope(player)
  local p_name = minetest.is_player(player) and player:get_player_name()
  local data = spyglass_users[p_name or nil]
  if not data then
    return
  end
  minetest.sound_play("tph_spyglass_exit",{pos = player:get_pos(), gain=1, max_hear_distance=8})
  if data.hud then
    player:hud_remove(data.hud)
  end
  if data.show_item then
    player:hud_set_flags({wielditem = data.show_item})
  end
  spyglass_users[p_name] = nil
  player:set_fov(0, false, .1)
end
--tph_spyglass.deactivate_spyglass = remove_scope

local function use_spyglass(player)
  if not minetest.is_player(player) then
    return
  end
  local p_name = player:get_player_name()
  -- check if player is using spyglass when using again, lower spyglass if so
  if is_spyglassing(p_name) then
    remove_scope(player)
    return
  end
  local data = {
    hud = player:hud_add({
      name = "tph_spyglass",
      hud_elem_type = "image",
      text = "tph_spyglass_hud.png", -- image is 26x16, any texture pack or edit to the image should have a resolution that properly factors to said resolution (e.g. 52x32) or width = height*1.625
      position = {x = 0.5, y = 0.5},
      scale = { x = -100, y = -100}
    }),
    index = player:get_wield_index(),
    show_item = player:hud_get_flags().wielditem
  }
  spyglass_users[p_name] = data
  if data.show_item then
    player:hud_set_flags({wielditem = false})
  end
  local spy_fov = tph_spyglass.fov + tph_spyglass.fov_add
  player:set_fov(spy_fov, false, .4)
  -- play sound
  minetest.sound_play("tph_spyglass_open",{pos = player:get_pos(), gain=1, max_hear_distance=8})
  -- verify if player is still using spyglass
  local function verify()
    -- not even using the spyglass (or invalid player)
    if not minetest.is_player(player) then
      return
    elseif not is_spyglassing(p_name) then
      return
    -- you changed slots!
    elseif player:get_wield_index() ~= data.index then
      remove_scope(player)
    -- wielded item is different
    elseif player:get_wielded_item():get_name() ~= "tph_spyglass:spyglass" then
      remove_scope(player)
    -- if FOV has been changed while in spyglass
    elseif player:get_fov() ~= spy_fov then
      remove_scope(player)
    else -- repeat verify check
      minetest.after(tph_spyglass.verify_s,verify)
    end
  end
  verify()
end
--tph_spyglass.activate_spyglass = use_spyglass

tph_spyglass.toggle_spyglass = function(player,onoff)
  local p_name = minetest.is_player(player) and player:get_player_name() or type(player) == "string" and player or nil
  if not p_name then
    return
  end
  player = minetest.is_player(player) and player or minetest.get_player_by_name(p_name)
  local data = spyglass_users[p_name]
  if not player then
    -- player left
    data[p_name] = nil
    return
  end
  if onoff ~= "boolean" then
    onoff = nil
  end
  if data then
    if onoff then return end -- onoff says we're keeping 'em on
    remove_scope(player)
  elseif not data then
    if onoff == false then return end -- onoff says we're keeping 'em off
    use_spyglass(player)
  end
end

minetest.register_craftitem("tph_spyglass:spyglass",{
  description = S("Spyglass"),
  inventory_image = "tph_spyglass_icon.png",
  stack_max = 1,
  -- looking at nothing or an entity
  on_secondary_use = function(itemstack, user, pointed_thing)
    if is_spyglassing(user) then
      return use_spyglass(user)
    end
    if pointed_thing.type == "object" then
      local ent = pointed_thing.ref:get_luaentity()
      if ent and type(ent.on_rightclick) == "function" then
        local rc_result = ent:on_rightclick(user)
        if rc_result ~= itemstack then
          return rc_result
        end
      end
    end
    use_spyglass(user)
  end,
  -- looking at a node
  on_place = function(itemstack, placer, pointed_thing)
    local is_looking = is_spyglassing(placer)
    if is_looking then
      -- permit interacting with node after closing spyglass
      use_spyglass(placer)
    end
    -- in case someone decides to do something inappropriate with pointed_thing
    if pointed_thing and pointed_thing.under then
      local node = minetest.get_node(pointed_thing.under)
      local ndef = minetest.registered_nodes[node.name]
      if ndef and type(ndef.on_rightclick) == "function" then
        local rc_result = ndef.on_rightclick(pointed_thing.under, node, placer, itemstack, pointed_thing) -- rightclick result
        -- return false to not affect spyglassing
        if rc_result ~= false then
          return rc_result
        end
      end
    end
    -- zooming in if node doesn't do anything and if we weren't already zoomed in
    if not is_looking then
      use_spyglass(placer)
    end
  end,
})

local spy_craft = tph_spyglass.crafting
-- prefer brass from mt-mods's "Basic Materials" mod
if minetest.get_modpath("basic_materials") then
  spy_craft.metal = {"basic_materials:brass_ingot"}
end
if minetest.get_modpath("hades_core") then
  table.insert(spy_craft.glass,"hades_core:glass")
  table.insert(spy_craft.metal,"hades_core:bronze_ingot")
end
-- set up crafting (allow mods or games to modify)
minetest.register_on_mods_loaded(function()
  if not tph_spyglass.crafting_recipe then
    return
  end
  local function find_registered(name)
    if string.match(name,"group:") then
      -- we're not going to iterate through every table to check if there exists a thing with a group
      return true
    end
    local data = minetest.registered_items[name] or minetest.registered_nodes[name]
    return data
  end
  -- ensure all ingredients exist, remove if not
  for index,glass in pairs(spy_craft.glass) do
    if not find_registered(glass) then
      table.remove(spy_craft.glass,index)
    end
  end
  for index,metal in pairs(spy_craft.metal) do
    if not find_registered(metal) then
      table.remove(spy_craft.metal,index)
    end
  end
  for index,stick in pairs(spy_craft.stick) do
    if not find_registered(stick) then
      table.remove(spy_craft.stick,index)
    end
  end
  -- prevent registration of crafting recipes if no ingredients available
  if #spy_craft.glass == 0 then
    minetest.log("error","tph_spyglass: no glass available for spyglass crafting, removing crafting recipe")
    return
  elseif #spy_craft.metal == 0 then
    minetest.log("error","tph_spyglass: no metal available for spyglass crafting, removing crafting recipe")
    return
  elseif #spy_craft.stick == 0 then
    minetest.log("error","tph_spyglass: no stick available for spyglass crafting, removing crafting recipe")
    return
  end
  -- iterate through glass, metals, and sticks provided
  for _,glass in pairs(spy_craft.glass) do
    for _,metal in pairs(spy_craft.metal) do
      for _,stick in pairs(spy_craft.stick) do
        -- flat craft
        minetest.register_craft({
          output = "tph_spyglass:spyglass",
          recipe = {
            {metal,glass,metal},
            {"",metal,""},
            {"",stick,""}}
        })
        -- leaning left craft
        minetest.register_craft({
          output = "tph_spyglass:spyglass",
          recipe = {
            {glass,metal,""},
            {metal,metal,""},
            {"","",stick}
          }
        })
        -- register crafts manually for i3 due to waiting on registered mods
        if minetest.get_modpath("i3") then
          i3.register_craft({
            result = "tph_spyglass:spyglass",
            items = {
              ""..metal..","..glass..","..metal,
              " ,"..metal..", ",
              " ,"..stick..", ",
            }
          })
          i3.register_craft({
            result = "tph_spyglass:spyglass",
            items = {
              glass..","..metal..", ",
              metal..","..metal..", ",
              " , ,"..stick,
            }
          })
        end
      end
    end
  end
end)


