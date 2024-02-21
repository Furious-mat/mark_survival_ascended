-----------------
-- Ovis --
-----------------

local palette  = {
	{"black",      "Black",      "#000000b0"},
	{"blue",       "Blue",       "#015dbb70"},
	{"brown",      "Brown",      "#663300a0"},
	{"cyan",       "Cyan",       "#01ffd870"},
	{"dark_green", "Dark Green", "#005b0770"},
	{"dark_grey",  "Dark Grey",  "#303030b0"},
	{"green",      "Green",      "#61ff0170"},
	{"grey",       "Grey",       "#5b5b5bb0"},
	{"magenta",    "Magenta",    "#ff05bb70"},
	{"orange",     "Orange",     "#ff840170"},
	{"pink",       "Pink",       "#ff65b570"},
	{"red",        "Red",        "#ff0000a0"},
	{"violet",     "Violet",     "#2000c970"},
	{"white",      "White",      "#ababab00"},
	{"yellow",     "Yellow",     "#e3ff0070"},
}

local function set_mob_tables(self)
    for _, entity in pairs(minetest.luaentities) do
        local name = entity.name
        if name ~= self.name and
            paleotest.find_string(paleotest.mobkit_mobs, name) then
            local height = entity.height
            if not paleotest.find_string(self.targets, name) and height and
                height < 2.5 then
                if entity.object:get_armor_groups() and
                    entity.object:get_armor_groups().fleshy then
                    table.insert(self.targets, name)
                elseif entity.name:match("^petz:") then
                    table.insert(self.targets, name)
                end
                if entity.targets and
                    paleotest.find_string(entity.targets, self.name) and
                    not not paleotest.find_string(self.predators, name) then
                    if entity.object:get_armor_groups() and
                        entity.object:get_armor_groups().fleshy then
                        table.insert(self.predators, name)
                    end
                end
            end
        end
    end
end

local function ovis_logic(self)

    if self.hp <= 0 then
        mob_core.on_die(self)
        return
    end

    set_mob_tables(self)

    local prty = mobkit.get_queue_priority(self)
    local player = mobkit.get_nearby_player(self)

    if mobkit.timer(self, 1) then

		mob_core.random_drop(self, 900, 1800, "paleotest:small_animal_poop")

        if self.order == "stand" and self.mood > 25 then
            mobkit.animate(self, "stand")
            return
        end

        if prty < 18 and self.isinliquid then
            mob_core.hq_liquid_recovery(self, 18, "walk")
            return
        end

        if prty < 16 and self.owner_target then
            mob_core.logic_attack_mob(self, 16, self.owner_target)
        end

        if self.status ~= "sleeping" then

            if prty < 14 and self.hunger < self.max_hunger then
                if self.feeder_timer == 1 then
                    paleotest.hq_go_to_feeder(self, 14, "paleotest:feeder_herbivore")
                end
            end
    
            if prty < 12 then
                if not self.child then
                    if self.attacks == "mobs" or self.attacks == "all" then
                        table.insert(self.targets, self.name)
                        mob_core.logic_attack_mobs(self, 12)
                    end
                    if self.mood < 25 then
                        mob_core.logic_attack_mobs(self, 12)
                    end
                    if #self.predators > 0 then
                        mob_core.logic_runaway_mob(self, 12, self.predators)
                    end
                end
            end
    
            if prty < 10 then
                if player
                and not self.child then
                    if self.mood < 25 then
                        mob_core.logic_attack_player(self, 10, player)
                    end
                end
            end
    
            if prty < 8 then
                if self.mood > 25 then
                    mob_core.hq_follow_holding(self, 8, player)
                end
            end
    
            if prty < 6 then
                if math.random(1, self.mood) == 1 then
                    if paleotest.can_find_post(self) then
                        paleotest.logic_play_with_post(self, 6)
                    elseif paleotest.can_find_ball(self) then
                        paleotest.logic_play_with_ball(self, 6)
                    end
                end
            end
    
            if prty < 4 then
                if math.random(1, self.hunger) == 1 then
                    paleotest.hq_graze(self, 4, paleotest.global_cake)
                    return
                end
            end
        end

        if prty < 2 then
            if self.sleep_timer <= 0 and self.status ~= "following" then
                paleotest.hq_sleep(self, 2)
            end
        end

        if mobkit.is_queue_empty_high(self) then
            mob_core.hq_roam(self, 0, true)
        end
    end
end

