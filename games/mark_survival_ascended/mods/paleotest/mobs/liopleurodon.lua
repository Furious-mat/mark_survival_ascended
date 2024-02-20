------------------
-- Liopleurodon --
------------------

local function set_mob_tables(self)
    for _, entity in pairs(minetest.luaentities) do
        local name = entity.name
        if name ~= self.name and
            paleotest.find_string(paleotest.mobkit_mobs, name) then
            local height = entity.height
            if not paleotest.find_string(self.targets, name)
            and (height and height < 1.5)
            and (entity.bouyancy and entity.bouyancy > 0.75) then
                if entity.object:get_armor_groups() and
                    entity.object:get_armor_groups().fleshy then
                    table.insert(self.targets, name)
                elseif entity.name:match("^petz:") then
                    table.insert(self.targets, name)
                end
            end
        end
    end
end

local function liopleurodon_logic(self)

    if self.hp <= 0 then
        mob_core.on_die(self)
        return
    end

    set_mob_tables(self)

    local prty = mobkit.get_queue_priority(self)
    local player = mobkit.get_nearby_player(self)

    if mobkit.timer(self, 1) then

		mob_core.random_loot_drop(self, 1800, 3600, "loot_crates:rare")
		
		mob_core.random_loot_drop(self, 900, 1800, "loot_crates:uncommon")
				
		mob_core.random_loot_drop(self, 300, 600, "loot_crates:common")

        if prty < 20 then
            if self.driver then
                mob_core.hq_mount_logic(self, 20)
                return
            end
        end

        if prty < 10 and not self.isinliquid then
            paleotest.hq_flop(self, 10)
            return
        end

        if prty < 8 and self.owner_target then
            mob_core.logic_aqua_attack_mob(self, 8, self.owner_target)
        end

        if prty < 6 and self.hunger < self.max_hunger then
            if self.feeder_timer == 1 then
                paleotest.hq_aqua_go_to_feeder(self, 6,
                                               "paleotest:feeder_piscivore")
            end
        end

        if prty < 4 then
            if self.attacks == "mobs" or self.attacks == "all" then
                table.insert(self.targets, self.name)
                mob_core.logic_aqua_attack_mobs(self, 4)
            end
            if self.hunger < self.max_hunger / 1.25 then
                mob_core.logic_aqua_attack_mobs(self, 4)
            end
        end

        if prty < 2 then mob_core.hq_follow_holding(self, 2, player) end

        if mobkit.is_queue_empty_high(self) then
            mob_core.hq_aqua_roam(self, 0, 0.5, 1, 2)
        end
    end
end

minetest.register_entity("paleotest:liopleurodon", {
    -- Stats
    max_hp = 3200,
    armor_groups = {fleshy = 100},
    view_range = 16,
    reach = 5,
    damage = 40,
    knockback = 1,
    -- Movement & Physics
    max_speed = 8,
    stepheight = 1.26,
    jump_height = 1.26,
    buoyancy = 1,
    springiness = 0,
    obstacle_avoidance_range = 2,
    surface_avoidance_range = 1,
    floor_avoidance_range = 1,
    turn_rate = 4,
    -- Visual
	collisionbox = {-1.5, -1.5, -1.5, 1.5, 1.5, 1.5},
	visual_size = {x=15, y=15},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    visual = "mesh",
    mesh = "paleotest_liopleurodon.b3d",
    female_textures = {"paleotest_liopleurodon_female.png"},
    male_textures = {"paleotest_liopleurodon_male.png"},
    child_textures = {"paleotest_elasmosaurus_female.png"},
    animation = {
        swim = {range = {x = 1, y = 40}, speed = 30, loop = true},
        run = {range = {x = 1, y = 40}, speed = 35, loop = true},
        punch = {range = {x = 50, y = 70}, speed = 15, loop = false}
    },
    -- Mount
    driver_scale = {x = 0.100, y = 0.100},
    driver_attach_at = {x = 0, y = 1, z = 0},
    driver_eye_offset = {{x = 0, y = 5, z = 5}, {x = 0, y = 50, z = 55}},
    max_speed_forward = 8,
    max_speed_reverse = 4,
    -- Sound
    sounds = {
        alter_child_pitch = true,
        random = {
            name = "paleotest_liopleurodon",
            gain = 1.0,
            distance = 16
        },
        hurt = {
            name = "paleotest_liopleurodon",
            gain = 1.0,
            distance = 16
        },
        death = {
            name = "paleotest_liopleurodon",
            gain = 1.0,
            distance = 16
        }
    },
    -- Basic
    physical = true,
    collide_with_objects = true,
    static_save = true,
    needs_enrichment = false,
    live_birth = true,
    max_hunger = 2000,
    punch_cooldown = 1,
    defend_owner = true,
    targets = {},
    follow = paleotest.global_honey,
    drops = {
        {name = "paleotest:fish_meat_raw", chance = 1, min = 30, max = 40},
        {name = "paleotest:raw_prime_fish_meat", chance = 1, min = 20, max = 40},
        {name = "paleotest:black_pearl", chance = 1, min = 25, max = 50}
    },
    timeout = 0,
    logic = liopleurodon_logic,
    get_staticdata = mobkit.statfunc,
    on_activate = paleotest.on_activate,
    on_step = paleotest.on_step,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 1, true, true) then
            return
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:_female_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "paleotest_liopleurodon_fg.png",
                male_image = "paleotest_liopleurodon_fg.png",
                diet = "Sweet Tooth",
                temper = "Elusive"
            }))
        end
        if clicker:get_wielded_item():get_name() == "" then
            mob_core.mount(self, clicker)
        end
        mob_core.protect(self, clicker, true)
        mob_core.nametag(self, clicker)
    end,
    on_punch = function(self, puncher, _, tool_capabilities, dir)
        if puncher:get_player_control().sneak == true then
            paleotest.set_attack(self, puncher)
        else
            paleotest.on_punch(self)
            mob_core.on_punch_basic(self, puncher, tool_capabilities, dir)
            mob_core.on_punch_retaliate(self, puncher, true, false)
        end
    end
})

mob_core.register_spawn_egg("paleotest:liopleurodon", "533b29cc", "4d3627d9")

minetest.register_craftitem("paleotest:liopleurodon_dossier", {
	description = "Liopleurodon Dossier",
	stack_max= 1,
	inventory_image = "paleotest_liopleurodon_fg.png",
	groups = {dossier = 1},
})
