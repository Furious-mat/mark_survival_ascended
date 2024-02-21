-- Visual Harm 1ndicators
-- Author: Mantar
-- License: GPL v3 or later

VH1 = {} -- namespace

local defaultbarsize = { x = 0.8, y = 0.1 }

local tracking = {} -- mobs that we have an attached entity for, obj = ent
local revtracking = {} -- reverse lookup for objects from a bar
local clearqueue = {} -- bars that are full; cleared in 1 second unless updated

local entdef = {
   initial_properties = { visual = "sprite",
			  textures = { "hpbar_empty.png"},
			  visual_size = defaultbarsize,
			  pointable = false,
			  static_save = false,
			  glow = 100,
			  shaded = false },
   on_detach = function(self)
      self.object:remove()
   end,
}

minetest.register_entity("visual_harm_1ndicators:hpbar", entdef)

local ourkeys = { "barheight", "barsize", "nohpbar" }
local function get_props(prop)
   if not prop then return {} end
   local props = {}
   for i = 1, #ourkeys do
      props[ourkeys[i]] = prop["_VH1_"..ourkeys[i]]
   end
   return props
end

local function set_bar(hpbar, hp, max)
   local suffix = "^[transformR270"
   local percent = math.floor(hp / max * 100)
   if percent <= 0 then
      hpbar:set_texture_mod(suffix)
      return
   end
   if percent > 100 then -- more than max health? light the bar to warn player
      percent = 100
      suffix = suffix.."^[colorize:#ffffff:160"
   elseif percent == 100 then -- full health normally?
      clearqueue[hpbar] = 1.0 -- Start a 1 second timer to clear
   else
      clearqueue[hpbar] = nil -- We're hurt again, don't clear the bar
   end
   percent = tostring(percent)
   hpbar:set_texture_mod("^[lowpart:"..percent..":hpbar_full.png"..suffix)
end

local function add_bar(obj, hp, max, height, props)
   local hpbar = minetest.add_entity(obj:get_pos(),
				     "visual_harm_1ndicators:hpbar")
   set_bar(hpbar, hp, max)
   tracking[obj] = hpbar
   revtracking[hpbar] = obj
   local barheight = height
   if props.barheight then
      barheight = props.barheight
   end
   hpbar:set_attach(obj, "", vector.new(0,barheight,0))
   if props.barsize then
      local tbl = hpbar:get_properties()
      tbl.visual_size = { x = props.barsize.x or defaultbarsize.x,
			  y = props.barsize.y or defaultbarsize.y }
      hpbar:set_properties(tbl)
   end
   return hpbar
end

function VH1.update_bar(object, hp, max)
   if not object then return end
   local name = object:get_luaentity().name or object:get_entity_name()
   local edef = minetest.registered_entities[name]
   local obprop = object:get_properties()
   local props = get_props(edef)
   if props.nohpbar == true then return end

   if not hp then -- use default HP system. This won't work with mobs redo
      hp = object:get_hp()
   end
   if not max then
      max = obprop.hp_max
   end
   local hpbar = tracking[object]
   if not hpbar then
      -- Set default bar height, just over the top of the collision box
      local height = (obprop.collisionbox[5] * 10) + 5
      if obprop.visual_size then height = height / obprop.visual_size.y end
      hpbar = add_bar(object, hp, max, height, props)
   end
   set_bar(hpbar, hp, max)
end

function VH1.clear_bar(object)
   if object and tracking[object] then
      local bar = tracking[object]
      tracking[object]:remove()
      revtracking[bar] = nil
      tracking[object] = nil
   end
end

function VH1.set_default_size(xs, ys)
   defaultbarsize = { x = xs, y = ys }
end

minetest.register_globalstep(function(dtime)
      for bar, timestamp in pairs(clearqueue) do
	 timestamp = timestamp - dtime
	 if timestamp <= 0 then
	    VH1.clear_bar(revtracking[bar])
	    clearqueue[bar] = nil
	 else
	    clearqueue[bar] = timestamp
	 end
      end
end)
