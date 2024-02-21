Visual Harm 1ndicators ---------------------------------------------------

Author: Mantar
License: GPLv3 or later

 This mod adds a graphical display of a mob's health in the form
of a green bar that turns red as the mob approaches death. If a mob
is healed to full health, the bar will disappear one second later.
If a mob's hp is above its max hp for some reason, the bar will light
up to indicate that there are more hit points than can be displayed.

 The mod should work automatically with any supported mob api. The bar's
height will be set just above the top of the collision box.

 For mob creators, VH1 supports custom lua entity definition properties
to override its behavior:

  _VH1_barheight: in case your mob's visual does not match the collision box
  _VH1_barsize:   to change the x/y size of the bar (default x=0.8, y=0.1)
  _VH1_nohpbar:   to disable bars on your specific mob.

 Add these to the definition when registering your entity. If you use a mob
api, how these properties are set may vary.

 The API follows:

Global functions ---------------------------------------------------------
 VH1.update_bar(object, hp, max)
	Call this whenever your mob's hp is changed, a bar will be added
	 automatically if one does not yet exist.
	
	If hp and max values are not provided, VH1 will use the builtin
	 object:get_hp() and object:get_properties().max_hp values instead.

 VH1.clear_bar(object)
	Removes the bar for the mob specified by the objectref.
	 If this is not called explicitly on death, the bar will still be
	 removed automatically when the parent 'object' is removed

Misc functions -----------------------------------------------------------
 VH1.set_default_size(x, y)
 	Adjust the size of the bar for all mobs. Defaults are x = 0.8, y = 0.1


