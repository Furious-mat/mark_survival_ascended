------------------
-- Cnidaria --
------------------

local function set_mob_tables(self)
    for _, entity in pairs(minetest.luaentities) do
        local name = entity.name
        if name ~= self.name and
            paleotest.find_string(paleotest.mobkit_mobs, name) and
            name ~= "paleotest:alpha_megalodon" and
            name ~= "paleotest:ammonite" and
            name ~= "paleotest:basilosaurus" and
            name ~= "paleotest:coelacanth" and
            name ~= "paleotest:dunkleosteus" and
            name ~= "paleotest:ichthyosaurus" and
            name ~= "paleotest:electrophorus" and
            name ~= "paleotest:leedsichthys" and
            name ~= "paleotest:liopleurodon" and
            name ~= "paleotest:piranha" and
            name ~= "paleotest:plesiosaurus" and
            name ~= "paleotest:angler" and
            name ~= "paleotest:alpha_mosasaurus" and
            name ~= "paleotest:alpha_tusoteuthis" and
            name ~= "paleotest:manta" and
            name ~= "paleotest:salmon" and
            name ~= "paleotest:alpha_leedsichthys" and
            name ~= "paleotest:megalodon" and
            name ~= "paleotest:mosasaurus" and
            name ~= "paleotest:tusoteuthis" then
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

local function cnidaria_logic(self)

    if not self.isinliquid then
        self.hp = 0
    end

    if self.hp <= 0 then
        mob_core.on_die(self)
        return
    end

    set_mob_tables(self)

    local prty = mobkit.get_queue_priority(self)
    local player = mobkit.get_nearby_player(self)

    if mobkit.timer(self, 1) then

        if prty < 10 and not self.isinliquid then
            paleotest.hq_flop(self, 10)
            return
        end

        if prty < 8 and self.hunger < self.max_hunger then
            if self.feeder_timer == 1 then
                paleotest.hq_aqua_go_to_feeder(self, 8,
                                               "paleotest:feeder_piscivore")
            end
        end

        if prty < 6 then
            if self.hunger < self.max_hunger / 1.25 then
                mob_core.logic_aqua_attack_mobs(self, 6)
            end
        end

        if prty < 4 then
            if player
            and not self.child then
                mob_core.logic_aqua_attack_player(self, 4, player)
            end
        end

        if mobkit.is_queue_empty_high(self) then
            mob_core.hq_aqua_roam(self, 0, 0.8, 3, 12)
        end
    end
end

minetest.register_entity("paleotest:cnidaria", {
    -- Stats
    max_hp = 180,
    armor_groups = {fleshy = 80},
    view_range = 30,
    reach = 5,
    damage = 30,
    knockback = -10,
    -- Movement & Physics
    max_speed = 1,
    stepheight = 1.26,
    jump_height = 1.26,
    buoyancy = 1,
    springiness = 0,
    obstacle_avoidance_range = 1.5,
    surface_avoidance_range = 2,
    floor_avoidance_range = 2,
    -- Visual
	collisionbox = {-0.3, -0.01, -0.3, 0.3, 0.95, 0.3},
	visual_size = {x = 5.0, y = 5.0},
    scale_stage1 = 0.25,
    scale_stage2 = 0.5,
    scale_stage3 = 0.75,
    glow = 16,
    visual = "mesh",
    mesh = "paleotest_cnidaria.b3d",
    textures = {"paleotest_cnidaria.png"},
    animation = {
        swim = {range = {x = 1, y = 40}, speed = 30, loop = true},
        run = {range = {x = 1, y = 40}, speed = 35, loop = true},
        punch = {range = {x = 50, y = 70}, speed = 15, loop = false}
    },
    -- Sound
    sounds = {
        alter_child_pitch = true,
        random = {
            name = "",
            gain = 1.0,
            distance = 16
        },
        hurt = {
            name = "",
            gain = 1.0,
            distance = 16
        },
        death = {
            name = "",
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
    max_hunger = 1200,
    punch_cooldown = 0.1,
    defend_owner = false,
    targets = {},
    follow = paleotest.global_meat,
    drops = {{name = "paleotest:bio_toxin", chance = 1, min = 15, max = 30}},
    timeout = 0,
    logic = cnidaria_logic,
    get_staticdata = mobkit.statfunc,
    on_activate = paleotest.on_activate,
    on_step = paleotest.on_step,
    on_rightclick = function(self, clicker)
        if paleotest.feed_tame(self, clicker, 5, false, false) then
            return
        end
        if clicker:get_wielded_item():get_name() == "paleotest:field_guide" then
            minetest.show_formspec(clicker:get_player_name(),
                                   "paleotest:cnidaria_guide",
                                   paleotest.register_fg_entry(self, {
                image = "paleotest_cnidaria_fg.png",
                diet = "Carnivore",
                temper = "Aggressive"
            }))
        end
        mob_core.nametag(self, clicker)
    end,
    on_punch = function(self, puncher, _, tool_capabilities, dir)
        paleotest.on_punch(self)
        mob_core.on_punch_basic(self, puncher, tool_capabilities, dir)
        mob_core.on_punch_retaliate(self, puncher, true, false)
    end
})

mob_core.register_spawn_egg("paleotest:cnidaria", "495863cc", "262d34d9")

minetest.register_craftitem("paleotest:cnidaria_dossier", {
	description = "Cnidaria Dossier",
	stack_max= 1,
	inventory_image = "paleotest_cnidaria_fg.png",
	groups = {dossier = 1},
	on_use = function(itemstack, user, pointed_thing)
		xp_redo.add_xp(user:get_player_name(), 100)
		itemstack:take_item()
		return itemstack
	end,
})
