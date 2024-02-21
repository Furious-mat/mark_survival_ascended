-- chat-controllable switch node for mesecons
-- Licenced under LGPLv3
-- heavily influenced by:
-- 	- Minecraft mod Cyclic's password trigger (idea)
-- 	- mesecons_detector:object_detector_* (code)
-- 	- h-v-smacker's technic fork's Mk2 prospector (code)

local range = tonumber(minetest.settings:get("mesecons_microphone_range") or 50)
local default_hotword = tostring(minetest.settings:get("mesecons_microphone_default_hotword") or "microphone")

--register nodes
local base_texture = "default_steel_block.png"
local mic_textures = {
	['on'] = base_texture.."^[combine:16x16:0,0=mesecons_microphone_mic_on.png",
	['off'] = base_texture.."^[combine:16x16:0,0=mesecons_microphone_mic_off.png"
}
for _,node_state in pairs({"off","on"}) do
	minetest.register_node("mesecons_microphone:microphone_"..node_state, {
		description = "Microphone",
		tiles = {base_texture,base_texture,mic_textures[node_state],mic_textures[node_state],mic_textures[node_state],mic_textures[node_state]},
		paramtype = "light",
		is_ground_content = false,
		walkable = true,
		groups = {cracky=3,not_in_creative_inventory=(node_state=="on" and 1 or 0),mesecons_microphone=1},
		drop = "mesecons_microphone:microphone_off",
		mesecons = {receptor = {
			state = mesecon.state[node_state],
			rules = mesecon.rules.pplate
		}},
		after_place_node = function(pos,placer)
			if placer and placer:is_player() then
				local meta = minetest.get_meta(pos)
				meta:set_string("owner",placer:get_player_name())
				meta:set_string("mesecons_microphone_hotword",default_hotword)
				meta:set_string("formspec",""..
					"formspec_version[4]"..
					"size[9,3]"..
					"field[0.3,1;5,1;hotword;Set A Hotword;${mesecons_microphone_hotword}]"..
					"button_exit[5.5,1;3,1;save_hotword;Save]")
			end
		end,
		on_receive_fields = function(pos, formname, fields, sender)
			local name = sender:get_player_name()
			if minetest.is_protected(pos, name) and not minetest.check_player_privs(name, {protection_bypass=true}) then
				minetest.record_protection_violation(pos, name)
				return
			end
			
			local meta = minetest.get_meta(pos)
			if fields.save_hotword then
				meta:set_string("mesecons_microphone_hotword",fields.hotword)
				minetest.chat_send_player(name,"Microphone updated to: "..fields.hotword)
			end
		end,
		sounds = default.node_sound_stone_defaults(),
		on_blast = mesecon.on_blastnode
	})
end

local function swap_microphone(pos)
	local node = minetest.get_node(pos)
	if not node then return false end
	if node.name=="mesecons_microphone:microphone_off" then
		minetest.swap_node(pos,{name="mesecons_microphone:microphone_on"})
		mesecon.receptor_on(pos,mesecon.rules.pplate)
	elseif node.name=="mesecons_microphone:microphone_on" then
		minetest.swap_node(pos,{name="mesecons_microphone:microphone_off"})
		mesecon.receptor_off(pos,mesecon.rules.pplate)
	end
	return true
end


minetest.register_on_chat_message(function(name, message)
	if not name or not message then return end
	local player = minetest.get_player_by_name(name)
	if not player then return end
	
	local pos = player:get_pos()
	local min_pos = {x=pos.x-range, y=pos.y-range, z=pos.z-range}
	local max_pos = {x=pos.x+range, y=pos.y+range, z=pos.z+range}
	local nodes = minetest.find_nodes_in_area(min_pos,max_pos,"group:mesecons_microphone")
	if #nodes == 0 then return false end
	
	local activated = false
	for _,pos in pairs(nodes) do
		local meta = minetest.get_meta(pos)
		if meta:get_string("owner") == name and meta:get_string("mesecons_microphone_hotword") == minetest.strip_colors(message) then
			minetest.log("action",name.." activated a microphone at "..minetest.pos_to_string(pos).." with the phrase: "..message)
			activated = true
			if not swap_microphone(pos) then
				minetest.log("error",name.." tried to swap a non-microphone node: "..minetest.pos_to_string(pos))
			end
		end
	end
	return activated
end)

minetest.register_craft({
    output = 'mesecons_microphone:microphone_off',
    recipe = {
        {"default:steel_ingot", "wool:black", "default:steel_ingot"},
        {"default:steel_ingot", "wool:black", "default:steel_ingot"},
        {"default:steel_ingot", "group:mesecon_conductor_craftable", "default:steel_ingot"},
    }, 
})
print("[OK] Mesecon Microphone")