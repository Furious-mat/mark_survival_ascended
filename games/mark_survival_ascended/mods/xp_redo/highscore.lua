

-- ordered list: { name: '', xp: 0 }
xp_redo.highscore = {}

local fname = minetest.get_worldpath().."/highscore.txt"


local write_file = function()
   local f = io.open(fname, "w")
   local data_string = minetest.serialize(xp_redo.highscore)
   f:write(data_string)
   io.close(f)
end

local f = io.open(fname, "r")
if f then   -- file exists
   local data_string = f:read("*all")
   xp_redo.highscore = minetest.deserialize(data_string)
   io.close(f)
else
   write_file()
end


local update_highscore = function()
	local players = minetest.get_connected_players()

	for _,player in pairs(players) do
		local name = player:get_player_name()
		local xp = player:get_meta():get_int("xp")
		local found = false
		for _,entry in pairs(xp_redo.highscore) do
			if entry.name == name then
				-- connected player already exists in highscore, update value
				entry.xp = xp
				found = true
			end
		end

		if not found then
			-- create new entry
			table.insert(xp_redo.highscore, { name=name, xp=xp })
		end
	end

	-- sort
	table.sort(xp_redo.highscore, function(a,b) return a.xp > b.xp end)

	-- truncate
	while table.getn(xp_redo.highscore) > 10 do
		table.remove(xp_redo.highscore, table.getn(xp_redo.highscore))
	end
end

local timer = 0
minetest.register_globalstep(function(dtime)
   timer = timer + dtime;
   if timer >= 60 then
      update_highscore()
      write_file()
      timer = 0
   end
end)
