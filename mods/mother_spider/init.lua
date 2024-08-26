mobs:register_mob("mother_spider:broodmother_lysrix", {
	nametag = "BroodMother Lysrix" ,
	type = "monster",
	passive = false,
	damage = 180,
	attack_type = "dogshoot",
	pathfinding = 1,
	dogshoot_switch = 1,
	dogshoot_count_max = 4, -- shoot for 10 seconds
	dogshoot_count2_max = 2, -- dogfight for 3 seconds
	reach = 6,
	shoot_interval = 1,
	arrow = "mother_spider:cobweb_arrow",
	shoot_offset = 2,
	hp_min = 324000,
	hp_max = 324000,
	armor = 80,
	collisionbox = {-1.0, -1.1, -0.5, 0.5, 1.0, 0.5},
	visual = "mesh",
	mesh = "spider_boss.b3d",
	visual_size = {x = 0.7, y = 0.7},
	rotate = 180,
	textures = {
		{"spider_mother_boss.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		random = "broodmother",
		death = "paleotest_araneo_idle",
		shoot_attack = "shoot_attack",
	},
	view_range = 64,
	walk_velocity = 1,
	run_velocity = 4,
	jump = true,
	jump_height = 12,
	fall_damage = 0,
	fall_speed = -6,
	stepheight = 2.2,
    drops = {
        {name = "overpowered:ingot", chance = 1, min = 20, max = 20},
        {name = "mother_spider:mother_spider_trophy", chance = 1, min = 1, max = 1},
        {name = "artifact:BroodMother_Dossier_Item", chance = 1, min = 1, max = 1},
        {name = "artifact:gamma_b", chance = 1, min = 1, max = 1},
        {name = "overpowered:gamma_broodmother_lock", chance = 1, min = 10, max = 10}
    },
	water_damage = 0,
	lava_damage = 0,
	light_damage = 0,
	animation = {
		--speed_normal = 15,
		--speed_run = 15,
		stand_start = 0,
		stand_end = 0,
		walk_start = 15,
		walk_end = 34,
		run_start = 40,
		run_end = 47,
		shoot_start = 0,
		shoot_end = 0,
		punch_start = 50,
		punch_end = 79,
		--die_start = 0 ,
		--die_end = 0,
		
		
		
	},
})

-- arrow (weapon)
mobs:register_arrow("mother_spider:cobweb_arrow", {
	visual = "sprite",
--	visual = "wielditem",
	visual_size = {x = 1.0, y = 1.0},
	textures = {"mobs_cobweb.png"},
	velocity = 36, -- 12
--	rotate = 180,

	hit_player = function(self, player)
	
		player:punch(self.object, 1.0, {
			full_punch_interval = 0.5, -- 1.0
			damage_groups = {fleshy = 25},
		}, nil)
		
		-- add bloco de teias para segurar palyer
		local pp = player:get_pos()
		minetest.set_node(pp, {name = "paleotest:spiderweb"})
                local pos = self.object:get_pos()
                minetest.add_entity({x=pos.x+1, y=pos.y+1, z=pos.z+1}, "paleotest:araneo")
                minetest.add_entity({x=pos.x+1, y=pos.y+1, z=pos.z+1}, "paleotest:araneo")
                minetest.add_entity({x=pos.x+1, y=pos.y+1, z=pos.z+1}, "paleotest:araneo")
                
	end,

	hit_mob = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 0.5, -- 1.0
			damage_groups = {fleshy = 8},
		}, nil)
	end,

	hit_node = function(self, pos, node)
	end
})



-- === MOTHER SPIDER TROPHY ===

minetest.register_node("mother_spider:mother_spider_trophy", {
	description = "Mother Spider Trophy",
	drawtype = "mesh",
	mesh = "mother_spider_trofeu.obj",
	tiles = {"spider_mother_boss_trofeu.png"} ,
	wield_scale = {x=1, y=1, z=1},
	groups = {dig_immediate=3},
	paramtype = "light",
	use_texture_alpha = "clip",

-- CAIXA DE COLISÃO :
	paramtype2 = "facedir",
		selection_box = {
			type = "fixed", -- fica no formato da caixa se ajustado
			fixed = {
				{-0.5, -0.5, -0.25, 0.5, 0.5, 0.5},
				
			},
		},
		
		
	
})



mobs:register_egg("mother_spider:broodmother_lysrix", "BroodMother Lysrix", "mother_spider_egg.png", 0)

mobs:register_mob("mother_spider:broodmother_lysrix_beta", {
	nametag = "Beta BroodMother Lysrix" ,
	type = "monster",
	passive = false,
	damage = 320,
	attack_type = "dogshoot",
	pathfinding = 1,
	dogshoot_switch = 1,
	dogshoot_count_max = 4, -- shoot for 10 seconds
	dogshoot_count2_max = 2, -- dogfight for 3 seconds
	reach = 8,
	shoot_interval = 1,
	arrow = "mother_spider:cobweb_arrow",
	shoot_offset = 2,
	hp_min = 648000,
	hp_max = 648000,
	armor = 80,
	collisionbox = {-1.0, -1.1, -0.5, 0.5, 1.0, 0.5},
	visual = "mesh",
	mesh = "spider_boss.b3d",
	visual_size = {x = 0.7, y = 0.7},
	rotate = 180,
	textures = {
		{"beta_spider_mother_boss.png"},
	},
	--blood_texture = " ",
	makes_footstep_sound = true,
	sounds = {
		random = "broodmother",
		death = "paleotest_araneo_idle",
		shoot_attack = "shoot_attack",
	},
	view_range = 64,
	walk_velocity = 1,
	run_velocity = 4,
	jump = true,
	jump_height = 12,
	fall_damage = 0,
	fall_speed = -6,
	stepheight = 2.2,
    drops = {
        {name = "overpowered:ingot", chance = 1, min = 56, max = 56},
        {name = "mother_spider:beta_mother_spider_trophy", chance = 1, min = 1, max = 1},
        {name = "artifact:BroodMother_Dossier_Item", chance = 1, min = 1, max = 1},
        {name = "artifact:beta_b", chance = 1, min = 1, max = 1},
        {name = "overpowered:beta_broodmother_lock", chance = 1, min = 10, max = 10}
    },
	water_damage = 0,
	lava_damage = 0,
	light_damage = 0,
	animation = {
		--speed_normal = 15,
		--speed_run = 15,
		stand_start = 0,
		stand_end = 0,
		walk_start = 15,
		walk_end = 34,
		run_start = 40,
		run_end = 47,
		shoot_start = 0,
		shoot_end = 0,
		punch_start = 50,
		punch_end = 79,
		--die_start = 0 ,
		--die_end = 0,
		
		
		
	},
})

