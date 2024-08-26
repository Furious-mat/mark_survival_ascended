missions.register_step({

    type = "teleport",
    name = "Teleport Entities",

    create = function()
        return { pos = nil }
    end,

    privs = { missions_teleport = true },

    validate = function(ctx)
        local stepdata = ctx.step.data

        if stepdata.pos == nil then
            return {
                success = false,
                failed = true,
                msg = "No position defined"
            }
        else
            return { success = true }
        end
    end,

    allow_inv_stack_put = function(listname, index, stack)
        -- allow position wand on pos 1 of main inv
        if listname == "main" and index == 1 and stack:get_name() == "missions:wand_position" then
            return true
        end

        return false
    end,

    edit_formspec = function(ctx)
        local stepdata = ctx.step.data
        local pos = ctx.pos

        local name = ""

        if stepdata.pos then
            local distance = vector.distance(pos, stepdata.pos)
            name = name .. "Position(" .. stepdata.pos.x .. "/" ..
                stepdata.pos.y .. "/" .. stepdata.pos.z .. ") " ..
                "Distance: " .. math.floor(distance) .. " m"
        end

        local formspec = "size[8,8;]" ..
            "label[0,0;Teleport Entities (Step #" .. ctx.stepnumber .. ")]" ..

            "list[nodemeta:" .. pos.x .. "," .. pos.y .. "," .. pos.z .. ";main;3,1;1,1;0]" ..
            "label[0,2;" .. name .. "]" ..

            "list[current_player;main;0,2.7;8,4;]listring[]" ..

            "button[0,7;8,1;save;Save]"

        return formspec;
    end,

    update = function(ctx)
        local fields = ctx.fields
        local inv = ctx.inv
        local stepdata = ctx.step.data

        if fields.save then
            local stack = inv:get_stack("main", 1)

            if not stack:is_empty() then
                local meta = stack:get_meta()
                local pos = minetest.string_to_pos(meta:get_string("pos"))
                local name = meta:get_string("name")

                stepdata.pos = pos
                stepdata.name = name
            end

            ctx.show_mission()
        end
    end,

    on_step_enter = function(ctx)
        local player = ctx.player
        local stepdata = ctx.step.data

        local pos = stepdata.pos
        pos.y = pos.y + 1
        local player_pos = player:get_pos()
        local nearby_entities = minetest.get_objects_inside_radius(player_pos, 10)
        local num_entities = #nearby_entities
        table.sort(nearby_entities, function(a, b)
            return vector.distance(player_pos, a:get_pos()) < vector.distance(player_pos, b:get_pos())
        end)
        for i = 1, math.min(num_entities, 20) do
            local entity = nearby_entities[i]
            if entity and entity:is_player() == false then
                entity:move_to(pos)
            end
        end

        ctx.on_success()
    end
})


