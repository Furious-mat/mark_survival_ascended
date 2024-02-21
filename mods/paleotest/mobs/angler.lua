----------------
-- Angler --
----------------

local function set_mob_tables(self)
    for _, entity in pairs(minetest.luaentities) do
        local name = entity.name
        if name ~= self.name and
            paleotest.find_string(paleotest.mobkit_mobs, name) then
            if not paleotest.find_string(self.targets, name) then
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

local function angler_logic(self)

    if self.hp <= 0 then
        mob_core.on_die(self)
        return
    end

    set_mob_tables(self)

    local prty = mobkit.get_queue_priority(self)
    local player = mobkit.get_nearby_player(self)

    if mobkit.timer(self, 1) then

        if prty < 20 then
            if self.driver then
                mob_core.hq_mount_logic(self, 20)
                return
            end
        end

        if prty < 12 and not self.isinliquid then
            paleotest.hq_flop(self, 12)
            return
        end

        if prty < 10 and self.owner_target then
            mob_core.logic_aqua_attack_mob(self, 10, self.owner_target)
        end

        if prty < 8 then
            if self.hunger < self.max_hunger and self.feeder_timer == 1 then
                paleotest.hq_aqua_go_to_feeder(self, 8,
                                               "paleotest:feeder_piscivore")
            end
        end

        if prty < 6 then
            if self.attacks == "mobs" or self.attacks == "all" then
                table.insert(self.targets, self.name)
                mob_core.logic_aqua_attack_mobs(self, 6)
            end
            if self.hunger < self.max_hunger / 1.25 then
                mob_core.logic_aqua_attack_mobs(self, 6)
            end
        end

        if prty < 4 then
            if player then
                if self.child then return end
                if player:get_player_name() ~= self.owner then
                    mob_core.logic_aqua_attack_player(self, 4, player)
                end
            end
        end

        if prty < 2 then mob_core.hq_aqua_follow_holding(self, 2, player) end

        if mobkit.is_queue_empty_high(self) then
            mob_core.hq_aqua_roam(self, 0, 0.8)
        end
    end
end

minetest.register_entity("paleotest:angler", {
    -- Stats
    max_hp = 450,
    armor_groups = {fleshy = 100},
    view_range = 16,
    reach = 6,
    damage = 30,
    knockback = 6,
    -- Movement & Physics
    max_speed = 3,
    stepheight = 1.1,
    jump_height = 1.26,
    buoyancy = 1,
    springiness = 0,
    obstacle_avoidance_range = 1.5,
    surface_avoidance_range = 4,
    floor_avoidance_range = 4,
    -- Visual
    collisionbox = {-0.5, -0.4, -0.5, 0.5, 0.4, 0.5},
    visual_size = {x = 10, y = 10},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    glow = 16,
    visual = "mesh",
    mesh = "paleotest_angler.b3d",
    female_textures = {"paleotest_angler.png"},
    male_textures = {"paleotest_angler.png"},
    child_textures = {"paleotest_angler.png"},
    animation = {
        swim = {range = {x = 1, y = 40}, speed = 20, loop = true},
        run = {range = {x = 1, y = 40}, speed = 25, loop = true},
        punch = {range = {x = 50, y = 80}, speed = 7, loop = false}
    },
    -- Mount
    driver_scale = {x = 0.0325, y = 0.0325},
    driver_attach_at = {x = 0, y = 0.725, z = 0},
    driver_eye_offset = {{x = 0, y = 20, z = 5}, {x = 0, y = 45, z = 55}},
    max_speed_forward = 3,
    max_speed_reverse = 3,
    -- Sound
    sounds = {
        alter_child_pitch = true,
        random = {
            name = "paleotest_angler_idle",
            gain = 1.0,
            distance = 16
        },
        hurt = {
            name = "paleotest_angler_hurt",
            gain = 1.0,
            distance = 16
        },
        death = {
            name = "paleotest_angler_death",
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
    max_hunger = 1500,
    defend_owner = true,
    imprint_tame = true,
    targets = {},
    igniter_damage = false,
    follow = paleotest.global_meat,
    drops = {
        {name = "paleotest:fish_meat_raw", chance = 1, min = 10, max = 20},
        {name = "paleotest:angler_gel", chance = 1, min = 30, max = 50},
        {name = "fishing_rod:fish_anglerfish", chance = 1, min = 1, max = 1}
    },
    timeout = 0,
    logic = angler_logic,
    get_staticdata = mobkit.statfunc,
    on_activate = paleotest.on_activate,
    on_step = paleotest.on_step,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 25, true, true) then
            return
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:angler_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "paleotest_angler_fg.png",
                male_image = "paleotest_angler_fg.png",
                diet = "Carnivore",
                temper = "Opportunistic"
            }))
        end
        if clicker:get_wielded_item():get_name() == "" then
            mob_core.mount(self, clicker)
        end
        if clicker:get_wielded_item():get_name() == "cryopod:cryopod" then
        cryopod.capture_with_cryopod(self, clicker)
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

mob_core.register_spawn_egg("paleotest:angler", "42635acc", "354e46d9")

minetest.register_craftitem("paleotest:angler_dossier", {
	description = "AnglerFish Dossier",
	stack_max= 1,
	inventory_image = "paleotest_angler_fg.png",
	groups = {dossier = 1},
})
