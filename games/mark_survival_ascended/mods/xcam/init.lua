--[[

xcam – Minetest mod that makes renderings of a scene using raycasting
Copyright © 2023  Nils Dagsson Moskopp (erlehmann)

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

Dieses Programm hat das Ziel, die Medienkompetenz der Leser zu
steigern. Gelegentlich packe ich sogar einen handfesten Buffer
Overflow oder eine Format String Vulnerability zwischen die anderen
Codezeilen und schreibe das auch nicht dran.

]]--

local get_setting = function( key, default_value )
	return tonumber( minetest.settings:get( key ) or default_value )
end

local create_photo_item = function( pixels )
	local itemstack = ItemStack( "xcam:photo" )
	local meta = itemstack:get_meta()

	local image = tga_encoder.image( pixels )
	image:encode()
	local texture_string = "[png:" .. minetest.encode_base64( image.data )
	meta:set_string(
		"inventory_image",
		texture_string
	)

	return itemstack
end

local clamp = function( x, min, max )
	return math.max( math.min( x, max ), min )
end

local get_node_color = function( node )
	local short_name = node.name:gmatch(":.+")():gsub(":", "")
	local value = ( #short_name % ( string.byte( short_name ) - 65 ) ) * 8
	if short_name:find("light") or short_name:find("snow") then
		value = 255
	end
	return clamp( value, 0, 255 )
end

local get_light = function( position )
	local node_light = minetest.get_node_light( position )
	return node_light and node_light / 16 or 0
end

local get_fog = function( distance )
   return clamp( math.pow ( distance / 128, 2 ), 0, 1 )
end

local step = function( value, steps )
   return math.floor( ( value - math.floor(value) ) * steps ) / steps
end

local shade = function( origin, target, background_color, liquids )
	local ray = minetest.raycast( origin, target, false, liquids )
	local color, hit_water
	for pointed_thing in ray do
		if "node" == pointed_thing.type then
			local position = pointed_thing.under
			local node = minetest.get_node( position )
			local base_color = get_node_color( node )
			local light = get_light( pointed_thing.above )
			local distance = vector.distance ( position, origin )
			local fog = get_fog( distance )
			-- TODO: proper lighting based on sun position (LOL)
			local n = 1 + (
				pointed_thing.intersection_normal.x +
				pointed_thing.intersection_normal.y * 3 +
				pointed_thing.intersection_normal.z * 1
			) / 12
			local point = pointed_thing.intersection_point
			local x = step( point.x, 8 )
			local y = step( point.y, 8 )
			local z = step( point.z, 8 )
			local noise = math.floor(
				(
					( math.sin(x) * math.tan(z) ) * 65497 +
					( math.sin(y) * math.tan(x) ) * 65519 +
					( math.sin(z) * math.tan(y) ) * 65521
				) / 3
			) % 16
			local l_color = math.min(
				( base_color + noise ) * n * light,
				255
			)
			color = math.floor(
				l_color * ( 1 - fog ) +
				background_color * fog
			)
			hit_water = node.name:find("water")
			break
		end
	end
	return color, hit_water
end

x_offset_by_sample = { 0, 1, 0, 1, 0, 1,-1,-1,-1 }
y_offset_by_sample = { 0, 0, 1, 1,-1,-1, 0, 1,-1 }

local create_photo_pixels = function( player_name )
	local width = get_setting( "xcam_photo_height", 128 )
	local height = get_setting( "xcam_photo_width", 128 )
	local render_distance = get_setting( "xcam_render_distance", 128 )
	local samples = get_setting( "xcam_supersampling_samples", 4 )
	local girl = minetest.get_player_by_name( player_name )
	local eye = girl:get_pos() + girl:get_eye_offset() / 10
	eye.y = eye.y + girl:get_properties().eye_height
	local dir = girl:get_look_dir()
	local angled = minetest.settings:get_bool( "xcam_dutch_angle", false )
	local right = vector.normalize(
		vector.new( { x=dir.z, y=angled and dir.y or 0, z=-dir.x } )
	)
	local down = vector.normalize(
		dir:cross( right )
	)
	local fov_factor = 2
	local corner = eye + dir - fov_factor * (
		right * width/2 +
		down * height/2
	)
	local bg = 127
	local pixels = {}
	for h = 1,height,1 do
		local y = height - ( h - 1 )
		pixels[h] = {}
		for w = 1,width,1 do
			local x = width - ( w - 1 )
			local sky_color = 191 - math.floor ( y / 2 )
			local acc_color = 0
			for sample = 1,samples,1 do
				local x_offset = x_offset_by_sample[sample] * 0.2
				local y_offset = y_offset_by_sample[sample] * 0.2
				local lens = fov_factor * (
					right * ( width/2 - x + x_offset ) +
					down * ( height/2 - y + y_offset )
				)
				local pos1 = eye
				local pos2 = eye + lens + (
					dir * render_distance
				)
				local color, hit_water = shade(
					pos1,
					pos2,
					bg,
					true
				)
				color = color or sky_color
				if hit_water then
					local color2, _ = shade(
						pos1,
						pos2,
						bg,
						false -- no liquids
					)
					color2 = color2 or sky_color
					color = ( color * 3 + color2 ) / 4
				end
				acc_color = acc_color + (
					clamp(
						color / samples,
						0,
						255 / samples
					)
				)
			end
			pixels[h][w] = { math.floor( acc_color ) }
		end
	end
	return pixels
end

minetest.register_chatcommand(
	"snap",
	{
		description = "Snap a photo.",
		func = function( player_name )
			local pixels = create_photo_pixels( player_name )
			local photo_item = create_photo_item( pixels )
			local girl = minetest.get_player_by_name( player_name )
			girl:get_inventory():add_item("main", photo_item)
		end
	}
)

minetest.register_craftitem(
	"xcam:photo",
	{
		description = "A photo.",
		inventory_image = "xcam_photo.tga",
		groups = { not_in_creative_inventory = 1 },
		on_place = function(itemstack, player, pointed_thing)
			if "node" ~= pointed_thing.type then
				return
			end

			local player_pos = player:get_pos()
			if not player_pos then
				return
			end

			local node_pos = pointed_thing.under

			local direction = vector.normalize(
				vector.subtract(
					node_pos,
					player_pos
				)
			)
			local wallmounted = minetest.dir_to_wallmounted(
				direction
			)

			-- TODO: implement photos on floor or ceiling
			if wallmounted < 2 then
				return
			end

			direction = minetest.wallmounted_to_dir(
				wallmounted
			)
			local pos = vector.subtract(
				node_pos,
				vector.multiply(
					direction,
					1/2 + 1/256 -- avoid z-fighting
				)
			)
			local itemstring = itemstack:to_string()
			if pos and "" ~= itemstring then
				local staticdata = {
					_wallmounted = wallmounted,
					_itemstring = itemstring,
				}
				local obj = minetest.add_entity(
					pos,
					"xcam:photo",
					minetest.serialize(staticdata)
				)
				if obj then
					-- TODO: creative mode
					itemstack:take_item()
				end
			end
			return itemstack
		end
	}
)

minetest.register_entity(
	"xcam:photo",
	{
		visual = "upright_sprite",
		visual_size = { x = 1, y = 1 },
		physical = false,
		collide_with_objects = false,
		textures = { "blank.png" },
		on_activate = function(self, staticdata)
			if (
				staticdata and
				"" ~= staticdata
			) then
				local data = minetest.deserialize(staticdata)
				if not data then
					return
				end

				self._wallmounted = data._wallmounted
				assert( self._wallmounted )

				local min, max = -8/16, 8/16
				local len = 1/64
				local sbox
				if 2 == self._wallmounted then
					sbox = { -len, min, min, len, max, max }
				elseif 3 == self._wallmounted then
					sbox = { -len, min, min, len, max, max }
				elseif 4 == self._wallmounted then
					sbox = { min, min, -len, max, max, len }
				elseif 5 == self._wallmounted then
					sbox = { min, min, -len, max, max, len }
				end
				assert( sbox )

				self._itemstring = data._itemstring
				assert( self._itemstring )
				local itemstack = ItemStack(self._itemstring)
				local meta = itemstack:get_meta()
				local texture = meta:get_string("inventory_image")

				self.object:set_properties({
				      selectionbox = sbox,
				      textures = { texture },
				})

				local yaw = minetest.dir_to_yaw(
					minetest.wallmounted_to_dir(
						self._wallmounted
					)
				)
				self.object:set_yaw(yaw)
			end
		end,
		get_staticdata = function(self)
			return minetest.serialize(
				{
					_wallmounted = self._wallmounted,
					_itemstring = self._itemstring,
				}
			)
		end,
		on_punch = function(self)
			-- TODO: implement protection
			local pos = self.object:get_pos()
			local itemstring = self._itemstring
			if pos and itemstring then
				minetest.add_item(
					pos,
					itemstring
				)
				self.object:remove()
			end
		end
	}
)
