msa_endgame = {}

local path = minetest.get_modpath("msa_endgame")

msa_endgame.walkable_nodes = {}

minetest.register_on_mods_loaded(function()
	for name in pairs(minetest.registered_nodes) do
		if name ~= "air" and name ~= "ignore" then
			if minetest.registered_nodes[name].walkable then
				table.insert(msa_endgame.walkable_nodes, name)
			end
		end
	end
end)

dofile(path.."/api/api.lua")
dofile(path.."/api/pathfinding.lua")
dofile(path.."/mobs/visual_objects.lua")
dofile(path.."/mobs/Gamma_Overseer.lua")
dofile(path.."/mobs/Gamma_Defense_Unit.lua")
dofile(path.."/mobs/Beta_Overseer.lua")
dofile(path.."/mobs/Beta_Defense_Unit.lua")
dofile(path.."/mobs/Alpha_Overseer.lua")
dofile(path.."/mobs/Alpha_Defense_Unit.lua")
dofile(path.."/nodes.lua")
