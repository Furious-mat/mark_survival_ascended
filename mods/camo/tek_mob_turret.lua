ARROW_DAMAGE = 1500
ARROW_VELOCITY = 3
minetest.register_node("camo:tek_mob_turret", {
	description = "Tek Anti Mob Turret",
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.250000,-0.500000,-0.250000,0.250000,0.500000,0.250000},
			{-0.125000,0.125000,-0.500000,0.125000,0.375000,0.500000}, 
			{-0.500000,0.125000,-0.125000,0.500000,0.375000,0.125000}, 
			{-0.312500,-0.500000,-0.312500,0.312500,-0.250000,0.312500}, 
			{-0.062500,0.187500,-0.546392,0.062500,0.312500,0.546392}, 
			{-0.567010,0.187500,-0.062500,0.546392,0.312500,0.062500}, 
		},
	},
	tiles = {"overpowered_block.png^light.png",
	         "overpowered_block.png",
	         "overpowered_block.png",
			 "overpowered_block.png",
			 "overpowered_block.png",
			 "overpowered_block.png"},
	is_ground_content = true,
	groups = {oddly_breakable_by_hand=2, falling_node=1},
	drop = 'camo:tek_mob_turret',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("camo:tek_turret_computer", {
	description = "Tek Turret Computer",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"computer_top.png",
	         "computer_side.png",
	         "computer_side.png",
			 "overpowered_block.png",
			 "overpowered_block.png",
			 "overpowered_block.png"},
	is_ground_content = true,
	groups = {oddly_breakable_by_hand=2},
	drop = 'camo:tek_turret_computer',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_abm({
	nodenames = {"camo:tek_mob_turret"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
	local objects = minetest.env:get_objects_inside_radius(pos, 10)
		for _,obj in ipairs(objects) do
		    if not obj:is_player() then
				local obj_p = obj:getpos()
				local calc = {x=obj_p.x - pos.x,y=obj_p.y+1 - pos.y,z=obj_p.z - pos.z}
				local bullet=minetest.env:add_entity({x=pos.x,y=pos.y,z=pos.z}, "camo:tek_arrow_entity")
				bullet:setvelocity({x=calc.x * ARROW_VELOCITY,y=calc.y * ARROW_VELOCITY,z=calc.z * ARROW_VELOCITY})
			    music_handle=minetest.sound_play("gun",
				{pos = pos, gain = 1.0, max_hear_distance = 15,}) 
			end
		end
	end
})

minetest.register_abm({
	nodenames = {"camo:tek_mob_turret"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
	local objects = minetest.env:get_objects_inside_radius(pos, 20)
	if minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z}).name ~= 'camo:tek_turret_computer' then return end
		for _,obj in ipairs(objects) do
		    if not obj:is_player() then
				local obj_p = obj:getpos()
				local calc = {x=obj_p.x - pos.x,y=obj_p.y+1 - pos.y,z=obj_p.z - pos.z}
				local bullet=minetest.env:add_entity({x=pos.x,y=pos.y,z=pos.z}, "camo:tek_arrow_entity")
				bullet:setvelocity({x=calc.x * ARROW_VELOCITY,y=calc.y * ARROW_VELOCITY,z=calc.z * ARROW_VELOCITY})
			    music_handle=minetest.sound_play("gun",
				{pos = pos, gain = 1.0, max_hear_distance = 25,}) 
			end
		end
	end
})

-- The Arrow Entity

THROWING_ARROW_ENTITY={
	physical = false,
	timer=0,
	visual_size = {x=0.2, y=0.2},
	textures = {"overpowered_untreatedingot.png"},
	lastpos={},
	collisionbox = {-0.2,-0.2,-0.2,0.2,0.2,0.2},
}
-- Arrow_entity.on_step()--> called when arrow is moving
THROWING_ARROW_ENTITY.on_step = function(self, dtime)
	self.timer=self.timer+dtime
	local pos = self.object:getpos()
	local node = minetest.env:get_node(pos)
	if self.timer > 10 then
		self.object:remove()
	end
	-- When arrow is away from mob (after 0.5 seconds): Cause damage to mobs
	if self.timer>0.5 then
		local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 1.5)
		for k, obj in pairs(objs) do
			if not obj:is_player() then
				local damage = obj:get_hp()-ARROW_DAMAGE
				print(damage)
				if (damage <=0) then
					obj:remove()
				else
				  obj:set_hp(damage)
				end
				self.object:remove()
			end
		end
	end

	-- Become item when hitting a node
	if self.lastpos.x~=nil then --If there is no lastpos for some reason
		if node.name ~= "air" and node.name ~= "camo:tek_mob_turret" then
			minetest.env:add_item(self.lastpos, 'throwing:arrow')
			self.object:remove()
		end
	end
	self.lastpos={x=pos.x, y=pos.y, z=pos.z} -- Set lastpos-->Item will be added at last pos outside the node
end

minetest.register_entity("camo:tek_arrow_entity", THROWING_ARROW_ENTITY)
