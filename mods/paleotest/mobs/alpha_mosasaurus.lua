----------------
-- Alpha Mosasaurus --
----------------

local function set_mob_tables(self)
    for _, entity in pairs(minetest.luaentities) do
        local name = entity.name
        if name ~= self.name and
            paleotest.find_string(paleotest.mobkit_mobs, name) and
            name ~= "paleotest:angler" and
            name ~= "paleotest:ammonite" and
            name ~= "paleotest:basilosaurus" and
            name ~= "paleotest:cnidaria" and
            name ~= "paleotest:coelacanth" and
            name ~= "paleotest:dunkleosteus" and
            name ~= "paleotest:ichthyosaurus" and
            name ~= "paleotest:electrophorus" and
            name ~= "paleotest:leedsichthys" and
            name ~= "paleotest:liopleurodon" and
            name ~= "paleotest:piranha" and
            name ~= "paleotest:manta" and
            name ~= "paleotest:megalodon" and
            name ~= "paleotest:alpha_tusoteuthis" and
            name ~= "paleotest:plesiosaurus" and
            name ~= "paleotest:salmon" and
            name ~= "paleotest:alpha_leedsichthys" and
            name ~= "paleotest:alpha_megalodon" and
            name ~= "paleotest:mosasaurus" and
            name ~= "paleotest:tusoteuthis" then
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

local function give_xp_to_nearby_players(pos)
    local players = minetest.get_objects_inside_radius(pos, 10)
    for _, obj in ipairs(players) do
        if obj:is_player() then
            xp_redo.add_xp(obj:get_player_name(), 250)
        end
    end
end

local function mosasaurus_logic(self)

    if not self.isinliquid then
        self.hp = 0
    end

    if self.hp <= 0 then
        local pos = self.object:get_pos()
        mob_core.on_die(self)
        give_xp_to_nearby_players(pos)
        return
    end

    set_mob_tables(self)

    local prty = mobkit.get_queue_priority(self)
    local player = mobkit.get_nearby_player(self)

    if mobkit.timer(self, 1) then

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

minetest.register_entity("paleotest:alpha_mosasaurus", {
    -- Stats
    max_hp = 54000,
    armor_groups = {fleshy = 100},
    view_range = 32,
    reach = 6,
    damage = 200,
    knockback = 6,
    -- Movement & Physics
    max_speed = 12,
    stepheight = 1.1,
    jump_height = 1.26,
    buoyancy = 1,
    springiness = 0,
    obstacle_avoidance_range = 1.5,
    surface_avoidance_range = 4,
    floor_avoidance_range = 4,
    -- Visual
    collisionbox = {-1.8, -1, -1.8, 1.8, 1.8, 1.8},
    visual_size = {x = 50, y = 50},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    glow = 16,
    visual = "mesh",
    mesh = "paleotest_mosasaurus.b3d",
    textures = {
        "paleotest_alpha_mosasaurus.png", "paleotest_alpha_mosasaurus.png"
    },
    female_texture = {"paleotest_alpha_mosasaurus.png"},
    male_texture = {"paleotest_alpha_mosasaurus.png"},
    child_texture = {"paleotest_alpha_mosasaurus.png"},
    animation = {
        swim = {range = {x = 1, y = 40}, speed = 20, loop = true},
        run = {range = {x = 1, y = 40}, speed = 25, loop = true},
        punch = {range = {x = 50, y = 80}, speed = 7, loop = false}
    },
    -- Basic
    physical = true,
    collide_with_objects = true,
    static_save = true,
    needs_enrichment = false,
    live_birth = true,
    max_hunger = 8000,
    defend_owner = true,
    imprint_tame = true,
    targets = {},
    follow = paleotest.global_meat,
    drops = {
        {name = "paleotest:raw_prime_meat", chance = 1, min = 30, max = 50},
        {name = "paleotest:raw_prime_fish_meat", chance = 1, min = 20, max = 30},
        {name = "fishing_rod:fishing_rod", chance = 1, min = 1, max = 1},
        {name = "paleotest:black_pearl", chance = 1, min = 100, max = 100},
        {name = "paleotest:alpha_mosasaurus_tooth", chance = 1, min = 1, max = 1}
    },
    timeout = 0,
    logic = mosasaurus_logic,
    get_staticdata = mobkit.statfunc,
    on_activate = paleotest.on_activate,
    on_step = paleotest.on_step,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 200, false, false) then
            return
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:mosasaurus_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "paleotest_mosasaurus_fg_female.png",
                male_image = "paleotest_mosasaurus_fg_male.png",
                diet = "Carnivore",
                temper = "Aggressive (Alpha)"
            }))
        end
        if self.mood > 50 then paleotest.set_order(self, clicker) end
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

mob_core.register_spawn_egg("paleotest:alpha_mosasaurus", "42635acc", "354e46d9")
