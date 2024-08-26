controls.register_on_press(function(player, key)
  local ctrl = player:get_player_control()
  if not (key == "aux1" and ctrl.sneak) then
    return
  end

  local inv = player:get_inventory()
  local width = inv:get_width("main")
  if width == 0 then
    width = 8
  end
  local list = inv:get_list("main")
  local newlist = {}
  local total = math.floor(#list / width) * width

  for k, v in ipairs(list) do
    newlist[k] = k <= total and list[(k - width -1) % total +1] or v
  end

  inv:set_list("main", newlist)
end)
