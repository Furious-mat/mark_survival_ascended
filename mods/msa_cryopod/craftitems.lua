------------------
-- Cryopod --
------------------

minetest.register_craftitem("msa_cryopod:cryopod", {
	description = "Cryopod",
	inventory_image = "cryopod.png",
	stack_max = 1,
	on_place = function(itemstack, placer, pointed_thing)
	        if not placer or not placer:is_player() then
			return
		end
		local pos = pointed_thing.above
		local under = minetest.get_node(pointed_thing.under)
		local node = minetest.registered_nodes[under.name]
		if node and node.on_rightclick then
			return node.on_rightclick(pointed_thing.under, under, placer, itemstack)
		end
		if pos
		and not minetest.is_protected(pos, placer:get_player_name()) then
			pos.y = pos.y + 3
			local mob = itemstack:get_meta():get_string("mob")
			local staticdata = itemstack:get_meta():get_string("staticdata")
			local pos2 = placer:get_pos()
                        local cryo_pos = minetest.find_node_near(pos2, 50, "msa_cryopod:cryofridge")
			if mob ~= "" and cryo_pos then
				minetest.add_entity(pos, mob, staticdata)
				itemstack:get_meta():set_string("mob", nil)
				itemstack:get_meta():set_string("staticdata", nil)
				itemstack:get_meta():set_string("description", "Cryopod")
			end
			if not cryo_pos then
			minetest.chat_send_player(placer:get_player_name(), "" ..core.colorize("#ff0000","No Cryofridges within a 50-block radius !"))
			end
		end
		return itemstack
	end,
	on_secondary_use = function(itemstack, player)
		local mob = itemstack:get_meta():get_string("mob")
		if mob ~= "" then return end
		local name = player:get_player_name()
		local dir = player:get_look_dir()
		local pos = player:get_pos()
		pos.y = pos.y + player:get_properties().eye_height or 1.625
		pos = vector.add(pos, vector.multiply(dir, 1))
		local dest = vector.add(pos, vector.multiply(dir, 100))
		local ray = minetest.raycast(pos, dest, true, false)
		for pointed_thing in ray do
			if pointed_thing.type == "object" then
				local obj = pointed_thing.ref
				if obj:get_luaentity() then
					obj = obj:get_luaentity()
				else
					return
				end
				if obj.name == "draconis:fire_dragon"
				or obj.name == "draconis:ice_dragon" then
					if not obj.tamed then
						minetest.chat_send_player(name, "You do not own this creature")
					elseif obj.owner == name then
						mobkit.clear_queue_high(obj)
						if not obj.isonground then
							obj.order = mobkit.remember(obj, "order", "follow")
						end
					end
				end
			end
		end
	end
})

function msa_cryopod.capture_with_cryopod(self, clicker)
	if not clicker:is_player()
	or not clicker:get_inventory() then
		return false
	end
	local dinos = self.name
	local catcher = clicker:get_player_name()
	local cryo = clicker:get_wielded_item()
	if cryo:get_name() ~= "msa_cryopod:cryopod" then
		return false
	end
	if not self.tamed then
		return false
	end
	if self.owner ~= catcher then
		minetest.chat_send_player(catcher, "This Creature is owned by @1"..self.owner)
		return false
	end
	if clicker:get_inventory():room_for_item("main", dinos) then
		local stack = clicker:get_wielded_item()
		local meta = stack:get_meta()
	        local info = "Cryopod\n"..minetest.colorize("#a9a9a9", mob_core.get_name_proper(self.name))
		if not meta:get_string("mob")
		or meta:get_string("mob") == "" then
			meta:set_string("mob", dinos)
			meta:set_string("staticdata", self:get_staticdata())
			meta:set_string("description", info)
			clicker:set_wielded_item(stack)
			self.object:remove()
			minetest.sound_play("meseportal_warp", {gain = 1})
			return stack
		else
			minetest.chat_send_player(catcher, "This Cryopod already contains a creature")
			return false
		end
	end
	return true
end

minetest.register_alias("cryopod:cryopod", "msa_cryopod:cryopod")

------------------
-- Cryofridge --
------------------

minetest.register_node("msa_cryopod:cryofridge", {
    description = "Cryofridge",
    drawtype = "mesh",
    mesh = "cryopod_cryofridge.obj",
    tiles = {"cryopod_cryofridge.png"},
    inventory_image = "cryopod_cryofridge_inv.png",
    selection_box = {
        type = "fixed",
        fixed = {-0.3125, -0.5000, -0.3125, 0.3125, 1.125, 0.3125}
    },
    groups = {cracky = 1, level = 2},
    drop = ""
})

minetest.register_alias("cryopod:cryofridge", "msa_cryopod:cryofridge")