minetest.register_entity("paleotest:ovis", {
    -- Stats
    max_hp = 100,
    armor_groups = {fleshy = 100},
    view_range = 1,
    reach = 5,
    damage = 5,
    knockback = 16,
    lung_capacity = 30,
    -- Movement & Physics
    max_speed = 6,
    stepheight = 1.26,
    jump_height = 1.26,
    max_fall = 3,
    buoyancy = 0.25,
    springiness = 0,
    -- Visual
	collisionbox = {-0.5, -1, -0.5, 0.5, 0.3, 0.5},
	visual_size = {x = 1.0, y = 1.0},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    makes_footstep_sound = true,
    visual = "mesh",
    mesh = "paleotest_ovis.b3d",
    female_textures = {"paleotest_ovis.png^paleotest_ovis_wool.png^paleotest_ovis_horn.png"},
    male_textures = {"paleotest_ovis.png"},
    child_textures = {"paleotest_ovis.png"},
    animation = {
        stand = {range = {x = 1, y = 59}, speed = 15, loop = true},
        walk = {range = {x = 70, y = 100}, speed = 40, loop = true},
        run = {range = {x = 70, y = 100}, speed = 50, loop = true},
        punch = {range = {x = 110, y = 125}, speed = 20, loop = false},
        sleep = {range = {x = 130, y = 190}, speed = 10, loop = true}
    },
    -- Sound
    sounds = {
        alter_child_pitch = true,
        random = {
            name = "paleotest_ovis_idle",
            gain = 1.0,
            distance = 16
        },
        hurt = {
            name = "",
            gain = 1.0,
            distance = 16
        },
        death = {
            name = "paleotest_ovis_idle",
            gain = 1.0,
            distance = 16
        }
    },
    -- Basic
    physical = true,
    collide_with_objects = true,
    static_save = true,
    needs_enrichment = true,
    live_birth = true,
    max_hunger = 1200,
    punch_cooldown = 1,
    defend_owner = true,
    targets = {},
    predators = {},
    follow = paleotest.global_cake,
    drops = {
        {name = "paleotest:raw_mutton", chance = 1, min = 20, max = 40},
        {name = "paleotest:pelt", chance = 1, min = 10, max = 15},
        {name = "paleotest:hide", chance = 1, min = 5, max = 10}
    },
    timeout = 0,
    logic = ovis_logic,
    get_staticdata = mobkit.statfunc,
	on_step = function(self, dtime, moveresult)
		paleotest.on_step(self, dtime, moveresult)
		if mobkit.is_alive(self) then
			if self.object:get_properties().textures[1] == "paleotest_ovis.png"
			and not self.gotten then
				self.object:set_properties({
					textures = {"paleotest_ovis.png^paleotest_ovis_wool.png"},
				})
			end
		end
	end,
	on_activate = function(self, staticdata, dtime_s)
		paleotest.on_activate(self, staticdata, dtime_s)
		self.dye_color = mobkit.recall(self, "dye_color") or "white"
		self.dye_hex = mobkit.recall(self, "dye_hex") or ""
		if self.dye_color ~= "white"
		and not self.gotten then
			self.object:set_properties({
				textures = {"paleotest_ovis.png^(paleotest_ovis_wool.png^[colorize:" .. self.dye_hex .. ")"},
			})
		end
		if self.gotten then
			self.object:set_properties({
				textures = {"paleotest_ovis.png"},
			})
		end
	end,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 3, true, true) then
            return
        end
        if clicker:get_wielded_item():get_name() == "cryopod:cryopod" then
        cryopod.capture_with_cryopod(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            if self._pregnant and clicker:get_player_control().sneak then
                minetest.show_formspec(clicker:get_player_name(),
                                       "paleotest:pregnant_guide",
                                       paleotest.pregnant_progress_page(self))
                return
            end
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:ovis_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "paleotest_ovis_fg.png",
                male_image = "paleotest_ovis_fg.png",
                diet = "Herbivore",
                temper = "Stupid"
            }))
        end
        paleotest.set_order(self, clicker)
        mob_core.protect(self, clicker, true)
        mob_core.nametag(self, clicker)
		local item = clicker:get_wielded_item()
		local itemname = item:get_name()
		local name = clicker:get_player_name()
		if itemname == "shears:shears"
		and not self.gotten
		and not self.child then
			if not minetest.get_modpath("wool") then
				return
			end

			local obj = minetest.add_item(
				self.object:get_pos(),
				ItemStack( "wool:" .. self.dye_color .. " " .. math.random(1, 3) )
			)

			self.gotten = mobkit.remember(self, "gotten", true)
			self.dye_color = mobkit.remember(self, "dye_color", "white")
			self.dye_hex = mobkit.remember(self, "dye_hex",  "#abababc000")

			item:add_wear(650) -- 100 uses

			clicker:set_wielded_item(item)

			self.object:set_properties({
				textures = {"paleotest_ovis.png"},
			})
		end
		for _, color in ipairs(palette) do
			if itemname:find("dye:")
			and not self.gotten
			and not self.child then
				local dye = string.split(itemname, ":")[2]
				if color[1] == dye then

					self.dye_color = mobkit.remember(self, "dye_color", color[1])
					self.dye_hex = mobkit.remember(self, "dye_hex", color[3])

					self.drops = {
						{name = "paleotest:raw_mutton", chance = 1, min = 20, max = 40},
                        {name = "paleotest:pelt", chance = 1, min = 10, max = 15},
                        {name = "paleotest:hide", chance = 1, min = 5, max = 10},
						{name = "wool:"..self.dye_color, chance = 2, min = 1, max = 2},
					}

					self.object:set_properties({
						textures = {"paleotest_ovis.png^(paleotest_ovis_wool.png^[colorize:" .. color[3] .. ")"},
					})

					if not mobs.is_creative(clicker:get_player_name()) then
						item:take_item()
						clicker:set_wielded_item(item)
					end
					break
				end
			end
		end
	end,
    on_punch = function(self, puncher, _, tool_capabilities, dir)
        if puncher:get_player_control().sneak == true then
            paleotest.set_attack(self, puncher)
        else
            paleotest.on_punch(self)
            mob_core.on_punch_basic(self, puncher, tool_capabilities, dir)
            if puncher:get_player_name() == self.owner and self.mood > 25 then
                return
            end
            mob_core.on_punch_runaway(self, puncher, false, true)
        end
    end
})

mob_core.register_spawn_egg("paleotest:ovis", "6e512dcc", "2f1702d9")

minetest.register_craftitem("paleotest:ovis_dossier", {
	description = "Ovis Dossier",
	stack_max= 1,
	inventory_image = "paleotest_ovis_fg.png",
	groups = {dossier = 1},
})
