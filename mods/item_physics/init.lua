
local builtin_item = minetest.registered_entities["__builtin:item"]

local flat_node_types = {
    signlike = true,
    raillike = true,
    torchlike = true,
    plantlike = true,
}
-- rot = vector.new(0,0,1):rotate(rot)
local new_item_ent = {
    _get_is_node = function(self, itemstring)
        local stack = ItemStack(itemstring)
        local idef = minetest.registered_items[stack:get_name()]
        if not idef then return false end
        if idef.type ~= "node" then return false end
        if flat_node_types[idef.drawtype] ~= nil then return false end
        if idef.wield_image ~= "" then return false end
        return true
    end,
    _item_stick = function(self)
        self._is_stuck = true
        if (not self._is_node) then
            local rot = self.object:get_rotation()
            rot = vector.new(math.pi*0.5, rot.y, 0)
            self.object:set_rotation(rot)
        end
    end,
    _item_unstick = function(self)
        self._is_stuck = false
        local rot = self.object:get_rotation()
        rot = vector.new(0, rot.y, 0)
        self.object:set_rotation(rot)
    end,
    enable_physics = function(self)
        local ret = builtin_item.enable_physics(self)
        self:_item_unstick()
    end,
    disable_physics = function(self)
        local ret = builtin_item.disable_physics(self)
        self:_item_stick()
    end,
    set_item = function(self, itemstring, ...)
        local ret = builtin_item.set_item(self, itemstring, ...)
        -- init, remove `automatic_rotate` because it's broken
        local collisionbox = {-0.3, -0.18, -0.3, 0.3, 0.3, 0.3}
        self._is_node = self:_get_is_node(itemstring)
        if (not self._is_node) then
            collisionbox = {-0.3, -0.03, -0.3, 0.3, 0.3, 0.3}
        end
        self.object:set_properties({
            automatic_rotate = 0,
            collisionbox = collisionbox,
        })
        self.object:set_rotation(vector.new(0,math.random()*math.pi*2, 0))
        if self._is_stuck then
            self:_item_stick()
        else
            self:_item_unstick()
        end
        return ret
    end,
    try_merge_with = function(self, own_stack, object, entity, ...)
        return builtin_item.try_merge_with(self, own_stack, object, entity, ...)
    end,
    _do_idle_rotation = function(self, amount)
        local rot = self.object:get_rotation()
        if not rot then return end
        rot = vector.new(0, rot.y - amount * self._spin_dir, 0)
        self.object:set_rotation(rot)
    end,
    on_step = function(self, dtime, moveresult, ...)
        if not self._spin_dir then
            self._spin_dir = math.random(0,1)*2-1
        end
        -- prevent unloaded nil errors just in case
        local pos = self.object:get_pos()
        local vel = self.object:get_velocity()
        if not pos then return end
        if not self._is_stuck then
            local spin_speed = math.min(0.3, dtime * vel:length())
            self._do_idle_rotation(self, spin_speed)
        end

        -- if it's not moving, stick
        if not self._is_node then vel.x = 0; vel.z = 0; end
        local should_stick = (math.abs(vel.x) + math.abs(vel.y) + math.abs(vel.z) < 0.1)
        if should_stick and not self._is_stuck then
            self:_item_stick()
        elseif self._is_stuck and not should_stick then
            self:_item_unstick()
        end

        builtin_item.on_step(self, dtime, moveresult, ...)
    end,
}

setmetatable(new_item_ent, { __index = builtin_item })
minetest.register_entity(":__builtin:item", new_item_ent)
