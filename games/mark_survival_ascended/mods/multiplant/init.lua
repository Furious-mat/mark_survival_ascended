
--Datenstruktur:
local modpath=minetest.get_modpath(minetest.get_current_modname())

multiplant={
    seeds={}
}

dofile(modpath.."/api.lua")
multiplant.get_all_seeds()

dofile (modpath.."/multiplant.lua")
dofile(modpath.."/crafts.lua")

minetest.after(2, function() 
    multiplant.get_all_seeds()
    end)
