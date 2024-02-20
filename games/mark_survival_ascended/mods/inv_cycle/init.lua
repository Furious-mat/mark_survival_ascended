
local INVLENGTH = 8
local INVHEIGHT = 4

local games = {
  minetest = {8,4},
  MineClone2 = {9,4},
  exile = {8,2}
}

local id = "minetest"

if minetest.get_modpath("mcl_core") then
  id = "MineClone2"
elseif minetest.get_modpath("exile_env_sounds") then
  id = "exile"
end

if games[id] then

  INVLENGTH = games[id][1]
  INVHEIGHT = games[id][2]
end


local inv_size = INVLENGTH*INVHEIGHT

controls.register_on_press(function(player, key)

  local ctrl = player:get_player_control()
  if key == "aux1" and ctrl.sneak then
  else
    return
  end


  local inv = player:get_inventory():get_list("main")
  local inv2 = {}

  for i=1, inv_size+INVLENGTH do
    inv2[i] = ""
  end
  for i,val in pairs(inv) do
    inv2[i+INVLENGTH] = val
  end

  for i,val in pairs(inv2) do
    if i > inv_size then
      inv2[i-inv_size] = val
    end
  end

  player:get_inventory():set_list("main", inv2)

end)