-- === MOTHER SPIDER TROPHY ===

minetest.register_node("mother_spider:beta_mother_spider_trophy", {
	description = "Beta Mother Spider Trophy",
	drawtype = "mesh",
	mesh = "mother_spider_trofeu.obj",
	tiles = {"beta_spider_mother_boss.png"} ,
	wield_scale = {x=1, y=1, z=1},
	groups = {dig_immediate=3},
	paramtype = "light",
	use_texture_alpha = "clip",

-- CAIXA DE COLISÃO :
	paramtype2 = "facedir",
		selection_box = {
			type = "fixed", -- fica no formato da caixa se ajustado
			fixed = {
				{-0.5, -0.5, -0.25, 0.5, 0.5, 0.5},
				
			},
		},
		
		
	
})



mobs:register_egg("mother_spider:broodmother_lysrix_beta", "Beta BroodMother Lysrix", "mother_spider_egg.png", 0)

mobs:register_mob("mother_spider:broodmother_lysrix_alpha", {
	nametag = "Alpha BroodMother Lysrix" ,
	type = "monster",
	passive = false,
	damage = 540,
	attack_type = "dogshoot",
	pathfinding = 1,
	dogshoot_switch = 1,
	dogshoot_count_max = 4, -- shoot for 10 seconds
	dogshoot_count2_max = 2, -- dogfight for 3 seconds
	reach = 10,
	shoot_interval = 0.5,
	arrow = "mother_spider:cobweb_arrow",
	shoot_offset = 2,
	hp_min = 972000,
	hp_max = 972000,
	armor = 80,
	collisionbox = {-1.0, -1.1, -0.5, 0.5, 1.0, 0.5},
	visual = "mesh",
	mesh = "spider_boss.b3d",
	visual_size = {x = 0.7, y = 0.7},
	rotate = 180,
	textures = {
		{"alpha_spider_mother_boss.png"},
	},
	--blood_texture = " ",
	makes_footstep_sound = true,
	sounds = {
		random = "broodmother",
		death = "paleotest_araneo_idle",
		shoot_attack = "shoot_attack",
	},
	view_range = 64,
	walk_velocity = 1,
	run_velocity = 4,
	jump = true,
	jump_height = 12,
	fall_damage = 0,
	fall_speed = -6,
	stepheight = 2.2,
    drops = {
        {name = "paleotest:meat_raw", chance = 1, min = 10, max = 15},
        {name = "paleotest:raw_prime_meat", chance = 1, min = 10, max = 15},
        {name = "paleotest:organic_polymer", chance = 1, min = 10, max = 15},
        {name = "paleotest:chitin", chance = 1, min = 10, max = 20},
        {name = "overpowered:ingot", chance = 1, min = 148, max = 148},
        {name = "mother_spider:alpha_mother_spider_trophy", chance = 1, min = 1, max = 1},
        {name = "artifact:BroodMother_Dossier_Item", chance = 1, min = 1, max = 1},
        {name = "artifact:alpha_b", chance = 1, min = 1, max = 1},
        {name = "overpowered:alpha_broodmother_lock", chance = 1, min = 10, max = 10}
    },
	water_damage = 0,
	lava_damage = 0,
	light_damage = 0,
	animation = {
		--speed_normal = 15,
		--speed_run = 15,
		stand_start = 0,
		stand_end = 0,
		walk_start = 15,
		walk_end = 34,
		run_start = 40,
		run_end = 47,
		shoot_start = 0,
		shoot_end = 0,
		punch_start = 50,
		punch_end = 79,
		--die_start = 0 ,
		--die_end = 0,
		
		
		
	},
})

-- === MOTHER SPIDER TROPHY ===

minetest.register_node("mother_spider:alpha_mother_spider_trophy", {
	description = "Alpha Mother Spider Trophy",
	drawtype = "mesh",
	mesh = "mother_spider_trofeu.obj",
	tiles = {"alpha_spider_mother_boss.png"} ,
	wield_scale = {x=1, y=1, z=1},
	groups = {dig_immediate=3},
	paramtype = "light",
	use_texture_alpha = "clip",

-- CAIXA DE COLISÃO :
	paramtype2 = "facedir",
		selection_box = {
			type = "fixed", -- fica no formato da caixa se ajustado
			fixed = {
				{-0.5, -0.5, -0.25, 0.5, 0.5, 0.5},
				
			},
		},
		
		
	
})



mobs:register_egg("mother_spider:broodmother_lysrix_alpha", "Alpha BroodMother Lysrix", "mother_spider_egg.png", 0)















