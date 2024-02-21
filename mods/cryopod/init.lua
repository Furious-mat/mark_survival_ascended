cryopod = {}

local craftable = minetest.settings:get_bool("cryopod.craftable")

if craftable == nil then
    craftable = false
    minetest.settings:set_bool("cryopod.craftable", false)
end

local path = minetest.get_modpath("cryopod")
local storage = dofile(path.."/storage.lua")

dofile(path.."/craftitems.lua")

if craftable == true then
dofile(path.."/craft.lua")
end


minetest.log("action", "[MOD] Cryopod v1.0 Dev loaded")
