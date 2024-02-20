-- base wand
-- register item
minetest.register_craftitem("missions:wand", {
	description = "Mission wand",
	inventory_image = "missions_wand.png",
	on_use = function(itemstack, player, pointed_thing)
		if pointed_thing and pointed_thing.type == "node" and pointed_thing.under then
			missions.form.wand(pointed_thing.under, player)
		end

		return itemstack
	end
})

-- converted wands
-- helper table to track which wands are being added
wands = {
	["position"] = "position",
	["chest"] = "chest-reference",
	["mission"] = "mission-reference"
}

for key, value in pairs(wands) do
	-- register item
	minetest.register_craftitem("missions:wand_" .. key, {
		description = "Mission wand with " .. value,
		inventory_image = "missions_wand_" .. key .. ".png",
		stack_max = 1
	})
end
