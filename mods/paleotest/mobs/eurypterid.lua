-------------------
-- Eurypterid --
-------------------

local function set_mob_tables(self)
    for _, entity in pairs(minetest.luaentities) do
        local name = entity.name
        if name ~= self.name and
            paleotest.find_string(paleotest.mobkit_mobs, name) and
            name ~= "paleotest:achatina" and
            name ~= "paleotest:pulmonoscorpius" and
            name ~= "paleotest:araneo" and
            name ~= "paleotest:arthropluera" and
            name ~= "paleotest:dilophosaur" and
            name ~= "paleotest:leech" and
            name ~= "paleotest:leech_diseased" and
            name ~= "paleotest:megalania" and
            name ~= "paleotest:megalosaurus" and
            name ~= "paleotest:meganeura" and
            name ~= "paleotest:onyc" and
            name ~= "paleotest:titanoboa" and
            name ~= "paleotest:titanomyrma" and
            name ~= "paleotest:titanomyrma_soldier" and
            name ~= "paleotest:dung_beetle" then
            local height = entity.height
            if not paleotest.find_string(self.targets, name) and height and
                height < 3.5 then
                if entity.object:get_armor_groups() and
                    entity.object:get_armor_groups().fleshy then
                    table.insert(self.targets, name)
                elseif entity.name:match("^petz:") then
                    table.insert(self.targets, name)
                end
                if entity.targets and
                    paleotest.find_string(entity.targets, self.name) then
                    if entity.object:get_armor_groups() and
                        entity.object:get_armor_groups().fleshy then
                        table.insert(self.rivals, name)
                    end
                end
            end
        end
    end
end

local function give_xp_to_nearby_players(pos)
    local players = minetest.get_objects_inside_radius(pos, 10)
    for _, obj in ipairs(players) do
        if obj:is_player() then
            xp_redo.add_xp(obj:get_player_name(), 30)
        end
    end
end

local function eurypterid_logic(self)

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

        if self.order == "stand" and self.mood > 50 then
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

            if prty < 14 then
                if self.hunger < self.max_hunger and self.feeder_timer == 1 then
                    if math.random(1, 2) == 1 then
                        paleotest.hq_go_to_feeder(self, 14,
                                                  "paleotest:feeder_carnivore")
                    else
                        paleotest.hq_eat_items(self, 14)
                    end
                end
            end

            if prty < 12 then
                if not self.child then
                    if self.attacks == "mobs" or self.attacks == "all" then
                        table.insert(self.targets, self.name)
                        mob_core.logic_attack_mobs(self, 12)
                    end
                    if self.mood < 90 or not self.tamed then
                        mob_core.logic_attack_mobs(self, 12)
                    end
                    if #self.rivals > 0 then
                        mob_core.logic_attack_mobs(self, 12, self.rivals)
                    end
                end
            end

            if prty < 10 then
                if player and not self.child then
                    if (self.attacks == "players" or self.attacks == "all") and
                        player:get_player_name() ~= self.owner then
                        mob_core.logic_attack_player(self, 10, player)
                    end
                    if self.mood > 50 and player:get_player_name() ~= self.owner then
                        mob_core.logic_attack_player(self, 10, player)
                    elseif self.mood < 50 then
                        mob_core.logic_attack_player(self, 10, player)
                    end
                end
            end

            if prty < 8 then
                if self.mood > 50 then
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
                if math.random(1, 150) == 1 then
                    paleotest.hq_roar(self, 4, "roar")
                end
            end
        end

        if prty < 2 then
            if self.sleep_timer <= 0 and self.status ~= "following" then
                paleotest.hq_sleep(self, 2)
            end
        end

        if mobkit.is_queue_empty_high(self) then
            mob_core.hq_roam(self, 0)
        end
    end
    
    local megatherium_nearby = false
    for _, obj in ipairs(minetest.get_objects_inside_radius(self.object:getpos(), 5)) do
        if obj:get_luaentity() and obj:get_luaentity().name == "paleotest:megatherium" then
            megatherium_nearby = true
            break
        end
    end

    if megatherium_nearby then
        self.hp = 0
    end
end

minetest.register_entity("paleotest:eurypterid", {
    -- Stats
    max_hp = 160,
    armor_groups = {fleshy = 80},
    view_range = 20,
    reach = 3,
    damage = 7,
    knockback = 8,
    -- Movement & Physics
    max_speed = 3,
    stepheight = 1.26,
    jump_height = 1.26,
    max_fall = 3,
    buoyancy = 10,
    springiness = 0,
    -- Visual
	collisionbox = {-0.5, -0.01, -0.5, 0.5, 0.5, 0.5},
    visual_size = {x = 3, y = 3},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    visual = "mesh",
    mesh = "paleotest_eurypterid.b3d",
    female_textures = {"paleotest_eurypterid.png"},
    male_textures = {"paleotest_eurypterid.png"},
    child_textures = {"paleotest_eurypterid.png"},
    sleep_overlay = "paleotest_eurypterid.png",
    child_sleep_overlay = "paleotest_eurypterid.png",
    animation = {
        stand = {range = {x = 1, y = 59}, speed = 15, loop = true},
        walk = {range = {x = 70, y = 100}, speed = 20, loop = true},
        run = {range = {x = 70, y = 100}, speed = 25, loop = true},
        punch = {range = {x = 110, y = 125}, speed = 15, loop = true},
        sleep = {range = {x = 170, y = 230}, speed = 15, loop = true}
    },
    -- Basic
    physical = true,
    collide_with_objects = true,
    static_save = true,
    needs_enrichment = true,
    live_birth = false,
    max_hunger = 450,
    punch_cooldown = 1,
    defend_owner = true,
    imprint_tame = true,
    targets = {},
    rivals = {},
    follow = paleotest.global_spoiled,
    drops = {
        {name = "paleotest:black_pearl", chance = 1, min = 5, max = 10},
        {name = "paleotest:chitin", chance = 1, min = 10, max = 20},
        {name = "paleotest:oil", chance = 1, min = 5, max = 10},
        {name = "paleotest:meat_raw", chance = 1, min = 10, max = 20},
        {name = "paleotest:silica_pearls", chance = 1, min = 3, max = 6}
    },
    timeout = 0,
    logic = eurypterid_logic,
    get_staticdata = mobkit.statfunc,
    on_activate = paleotest.on_activate,
    on_step = paleotest.on_step,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 10, false, false) then
            return
        end
        paleotest.imprint_tame(self, clicker)
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:eurypterid_guide",
                                   paleotest.register_fg_entry(self, {
                female_image = "paleotest_eurypterid_fg.png",
                male_image = "paleotest_eurypterid_fg.png",
                diet = "Carnivore",
                temper = "Aggressive"
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
            if puncher:get_player_name() == self.owner and self.mood > 50 then
                return
            end
            mob_core.on_punch_retaliate(self, puncher, false, false)
        end
    end
})

mob_core.register_spawn_egg("paleotest:eurypterid", "c0926acc", "996433d9")

minetest.register_craftitem("paleotest:eurypterid_dossier", {
	description = "Eurypterid Dossier",
	stack_max= 1,
	inventory_image = "paleotest_eurypterid_fg.png",
	groups = {dossier = 1},
	on_use = function(itemstack, user, pointed_thing)
		xp_redo.add_xp(user:get_player_name(), 100)
		itemstack:take_item()
		return itemstack
	end,
})
