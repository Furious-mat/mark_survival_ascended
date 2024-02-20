------------------
-- Alpha Leedsichthys --
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

local function leedsichthys_logic(self)

    if self.hp <= 0 then
        mob_core.on_die(self)
        return
    end

    set_mob_tables(self)

    if self.mood < 50 then paleotest.block_breaking(self) end

    local prty = mobkit.get_queue_priority(self)
    local player = mobkit.get_nearby_player(self)

    if mobkit.timer(self, 1) then

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

minetest.register_entity("paleotest:alpha_leedsichthys", {
    -- Stats
    max_hp = 8800,
    armor_groups = {fleshy = 100},
    view_range = 16,
    reach = 5,
    damage = 160,
    knockback = 1,
    -- Movement & Physics
    max_speed = 6,
    stepheight = 1.26,
    jump_height = 1.26,
    buoyancy = 1,
    springiness = 0,
    obstacle_avoidance_range = 2,
    surface_avoidance_range = 1,
    floor_avoidance_range = 1,
    turn_rate = 4,
    -- Visual
	collisionbox = {-4, -2, -4, 4, 2, 4},
	visual_size = {x=1.5, y=1.5},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    glow = 16,
    visual = "mesh",
    mesh = "paleotest_leedsichthys.b3d",
    female_textures = {"paleotest_alpha_leedsichthys.png"},
    male_textures = {"paleotest_alpha_leedsichthys.png"},
    child_textures = {"paleotest_alpha_leedsichthys.png"},
    animation = {
        swim = {range = {x = 1, y = 40}, speed = 30, loop = true},
        run = {range = {x = 1, y = 40}, speed = 35, loop = true},
        punch = {range = {x = 50, y = 70}, speed = 15, loop = false}
    },
    -- Sound
    sounds = {
        alter_child_pitch = true,
        random = {
            name = "paleotest_leedsichthys",
            gain = 1.0,
            distance = 16
        },
        hurt = {
            name = "paleotest_leedsichthys",
            gain = 1.0,
            distance = 16
        },
        death = {
            name = "paleotest_leedsichthys",
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
    max_hunger = 8000,
    punch_cooldown = 1,
    defend_owner = true,
    targets = {},
    follow = paleotest.global_fish,
    drops = {
        {name = "paleotest:fish_meat_raw", chance = 1, min = 300, max = 600},
        {name = "paleotest:raw_prime_fish_meat", chance = 1, min = 250, max = 350},
        {name = "paleotest:hide", chance = 1, min = 200, max = 300},
        {name = "paleotest:alpha_leedsichthys_blubber", chance = 1, min = 1, max = 1}
    },
    timeout = 0,
    logic = leedsichthys_logic,
    get_staticdata = mobkit.statfunc,
    on_activate = paleotest.on_activate,
    on_step = paleotest.on_step,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 100, false, false) then
            return
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:leedsichthys_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "paleotest_leedsichthys_fg.png",
                male_image = "paleotest_leedsichthys_fg.png",
                diet = "Piscivore",
                temper = "Defensive (Alpha)"
            }))
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

mob_core.register_spawn_egg("paleotest:alpha_leedsichthys", "533b29cc", "4d3627d9")
