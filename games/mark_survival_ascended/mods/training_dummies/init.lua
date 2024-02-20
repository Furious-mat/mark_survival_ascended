local S = minetest.get_translator("training_dummies") -- [Ru,Es,Fr,En,De,It]


minetest.register_entity("training_dummies:training_dummies", {
    initial_properties = {
        physical = true,
        visual = "mesh",
        visual_size = {x = 12, y = 11},
        hp_max = 750,
        mesh = "training_dummies.obj",
        textures = {"training_dummies.png"},
        collisionbox = {-0.25, 0, -0.25, 0.25, 2.5, 0.25},
    },

    on_activate = function(self)
        self.object:set_armor_groups({fleshy = 100})
        self.hp = self.object:get_hp()
    end,

    update_nametag = function(self)
        local current_hp = self.object:get_hp()
        local hp_max = 750
        local hp_change = current_hp - (self.hp or current_hp)
        if hp_change ~= 0 then
            self.hp = current_hp
            local damage = hp_change * -1
            local nametag_text = S("Health: ") .. current_hp .. "/" .. hp_max ..  " \n" .. S("Damage: ") .. damage
            self.object:set_properties({nametag = nametag_text})
            minetest.after(5, function()
                if self.object:get_hp() == current_hp then
                    self.object:set_properties({nametag = ""})
                end
            end)
        end
    end,

    on_step = function(self, dtime)
        self.object:set_velocity({x = 0, y = -9.81, z = 0})
        local pos = self.object:get_pos()
        local nearby_nodes = minetest.find_nodes_in_area(
            {x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
            {x = pos.x + 1, y = pos.y + 2, z = pos.z + 1},
            {"group:fire", "group:lava"})

        if #nearby_nodes > 0 then
            if not self.fire_damage_timer or self.fire_damage_timer <= 0 then
                self.object:set_properties({textures = {"training_dummies.png"}})
                self.object:set_hp(self.object:get_hp() - 4)

                if minetest.get_modpath("default") then
                    minetest.sound_play("fire_extinguish_flame", {pos = pos, gain = 1.0})
                end

                self.fire_damage_timer = 1
            else
                self.fire_damage_timer = self.fire_damage_timer - dtime
            end
        else
            self.object:set_properties({textures = {"training_dummies.png"}})
            self.fire_damage_timer = nil
        end

        local hp = self.object:get_hp() or 0
        if hp <= 75 then
            self.object:set_properties({textures = {"training_dummies_broke_1.png"}})
        end

        if hp <= 35 then
            self.object:set_properties({textures = {"training_dummies_broke_2.png"}})
        end
        self:update_nametag()
    end,


    on_punch = function(self)
        self:update_nametag()
        if minetest.get_modpath("default") then
        local hp = self.object:get_hp() or 0
        if hp <= 50 then
            minetest.sound_play("default_wood_footstep", {pos = self.object:get_pos(), gain = 1.0})
        end
        if hp <= 20 then
            minetest.sound_play("default_tool_breaks", {pos = self.object:get_pos(), gain = 1.0})
            end
        end
    end,

    on_rightclick = function(self, clicker)
        if clicker and clicker:is_player() then
            self.object:remove()
            local leftover = clicker:get_inventory():add_item("main", ItemStack("training_dummies:training_dummies"))
            if not leftover:is_empty() then
                minetest.add_item(clicker:get_pos(), leftover)
            end
        end
    end,
})

minetest.register_craftitem("training_dummies:training_dummies", {
    description = S("Training Dummies"),
    inventory_image = "training_dummies_item.png",
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type == "node" then
            local pos = pointed_thing.under
            pos.y = pos.y + 0.5
            minetest.add_entity(pos, "training_dummies:training_dummies")
            itemstack:take_item()
            return itemstack
        end
    end,
})

minetest.register_craft({
    output = "training_dummies:training_dummies",
    recipe = {
        {"", "default:tree", ""},
        {"farming:straw", "default:tree", "farming:straw"},
        {"default:tree", "default:tree", "default:tree"},
    }
})


        --[[
            local color = ""
            if damage > 10 and damage <= 16 then
                color = minetest.colorize("#e26800", nametag_text)
            elseif damage > 16 and damage <= 30 then
                color = minetest.colorize("#e20000", nametag_text)
            elseif damage > 30 then
                color = minetest.colorize("#692f2f", nametag_text)
            else
                color = nametag_text
            end

        self.object:set_properties({nametag = color})
]]--
