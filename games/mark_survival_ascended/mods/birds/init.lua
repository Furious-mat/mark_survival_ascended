local totalBirdCount = 0
local emptyTable = {}

local birdNames = {"white","sparrow","red","blue","eagle"}
local Paleotest = minetest.get_modpath("paleotest")
math.randomseed( os.time() )
local Bird = {
	speed = 5,
    initial_properties = {
        hp_max = 1,
        physical = true,
        collide_with_objects = false,
        collisionbox = {-0.3, -0.3, -0.3, 0.3, 0.3, 0.3},
        visual = "mesh",
        mesh = "bird.b3d",
        visual_size = {x = 1, y = 1},		
		textures = {
			"birds_white_bottom.png",
			"birds_white_top.png",
			"birds_white_top.png",
			"birds_white_bottom.png",
		},
        static_save = false,
        automatic_face_movement_dir = 0,
		--automatic_face_movement_max_rotation_per_sec = 100,
    },
	follow = nil,
	followers = {},
	time = 0,
	deletetimer = 0,
}

--causes crashes for unknown reasons
--~ function Bird:endRelations()
	--~ local followers = self.followers
	--~ if self.follow then
		--~ local f = self.follow.followers
		
		--~ table.remove(f,table.find(f,self))
		--~ self.follow = nil
	--~ end
	
	
	--~ if #followers > 0 then
		--~ for k,v in ipairs(followers) do
			--~ v.follow = nil
		--~ end
		--~ self.followers = emptyTable
	--~ end
--~ end

function Bird:on_activate(staticdata, dtime_s)
	totalBirdCount = totalBirdCount + 1
	self.object:set_animation({x=0,y=80},24,0,true)
	--self.object:set_rotation({0,0,math.pi/2})
	
	--fly in random direction
	local yaw = (math.random()*math.pi*2)		
	local x = math.sin(yaw) * -1 * self.speed
	local z = math.cos(yaw) * 1 * self.speed
	self.object:set_velocity({x=x, y=0, z=z})
end

function Bird:on_deactivate(removal)
	--~ self:endRelations()

	if removal then
		totalBirdCount = totalBirdCount - 1
		--minetest.chat_send_player("singleplayer","Bird deleted. New count: "..totalBirdCount)
	else
		self.object:remove()
	end
	
end

function Bird:on_punch(hitter)
    if Paleotest then
		minetest.add_item(self.object:get_pos(),"paleotest:meat_raw")
    end
end


--~ minetest.chat_send_player("singleplayer","Ow!")

local v_axis_y = {x=0,y=1,z=0}
function Bird:on_step(dtime, moveresult)
	local obj = self.object
	
	if not self.follow then
		self.deletetimer = self.deletetimer + dtime
		if self.deletetimer > 10 then
			local list = minetest.get_connected_players()
			if #list == 0 then
				obj:remove()
				return
			else
				local nearPlayers = 0
				for _,p in ipairs(list) do
					if vector.distance( p:get_pos(), obj:get_pos() ) < 50 then
						nearPlayers = nearPlayers + 1
					end
				end
				if nearPlayers == 0 then
					--minetest.chat_send_player("singleplayer","Bird deleted. New count: "..totalBirdCount)
					obj:remove()
					return
				end
			end
			self.deletetimer = 0
		end
	end
	
	--preserves speed on collision
	if moveresult.collides then
		--don't follow anymore
		self.follow = nil
		--~ self:endRelations()
		
		local c = moveresult.collisions
		
		obj:set_velocity(
				vector.rotate_around_axis(
					vector.new(self.speed,0,0),
					v_axis_y,
					obj:get_yaw()
				)
			)
	
	end

    self.time = self.time + dtime
	
	if self.follow and self.follow.object:get_pos() then
		obj:set_velocity(self.follow.object:get_velocity())
	
	else
	
		if self.time >= 0.3 then
			self.time = 0
			
			obj:set_velocity(
				vector.rotate_around_axis(
					obj:get_velocity(),
					v_axis_y,
					(math.random()-0.5)*2 *0.1
				)
			)
				--self.initial_sprite_basepos = {1,5}
			--  minetest.chat_send_player("singleplayer", self.message)
		end
	end
end

local function copy(obj, seen)
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
  return res
end

for _,birdName in ipairs(birdNames) do
	local b = copy(Bird)
	b.initial_properties.textures = {
			"birds_"..birdName.."_bottom.png",
			"birds_"..birdName.."_top.png",
			"birds_"..birdName.."_top.png",
			"birds_"..birdName.."_bottom.png",
		}
	minetest.register_entity("birds:"..birdName, b)

end

local spawnOffsetMult = vector.new(20.0,3.0,20.0)
function spawnSwarm(pos)
	if minetest.get_node(pos).name ~= "air" then
		return false
	end
	
	for x=pos.x-spawnOffsetMult.x/2,pos.x+spawnOffsetMult.x/2 do
	for y=pos.y-spawnOffsetMult.y/2,pos.y+spawnOffsetMult.y/2 do
	for z=pos.z-spawnOffsetMult.z/2,pos.z+spawnOffsetMult.z/2 do
		if minetest.get_node(pos).name ~= "air" then
			return false
		end
	end
	end
	end
	
	pos.x = pos.x + 3
	local b = "birds:"..birdNames[math.ceil(math.random()*#birdNames)]
	
	local leader = minetest.add_entity(pos,b)
	
	leader = leader:get_luaentity()
	for i=1,math.floor(math.random()*10) do
		local e = minetest.add_entity(
			vector.add(
				pos,
				vector.multiply(vector.new(math.random()-0.5,math.random()-0.5,math.random()-0.5),spawnOffsetMult)
				),
			b
		)
		
		e = e:get_luaentity()
		e.follow = leader
		--~ table.insert(leader.followers,e)
	end
	return true
end

local timeout = 0
local itable = {}
minetest.register_globalstep(function(dtime)
	timeout = timeout - dtime
	if timeout <= 0 and totalBirdCount < 100 then
		local list = minetest.get_connected_players()
		if #list == 0 then timeout = 3 return end
		local p = list[math.ceil(math.random()*#list)]
		local pos = p:get_pos()
		
		if pos.y > -50 and pos.y < 300 then
			pos.y = math.max(pos.y,60) + math.random()*30
			pos.x = pos.x + (math.random()-0.5)*100
			pos.z = pos.z + (math.random()-0.5)*100
			if not spawnSwarm(pos) then timeout = 3 return end
		end
	end
end)
