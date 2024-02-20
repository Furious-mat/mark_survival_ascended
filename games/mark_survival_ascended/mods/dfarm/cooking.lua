--------------------------------------------------------------------------------
--  Vegetables soup ( Master Cook )
--------------------------------------------------------------------------------
local S = minetest.get_translator("dfarm")

 minetest.register_craftitem("dfarm:vegetables_soup", {
	description = S("Vegetables Soup"),
	inventory_image = "dfarm_vegetables_soup.png",
	stack_max = 1, ---- não pode agrupar itens
	
	on_use = 
	minetest.item_eat(15,"dfarm:bowl")
	
		
})

minetest.register_craft({
    type = "shaped",
    output = "dfarm:vegetables_soup 1",
    recipe = {
        {"","", ""},
        {"dfarm:seed_potato", "dfarm:pumpkin_slice",  "dfarm:seed_carrot"},
        {"", "dfarm:bowl",  ""}
    }
})


-------------------------------------------------------------------------------
-- SUGAR 
-------------------------------------------------------------------------------
minetest.register_craftitem("dfarm:sugar", {
	description = S("Sugar"),
	inventory_image = "dsugar.png",
	--stack_max = 1, 
	on_use = minetest.item_eat(1)
	
		
})

minetest.register_craft({
		output = "dfarm:sugar 1",
		recipe = {{"default:papyrus"}}
	})

-------------------------------------------------------------------------------
-- PUMPKIN PIE
-------------------------------------------------------------------------------
minetest.register_craftitem("dfarm:pumpkin_Pie", {
	description = S("Pumpkin Pie"),
	inventory_image = "pumpkin_Pie.png",
	--stack_max = 1, 
    groups = {pie = 1},
	on_use = minetest.item_eat(10)
	
		
})

minetest.register_craft({
    type = "shaped",
    output = "dfarm:pumpkin_Pie 1",
    recipe = {
        {"","", ""},
        {"dfarm:pumpkin_slice","dfarm:pumpkin_slice","dfarm:pumpkin_slice"},
        {"farming:flour", "dfarm:sugar","group:egg"}
    }
})


-------------------------------------------------------------------------------
-- APPLE PIE
-------------------------------------------------------------------------------
minetest.register_craftitem("dfarm:apple_Pie", {
	description = S("Apple Pie"),
	inventory_image = "apple_Pie.png",
	--stack_max = 1, 
    groups = {pie = 1},
	on_use = minetest.item_eat(10)
	
		
})

minetest.register_craft({
    type = "shaped",
    output = "dfarm:apple_Pie 1",
    recipe = {
        {"","", ""},
        {"default:apple","default:apple","default:apple"},
        {"farming:flour", "dfarm:sugar","group:egg"}
    }
})


-------------------------------------------------------------------------------
-- COOKIES
-------------------------------------------------------------------------------
minetest.register_craftitem("dfarm:strawberry_cookie", {
	description = S("Strawberry Cookie"),
	inventory_image = "coockie.png",
	--stack_max = 1, 
    groups = {pie = 1},
	on_use = minetest.item_eat(10)
	
		
})

minetest.register_craft({
    type = "shaped",
    output = "dfarm:strawberry_cookie 1",
    recipe = {
        {"dfarm:strawberry","dfarm:strawberry", "dfarm:strawberry"},
        {"farming:flour","dfarm:sugar","farming:flour"},
        {"", "",""}
    }
})






