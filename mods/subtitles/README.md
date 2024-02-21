Subtitles
=========

[ContentDB](https://content.minetest.net/packages/SilverSandstone/subtitles/)

This mod adds multiple styles of on-screen subtitles for sound effects.

Subtitles are disabled by default in multiplayer, and can be enabled and configured for each player.
You can access your subtitle preferences by clicking the ![Subtitles icon] button in the inventory or by typing `/subtitles` in chat.


Supported Games and Mods
------------------------

Descriptions are provided for these games:

- Minetest Game
- MineClone
- NodeCore
- Repixture
- Jail Escape
- Builda City
- Alter
- Moontest
- Super Sam
- Subway Miner

Descriptions are provided for these mods:

- Advanced Trains
    - Basic Trains
    - More Trains
    - DlxTrains
    - Trains are Neat
    - Advanced Trains Freight Train
    - JR E231
- Ambience
- Animalia
    - Creatura
- Anvil
- APercy's aeroplanes
    - Demoiselle
    - Ju52
    - PA28
    - Super Cub
    - Super Duck Hydroplane
    - Ultralight Trike
- Automobiles Pack
- Awards
- Bedrock
- Bees
- Bell
- Bows
- BWeapons Modpack
- Castle Weapons
- Death Compass
- DFCaverns
- Digtron
- Documentation System
- Draconis
- CCompass
- Enderpearl
- Fishing!
- Gunslinger
- Home Decor
- Hudbars
- i3
- Mesebox
- Mesecons
- Mese Portals
- Minetest Game Plus
- Mobs
    - Mobs Animal
    - Mobs Monster
    - Mobs Creature
    - Mobs Skeleton
    - Mobs MC
    - Mob Horse
    - Extra Mobs
- Nether
- New Fireworks
- NextGen Bows
- Pedology
- Pyramids
- Radiant Damage
- Real Torch
- Regional Weather
- Ropes
- Scythes and Sickles
- Shifter Tool
- Sounds
- Spyglass
- Stamina
- Steampunk Blimp
- Storage Drawers
- Torch Bomb
- Travelnet
- Unified Inventory
- Vacuum
- Vehicles
- Weather
- X Clay
- X Enchanting

UI integration is provided for these games and mods:

- Simple Fast Inventory (via SFInv Buttons)
- Unified Inventory
- i3
- Repixture


Supporting Subtitles in Your Mod
--------------------------------

There are two ways a mod can support subtitles.

You can associate a description with a sound name using
`subtitles.register_description(sound_name, description)`:

	subtitles.register_description('default_dig_metal', S'Metal clangs');

Alternatively, you can specify a description by setting `description` or
`subtitle` in either the sound spec or the parameters when playing a sound:

	minetest.sound_play('default_dig_metal', {gain = 0.5, description = S'Hitting metal'});
	minetest.sound_play({name = 'default_dig_metal', description = S'Hitting metal'}, {gain = 0.5});

This also works in node definitions:

	minetest.register_node('foomod:foobarium',
	{
		description = S'Foobarium';
		sounds =
		{
		    dig      = {name = 'default_dig_metal', description = S'Foobarium breaks'};
		    footstep = {name = 'default_dig_metal', description = S'Footstep on foobarium'};
		};
	});

You can specify how long to display the subtitle by setting `duration` on
either the spec or the parameters.

You can disable the subtitle for a sound by setting `no_subtitle = true` on
the spec or parameters, or by setting the description to an empty string.


License
-------

Copyright © 2022‒2023, Silver Sandstone <@SilverSandstone@craftodon.social>  
Licensed under the MIT license, with assets under CC0.

See `LICENSE.md` for more information.


[Subtitles icon]: data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAgMAAABinRfyAAAACVBMVEUAAAAAAAD///+D3c/SAAAAAXRSTlMAQObYZgAAAC5JREFUCFtjYEAFrKGhAQxSq1YtQSckp6WmQFmR06As1tDMAKCeFJBGEIPBgQEAwEwSV24kTgQAAAAASUVORK5CYII=
 "Subtitles"
