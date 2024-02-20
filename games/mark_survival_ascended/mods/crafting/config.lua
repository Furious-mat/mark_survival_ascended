local CONFIG_FILE_PREFIX = minetest.get_current_modname().."_"

crafting.config = {}

local print_settingtypes = false

local function setting(stype, name, default, description)
	local value
	if stype == "bool" then
		value = minetest.setting_getbool(CONFIG_FILE_PREFIX..name)
	elseif stype == "string" then
		value = minetest.setting_get(CONFIG_FILE_PREFIX..name)
	elseif stype == "int" or stype == "float" then
		value = tonumber(minetest.setting_get(CONFIG_FILE_PREFIX..name))
	end
	if value == nil then
		value = default
	end
	crafting.config[name] = value
	
	if print_settingtypes then
		minetest.debug(CONFIG_FILE_PREFIX..name.." ("..description..") "..stype.." "..tostring(default))
	end	
end

setting("bool", "import_default_recipes", true, "Import default crafting system recipes")
setting("bool", "clear_default_crafting", false, "Clear default crafting system recipes")
setting("bool", "sort_alphabetically", false, "Sort crafting output list alphabetically")
setting("bool", "show_guides", true, "Show crafting guides")
