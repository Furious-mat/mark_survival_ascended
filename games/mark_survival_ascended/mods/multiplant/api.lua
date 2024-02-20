multiplant.get_all_seeds = function()
    
    local things={}
    for name, def in pairs(minetest.registered_items) do
        local group=def.groups or {}
        if not group.not_in_creative_inventory then
            if group.flora or 
               group.seed or
               group.sapling then
                table.insert(things,name)
                --minetest.log(name)
            end
        end
    end
    --[[
    minetest.log("Ausgabe gesammelter Daten:")
    minetest.log(table.concat(things, '",'.."\n"..'"'))
    minetest.log("-----------------")
    --]]
    multiplant.seeds=things
end

multiplant.get_random_seed=function()
    local x =math.random(table.maxn(multiplant.seeds))
    --minetest.log("Gebe ".. multiplant.seeds[x].. " zurück")
    return multiplant.seeds[x]
end


minetest.register_chatcommand("sapling", {
    privs = {
        interact = true,
    },
    func= function(name, param)
        if sapling_seeds ~= nil or 0 then
            return true, table.concat(multiplant.seeds, '",'.."\n"..'"')
        else
            return true, "Noch keine seeds gefunden" 
        end
    end,
})
