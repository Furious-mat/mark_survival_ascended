if minetest.get_modpath("hunger_ng") ~= nil then


	hunger_ng.add_hunger_data('dfarm:potato', {
		satiates = 1.0,
	})
	
	hunger_ng.add_hunger_data('dfarm:potato_baked', {
		satiates = 5.0,
	})
	
	
	hunger_ng.add_hunger_data('dfarm:carrot', {
		satiates = 2.0,
	})
	
	hunger_ng.add_hunger_data('dfarm:strawberry', {
		satiates = 2.0,
	})
	
	-- PUMPKIN :
	hunger_ng.add_hunger_data('dfarm:pumpkin_slice', {
		satiates = 1.0,
	})
	
	hunger_ng.add_hunger_data('dfarm:pumpkin_baked', {
		satiates = 3.0,
	})
	
	
	-- MELON :
	hunger_ng.add_hunger_data('dfarm:melon_slice', {
		satiates = 2.0,
	})
	
	-- Vegetables soup :
	hunger_ng.add_hunger_data('dfarm:vegetables_soup', {
		satiates = 10.0,
		 -- heals =0,       -- cura
		returns = "dfarm:bowl", 
		
	})
	
	--[[
	
	-- Sugar :
	hunger_ng.add_hunger_data('dfarm:sugar', {
		satiates = 0.5,
	})
	
	]]

	
		
end
