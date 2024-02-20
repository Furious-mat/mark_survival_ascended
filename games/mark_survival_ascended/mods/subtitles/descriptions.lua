--[[
    Subtitles — adds subtitles to Minetest.

    Copyright © 2022‒2023, Silver Sandstone <@SilverSandstone@craftodon.social>

    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the "Software"),
    to deal in the Software without restriction, including without limitation
    the rights to use, copy, modify, merge, publish, distribute, sublicense,
    and/or sell copies of the Software, and to permit persons to whom the
    Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
    THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
    DEALINGS IN THE SOFTWARE.
]]


--- Defines descriptions for sounds.


local S = subtitles.S;


subtitles.register_description('damage',                                        S'Person hurts');
subtitles.register_description('player_damage',                                 S'Person hurts');
subtitles.register_description('default_punch',                                 S'Punch');
subtitles.register_description('item_drop_pickup',                              S'Pick up item');
subtitles.register_description('builtin_item_pickup',                           S'Pick up item');
subtitles.register_description('default_item_smoke',                            S'Item hisses');
subtitles.register_description('swoosh',                                        S'Swoosh');

-- Minetest Game:

subtitles.register_description('default_dig_choppy',                            S'Chop');
subtitles.register_description('default_dig_cracky',                            S'Crack');
subtitles.register_description('default_dig_crumbly',                           S'Crumble');
subtitles.register_description('default_dig_dig_immediate',                     S'Pop');
subtitles.register_description('default_dig_hard',                              S'Hard material');
subtitles.register_description('default_dig_metal',                             S'Metal clangs');
subtitles.register_description('default_dig_oddly_breakable_by_hand',           S'Oddly breakable by hand');
subtitles.register_description('default_dig_snappy',                            S'Rustle');
subtitles.register_description('default_dig_soft',                              S'Soft material');
subtitles.register_description('default_dig_water',                             S'Water splashes');
subtitles.register_description('wool_coat_movement',                            S'Wool');

subtitles.register_description('default_break_glass',                           S'Glass donks');
subtitles.register_description('default_gravel_dug',                            S'Gravel');
subtitles.register_description('default_ice_dug',                               S'Ice crumbles');
subtitles.register_description('default_dug_metal',                             S'Metal');
subtitles.register_description('default_dug_node',                              S'Block');
subtitles.register_description('default_dug_water',                             S'Water splashes');

subtitles.register_description('default_place_node',                            S'Block placed');
subtitles.register_description('default_place_node_hard',                       S'Hard block placed');
subtitles.register_description('default_place_node_lava',                       S'Lava pours');
subtitles.register_description('default_place_node_metal',                      S'Metal placed');
subtitles.register_description('default_place_node_water',                      S'Water pours');

subtitles.register_description('default_chest_close',                           S'Chest closes');
subtitles.register_description('default_chest_open',                            S'Chest opens');
subtitles.register_description('default_furnace_active',                        S'Furnace burns');
subtitles.register_description('default_cool_lava',                             S'Hissing');

subtitles.register_description('default_gravel_dig',                            S'Gravel');
subtitles.register_description('default_ice_dig',                               S'Ice cracks');

subtitles.register_description('default_crunch_footstep',                       S'Crunchy footsteps');
subtitles.register_description('default_dirt_footstep',                         S'Dirty footsteps');
subtitles.register_description('default_grass_footstep',                        S'Rustly footsteps');
subtitles.register_description('default_glass_footstep',                        S'Glass donks');
subtitles.register_description('default_gravel_footstep',                       S'Gravelly footsteps');
subtitles.register_description('default_hard_footstep',                         S'Hard material');
subtitles.register_description('default_ice_footstep',                          S'Ice crunches');
subtitles.register_description('default_metal_footstep',                        S'Metallic footsteps');
subtitles.register_description('default_sand_footstep',                         S'Sandy footsteps');
subtitles.register_description('default_snow_footstep',                         S'Snow crunches');
subtitles.register_description('default_soft_footstep',                         S'Soft footsteps');
subtitles.register_description('default_water_footstep',                        S'Water splashes');
subtitles.register_description('default_wood_footstep',                         S'Wooden footsteps');

subtitles.register_description('default_tool_breaks',                           S'Tool breaks');

subtitles.register_description('env_sounds_water',                              S'Water splashes');
subtitles.register_description('env_sounds_lava',                               S'Lava bubbles');
subtitles.register_description('builtin_item_lava',                             S'Item burns');

subtitles.register_description('doors_door_open',                               S'Door opens');
subtitles.register_description('doors_door_close',                              S'Door closes');
subtitles.register_description('doors_steel_door_open',                         S'Metal door opens');
subtitles.register_description('doors_steel_door_close',                        S'Metal door closes');
subtitles.register_description('doors_glass_door_open',                         S'Glass door opens');
subtitles.register_description('doors_glass_door_close',                        S'Glass door closes');
subtitles.register_description('doors_fencegate_open',                          S'Gate opens');
subtitles.register_description('doors_fencegate_close',                         S'Gate closes');

subtitles.register_description('xpanes_steel_bar_door_open',                    S'Steel bar door opens');
subtitles.register_description('xpanes_steel_bar_door_close',                   S'Steel bar door closes');

subtitles.register_description('fire_flint_and_steel',                          S'Flint and steel clicks');
subtitles.register_description('fire_fire',                                     S'Fire burns');
subtitles.register_description('fire_large',                                    S'Fire roars');
subtitles.register_description('fire_extinguish_flame',                         S'Fire fizzles out');
subtitles.register_description('fire_extinguish',                               S'Fire fizzles out');
subtitles.register_description('fire_extinguis',                                S'Fire fizzles out');

subtitles.register_description('carts_cart_moving',                             S'Minecart rolls');

subtitles.register_description('tnt_gunpowder_burning',                         S'Fuse sizzles');
subtitles.register_description('tnt_ignite',                                    S'Fuse ignites');
subtitles.register_description('tnt_explode',                                   S'BOOM');

-- Mobs:

subtitles.register_description('mobs_punch',                                    S'Hit');

subtitles.register_description('mobs_bee',                                      S'Bee buzzes');
subtitles.register_description('mobs_chicken',                                  S'Chicken clucks');
subtitles.register_description('mobs_cow',                                      S'Cow moos');
subtitles.register_description('mobs_dirtmonster',                              S'Dirt monster chomps');
subtitles.register_description('mobs_dungeonmaster',                            S'Dungeon master grumbles');
subtitles.register_description('mobs_eerie',                                    S'Death approaches');
subtitles.register_description('mobs_fireball',                                 S'Fireball');
subtitles.register_description('mobs_kitten',                                   S'Cat meows');
subtitles.register_description('mobs_lavaflan',                                 S'Flan gurgles');
subtitles.register_description('mobs_mesemonster',                              S'Mese monster hovers');
subtitles.register_description('mobs_oerkki',                                   S'Oerkki mutters');
subtitles.register_description('mobs_omsk',                                     S'Omsk whirls');
subtitles.register_description('mobs_panda',                                    S'Panda pants');
subtitles.register_description('mobs_pig',                                      S'Pig snorts');
subtitles.register_description('mobs_pig_angry',                                S'Pig screams');
subtitles.register_description('mobs_rat',                                      S'Rat hisses');
subtitles.register_description('mobs_sandmonster',                              S'Sand monster breathes');
subtitles.register_description('mobs_sheep',                                    S'Sheep baas');
subtitles.register_description('mobs_spell',                                    S'Spell casts');
subtitles.register_description('mobs_spider',                                   S'Spider hisses');
subtitles.register_description('mobs_stonemonster',                             S'Stone monster growls');
subtitles.register_description('mobs_swing',                                    S'Swing');
subtitles.register_description('mobs_treemonster',                              S'Tree monster rattles');
subtitles.register_description('mobs_wolf_attack',                              S'Wolf attacks');

subtitles.register_description('mobs_animal_horse_random',                      S'Horse neighs');
subtitles.register_description('mobs_animal_horse_jump',                        S'Horse jumps');
subtitles.register_description('mobs_animal_horse_warcry',                      S'Horse neighs angrily');
subtitles.register_description('mobs_animal_horse_pain',                        S'Horse hurts');
subtitles.register_description('mobs_animal_horse_death',                       S'Horse dies');

subtitles.register_description('mobs_mc_bat_idle',                              S'Bat squeaks');
subtitles.register_description('mobs_mc_bat_hurt',                              S'Bat hurts');
subtitles.register_description('mobs_mc_bat_death',                             S'Bat dies');
subtitles.register_description('mobs_mc_bear_random',                           S'Bear huffs');
subtitles.register_description('mobs_mc_bear_growl',                            S'Bear growls');
subtitles.register_description('mobs_mc_bear_attack',                           S'Bear attacks');
subtitles.register_description('mobs_mc_bear_hurt',                             S'Bear hurts');
subtitles.register_description('mobs_mc_bear_death',                            S'Bear dies');
subtitles.register_description('mobs_mc_blaze_breath',                          S'Blaze breathes');
subtitles.register_description('mobs_mc_blaze_hurt',                            S'Blaze hurts');
subtitles.register_description('mobs_mc_blaze_died',                            S'Blaze dies');
subtitles.register_description('mobs_mc_cat_idle',                              S'Cat meows');
subtitles.register_description('mobs_mc_cat_hiss',                              S'Cat hisses');
subtitles.register_description('mobs_mc_chicken_buck',                          S'Chicken clucks');
subtitles.register_description('mobs_mc_chicken_child',                         S'Baby chicken squeaks');
subtitles.register_description('mobs_mc_chicken_lay_egg',                       S'Chicken lays egg');
subtitles.register_description('mobs_mc_chicken_hurt',                          S'Chicken hurts');
subtitles.register_description('mobs_mc_cow',                                   S'Cow moos');
subtitles.register_description('mobs_mc_cow_milk',                              S'Milks cow');
subtitles.register_description('mobs_mc_cow_hurt',                              S'Cow hurts');
subtitles.register_description('mobs_mc_creeper_hurt',                          S'Creeper hurts');
subtitles.register_description('mobs_mc_creeper_death',                         S'Creeper dies');
subtitles.register_description('mobs_mc_donkey_random',                         S'Donkey hee-haws');
subtitles.register_description('mobs_mc_donkey_hurt',                           S'Donkey hurts');
subtitles.register_description('mobs_mc_donkey_death',                          S'Donkey dies');
subtitles.register_description('mobs_mc_ender_dragon_attack',                   S'Ender dragon attacks');
subtitles.register_description('mobs_mc_ender_dragon_shoot',                    S'Ender dragon fires');
subtitles.register_description('mobs_mc_enderman_random',                       S'Enderman chitters');
subtitles.register_description('mobs_mc_enderman_teleport_src',                 S'Enderman disappears');
subtitles.register_description('mobs_mc_enderman_teleport_dst',                 S'Enderman appears');
subtitles.register_description('mobs_mc_enderman_hurt',                         S'Enderman hurts');
subtitles.register_description('mobs_mc_enderman_death',                        S'Enderman dies');
subtitles.register_description('mobs_mc_endermite_random',                      S'Endermite scuttles');
subtitles.register_description('mobs_mc_endermite_hurt',                        S'Endermite hurts');
subtitles.register_description('mobs_mc_endermite_death',                       S'Endermite dies');
subtitles.register_description('mobs_mc_guardian_random',                       S'Guardian guards');
subtitles.register_description('mobs_mc_guardian_hurt',                         S'Guardian hurts');
subtitles.register_description('mobs_mc_guardian_death',                        S'Guardian dies');
subtitles.register_description('mobs_mc_horse_random',                          S'Horse neighs');
subtitles.register_description('mobs_mc_horse_hurt',                            S'Horse hurts');
subtitles.register_description('mobs_mc_horse_death',                           S'Horse dies');
subtitles.register_description('mobs_mc_llama',                                 S'Llama bleats');
subtitles.register_description('mobs_mc_magma_cube_small',                      S'Magma cube plops');
subtitles.register_description('mobs_mc_magma_cube_big',                        S'Magma cube plorps');
subtitles.register_description('mobs_mc_magma_cube_attack',                     S'Magma cube attacks');
subtitles.register_description('mobs_mc_ocelot_hurt',                           S'Ocelot hurts');
subtitles.register_description('mobs_mc_parrot_random',                         S'Parrot chatters');
subtitles.register_description('mobs_mc_parrot_hurt',                           S'Parrot hurts');
subtitles.register_description('mobs_mc_parrot_death',                          S'Parrot dies');
subtitles.register_description('mobs_mc_pillager_grunt1',                       S'Pillager grunts');
subtitles.register_description('mobs_mc_pillager_grunt2',                       S'Pillager grunts');
subtitles.register_description('mobs_mc_pillager_ow1',                          S'Pillager hurts');
subtitles.register_description('mobs_mc_pillager_ow2',                          S'Pillager hurts');
subtitles.register_description('mobs_mc_rabbit_random',                         S'Rabbit squeaks');
subtitles.register_description('mobs_mc_rabbit_attack',                         S'Rabbit attacks');
subtitles.register_description('mobs_mc_rabbit_hurt',                           S'Rabbit hurts');
subtitles.register_description('mobs_mc_rabbit_death',                          S'Rabbit dies');
subtitles.register_description('mobs_mc_silverfish_idle',                       S'Silverfish hisses');
subtitles.register_description('mobs_mc_silverfish_hurt',                       S'Silverfish hurts');
subtitles.register_description('mobs_mc_silverfish_death',                      S'Silverfish dies');
subtitles.register_description('mobs_mc_skeleton_random',                       S'Skeleton xyles');
subtitles.register_description('mobs_mc_skeleton_hurt',                         S'Skeleton hurts');
subtitles.register_description('mobs_mc_skeleton_death',                        S'Skeleton dies');
subtitles.register_description('mobs_mc_snowman_hurt',                          S'Snow golem hurts');
subtitles.register_description('mobs_mc_snowman_death',                         S'Snow golem dies');
subtitles.register_description('mobs_mc_spider_random',                         S'Spider hisses');
subtitles.register_description('mobs_mc_spider_attack',                         S'Spider attacks');
subtitles.register_description('mobs_mc_spider_hurt',                           S'Spider hurts');
subtitles.register_description('mobs_mc_spider_death',                          S'Spider dies');
subtitles.register_description('mobs_mc_squid_flop',                            S'Squid flops');
subtitles.register_description('mobs_mc_squid_hurt',                            S'Squid hurts');
subtitles.register_description('mobs_mc_squid_death',                           S'Squid dies');
subtitles.register_description('mobs_mc_vex_hurt',                              S'Vex hurts');
subtitles.register_description('mobs_mc_vex_death',                             S'Vex dies');
subtitles.register_description('mobs_mc_villager',                              S'Villager speaks');
subtitles.register_description('mobs_mc_villager_accept',                       S'Villager accepts');
subtitles.register_description('mobs_mc_villager_deny',                         S'Villager denies');
subtitles.register_description('mobs_mc_villager_trade',                        S'Villager trades');
subtitles.register_description('mobs_mc_villager_hurt',                         S'Villager hurts');
subtitles.register_description('mobs_mc_wither_spawn',                          S'Wither spawns');
subtitles.register_description('mobs_mc_wolf_bark',                             S'Wolf barks');
subtitles.register_description('mobs_mc_wolf_take_bone',                        S'Wolf takes bone');
subtitles.register_description('mobs_mc_wolf_growl',                            S'Wolf growls');
subtitles.register_description('mobs_mc_wolf_hurt',                             S'Wolf hurts');
subtitles.register_description('mobs_mc_wolf_death',                            S'Wolf dies');
subtitles.register_description('mobs_mc_zombie_idle',                           S'Zombie groans');
subtitles.register_description('mobs_mc_zombie_growl',                          S'Zombie growls');
subtitles.register_description('mobs_mc_zombie_hurt',                           S'Zombie hurts');
subtitles.register_description('mobs_mc_zombie_death',                          S'Zombie dies');
subtitles.register_description('mobs_mc_zombiepig_random',                      S'Zombie pigman grunts');
subtitles.register_description('mobs_mc_zombiepig_war_cry',                     S'Zombie pigman screams');
subtitles.register_description('mobs_mc_zombiepig_hurt',                        S'Zombie pigman hurts');
subtitles.register_description('mobs_mc_zombiepig_death',                       S'Zombie pigman dies');

subtitles.register_description('extra_mobs_hoglin',                             S'Hoglin grunts');
subtitles.register_description('extra_mobs_hoglin_hurt',                        S'Hoglin hurts');

subtitles.register_description('mobs_creatures_astronaut_random',               S'Astronaut mutters');
subtitles.register_description('mobs_creatures_bat_random',                     S'Bat squeaks');
subtitles.register_description('mobs_creatures_bat_jump',                       S'Bat flaps');
subtitles.register_description('mobs_creatures_bat_attack',                     S'Bat attacks');
subtitles.register_description('mobs_creatures_bat_damage',                     S'Bat hurts');
subtitles.register_description('mobs_creatures_bat_death',                      S'Bat dies');
subtitles.register_description('mobs_creatures_bogeyman_random',                S'Bogeyman mutters');
subtitles.register_description('mobs_creatures_bogeyman_warcry',                S'Bogeyman screams');
subtitles.register_description('mobs_creatures_bogeyman_attack',                S'Bogeyman attacks');
subtitles.register_description('mobs_creatures_bogeyman_damage',                S'Bogeyman hurts');
subtitles.register_description('mobs_creatures_bogeyman_death',                 S'Bogeyman dies');
subtitles.register_description('mobs_creatures_boomer_damage',                  S'Boomer hurts');
subtitles.register_description('mobs_creatures_boomer_death',                   S'Boomer dies');
subtitles.register_description('mobs_creatures_cacodemon_random',               S'Cacodemon snarls');
subtitles.register_description('mobs_creatures_cacodemon_warcry',               S'Cacodemon screams');
subtitles.register_description('mobs_creatures_cacodemon_damage',               S'Cacodemon hurts');
subtitles.register_description('mobs_creatures_cacodemon_death',                S'Cacodemon dies');
subtitles.register_description('mobs_creatures_chicken_random',                 S'Chicken clucks');
subtitles.register_description('mobs_creatures_chicken_eggpop',                 S'Chicken lays egg');
subtitles.register_description('mobs_creatures_chicken_damage',                 S'Chicken hurts');
subtitles.register_description('mobs_creatures_common_attack_claw',             S'Claws swipe');
subtitles.register_description('mobs_creatures_common_poop',                    S'Animal defecates');
subtitles.register_description('mobs_creatures_common_shoot_arrow',             S'Arrow fires');
subtitles.register_description('mobs_creatures_common_shoot_arrow_hit',         S'Arrow hits');
subtitles.register_description('mobs_creatures_common_shoot_fireball',          S'Fireball whooshes');
subtitles.register_description('mobs_creatures_common_shoot_fireball_hit',      S'Fireball bursts');
subtitles.register_description('mobs_creatures_common_shoot_plasmaball',        S'Plasma ball fires');
subtitles.register_description('mobs_creatures_common_shoot_plasmaball_hit',    S'Plasma ball bursts');
subtitles.register_description('mobs_creatures_common_shoot_poisonball',        S'Poison ball fires');
subtitles.register_description('mobs_creatures_common_shoot_poisonball_hit',    S'Poison ball bursts');
subtitles.register_description('mobs_creatures_cow_random',                     S'Cow moos');
subtitles.register_description('mobs_creatures_cow_jump',                       S'Cow jumps');
subtitles.register_description('mobs_creatures_cow_milk',                       S'Cow lactates');
subtitles.register_description('mobs_creatures_cow_damage',                     S'Cow hurts');
subtitles.register_description('mobs_creatures_crocodile_jump',                 S'Crocodile jumps');
subtitles.register_description('mobs_creatures_crocodile_attack',               S'Crocodile attacks');
subtitles.register_description('mobs_creatures_crocodile_damage',               S'Crocodile hurts');
subtitles.register_description('mobs_creatures_crocodile_death',                S'Crocodile dies');
subtitles.register_description('mobs_creatures_cyberdemon_random',              S'Cyberdemon steps');
subtitles.register_description('mobs_creatures_cyberdemon_warcry',              S'Cyberdemon screams');
subtitles.register_description('mobs_creatures_cyberdemon_shoot',               S'Cyberdemon fires');
subtitles.register_description('mobs_creatures_cyberdemon_death',               S'Cyberdemon dies');
subtitles.register_description('mobs_creatures_demon_eye_attack',               S'Demon eye attacks');
subtitles.register_description('mobs_creatures_demon_eye_damage',               S'Demon eye hurts');
subtitles.register_description('mobs_creatures_demon_eye_death',                S'Demon eye dies');
subtitles.register_description('mobs_creatures_dirt_man_random',                S'Dirt monster chomps');
subtitles.register_description('mobs_creatures_facehugger_random',              S'Facehugger squeals');
subtitles.register_description('mobs_creatures_facehugger_jump',                S'Facehugger jumps');
subtitles.register_description('mobs_creatures_facehugger_damage',              S'Facehugger hurts');
subtitles.register_description('mobs_creatures_facehugger_death',               S'Facehugger dies');
subtitles.register_description('mobs_creatures_fire_imp_random',                S'Fire imp squibbles');
subtitles.register_description('mobs_creatures_fire_imp_attack',                S'Fire imp attacks');
subtitles.register_description('mobs_creatures_fire_imp_damage',                S'Fire imp hurts');
subtitles.register_description('mobs_creatures_fire_imp_death',                 S'Fire imp dies');
subtitles.register_description('mobs_creatures_flying_saucer_random',           S'Flying saucer warbles');
subtitles.register_description('mobs_creatures_flying_saucer_warcry',           S'Flying saucer alerts');
subtitles.register_description('mobs_creatures_flying_saucer_shoot',            S'Flying saucer fires');
subtitles.register_description('mobs_creatures_flying_saucer_shoot_impact',     S'Plasma explodes');
subtitles.register_description('mobs_creatures_flying_saucer_damage',           S'Flying saucer damaged');
subtitles.register_description('mobs_creatures_flying_saucer_death',            S'Flying saucer destroyed');
subtitles.register_description('mobs_creatures_ghost_random',                   S'Ghost haunts');
subtitles.register_description('mobs_creatures_ghost_warcry',                   S'Ghost laughs');
subtitles.register_description('mobs_creatures_ghost_attack',                   S'Ghost attacks');
subtitles.register_description('mobs_creatures_ghost_damage',                   S'Ghost hurts');
subtitles.register_description('mobs_creatures_ghost_death',                    S'Ghost dies');
subtitles.register_description('mobs_creatures_grey_civilian_random',           S'Grey civilian mutters');
subtitles.register_description('mobs_creatures_grey_civilian_warcry',           S'Grey civilian mutters angrily');
subtitles.register_description('mobs_creatures_grey_enlisted_random',           S'Grey enlisted mutters');
subtitles.register_description('mobs_creatures_grey_enlisted_warcry',           S'Grey enlisted mutters angrily');
subtitles.register_description('mobs_creatures_grey_enlisted_shoot',            S'Grey enlisted fires');
subtitles.register_description('mobs_creatures_grey_attack',                    S'Grey attacks');
subtitles.register_description('mobs_creatures_grey_damage',                    S'Grey hurts');
subtitles.register_description('mobs_creatures_grey_death',                     S'Grey dies');
subtitles.register_description('mobs_creatures_hellbaron_random',               S'Hellbaron grunts');
subtitles.register_description('mobs_creatures_hellbaron_warcry',               S'Hellbaron screams');
subtitles.register_description('mobs_creatures_hellbaron_damage',               S'Hellbaron hurts');
subtitles.register_description('mobs_creatures_hellbaron_death',                S'Hellbaron dies');
subtitles.register_description('mobs_creatures_imp_random',                     S'Imp growls');
subtitles.register_description('mobs_creatures_imp_warcry',                     S'Imp chuckles');
subtitles.register_description('mobs_creatures_imp_death',                      S'Imp dies');
subtitles.register_description('mobs_creatures_jabberer_random',                S'Jabberer squawks');
subtitles.register_description('mobs_creatures_jabberer_attack',                S'Jabberer attacks');
subtitles.register_description('mobs_creatures_jabberer_damage',                S'Jabberer hurts');
subtitles.register_description('mobs_creatures_jabberer_death',                 S'Jabberer dies');
subtitles.register_description('mobs_creatures_kangaroo',                       S'Kangaroo mutters');
subtitles.register_description('mobs_creatures_mancubus_random',                S'Mancubus groans');
subtitles.register_description('mobs_creatures_mancubus_warcry',                S'Mancubus growls');
subtitles.register_description('mobs_creatures_mancubus_warcy',                 S'Mancubus growls');
subtitles.register_description('mobs_creatures_mancubus_death',                 S'Mancubus dies');
subtitles.register_description('mobs_creatures_ocelot_random',                  S'Ocelot meows');
subtitles.register_description('mobs_creatures_ocelot_pain',                    S'Ocelot hurts');
subtitles.register_description('mobs_creatures_pig_random',                     S'Pig grunts');
subtitles.register_description('mobs_creatures_pig_death',                      S'Pig dies');
subtitles.register_description('mobs_creatures_pinky_random',                   S'Pinky grunts');
subtitles.register_description('mobs_creatures_pinky_warcry',                   S'Pinky grunts angrily');
subtitles.register_description('mobs_creatures_pinky_attack',                   S'Pinky attacks');
subtitles.register_description('mobs_creatures_pinky_damage',                   S'Pinky hurts');
subtitles.register_description('mobs_creatures_pinky_death',                    S'Pinky dies');
subtitles.register_description('mobs_creatures_polarbear_random',               S'Polar bear grunts');
subtitles.register_description('mobs_creatures_polarbear_jump',                 S'Polar bear jumps');
subtitles.register_description('mobs_creatures_polarbear_attack',               S'Polar bear attacks');
subtitles.register_description('mobs_creatures_polarbear_damage',               S'Polar bear hurts');
subtitles.register_description('mobs_creatures_polarbear_death',                S'Polar bear dies');
subtitles.register_description('mobs_creatures_rabbit_random',                  S'Rabbit squeaks');
subtitles.register_description('mobs_creatures_rabbit_jump',                    S'Rabbit jumps');
subtitles.register_description('mobs_creatures_rabbit_pain',                    S'Rabbit hurts');
subtitles.register_description('mobs_creatures_rabbit_death',                   S'Rabbit dies');
subtitles.register_description('mobs_creatures_rat_random',                     S'Rat squeaks');
subtitles.register_description('mobs_creatures_reptilian_elite_random',         S'Reptilian elite mutters');
subtitles.register_description('mobs_creatures_sand_man_random',                S'Sand monster breathes');
subtitles.register_description('mobs_creatures_shark_attack',                   S'Shark bites');
subtitles.register_description('mobs_creatures_shark_damage',                   S'Shark hurts');
subtitles.register_description('mobs_creatures_shark_death',                    S'Shark dies');
subtitles.register_description('mobs_creatures_skeleton_random',                S'Skeleton xyles');
subtitles.register_description('mobs_creatures_skeleton_jump',                  S'Skeleton jumps');
subtitles.register_description('mobs_creatures_skeleton_attack',                S'Skeleton attacks');
subtitles.register_description('mobs_creatures_skeleton_damage',                S'Skeleton hurts');
subtitles.register_description('mobs_creatures_skeleton_death',                 S'Skeleton dies');
subtitles.register_description('mobs_creatures_skull_random',                   S'Skull growls');
subtitles.register_description('mobs_creatures_skull_warcry',                   S'Skull growls angrily');
subtitles.register_description('mobs_creatures_skull_attack',                   S'Skull attacks');
subtitles.register_description('mobs_creatures_skull_death',                    S'Skull dies');
subtitles.register_description('mobs_creatures_spider_random',                  S'Spider hisses');
subtitles.register_description('mobs_creatures_spider_jump',                    S'Spider jumps');
subtitles.register_description('mobs_creatures_spider_death',                   S'Spider dies');
subtitles.register_description('mobs_creatures_stone_man_random',               S'Stone monster growls');
subtitles.register_description('mobs_creatures_werewolf_random',                S'Werewolf howls');
subtitles.register_description('mobs_creatures_werewolf_damage',                S'Werewolf hurts');
subtitles.register_description('mobs_creatures_witch_random',                   S'Witch mutters');
subtitles.register_description('mobs_creatures_witch_attack',                   S'Witch incants');
subtitles.register_description('mobs_creatures_witch_shoot_attack',             S'Witch hexes');
subtitles.register_description('mobs_creatures_witch_damage',                   S'Witch hurts');
subtitles.register_description('mobs_creatures_witch_death',                    S'Witch dies');
subtitles.register_description('mobs_creatures_wolf_random',                    S'Wolf barks');
subtitles.register_description('mobs_creatures_wolf_warcry',                    S'Wolf barks angrily');
subtitles.register_description('mobs_creatures_wolf_pain',                      S'Wolf hurts');
subtitles.register_description('mobs_creatures_wolf_death',                     S'Wolf dies');
subtitles.register_description('mobs_creatures_zombie_random',                  S'Zombie groans');
subtitles.register_description('mobs_creatures_zombie_warcry',                  S'Zombie growls');
subtitles.register_description('mobs_creatures_zombie_attack',                  S'Zombie attacks');
subtitles.register_description('mobs_creatures_zombie_damage',                  S'Zombie hurts');
subtitles.register_description('mobs_creatures_zombie_death',                   S'Zombie dies');

subtitles.register_description('mobs_skeletons_shoot',                          S'Skeleton fires arrow');
subtitles.register_description('mobs_skeletons_skeleton_death',                 S'Skeleton dies');
subtitles.register_description('mobs_skeletons_skeleton_hurt',                  S'Skeleton hurts');
subtitles.register_description('mobs_skeletons_skeleton_random',                S'Skeleton xyles');
subtitles.register_description('mobs_skeletons_slash_attack',                   S'Skeleton slashes');

subtitles.register_description('bark',                                          S'Dog barks');
subtitles.register_description('bat',                                           S'Bat squeaks');
subtitles.register_description('birdie',                                        S'Bird chirps');
subtitles.register_description('Cowhurt1',                                      S'Cow hurts');
subtitles.register_description('Creeperdeath',                                  S'Creeper dies');
subtitles.register_description('crow',                                          S'Crow caws');
subtitles.register_description('death_dm',                                      S'Dungeon master dies');
subtitles.register_description('frog',                                          S'Frog ribbits');
subtitles.register_description('ghost_breath',                                  S'Ghost breathes');
subtitles.register_description('green_slime_jump',                              S'Slime jumps');
subtitles.register_description('green_slime_land',                              S'Slime splots');
subtitles.register_description('green_slime_attack',                            S'Slime attacks');
subtitles.register_description('green_slime_damage',                            S'Slime hurts');
subtitles.register_description('green_slime_death',                             S'Slime dies');
subtitles.register_description('skeleton1',                                     S'Skeleton xyles');
subtitles.register_description('skeletondeath',                                 S'Skeleton dies');
subtitles.register_description('skeletonhurt1',                                 S'Skeleton hurts');
subtitles.register_description('yelp',                                          S'Dog yelps');
subtitles.register_description('zabuhailo_catgrowls',                           S'Ghost wails');

-- Creatura / Animalia:

subtitles.register_description('creatura_hit_1',                                S'Hit');
subtitles.register_description('creatura_hit_2',                                S'Hit');
subtitles.register_description('creatura_hit_3',                                S'Hit');

subtitles.register_description('animalia_bat',                                  S'Bat squeaks');
subtitles.register_description('animalia_cardinal',                             S'Cardinal chirps');
subtitles.register_description('animalia_cat_idle',                             S'Cat meows');
subtitles.register_description('animalia_cat_purr',                             S'Cat purrs');
subtitles.register_description('animalia_cat_hurt',                             S'Cat hurts');
subtitles.register_description('animalia_chicken_idle',                         S'Chicken clucks');
subtitles.register_description('animalia_chicken_hurt',                         S'Chicken hurts');
subtitles.register_description('animalia_chicken_death',                        S'Chicken dies');
subtitles.register_description('animalia_cow_random',                           S'Cow moos');
subtitles.register_description('animalia_cow_hurt',                             S'Cow hurts');
subtitles.register_description('animalia_cow_death',                            S'Cow dies');
subtitles.register_description('animalia_eastern_blue',                         S'Eastern blue chirps');
subtitles.register_description('animalia_frog',                                 S'Frog croaks');
subtitles.register_description('animalia_goldfinch',                            S'Goldfinch chirps');
subtitles.register_description('animalia_horse_idle',                           S'Horse neighs');
subtitles.register_description('animalia_horse_hurt',                           S'Horse hurts');
subtitles.register_description('animalia_horse_death',                          S'Horse dies');
subtitles.register_description('animalia_pig_random',                           S'Pig grunts');
subtitles.register_description('animalia_pig_hurt',                             S'Pig hurts');
subtitles.register_description('animalia_pig_death',                            S'Pig dies');
subtitles.register_description('animalia_sheep_idle',                           S'Sheep baas');
subtitles.register_description('animalia_sheep_hurt',                           S'Sheep hurts');
subtitles.register_description('animalia_sheep_death',                          S'Sheep dies');
subtitles.register_description('animalia_turkey_idle',                          S'Turkey gobbles');
subtitles.register_description('animalia_turkey_hurt',                          S'Turkey hurts');
subtitles.register_description('animalia_turkey_death',                         S'Turkey dies');

-- Hudbars:

subtitles.register_description('hbhunger_eat_generic',                          S'Eating');

-- Unified Inventory:

subtitles.register_description('click',                                         S'Click');
subtitles.register_description('paperflip1',                                    S'Page flip');
subtitles.register_description('paperflip2',                                    S'Page flip');
subtitles.register_description('birds',                                         S'Birds chirp');
subtitles.register_description('owl',                                           S'Owl hoots');
subtitles.register_description('dingdong',                                      S'Doorbell chimes');
subtitles.register_description('electricity',                                   S'Electricity buzzes');
subtitles.register_description('trash',                                         S'Item deleted');
subtitles.register_description('trash_all',                                     S'Inventory cleared');
subtitles.register_description('teleport',                                      S'Teleports');

-- Home Decor:

subtitles.register_description('toaster',                                       S'Toaster pops');
subtitles.register_description('fire_small',                                    S'Fire roars');
subtitles.register_description('insert_coin',                                   S'Coin inserts');

subtitles.register_description('homedecor_book_close',                          S'Book closes');
subtitles.register_description('homedecor_doorbell',                            S'Doorbell rings')
subtitles.register_description('homedecor_shower',                              S'Shower runs');
subtitles.register_description('homedecor_door_open',                           S'Door opens');
subtitles.register_description('homedecor_door_close',                          S'Door close');
subtitles.register_description('homedecor_faucet',                              S'Tap runs');
subtitles.register_description('homedecor_gate_open_close',                     S'Gate swings');
subtitles.register_description('homedecor_toilet_flush',                        S'Toilet flushes');
subtitles.register_description('homedecor_trash_all',                           S'Rubbish bin empties');

-- Mesecons:

subtitles.register_description('mesecons_button_push',                          S'Button presses');
subtitles.register_description('mesecons_button_pop',                           S'Button releases');
subtitles.register_description('mesecons_button_push_wood',                     S'Wooden button clicks');
subtitles.register_description('mesecons_switch',                               S'Switch toggles');
subtitles.register_description('mesecons_lever',                                S'Lever toggles');

subtitles.register_description('movestone',                                     S'Movestone shifts');

subtitles.register_description('piston_extend',                                 S'Piston extends');
subtitles.register_description('piston_retract',                                S'Piston retracts');

subtitles.register_description('mesecons_noteblock_c',                          S'♪ C');
subtitles.register_description('mesecons_noteblock_csharp',                     S'♪ C♯');
subtitles.register_description('mesecons_noteblock_d',                          S'♪ D');
subtitles.register_description('mesecons_noteblock_dsharp',                     S'♪ D♯');
subtitles.register_description('mesecons_noteblock_e',                          S'♪ E');
subtitles.register_description('mesecons_noteblock_f',                          S'♪ F');
subtitles.register_description('mesecons_noteblock_fsharp',                     S'♪ F♯');
subtitles.register_description('mesecons_noteblock_g',                          S'♪ G');
subtitles.register_description('mesecons_noteblock_gsharp',                     S'♪ G♯');
subtitles.register_description('mesecons_noteblock_a',                          S'♪ A');
subtitles.register_description('mesecons_noteblock_asharp',                     S'♪ A♯');
subtitles.register_description('mesecons_noteblock_b',                          S'♪ B');
subtitles.register_description('mesecons_noteblock_c2',                         S'♪ C2');
subtitles.register_description('mesecons_noteblock_csharp2',                    S'♪ C♯2');
subtitles.register_description('mesecons_noteblock_d2',                         S'♪ D2');
subtitles.register_description('mesecons_noteblock_dsharp2',                    S'♪ D♯2');
subtitles.register_description('mesecons_noteblock_e2',                         S'♪ E2');
subtitles.register_description('mesecons_noteblock_f2',                         S'♪ F2');
subtitles.register_description('mesecons_noteblock_fsharp2',                    S'♪ F♯2');
subtitles.register_description('mesecons_noteblock_g2',                         S'♪ G2');
subtitles.register_description('mesecons_noteblock_gsharp2',                    S'♪ G♯2');
subtitles.register_description('mesecons_noteblock_a2',                         S'♪ A2');
subtitles.register_description('mesecons_noteblock_asharp2',                    S'♪ A♯2');
subtitles.register_description('mesecons_noteblock_b2',                         S'♪ B2');

subtitles.register_description('mesecons_noteblock_bell',                       S'Bell dings');
subtitles.register_description('mesecons_noteblock_banjo',                      S'Banjo plays');
subtitles.register_description('mesecons_noteblock_chime',                      S'Chime dings');
subtitles.register_description('mesecons_noteblock_cowbell',                    S'Cowbell donks');
subtitles.register_description('mesecons_noteblock_crash',                      S'Cymbal crashes');
subtitles.register_description('mesecons_noteblock_didgeridoo',                 S'Didgeridoo parps');
subtitles.register_description('mesecons_noteblock_flute',                      S'Flute plays');
subtitles.register_description('mesecons_noteblock_guitar',                     S'Guitar twangs');
subtitles.register_description('mesecons_noteblock_hihat',                      S'Hihat');
subtitles.register_description('mesecons_noteblock_hit',                        S'Hit');
subtitles.register_description('mesecons_noteblock_kick',                       S'Drum kicks');
subtitles.register_description('mesecons_noteblock_litecrash',                  S'Cymbal crashes');
subtitles.register_description('mesecons_noteblock_piano_digital',              S'Digital piano tings');
subtitles.register_description('mesecons_noteblock_snare',                      S'Snare');
subtitles.register_description('mesecons_noteblock_squarewave',                 S'Square doots');
subtitles.register_description('mesecons_noteblock_xylophone_metal',            S'Xylophone tings');
subtitles.register_description('mesecons_noteblock_xylophone_wood',             S'Xylophone dits');

subtitles.register_description('mesecons_fpga_write',                           S'FPGA written');
subtitles.register_description('mesecons_fpga_copy',                            S'FPGA copied');
subtitles.register_description('mesecons_fpga_fail',                            S'FPGA fails');

-- Nether:

subtitles.register_description('nether_portal_ignite',                          S'Nether portal opens');
subtitles.register_description('nether_portal_ignition_failure',                S'Nether portal fails to open');
subtitles.register_description('nether_portal_ambient',                         S'Nether portal hums');
subtitles.register_description('nether_portal_teleport',                        S'Nether portal warps');
subtitles.register_description('nether_portal_extinguish',                      S'Nether portal closes');
subtitles.register_description('nether_book_open',                              S'Nether book opens');

subtitles.register_description('nether_lightstaff',                             S'Light staff casts');
subtitles.register_description('nether_rack_destroy',                           S'Netherrack breaks');

subtitles.register_description('nether_fumarole',                               S'Fumarole fumes');
subtitles.register_description('nether_lava_bubble',                            S'Lava bubbles');

-- MineClone:

subtitles.register_description('mcl_totems_totem',                              S'Totem activates');

subtitles.register_description('mcl_bows_bow_shoot',                            S'Bow fires');
subtitles.register_description('mcl_bows_hit_player',                           S'Arrow hits');
subtitles.register_description('mcl_bows_hit_other',                            S'Arrow lands');
subtitles.register_description('mcl_bows_crossbow_drawback_0',                  S'Crossbow loading');
subtitles.register_description('mcl_bows_crossbow_drawback_1',                  S'Crossbow loading');
subtitles.register_description('mcl_bows_crossbow_drawback_2',                  S'Crossbow loading');
subtitles.register_description('mcl_bows_crossbow_load',                        S'Crossbow loaded');
subtitles.register_description('mcl_bows_crossbow_shoot',                       S'Crossbow fires');

subtitles.register_description('mcl_bells_bell_stroke',                         S'Bell rings');

subtitles.register_description('mcl_experience',                                S'Experience');
subtitles.register_description('mcl_experience_level_up',                       S'Level up');

subtitles.register_description('mcl_mobs_mob_poof',                             S'Poof');

subtitles.register_description('mcl_throwing_throw',                            S'Yeet');
subtitles.register_description('mcl_throwing_snowball_impact_soft',             S'Snowball splats');
subtitles.register_description('mcl_throwing_snowball_impact_hard',             S'Snowball smashes');
subtitles.register_description('mcl_throwing_egg_impact',                       S'Egg smashes');

subtitles.register_description('mcl_hunger_bite',                               S'Eating');
subtitles.register_description('survival_thirst_drink',                         S'Drinking');

subtitles.register_description('mcl_end_teleport',                              S'Teleporting');

subtitles.register_description('mcl_chests_enderchest_open',                    S'Ender chest opens');
subtitles.register_description('mcl_chests_enderchest_close',                   S'Ender chest closes');
subtitles.register_description('mcl_chests_shulker_open',                       S'Shulker box opens');
subtitles.register_description('mcl_chests_shulker_close',                      S'Shulker box closes');

subtitles.register_description('mcl_amethyst_amethyst_break',                   S'Amethyst breaks');
subtitles.register_description('mcl_amethyst_amethyst_walk',                    S'Amethyst');

subtitles.register_description('mcl_brewing_complete',                          S'Potion brews');
subtitles.register_description('mcl_enchanting_enchant',                        S'Enchants');

subtitles.register_description('slimenodes_dug',                                S'Slime splorches');
subtitles.register_description('slimenodes_place',                              S'Slime splats');
subtitles.register_description('slimenodes_step',                               S'Slime squelches');

subtitles.register_description('mcl_portals_open_end_portals',                  S'End portal opens');
subtitles.register_description('mcl_portals_teleport',                          S'Interdimensional warp');

subtitles.register_description('mcl_potions_bottle_fill',                       S'Bottle fills');
subtitles.register_description('mcl_potions_bottle_pour',                       S'Bottle pours');
subtitles.register_description('mcl_potions_breaking_glass',                    S'Glass shatters');
subtitles.register_description('mcl_potions_drinking',                          S'Drinking');

subtitles.register_description('mcl_block',                                     S'Shield blocks');
subtitles.register_description('mcl_tools_shears_cut',                          S'Shears cut');

subtitles.register_description('mcl_jukebox_track_1',                           S'‘The Evil Sister’ plays');
subtitles.register_description('mcl_jukebox_track_2',                           S'‘The Energetic Rat’ plays');
subtitles.register_description('mcl_jukebox_track_3',                           S'‘Eastern Feeling’ plays');
subtitles.register_description('mcl_jukebox_track_4',                           S'‘Minetest’ plays');
subtitles.register_description('mcl_jukebox_track_5',                           S'‘Soaring Over the Sea’ plays');
subtitles.register_description('mcl_jukebox_track_6',                           S'‘Winter Feeling’ plays');
subtitles.register_description('mcl_jukebox_track_7',                           S'‘Synthgroove’ plays');
subtitles.register_description('mcl_jukebox_track_8',                           S'‘The Clueless Frog’ plays');

subtitles.register_description('drippingwater_drip',                            S'Water drips');
subtitles.register_description('drippingwater_lavadrip',                        S'Lava drips');

-- Weather:

subtitles.register_description('weather_rain',                                  S'Rain falls');
subtitles.register_description('weather_wind',                                  S'Wind blows');
subtitles.register_description('weather_storm',                                 S'Storm howls');
subtitles.register_description('lightning_thunder',                             S'Thunder rumbles');

-- Advanced Trains:

subtitles.register_description('advtrains_crossing_bell',                       S'Crossing bell chimes');
subtitles.register_description('advtrains_engine_diesel_horn',                  S'Diesel locomotive horn');
subtitles.register_description('advtrains_industrial_horn',                     S'Industrial locomotive horn');
subtitles.register_description('advtrains_japan_horn',                          S'Shinkansen chimes');
subtitles.register_description('advtrains_steam_loop',                          S'Steam engine chuffs');
subtitles.register_description('advtrains_steam_whistle',                       S'Steam engine whistles');
subtitles.register_description('advtrains_subway_loop',                         S'Subway train');
subtitles.register_description('advtrains_subway_arrive',                       S'Subway train arrives');
subtitles.register_description('advtrains_subway_depart',                       S'Subway train departs');
subtitles.register_description('advtrains_subway_dopen',                        S'Subway train doors open');
subtitles.register_description('advtrains_subway_dclose',                       S'Subway train doors close');
subtitles.register_description('advtrains_subway_horn',                         S'Subway train toots');

subtitles.register_description('advtrains_train_jre231_arrive',                 S'JR E231 arrives',     {merge_subtitles = true});
subtitles.register_description('advtrains_train_jre231_depart',                 S'JR E231 departs',     {merge_subtitles = true});
subtitles.register_description('advtrains_train_jre231_door_chime',             S'JR E231 door chimes', {merge_subtitles = true});
subtitles.register_description('advtrains_train_jre231_horn',                   S'JR E231 horn');

subtitles.register_description('advtrains_neat_sounds_crossing_bells_1',        S'Bells chime');
subtitles.register_description('advtrains_neat_sounds_diesel_engine_1',         S'Diesel engine rumbles');     
subtitles.register_description('advtrains_neat_sounds_diesel_engine_2',         S'Diesel engine runs');
subtitles.register_description('advtrains_neat_sounds_electric_engine_1',       S'Electric train hums');
subtitles.register_description('advtrains_neat_sounds_electric_engine_2',       S'Electric train hums');
subtitles.register_description('advtrains_neat_sounds_electric_engine_3',       S'Electric train buzzes');
subtitles.register_description('advtrains_neat_sounds_freight_wagon_1',         S'Goods train clangs');
subtitles.register_description('advtrains_neat_sounds_freight_wagon_1',         S'Goods train rattles');
subtitles.register_description('advtrains_neat_sounds_rotary_snowplow',         S'Rotary snowplow plows');
subtitles.register_description('advtrains_neat_sounds_steam_engine_1',          S'Steam engine chuffs');
subtitles.register_description('advtrains_neat_sounds_steam_engine_2',          S'Steam engine chuffs');
subtitles.register_description('advtrains_neat_sounds_whistle_1',               S'Steam engine whistles');
subtitles.register_description('advtrains_neat_sounds_whistle_2',               S'Steam engine whistles');

subtitles.register_description('moretrains_japan_horn',                         S'Shinkansen chimes');

subtitles.register_description('dlxtrains_diesel_locomotives_locomotive_type1_loop0', S'Diesel engine chugs');
subtitles.register_description('dlxtrains_diesel_locomotives_locomotive_type1_loop1', S'Diesel engine chugs');
subtitles.register_description('dlxtrains_diesel_locomotives_locomotive_type1_loop2', S'Diesel engine chugs');
subtitles.register_description('dlxtrains_diesel_locomotives_locomotive_type1_loop3', S'Diesel engine chugs');
subtitles.register_description('dlxtrains_diesel_locomotives_locomotive_type1_loop4', S'Diesel engine chugs');
subtitles.register_description('dlxtrains_diesel_locomotives_locomotive_type1_loop5', S'Diesel engine chugs');
subtitles.register_description('dlxtrains_diesel_locomotives_locomotive_type1_loop6', S'Diesel engine chugs');
subtitles.register_description('dlxtrains_diesel_locomotives_locomotive_type1_loop7', S'Diesel engine chugs');
subtitles.register_description('dlxtrains_diesel_locomotives_locomotive_type1_loop8', S'Diesel engine chugs');
subtitles.register_description('dlxtrains_diesel_locomotives_locomotive_type1_loop9', S'Diesel engine chugs');

subtitles.register_description('dlxtrains_age_selection_tool',                  S'Wagon ages');
subtitles.register_description('dlxtrains_livery_selection_tool',               S'Wagon painted');
subtitles.register_description('dlxtrains_wagon_updater_tool',                  S'Wagon updates');

-- LineTrack:

subtitles.register_description('linetrack_boat_horn',                           S'Foghorn');
subtitles.register_description('linetrack_boat_idle_high',                      S'Boat engine rumbles');
subtitles.register_description('linetrack_boat_idle_low',                       S'Boat engine hums');
subtitles.register_description('linetrack_boat_revdown',                        S'Boat slows down');
subtitles.register_description('linetrack_boat_revup',                          S'Boat speeds up');
subtitles.register_description('linetrack_boat_start',                          S'Boat engine spins up');
subtitles.register_description('linetrack_boat_stop',                           S'Boat engine spins down');

-- Jail Escape:

subtitles.register_description('mobs_jail_gaurd',                               S'Hey!');
subtitles.register_description('break',                                         S'Breaking');
subtitles.register_description('break_dug',                                     S'Bricks crumble');
subtitles.register_description('trash_can',                                     S'Punches metal');
subtitles.register_description('trash_can_dug',                                 S'Punches metal');
subtitles.register_description('vault_dug',                                     S'Punches vault');
subtitles.register_description('vault',                                         S'Vault clangs');
subtitles.register_description('vending_machine',                               S'Punches vending machine');
subtitles.register_description('drink',                                         S'Drinking');

subtitles.register_description('main',                                          '');
subtitles.register_description('jail',                                          '');

-- Gunslinger:

subtitles.register_description('gunslinger_fire',                               S'Gun fires');
subtitles.register_description('gunslinger_load',                               S'Gun loads');
subtitles.register_description('gunslinger_reload',                             S'Gun reloads');

subtitles.register_description('gunslinger_shotgun_fire',                       S'Shotgun fires');
subtitles.register_description('gunslinger_shotgun_pump',                       S'Shotgun pumps');

-- Vehicles:

subtitles.register_description('engine',                                        S'Engine hums');
subtitles.register_description('engine_start',                                  S'Engine starts');
subtitles.register_description('ambulance',                                     S'Ambulance siren');
subtitles.register_description('shot',                                          S'Weapon fires');

-- NodeCore:

subtitles.register_description('nc_envsound_air',                               S'Air whooshes');
subtitles.register_description('nc_envsound_drip',                              S'Water drips');

subtitles.register_description('nc_api_craft_hiss',                             S'Hiss');
subtitles.register_description('nc_api_craft_sizzle',                           S'Sizzle');
subtitles.register_description('nc_api_toolwear',                               S'Tool wears');
subtitles.register_description('nc_api_toolbreak',                              S'Tool breaks');

subtitles.register_description('nc_fire_ignite',                                S'Fire ignites');
subtitles.register_description('nc_fire_flamy',                                 S'Fire burns');
subtitles.register_description('nc_fire_snuff',                                 S'Fire goes out');

subtitles.register_description('nc_doors_operate',                              S'Door swings');

subtitles.register_description('nc_terrain_bubbly',                             S'Bubble');
subtitles.register_description('nc_terrain_chompy',                             S'Chomp');
subtitles.register_description('nc_terrain_crunchy',                            S'Crunch');
subtitles.register_description('nc_terrain_grassy',                             S'Grass');
subtitles.register_description('nc_terrain_stony',                              S'Stone');
subtitles.register_description('nc_terrain_swishy',                             S'Swish');
subtitles.register_description('nc_terrain_watery',                             S'Splash');

subtitles.register_description('nc_tree_breeze',                                S'Leaves rustle');
subtitles.register_description('nc_tree_corny',                                 S'Eggcorn');
subtitles.register_description('nc_tree_sticky',                                S'Stick');
subtitles.register_description('nc_tree_woody',                                 S'Wood');

subtitles.register_description('nc_lode_annealed',                              S'Lode annealed');
subtitles.register_description('nc_lode_tempered',                              S'Lode tempered');

subtitles.register_description('nc_optics_glassy',                              S'Glass dinks');

-- Builda City:

subtitles.register_description('builda_broken',                                 S'Buzz');
subtitles.register_description('builda_charge',                                 S'Powering up');
subtitles.register_description('builda_error',                                  S'Error');
subtitles.register_description('builda_explode',                                S'Building demolished');
subtitles.register_description('builda_income',                                 S'Earns money');
subtitles.register_description('builda_pay',                                    S'Pays money');
subtitles.register_description('builda_repair',                                 S'Repair');

-- Alter:

subtitles.register_description('error',                                         S'Error');
subtitles.register_description('success',                                       S'Success');
subtitles.register_description('teleport',                                      S'Teleports');
subtitles.register_description('mirror_place',                                  S'Places mirror');
subtitles.register_description('metallic_voice',                                S'Metallic voice');

-- Draconis:

subtitles.register_description('draconis_fire_breath',                          S'Dragon breathes fire');
subtitles.register_description('draconis_flap',                                 S'Dragon flaps');
subtitles.register_description('draconis_ice_breath',                           S'Dragon breathes ice');
subtitles.register_description('draconis_jungle_wyvern_bite',                   S'Wyvern bites');

subtitles.register_description('draconis_draconic_steel_shatter',               S'Draconic steel shatters');
subtitles.register_description('draconis_draconic_steel_swing',                 S'Draconic steel swings');

subtitles.register_description('draconis_fire_dragon',                          S'Fire dragon roars');
subtitles.register_description('draconis_ice_dragon_random_1',                  S'Ice dragon roars');
subtitles.register_description('draconis_ice_dragon_random_2',                  S'Ice dragon roars');
subtitles.register_description('draconis_ice_dragon_random_3',                  S'Ice dragon roars');

-- Minetest Game Plus:

subtitles.register_description('mtg_plus_door_ice_open',                        S'Ice door opens');
subtitles.register_description('mtg_plus_door_ice_close',                       S'Ice door closes');
subtitles.register_description('mtg_plus_door_icesteel_open',                   S'Icy steel door opens');
subtitles.register_description('mtg_plus_door_icesteel_close',                  S'Icy steel door closes');
subtitles.register_description('mtg_plus_paper_dig',                            S'Paper rustles');
subtitles.register_description('mtg_plus_paper_dug',                            S'Paper rips');
subtitles.register_description('mtg_plus_paper_step',                           S'Paper');

-- Digtron:

subtitles.register_description('buzzer',                                        S'Buzzer buzzes');
subtitles.register_description('construction',                                  S'Digtron constructs');
subtitles.register_description('dingding',                                      S'Bell dings');
subtitles.register_description('honk',                                          S'Horn beeps');
subtitles.register_description('machine1',                                      S'Machine runs');
subtitles.register_description('machine2',                                      S'Machine runs');
subtitles.register_description('sploosh',                                       S'Machine splashes');
subtitles.register_description('squeal',                                        S'Digtron brakes');
subtitles.register_description('steam_puff',                                    S'Engine puffs');
subtitles.register_description('truck',                                         S'Engine rumbles');
subtitles.register_description('whirr',                                         S'Engine spins up');
subtitles.register_description('woopwoopwoop',                                  S'Alarm rings');

-- Repixture:

subtitles.register_description('default_shears_cut',                            S'Shears snip');
subtitles.register_description('default_gui_button',                            S'Click');

subtitles.register_description('rp_default_fertilize',                          S'Plant fertilised');
subtitles.register_description('rp_default_ignite_torch',                       S'Torch ignites');
subtitles.register_description('rp_default_torch_burnout',                      S'Torch burns out');

subtitles.register_description('ambiance_birds',                                S'Birds chirp');
subtitles.register_description('ambiance_crickets',                             S'Crickets chirp');
subtitles.register_description('ambiance_cricket_mountain',                     S'Mountain cricket chirps');
subtitles.register_description('ambiance_frog',                                 S'Frog croaks');
subtitles.register_description('ambiance_water',                                S'Water waves');

subtitles.register_description('door_open',                                     S'Door opens');
subtitles.register_description('door_close',                                    S'Door close');
subtitles.register_description('door_blocked',                                  S'Door blocked');

subtitles.register_description('mobs_boar',                                     S'Boar grunts');
subtitles.register_description('mobs_boar_angry',                               S'Boar squeals');
subtitles.register_description('mobs_capture_succeed',                          S'Animal captured');
subtitles.register_description('mobs_eat',                                      S'Eating');
subtitles.register_description('mobs_lasso_swing',                              S'Lasso swings');
subtitles.register_description('mobs_mineturtle',                               S'Mineturtle blasts');
subtitles.register_description('mobs_skunk_hiss',                               S'Skunk hisses');

subtitles.register_description('parachute_open',                                S'Parachute opens');
subtitles.register_description('parachute_close',                               S'Parachute closes');

subtitles.register_description('armor_equip',                                   S'Armour equipped');
subtitles.register_description('armor_unequip',                                 S'Armour removed');

subtitles.register_description('hunger_eat',                                    S'Eating');
subtitles.register_description('hunger_hungry',                                 S'Stomach growls');

subtitles.register_description('rp_itemshow_put_item',                          S'Item placed');
subtitles.register_description('rp_itemshow_take_item',                         S'Item taken');

subtitles.register_description('jewels_jewelling_a_tool',                       S'Jewel tinks');
subtitles.register_description('jewels_jewelling_fail',                         S'Jewel donks');

subtitles.register_description('locks_lock',                                    S'Lock locks');
subtitles.register_description('locks_unlock',                                  S'Lock unlocks');
subtitles.register_description('locks_pick',                                    S'Lock picked');

subtitles.register_description('music_catsong',                                 S'‘catsong’ plays');
subtitles.register_description('music_greyarms',                                S'‘greyarms’ plays');

subtitles.register_description('rp_nav_magnetize_compass',                      S'Compass magnetised');
subtitles.register_description('rp_nav_demagnetize_compass',                    S'Compass demagnetised');

-- Sounds:

subtitles.register_description('sounds_airplane_prop',                          S'Engine rumbles');
subtitles.register_description('sounds_apple_bite',                             S'Food crunches');
subtitles.register_description('sounds_ar_burst_01',                            S'Assault rifle rapid-fires');
subtitles.register_description('sounds_ar_burst_02',                            S'Assault rifle rapid-fires');
subtitles.register_description('sounds_ar_burst_03',                            S'Assault rifle rapid-fires');
subtitles.register_description('sounds_ar_fire_01',                             S'Assault rifle fires');
subtitles.register_description('sounds_ar_fire_02',                             S'Assault rifle fires');
subtitles.register_description('sounds_balloon_inflate',                        S'Balloon inflates');
subtitles.register_description('sounds_balloon_pop',                            S'Balloon pops');
subtitles.register_description('sounds_bat_01',                                 S'Bat squeaks');
subtitles.register_description('sounds_bat_02',                                 S'Bat squeaks');
subtitles.register_description('sounds_bat_03',                                 S'Bat squeaks');
subtitles.register_description('sounds_bear_01',                                S'Bear roars');
subtitles.register_description('sounds_bear_02',                                S'Bear roars');
subtitles.register_description('sounds_bee',                                    S'Bee buzzes');
subtitles.register_description('sounds_bees',                                   S'Bees buzz');
subtitles.register_description('sounds_bicycle_bell',                           S'Bell rings');
subtitles.register_description('sounds_bicycle_horn',                           S'Horn honks');
subtitles.register_description('sounds_bicycle_spokes',                         S'Spokes rattle');
subtitles.register_description('sounds_bird_01',                                S'Bird chirps');
subtitles.register_description('sounds_bird_02',                                S'Bird chirps');
subtitles.register_description('sounds_bird_03',                                S'Bird chirps');
subtitles.register_description('sounds_boing',                                  S'Boing');
subtitles.register_description('sounds_bumble_bee_01',                          S'Bumblebee buzzes');
subtitles.register_description('sounds_bumble_bee_02',                          S'Bumblebee buzzes');
subtitles.register_description('sounds_camel_01',                               S'Camel grunts');
subtitles.register_description('sounds_camel_02',                               S'Camel grunts');
subtitles.register_description('sounds_canary_01',                              S'Canary tweets');
subtitles.register_description('sounds_canary_02',                              S'Canary tweets');
subtitles.register_description('sounds_canary_03',                              S'Canary tweets');
subtitles.register_description('sounds_car_motor',                              S'Motor rumbles');
subtitles.register_description('sounds_cat_meow',                               S'Cat meows');
subtitles.register_description('sounds_chalk_screech_01',                       S'Chalk scrapes');
subtitles.register_description('sounds_chalk_screech_02',                       S'Chalk scrapes');
subtitles.register_description('sounds_chalk_screech_03',                       S'Chalk scrapes');
subtitles.register_description('sounds_chalk_write_01',                         S'Chalk writes');
subtitles.register_description('sounds_chalk_write_02',                         S'Chalk writes');
subtitles.register_description('sounds_chalk_write_03',                         S'Chalk writes');
subtitles.register_description('sounds_chicken_01',                             S'Chicken clucks');
subtitles.register_description('sounds_chicken_02',                             S'Chicken clucks');
subtitles.register_description('sounds_church_bells_01',                        S'Church bells ring');
subtitles.register_description('sounds_church_bells_02',                        S'Church bells ring');
subtitles.register_description('sounds_cicada_01',                              S'Cicada chirps');
subtitles.register_description('sounds_cicada_02',                              S'Cicada chirps');
subtitles.register_description('sounds_cicada_03',                              S'Cicada chirps');
subtitles.register_description('sounds_cicada_04',                              S'Cicada chirps');
subtitles.register_description('sounds_cicada_05',                              S'Cicada chirps');
subtitles.register_description('sounds_cicada_06',                              S'Cicada chirps');
subtitles.register_description('sounds_cicada_07',                              S'Cicada chirps');
subtitles.register_description('sounds_cicada_08',                              S'Cicada chirps');
subtitles.register_description('sounds_clock_tick',                             S'Clock ticks');
subtitles.register_description('sounds_cobra_01',                               S'Cobra hisses');
subtitles.register_description('sounds_cobra_02',                               S'Cobra hisses');
subtitles.register_description('sounds_coin',                                   S'Coin tinkles');
subtitles.register_description('sounds_compressor_motor_01',                    S'Motor chugs');
subtitles.register_description('sounds_compressor_motor_02',                    S'Motor chugs');
subtitles.register_description('sounds_cow_moo_01',                             S'Cow moos');
subtitles.register_description('sounds_cow_moo_02',                             S'Cow moos');
subtitles.register_description('sounds_coyote_howl',                            S'Coyote howls');
subtitles.register_description('sounds_cricket',                                S'Cricket chirps');
subtitles.register_description('sounds_crow_caw',                               S'Crow caws');
subtitles.register_description('sounds_dog_bark',                               S'Dog barks');
subtitles.register_description('sounds_dolphin_chirp',                          S'Dolphin chirps');
subtitles.register_description('sounds_dolphin_click',                          S'Dolphin clicks');
subtitles.register_description('sounds_doorbell_01',                            S'Doorbell rings');
subtitles.register_description('sounds_doorbell_02',                            S'Doorbell rings');
subtitles.register_description('sounds_doorbell_03',                            S'Doorbell rings');
subtitles.register_description('sounds_door_close_01',                          S'Door closes');
subtitles.register_description('sounds_door_close_02',                          S'Door closes');
subtitles.register_description('sounds_door_close_03',                          S'Door closes');
subtitles.register_description('sounds_door_creak',                             S'Door creaks');
subtitles.register_description('sounds_door_knock_01',                          S'Knocking');
subtitles.register_description('sounds_door_knock_02',                          S'Knocking');
subtitles.register_description('sounds_door_open',                              S'Door opens');
subtitles.register_description('sounds_duck_quack_01',                          S'Duck quacks');
subtitles.register_description('sounds_duck_quack_02',                          S'Duck quacks');
subtitles.register_description('sounds_duck_quack_03',                          S'Duck quacks');
subtitles.register_description('sounds_elephant_trumpet',                       S'Elephant trumpets');
subtitles.register_description('sounds_entity_hit',                             S'Hit');
subtitles.register_description('sounds_explosion_01',                           S'BOOM');
subtitles.register_description('sounds_explosion_02',                           S'BOOM');
subtitles.register_description('sounds_explosion_03',                           S'BLAM');
subtitles.register_description('sounds_explosion_distant_01',                   S'Distant explosion');
subtitles.register_description('sounds_explosion_distant_02',                   S'Distant explosion');
subtitles.register_description('sounds_explosion_distant_03',                   S'Distant explosion');
subtitles.register_description('sounds_explosion_distant_04',                   S'Distant explosion');
subtitles.register_description('sounds_explosion_scifi',                        S'Shockwave');
subtitles.register_description('sounds_fire_crackle',                           S'Fire crackles');
subtitles.register_description('sounds_fireball_01',                            S'Fireball whooshes');
subtitles.register_description('sounds_fireball_02',                            S'Fireball whooshes');
subtitles.register_description('sounds_fireball_03',                            S'Fireball whooshes');
subtitles.register_description('sounds_fireworks_01',                           S'Firework launches');
subtitles.register_description('sounds_fireworks_02',                           S'Firework launches');
subtitles.register_description('sounds_fireworks_pop_01',                       S'Firework crackles');
subtitles.register_description('sounds_fireworks_pop_02',                       S'Firework crackles');
subtitles.register_description('sounds_fireworks_pop_03',                       S'Firework crackles');
subtitles.register_description('sounds_frog',                                   S'Frog ribbits');
subtitles.register_description('sounds_fuse',                                   S'Fuse ignites');
subtitles.register_description('sounds_fuse_short',                             S'Fuse ignites');
subtitles.register_description('sounds_gallop_01',                              S'Horse gallops');
subtitles.register_description('sounds_gallop_02',                              S'Horse gallops');
subtitles.register_description('sounds_ghost_01',                               S'Ghost whispers');
subtitles.register_description('sounds_ghost_02',                               S'Ghost whispers');
subtitles.register_description('sounds_ghost_damage',                           S'Ghost hurts');
subtitles.register_description('sounds_ghost_death',                            S'Ghost dies');
subtitles.register_description('sounds_giraffe_hum',                            S'Giraffe hums');
subtitles.register_description('sounds_goat_bleat_01',                          S'Goat bleats');
subtitles.register_description('sounds_goat_bleat_02',                          S'Goat bleats');
subtitles.register_description('sounds_goat_bleat_03',                          S'Goat bleats');
subtitles.register_description('sounds_goose',                                  S'Goose honks');
subtitles.register_description('sounds_gorilla_grunt',                          S'Gorilla grunts');
subtitles.register_description('sounds_gorilla_roar',                           S'Gorilla roars');
subtitles.register_description('sounds_gorilla_snarl_01',                       S'Gorilla snarls');
subtitles.register_description('sounds_gorilla_snarl_02',                       S'Gorilla snarls');
subtitles.register_description('sounds_gorilla_snarl_03',                       S'Gorilla snarls');
subtitles.register_description('sounds_gorilla_snarl_04',                       S'Gorilla snarls');
subtitles.register_description('sounds_grasshopper',                            S'Grasshopper chirps');
subtitles.register_description('sounds_helicopter',                             S'Helicopter spins');
subtitles.register_description('sounds_horse_neigh_01',                         S'Horse neighs');
subtitles.register_description('sounds_horse_neigh_02',                         S'Horse neighs');
subtitles.register_description('sounds_horse_snort_01',                         S'Horse snorts');
subtitles.register_description('sounds_horse_snort_02',                         S'Horse snorts');
subtitles.register_description('sounds_hyena_01',                               S'Hyena laughs');
subtitles.register_description('sounds_hyena_02',                               S'Hyena laughs');
subtitles.register_description('sounds_hyena_03',                               S'Hyena laughs');
subtitles.register_description('sounds_jaguar_saw',                             S'Jaguar growls');
subtitles.register_description('sounds_jet_ambience',                           S'Engine hums');
subtitles.register_description('sounds_jet_flyby',                              S'Jet aeroplane flies past');
subtitles.register_description('sounds_jet_land',                               S'Jet aeroplane lands');
subtitles.register_description('sounds_lamb',                                   S'Lamb baas');
subtitles.register_description('sounds_laser_01',                               S'Laser blasts');
subtitles.register_description('sounds_laser_02',                               S'Laser blasts');
subtitles.register_description('sounds_laser_03',                               S'Laser blasts');
subtitles.register_description('sounds_laser_04',                               S'Laser blasts');
subtitles.register_description('sounds_laser_05',                               S'Laser blasts');
subtitles.register_description('sounds_laser_06',                               S'Laser blasts');
subtitles.register_description('sounds_laser_07',                               S'Laser blasts');
subtitles.register_description('sounds_lava_cool',                              S'Lava hisses');
subtitles.register_description('sounds_laugh_evil_01',                          S'Evil laugh');
subtitles.register_description('sounds_laugh_evil_02',                          S'Evil laugh');
subtitles.register_description('sounds_leaves_01',                              S'Leaves rustle');
subtitles.register_description('sounds_leaves_02',                              S'Leaves rustle');
subtitles.register_description('sounds_leopard_growl_01',                       S'Leopard howls');
subtitles.register_description('sounds_leopard_growl_02',                       S'Leopard howls');
subtitles.register_description('sounds_leopard_growl_03',                       S'Leopard howls');
subtitles.register_description('sounds_leopard_roar_01',                        S'Leopard roars');
subtitles.register_description('sounds_leopard_roar_02',                        S'Leopard roars');
subtitles.register_description('sounds_leopard_roar_03',                        S'Leopard roars');
subtitles.register_description('sounds_leopard_roar_04',                        S'Leopard roars');
subtitles.register_description('sounds_leopard_roar_05',                        S'Leopard roars');
subtitles.register_description('sounds_leopard_saw_01',                         S'Leopard growls');
subtitles.register_description('sounds_leopard_saw_02',                         S'Leopard growls');
subtitles.register_description('sounds_leopard_saw_03',                         S'Leopard growls');
subtitles.register_description('sounds_leopard_snarl_01',                       S'Leopard snarls');
subtitles.register_description('sounds_leopard_snarl_02',                       S'Leopard snarls');
subtitles.register_description('sounds_leopard_snort',                          S'Leopard snorts');
subtitles.register_description('sounds_lion_bellow',                            S'Lion bellows');
subtitles.register_description('sounds_loon_01',                                S'Loon chirps');
subtitles.register_description('sounds_loon_02',                                S'Loon chirps');
subtitles.register_description('sounds_loon_03',                                S'Loon chirps');
subtitles.register_description('sounds_match_ignite',                           S'Match ignites');
subtitles.register_description('sounds_melee_hit_01',                           S'Smack');
subtitles.register_description('sounds_melee_hit_02',                           S'Smack');
subtitles.register_description('sounds_melee_hit_03',                           S'Smack');
subtitles.register_description('sounds_melee_hit_04',                           S'Smack');
subtitles.register_description('sounds_melee_hit_05',                           S'Smack');
subtitles.register_description('sounds_melee_hit_06',                           S'Smack');
subtitles.register_description('sounds_mermaid_song_01',                        S'Mysterious song');
subtitles.register_description('sounds_mermaid_song_02',                        S'Mysterious song');
subtitles.register_description('sounds_mermaid_song_03',                        S'Mysterious song');
subtitles.register_description('sounds_mermaid_song_04',                        S'Mysterious song');
subtitles.register_description('sounds_mermaid_song_05',                        S'Mysterious song');
subtitles.register_description('sounds_monkey_01',                              S'Monkey ooks');
subtitles.register_description('sounds_monkey_02',                              S'Monkey ooks');
subtitles.register_description('sounds_monkey_03',                              S'Monkey ooks');
subtitles.register_description('sounds_motorbike_idle',                         S'Engine idles');
subtitles.register_description('sounds_mouse',                                  S'Mouse squeaks');
subtitles.register_description('sounds_node_dig_choppy',                        S'Choppy');
subtitles.register_description('sounds_node_dig_cracky',                        S'Cracky');
subtitles.register_description('sounds_node_dig_crumbly',                       S'Crumble');
subtitles.register_description('sounds_node_dig_gravel',                        S'Gravel');
subtitles.register_description('sounds_node_dig_ice',                           S'Ice cracks');
subtitles.register_description('sounds_node_dig_metal',                         S'Metal clangs');
subtitles.register_description('sounds_node_dig_snappy',                        S'Rustle');
subtitles.register_description('sounds_node_dug',                               S'Block breaks');
subtitles.register_description('sounds_node_dug_glass',                         S'Glass shatters');
subtitles.register_description('sounds_node_dug_gravel',                        S'Gravel');
subtitles.register_description('sounds_node_dug_ice',                           S'Ice shatters');
subtitles.register_description('sounds_node_dug_metal',                         S'Metal clunks');
subtitles.register_description('sounds_node_place',                             S'Block blops');
subtitles.register_description('sounds_node_place_soft',                        S'Block plops');
subtitles.register_description('sounds_node_step_dirt',                         S'Dirt');
subtitles.register_description('sounds_node_step_glass',                        S'Glass donks');
subtitles.register_description('sounds_node_step_grass',                        S'Grass rustles');
subtitles.register_description('sounds_node_step_gravel',                       S'Gravel');
subtitles.register_description('sounds_node_step_hard',                         S'Hard material');
subtitles.register_description('sounds_node_step_ice',                          S'Ice crunches');
subtitles.register_description('sounds_node_step_metal',                        S'Metal clunks');
subtitles.register_description('sounds_node_step_sand',                         S'Sand crunches');
subtitles.register_description('sounds_node_step_snow',                         S'Snow crunches');
subtitles.register_description('sounds_node_step_water',                        S'Water splashes');
subtitles.register_description('sounds_node_step_wood',                         S'Wood');
subtitles.register_description('sounds_owl_hoot',                               S'Owl hoots');
subtitles.register_description('sounds_parrot_01',                              S'Parrot squawks');
subtitles.register_description('sounds_parrot_02',                              S'Parrot squawks');
subtitles.register_description('sounds_parrot_03',                              S'Parrot squawks');
subtitles.register_description('sounds_parrot_chirp',                           S'Parrot chirps');
subtitles.register_description('sounds_parrot_whistle',                         S'Parrot whistles');
subtitles.register_description('sounds_peacock_01',                             S'Peacock calls');
subtitles.register_description('sounds_peacock_02',                             S'Peacock calls');
subtitles.register_description('sounds_pencil_erase',                           S'Rubber erases');
subtitles.register_description('sounds_pencil_write',                           S'Pencil writes');
subtitles.register_description('sounds_penguin_01',                             S'Penguin calls');
subtitles.register_description('sounds_penguin_02',                             S'Penguin calls');
subtitles.register_description('sounds_piano',                                  S'Piano plays');
subtitles.register_description('sounds_pigeon',                                 S'Pigeon coos');
subtitles.register_description('sounds_pig_snort',                              S'Pig snorts');
subtitles.register_description('sounds_pig_squeal',                             S'Pig squeal');
subtitles.register_description('sounds_pistol_cock_01',                         S'Pistol cocks');
subtitles.register_description('sounds_pistol_cock_02',                         S'Pistol cocks');
subtitles.register_description('sounds_pistol_cock_03',                         S'Pistol cocks');
subtitles.register_description('sounds_pistol_fire_01',                         S'Pistol fires');
subtitles.register_description('sounds_pistol_fire_02',                         S'Pistol fires');
subtitles.register_description('sounds_pistol_fire_03',                         S'Pistol fires');
subtitles.register_description('sounds_pistol_fire_dry',                        S'Pistol clicks');
subtitles.register_description('sounds_pistol_reload',                          S'Pistol reloads');
subtitles.register_description('sounds_plasma_shot',                            S'Plasma shot');
subtitles.register_description('sounds_puppy_bark',                             S'Puppy barks');
subtitles.register_description('sounds_quail',                                  S'Quail chirps');
subtitles.register_description('sounds_raccoon_chatter',                        S'Raccoon chatters');
subtitles.register_description('sounds_raccoon_chatter_baby_01',                S'Baby raccoon chatters');
subtitles.register_description('sounds_raccoon_chatter_baby_02',                S'Baby raccoon chatters');
subtitles.register_description('sounds_rain_heavy_01',                          S'Heavy rain falls');
subtitles.register_description('sounds_rain_heavy_02',                          S'Heavy rain falls');
subtitles.register_description('sounds_rain_light',                             S'Rain drizzles');
subtitles.register_description('sounds_rain_medium',                            S'Rain falls');
subtitles.register_description('sounds_ricochet',                               S'Ploing!');
subtitles.register_description('sounds_rifle_cock_01',                          S'Rifle cocks');
subtitles.register_description('sounds_rifle_cock_02',                          S'Rifle cocks');
subtitles.register_description('sounds_rifle_cock_03',                          S'Rifle cocks');
subtitles.register_description('sounds_rifle_fire_01',                          S'Rifle fires');
subtitles.register_description('sounds_rifle_fire_02',                          S'Rifle fires');
subtitles.register_description('sounds_rifle_fire_03',                          S'Rifle fires');
subtitles.register_description('sounds_rifle_fire_04',                          S'Rifle fires');
subtitles.register_description('sounds_rifle_fire_cock',                        S'Rifle fires and cocks');
subtitles.register_description('sounds_rifle_fire_dry',                         S'Rifle clicks');
subtitles.register_description('sounds_rifle_small_fire_01',                    S'Small rifle fires');
subtitles.register_description('sounds_rifle_small_fire_02',                    S'Small rifle fires');
subtitles.register_description('sounds_robot_01',                               S'Robot speaks');
subtitles.register_description('sounds_robot_02',                               S'Robot beeps');
subtitles.register_description('sounds_rooster',                                S'Rooster crows');
subtitles.register_description('sounds_scrape_01',                              S'Scraping');
subtitles.register_description('sounds_scrape_02',                              S'Scraping');
subtitles.register_description('sounds_scrape_03',                              S'Scraping');
subtitles.register_description('sounds_scrape_04',                              S'Scraping');
subtitles.register_description('sounds_scrape_05',                              S'Scraping');
subtitles.register_description('sounds_scrape_06',                              S'Scraping');
subtitles.register_description('sounds_scrape_07',                              S'Scraping');
subtitles.register_description('sounds_scrape_08',                              S'Scraping');
subtitles.register_description('sounds_seagull_01',                             S'Seagull calls');
subtitles.register_description('sounds_seagull_02',                             S'Seagull calls');
subtitles.register_description('sounds_seagulls',                               S'Seagulls call');
subtitles.register_description('sounds_sea_lion_01',                            S'Sea lion roars');
subtitles.register_description('sounds_sea_lion_02',                            S'Sea lion roars');
subtitles.register_description('sounds_sea_lion_03',                            S'Sea lion roars');
subtitles.register_description('sounds_shears_01',                              S'Shears clip');
subtitles.register_description('sounds_shears_02',                              S'Shears clip');
subtitles.register_description('sounds_sheep_baa',                              S'Sheep baas');
subtitles.register_description('sounds_shotgun_fire_pump',                      S'Shotgun fires and pumps');
subtitles.register_description('sounds_shotgun_pump',                           S'Shotgun pumps');
subtitles.register_description('sounds_skeleton_bones',                         S'Skeleton xyles');
subtitles.register_description('sounds_snake_rattle',                           S'Snake rattles');
subtitles.register_description('sounds_squirrel_01',                            S'Squirrel chatters');
subtitles.register_description('sounds_squirrel_02',                            S'Squirrel chatters');
subtitles.register_description('sounds_squirrel_03',                            S'Squirrel chatters');
subtitles.register_description('sounds_thunder_01',                             S'Thunder rumbles');
subtitles.register_description('sounds_thunder_02',                             S'Thunder rumbles');
subtitles.register_description('sounds_thunder_03',                             S'Thunder rumbles');
subtitles.register_description('sounds_tiger_roar_01',                          S'Tiger roars');
subtitles.register_description('sounds_tiger_snarl_01',                         S'Tiger snarls');
subtitles.register_description('sounds_tiger_snarl_02',                         S'Tiger snarls');
subtitles.register_description('sounds_tiger_snarl_03',                         S'Tiger snarls');
subtitles.register_description('sounds_tiger_snarl_04',                         S'Tiger snarls');
subtitles.register_description('sounds_tool_break',                             S'Tool breaks');
subtitles.register_description('sounds_toucan_01',                              S'Toucan chirps');
subtitles.register_description('sounds_toucan_02',                              S'Toucan chirps');
subtitles.register_description('sounds_toucan_03',                              S'Toucan chirps');
subtitles.register_description('sounds_toy_squeak_01',                          S'Toy squeaks');
subtitles.register_description('sounds_toy_squeak_02',                          S'Toy squeaks');
subtitles.register_description('sounds_train_whistle',                          S'Train whistles');
subtitles.register_description('sounds_tree_creak',                             S'Tree creaks');
subtitles.register_description('sounds_trumpeter_swan',                         S'Swan honks');
subtitles.register_description('sounds_turkey_gobble',                          S'Turkey gobbles');
subtitles.register_description('sounds_undead_moan_01',                         S'Undead groans');
subtitles.register_description('sounds_undead_moan_02',                         S'Undead groans');
subtitles.register_description('sounds_undead_moan_03',                         S'Undead groans');
subtitles.register_description('sounds_undead_moan_04',                         S'Undead groans');
subtitles.register_description('sounds_vehicle_horn_01',                        S'Horn beeps');
subtitles.register_description('sounds_vehicle_horn_02',                        S'Horn beeps');
subtitles.register_description('sounds_vehicle_motor_idle',                     S'Motor idles');
subtitles.register_description('sounds_vomit_01',                               S'Bleurgh');
subtitles.register_description('sounds_vomit_02',                               S'Bleurgh');
subtitles.register_description('sounds_vomit_03',                               S'Bleurgh');
subtitles.register_description('sounds_vomit_04',                               S'Bleurgh');
subtitles.register_description('sounds_vomit_05',                               S'Bleurgh');
subtitles.register_description('sounds_vulture',                                S'Vulture caws');
subtitles.register_description('sounds_watch_tick',                             S'Watch clicks');
subtitles.register_description('sounds_whale',                                  S'Whale sings');
subtitles.register_description('sounds_whistle',                                S'Whistle blows');
subtitles.register_description('sounds_wind',                                   S'Wind blows');
subtitles.register_description('sounds_wolf_howl',                              S'Wolf howls');
subtitles.register_description('sounds_wolf_snarl',                             S'Wolf snarls');
subtitles.register_description('sounds_woodpecker_peck',                        S'Woodpecker pecks');
subtitles.register_description('sounds_woosh_01',                               S'Whoosh');
subtitles.register_description('sounds_woosh_02',                               S'Whoosh');
subtitles.register_description('sounds_woosh_03',                               S'Whoosh');
subtitles.register_description('sounds_woosh_04',                               S'Whoosh');
subtitles.register_description('sounds_yak',                                    S'Yak grunts');
subtitles.register_description('sounds_zebra',                                  S'Zebra chatters');
subtitles.register_description('sounds_zipper',                                 S'Zip zips');
subtitles.register_description('sounds_zombie_damage',                          S'Zombie hurts');
subtitles.register_description('sounds_zombie_death',                           S'Zombie dies');
subtitles.register_description('sounds_zombie_growl_01',                        S'Zombie growls');
subtitles.register_description('sounds_zombie_growl_02',                        S'Zombie growls');
subtitles.register_description('sounds_zombie_growl_03',                        S'Zombie growls');

-- Bows:

subtitles.register_description('bows_shoot',                                    S'Bow fires arrow');

-- Moontest:

subtitles.register_description('air_fill',                                      S'Air hisses');
subtitles.register_description('air_release',                                   S'Air releases');
subtitles.register_description('airlock',                                       S'Airlock clunks');
subtitles.register_description('alarm',                                         S'Alarm rings');
subtitles.register_description('alien',                                         S'Alien speaks');
subtitles.register_description('alien_attack',                                  S'Alien attacks');
subtitles.register_description('drill',                                         S'Drill drills');
subtitles.register_description('eat',                                           S'Eating');
subtitles.register_description('extractor',                                     S'Extractor runs');
subtitles.register_description('generator',                                     S'Generator chugs');
subtitles.register_description('gravity',                                       S'Gravity generator runs');
subtitles.register_description('hvac_off',                                      S'HVAC system shuts down');
subtitles.register_description('hvac_on',                                       S'HVAC system starts up');
subtitles.register_description('hvac_running',                                  S'HVAC system runs');
subtitles.register_description('lwscratch_dug',                                 S'Robot picked up');
subtitles.register_description('lwscratch_footstep',                            S'Footsteps on robot');
subtitles.register_description('lwscratch_place',                               S'Robot placed');
subtitles.register_description('oxygen',                                        S'Oxygen generator runs');
subtitles.register_description('oxygen_start_stop',                             S'Oxygen generator hisses');
subtitles.register_description('power_down',                                    S'Machine powers down');
subtitles.register_description('power_transmitter',                             S'Electricity buzzes');
subtitles.register_description('power_up',                                      S'Machine powers up');
subtitles.register_description('reactor',                                       S'Reactor hums');
subtitles.register_description('research',                                      S'Research received');
subtitles.register_description('rocket',                                        S'Rocket launches');
subtitles.register_description('splat',                                         S'Splat');
subtitles.register_description('teleporter',                                    S'Teleporter clunks');

-- Awards:

subtitles.register_description('awards_got_generic',                            S'Got award');

-- Pedology:

subtitles.register_description('pedology_clay_footstep',                        S'Clay');
subtitles.register_description('pedology_drip',                                 S'Drip');
subtitles.register_description('pedology_gravel_footstep',                      S'Gravel');
subtitles.register_description('pedology_ice_pure_footstep',                    S'Ice crunches');
subtitles.register_description('pedology_ice_white_footstep',                   S'Ice cracks');
subtitles.register_description('pedology_sand_footstep',                        S'Sand crunches');
subtitles.register_description('pedology_silt_footstep',                        S'Silt');
subtitles.register_description('pedology_snow_footstep',                        S'Snow crunches');
subtitles.register_description('pedology_snow_soft_footstep',                   S'Snow crunches');
subtitles.register_description('pedology_turf_footstep',                        S'Turf');

-- Torch Bomb:

subtitles.register_description('torch_bomb_crossbow_fire',                      S'Crossbow fires');
subtitles.register_description('torch_bomb_crossbow_reload',                    S'Crossbow reloads');
subtitles.register_description('torch_bomb_bolt_hit',                           S'Crossbow bolt hits');

-- Steampunk Blimp:

subtitles.register_description('steampunk_blimp_collision',                     S'Blimp collides');
subtitles.register_description('steampunk_blimp_rope',                          S'Rigging creaks');

-- DFCaverns:

subtitles.register_description('df_ambience',                                   S'Ambience');

subtitles.register_description('dfcaverns_arcing',                              S'Arcing');
subtitles.register_description('dfcaverns_avalanche',                           S'Avalanche');
subtitles.register_description('dfcaverns_bird_budgie_song',                    S'Budgie sings');
subtitles.register_description('dfcaverns_bird_noise',                          S'Birds echo');
subtitles.register_description('dfcaverns_crow_slow',                           S'Crow caws');
subtitles.register_description('dfcaverns_drums',                               S'Drum beats');
subtitles.register_description('dfcaverns_exotic_creature_song',                S'Creature calls');
subtitles.register_description('dfcaverns_flies',                               S'Flies buzz');
subtitles.register_description('dfcaverns_frog',                                S'Frog croaks');
subtitles.register_description('dfcaverns_fungus_footstep',                     S'Fungus squelches');
subtitles.register_description('dfcaverns_grinding_stone',                      S'Stone grinds');
subtitles.register_description('dfcaverns_horse_neigh',                         S'Horse neighs');
subtitles.register_description('dfcaverns_howler_monkey',                       S'Monkey howls');
subtitles.register_description('dfcaverns_howling',                             S'Howling');
subtitles.register_description('dfcaverns_jungle_bird',                         S'Jungle bird calls');
subtitles.register_description('dfcaverns_long_bird_song_slow',                 S'Birds sing');
subtitles.register_description('dfcaverns_massive_digging',                     S'Rocks crumble');
subtitles.register_description('dfcaverns_pig_grunting_grumbling',              S'Pig grunts');
subtitles.register_description('dfcaverns_puzzle_chest_close',                  S'Puzzle chest closes');
subtitles.register_description('dfcaverns_puzzle_chest_open',                   S'Puzzle chest opens');
subtitles.register_description('dfcaverns_slade_drill',                         S'Drill');
subtitles.register_description('dfcaverns_slow_heartbeat',                      S'Heartbeat');
subtitles.register_description('dfcaverns_solitary_bird_song',                  S'Bird sings');
subtitles.register_description('dfcaverns_spore_tree_pitter_patter',            S'Spore tree pitter-patters');
subtitles.register_description('dfcaverns_squish',                              S'Squish');
subtitles.register_description('dfcaverns_torchspine_ignite',                   S'Torch spine ignites');
subtitles.register_description('dfcaverns_torchspine_loop',                     S'Torch spine burns');
subtitles.register_description('dfcaverns_whale',                               S'Whale sings');
subtitles.register_description('dfcaverns_whispers',                            S'Whispering');

subtitles.register_description('df_farming_chomp_crunch',                       S'Crunch');
subtitles.register_description('df_farming_crisp_chew',                         S'Crisp chewing');
subtitles.register_description('df_farming_gummy_chew',                         S'Gummy chewing');
subtitles.register_description('df_farming_mushy_chew',                         S'Mushy chewing');
subtitles.register_description('df_farming_soft_chew',                          S'Soft chewing');

subtitles.register_description('mine_gas_seep_hiss',                            S'Gas hisses');

subtitles.register_description('oil_oil_footstep',                              S'Oil slicks');

-- Bees:

subtitles.register_description('bees',                                          S'Bees buzz');

-- X Enchanting:

subtitles.register_description('x_enchanting_enchant',                          S'Enchantment binds');
subtitles.register_description('x_enchanting_scroll',                           S'Scroll rustles');

-- Bedrock:

subtitles.register_description('bedrock2_step',                                 S'Bedrock');

-- Technic:

subtitles.register_description('chainsaw',                                      S'Chainsaw');
subtitles.register_description('mining_drill',                                  S'Drill mines');
subtitles.register_description('technic_hv_nuclear_reactor_siren_clear',        S'Reactor siren stops');
subtitles.register_description('technic_hv_nuclear_reactor_siren_danger_loop',  S'Reactor siren blares');
subtitles.register_description('technic_laser_mk1',                             S'Mk.1 laser zaps');
subtitles.register_description('technic_laser_mk2',                             S'Mk.2 laser zaps');
subtitles.register_description('technic_laser_mk3',                             S'Mk.3 laser zaps');
subtitles.register_description('technic_prospector_hit',                        S'Prospector hits');
subtitles.register_description('technic_prospector_miss',                       S'Prospector misses');
subtitles.register_description('technic_sonic_screwdriver',                     S'Sonic screwdriver sonics');
subtitles.register_description('vacuumcleaner',                                 S'Vacuum cleaner vacuums');

-- Mesebox:

subtitles.register_description('mesebox_open',                                  S'Mesebox opens');
subtitles.register_description('mesebox_close',                                 S'Mesebox closes');

-- Storage Drawers:

subtitles.register_description('drawers_interact',                              S'Drawer slides');

-- Enderpearl:

subtitles.register_description('enderpearl_throw',                              S'Throws enderpearl');
subtitles.register_description('enderpearl_teleport',                           S'Enderpearl teleports');

-- APercy's aeroplanes:

subtitles.register_description('demoiselle_engine',                             S'Demoiselle engine rattles');
subtitles.register_description('demoiselle_collision',                          S'Demoiselle crashes');

subtitles.register_description('hidroplane_engine',                             S'Hydroplane engine putters');
subtitles.register_description('hidroplane_touch',                              S'Hydroplane skids');
subtitles.register_description('hidroplane_touch_water',                        S'Hydroplane splashes');
subtitles.register_description('hidroplane_collision',                          S'Hydroplane crashes');

subtitles.register_description('ju52_engine',                                   S'Ju52 engine rumbles');
subtitles.register_description('ju52_door',                                     S'Ju52 door slides');
subtitles.register_description('ju52_touch',                                    S'Ju52 skids');
subtitles.register_description('ju52_collision',                                S'Ju52 crashes');

subtitles.register_description('pa28_engine',                                   S'PA28 engine rumbles');
subtitles.register_description('pa28_touch',                                    S'PA28 skids');
subtitles.register_description('pa28_collision',                                S'PA28 crashes');

subtitles.register_description('supercub_engine',                               S'Super Cub engine putters');
subtitles.register_description('supercub_touch',                                S'Super Cub skids');
subtitles.register_description('supercub_collision',                            S'Super Cub crashes');

subtitles.register_description('trike_engine',                                  S'Ultralight trike engine');
subtitles.register_description('trike_touch',                                   S'Ultralight trike skids');
subtitles.register_description('trike_collision',                               S'Ultralight trike crashes');

-- Spears:

subtitles.register_description('spears_throw',                                  S'Spear thrown');
subtitles.register_description('spears_hit',                                    S'Spear hits');

-- Fishing!:

subtitles.register_description('fishing_bobber1',                               S'Fishing bobber splashes');
subtitles.register_description('fishing_bobber2',                               S'Fishing bobber splashes');
subtitles.register_description('fishing_baitball',                              S'Fishing bait splashes');

subtitles.register_description('fishing_contest_start',                         S'Fishing contest starts');
subtitles.register_description('fishing_contest_end',                           S'Fishing contest ends');

-- Spyglass:

subtitles.register_description('spyglass_zoom',                                 S'Zooms in');
subtitles.register_description('spyglass_zoom_out',                             S'Zooms out');

-- Super Sam:

subtitles.register_description('super_sam_cash',                                S'Collects cash');
subtitles.register_description('super_sam_coin',                                S'Collects coin');
subtitles.register_description('super_sam_effect_off',                          S'Loses effect');
subtitles.register_description('super_sam_effect_on',                           S'Gains effect');
subtitles.register_description('super_sam_game_over',                           S'Game over');
subtitles.register_description('super_sam_heart',                               S'Collects heart');
subtitles.register_description('super_sam_jump',                                S'Jumps');

subtitles.register_description('super_sam_ambience_1',                          '');
subtitles.register_description('super_sam_ambience_2',                          '');
subtitles.register_description('super_sam_ambience_3',                          '');
subtitles.register_description('super_sam_ambience_4',                          '');
subtitles.register_description('super_sam_ambience_5',                          '');
subtitles.register_description('super_sam_ambience_6',                          '');
subtitles.register_description('super_sam_ambience_relax_1',                    '');

-- Real Torch:

subtitles.register_description('real_torch_burnout',                            S'Torch burns out');
subtitles.register_description('real_torch_extinguish',                         S'Torch extinguished');

-- CCompass:

subtitles.register_description('ccompass_calibrate',                            S'Compass calibrates');

-- Death Compass:

subtitles.register_description('death_compass_bone_crunch',                     S'Bones crunch');
subtitles.register_description('death_compass_tick_tock',                       S'Death clock ticks');

-- NextGen Bows:

subtitles.register_description('nextgen_bows_bow_load',                         S'Pulling bow');
subtitles.register_description('nextgen_bows_bow_loaded',                       S'Bow pulled');
subtitles.register_description('nextgen_bows_bow_shoot',                        S'Bow fires');
subtitles.register_description('nextgen_bows_bow_shoot_crit',                   S'Bow crits');
subtitles.register_description('nextgen_bows_arrow_hit',                        S'Arrow hits');
subtitles.register_description('nextgen_bows_arrow_successful_hit',             S'Arrow dings');

-- Pyramids:

subtitles.register_description('mummy',                                         S'Mummy growls');
subtitles.register_description('mummy_hurt',                                    S'Mummy hurts');
subtitles.register_description('mummy_death',                                   S'Mummy dies');

-- Stamina:

subtitles.register_description('stamina_eat',                                   S'Eating');
subtitles.register_description('stamina_sip',                                   S'Drinking');
subtitles.register_description('stamina_burp',                                  S'Burp');

-- Hunger:

subtitles.register_description('hunger_eating',                                 S'Eating');

-- Ambience:

subtitles.register_description('ambience_soundscape_beach',                     S'Ocean waves');
subtitles.register_description('bats',                                          S'Bats squeak');
subtitles.register_description('beach',                                         S'Ocean waves');
subtitles.register_description('beach_2',                                       S'Ocean waves');
subtitles.register_description('bird',                                          S'Birds chirp');
subtitles.register_description('bird1',                                         S'Birds chirp');
subtitles.register_description('bird2',                                         S'Birds chirp');
subtitles.register_description('birdsongnl',                                    S'Birds chirp');
subtitles.register_description('bluejay',                                       S'Bluejay calls');
subtitles.register_description('canadianloon2',                                 S'Canadian loon calls');
subtitles.register_description('cardinal',                                      S'Cardinal chirps');
subtitles.register_description('cave_crumble_2',                                S'Stone crumbles');
subtitles.register_description('cave_crumble_10',                               S'Stone crumbles');
subtitles.register_description('cave_crumble_12',                               S'Stone crumbles');
subtitles.register_description('cave_dust_fall',                                S'Stone dust falls');
subtitles.register_description('cave_scary_1',                                  S'Ominous noise');
subtitles.register_description('cave_scary_2',                                  S'Ominous noise');
subtitles.register_description('cave_scary_3',                                  S'Ominous noise');
subtitles.register_description('cave_scary_4',                                  S'Ominous noise');
subtitles.register_description('cave_scary_5',                                  S'Ominous noise');
subtitles.register_description('cave_scary_6',                                  S'Ominous noise');
subtitles.register_description('cave_scary_7',                                  S'Ominous noise');
subtitles.register_description('cave_scary_8',                                  S'Ominous noise');
subtitles.register_description('cave_scary_9',                                  S'Ominous noise');
subtitles.register_description('cave_scary_10',                                 S'Ominous noise');
subtitles.register_description('cave_scary_11',                                 S'Ominous noise');
subtitles.register_description('cave_scary_12',                                 S'Ominous noise');
subtitles.register_description('cave_scary_13',                                 S'Ominous noise');
subtitles.register_description('cave_scary_14',                                 S'Ominous noise');
subtitles.register_description('cave_scary_15',                                 S'Ominous noise');
subtitles.register_description('cave_scary_16',                                 S'Ominous noise');
subtitles.register_description('cave_scary_17',                                 S'Ominous noise');
subtitles.register_description('cave_scary_18',                                 S'Ominous noise');
subtitles.register_description('cave_scary_19',                                 S'Ominous noise');
subtitles.register_description('cave_scary_20',                                 S'Ominous noise');
subtitles.register_description('cave_scary_21',                                 S'Ominous noise');
subtitles.register_description('cave_scary_22',                                 S'Ominous noise');
subtitles.register_description('coyote',                                        S'Coyote howls');
subtitles.register_description('craw',                                          S'Crow caws');
subtitles.register_description('crestedlark',                                   S'Crested lark twitters');
subtitles.register_description('cricket',                                       S'Crickets chirp');
subtitles.register_description('deer',                                          S'Deer grumbles');
subtitles.register_description('desertwind',                                    S'Sandy wind blows');
subtitles.register_description('drippingwater1',                                S'Water drips');
subtitles.register_description('drippingwater2',                                S'Water drips');
subtitles.register_description('drippingwater_drip_a',                          S'Water drips');
subtitles.register_description('drippingwater_drip_b',                          S'Water drips');
subtitles.register_description('drippingwater_drip_c',                          S'Water drips');
subtitles.register_description('drowning_gasp',                                 S'Gasp');
subtitles.register_description('gull',                                          S'Gull calls');
subtitles.register_description('hornedowl',                                     S'Owl hoots');
subtitles.register_description('icecrack',                                      S'Ice cracks');
subtitles.register_description('jungle_day_1',                                  S'Jungle animals');
subtitles.register_description('jungle_night_1',                                S'Jungle animals');
subtitles.register_description('jungle_night_2',                                S'Jungle animals')
subtitles.register_description('lava',                                          S'Lava rumbles');
subtitles.register_description('peacock',                                       S'Peacock calls');
subtitles.register_description('river',                                         S'Water flows');
subtitles.register_description('robin',                                         S'Robin chirps');
subtitles.register_description('scuba',                                         S'Deep water');
subtitles.register_description('seagull',                                       S'Seagull calls');
subtitles.register_description('waterfall',                                     S'Waterfall splashes');
subtitles.register_description('wind',                                          S'Wind blows');
subtitles.register_description('wolves',                                        S'Wolves howl');

-- Anvil:

subtitles.register_description('anvil_clang',                                   S'Anvil clangs');

-- Castle Weapons:

subtitles.register_description('castle_crossbow_shoot',                         S'Crossbow fires');
subtitles.register_description('castle_crossbow_click',                         S'Crossbow clicks');
subtitles.register_description('castle_crossbow_bolt',                          S'Crossbow bolt hits');
subtitles.register_description('castle_crossbow_reload',                        S'Crossbow reloads');

-- Ropes:

subtitles.register_description('ropes_creak',                                   S'Rope creaks');

-- Travelnet:

subtitles.register_description('travelnet_bell',                                S'Travelnet bell dings');
subtitles.register_description('travelnet_travel',                              S'Travelnet warps');

-- Subway Miner:

subtitles.register_description('sm_game_button',                                S'Button clicks');
subtitles.register_description('sm_game_coin',                                  S'Mese shines');
subtitles.register_description('sm_game_wait',                                  S'Timer ticks', {duration = 0.5});
subtitles.register_description('sm_game_game_music',                            '');

-- Automobiles Pack:

subtitles.register_description('automobiles_engine',                            S'Car engine rumbles');
subtitles.register_description('automobiles_horn',                              S'Car horn beeps');

subtitles.register_description('buggy_engine',                                  S'Buggy engine rumbles');
subtitles.register_description('coupe_engine',                                  S'Coupe engine rumbles');
subtitles.register_description('delorean_engine',                               S'DeLorean engine hums');
subtitles.register_description('motorcycle_engine',                             S'Motorcycle engine chugs');
subtitles.register_description('roadster_engine',                               S'Roadster engine putters');
subtitles.register_description('roadster_horn',                                 S'Roadster horn honks');
subtitles.register_description('vespa_engine',                                  S'Vespa engine chugs');

-- Regional Weather:

subtitles.register_description('weather_hail',                                  S'Hail clatters');
subtitles.register_description('weather_puddle',                                S'Puddle splashes');
subtitles.register_description('weather_rain_heavy',                            S'Rain pours');

-- i3:

subtitles.register_description('i3_achievement',                                S'Achievement chimes');
subtitles.register_description('i3_cannot',                                     S'Buzz');
subtitles.register_description('i3_click',                                      S'Click');
subtitles.register_description('i3_craft',                                      S'Crafting');
subtitles.register_description('i3_heavy_armor',                                S'Armour clunks');
subtitles.register_description('i3_heavy_boots',                                S'Boots clunk');
subtitles.register_description('i3_heavy_helmet',                               S'Helmet clunks');
subtitles.register_description('i3_heavy_leggings',                             S'Leggings clunk');
subtitles.register_description('i3_heavy_shield',                               S'Shield clunks');
subtitles.register_description('i3_light_armor',                                S'Armour rustles');
subtitles.register_description('i3_light_boots',                                S'Boots rustle');
subtitles.register_description('i3_light_helmet',                               S'Helmet rustles');
subtitles.register_description('i3_light_leggings',                             S'Leggings rustle');
subtitles.register_description('i3_light_shield',                               S'Shield thocks');
subtitles.register_description('i3_skin_change',                                S'Changing clothes');
subtitles.register_description('i3_tab',                                        S'Fwip');
subtitles.register_description('i3_teleport',                                   S'Teleporting');
subtitles.register_description('i3_trash',                                      S'Item discarded');

-- Documentation System:

subtitles.register_description('doc_reveal',                                    S'Knowledge gloops');

-- Shifter Tool:

subtitles.register_description('shifter_tool_pull',                             S'Shifter tool pulls');
subtitles.register_description('shifter_tool_push',                             S'Shifter tool pushes');

-- Mese Portals:

subtitles.register_description('meseportal_open',                               S'Mese portal opens');
subtitles.register_description('meseportal_close',                              S'Mese portal closes');
subtitles.register_description('meseportal_warp',                               S'Mese portal warps');

-- Bell:

subtitles.register_description('bell_small',                                    S'Bell dings');
subtitles.register_description('bell_bell',                                     S'Bell dongs');

-- BWeapons Modpack:

subtitles.register_description('bweapons_bows_pack_arrow_hit',                  S'Arrow hits');
subtitles.register_description('bweapons_bows_pack_bolt_hit',                   S'Bolt hits');
subtitles.register_description('bweapons_bows_pack_crossbow_fire',              S'Crossbow fires');
subtitles.register_description('bweapons_bows_pack_crossbow_reload',            S'Crossbow reloads');
subtitles.register_description('bweapons_bows_pack_longbow_fire',               S'Longbow fires');
subtitles.register_description('bweapons_bows_pack_longbow_reload',             S'Longbow reloads');

subtitles.register_description('bweapons_firearms_pack_double_barrel_fire',     S'Double-barrelled shotgun fires');
subtitles.register_description('bweapons_firearms_pack_grenade_launcher_fire',  S'Grenade launched');
subtitles.register_description('bweapons_firearms_pack_grenade_launcher_hit',   S'Grenade hits');
subtitles.register_description('bweapons_firearms_pack_pistol_fire',            S'Pistol fires');
subtitles.register_description('bweapons_firearms_pack_pistol_reload',          S'Pistol reload');
subtitles.register_description('bweapons_firearms_pack_ricochet',               S'Bullet ricochets');
subtitles.register_description('bweapons_firearms_pack_rifle_fire',             S'Rifle fires');
subtitles.register_description('bweapons_firearms_pack_shotgun_fire',           S'Shotgun fires');
subtitles.register_description('bweapons_firearms_pack_shotgun_reload',         S'Shotgun reloads');

subtitles.register_description('bweapons_hitech_pack_impact',                   S'Plasma ball bursts');
subtitles.register_description('bweapons_hitech_pack_laser_gun_fire',           S'Laser gun fires');
subtitles.register_description('bweapons_hitech_pack_laser_gun_reload',         S'Laser gun charges');
subtitles.register_description('bweapons_hitech_pack_missile_launcher_fire',    S'Missile launcher fires');
subtitles.register_description('bweapons_hitech_pack_missile_launcher_reload',  S'Missile launcher reloads');
subtitles.register_description('bweapons_hitech_pack_particle_gun_fire',        S'Particle gun fires');
subtitles.register_description('bweapons_hitech_pack_plasma_gun_fire',          S'Plasma gun fires');
subtitles.register_description('bweapons_hitech_pack_rail_gun_fire',            S'Rail gun fires');

subtitles.register_description('bweapons_magic_pack_electrosphere_fire',        S'Electrosphere fires');
subtitles.register_description('bweapons_magic_pack_electrosphere_hit',         S'Electrosphere hits');
subtitles.register_description('bweapons_magic_pack_fireball_fire',             S'Fireball whooshes');
subtitles.register_description('bweapons_magic_pack_fireball_hit',              S'Fireball bursts');
subtitles.register_description('bweapons_magic_pack_iceshard_fire',             S'Iceshard fires');
subtitles.register_description('bweapons_magic_pack_iceshard_hit',              S'Iceshard hits');
subtitles.register_description('bweapons_magic_pack_light_fire',                S'Light staff casts');
subtitles.register_description('bweapons_magic_pack_light_hit',                 S'Light ball bursts');
subtitles.register_description('bweapons_magic_pack_magic_fire',                S'Energy staff casts');
subtitles.register_description('bweapons_magic_pack_magic_hit',                 S'Energy ball bursts');
subtitles.register_description('bweapons_magic_pack_reload',                    S'Staff charges');
subtitles.register_description('bweapons_magic_pack_void_fire',                 S'Void staff casts');
subtitles.register_description('bweapons_magic_pack_void_hit',                  S'Void ball bursts');

-- New Fireworks:

subtitles.register_description('new_fireworks_rocket',                          S'Firework launches');
subtitles.register_description('new_fireworks_bang',                            S'Firework explodes');

-- Radiant Damage:

subtitles.register_description('radiant_damage_geiger',                         S'Geiger counter clicks');
subtitles.register_description('radiant_damage_sizzle',                         S'Sizzling');

-- Vacuum:

subtitles.register_description('vacuum_hiss',                                   S'Air hisses');

-- X Clay:

subtitles.register_description('x_clay_dig',                                    S'Clay tinks');
subtitles.register_description('x_clay_dug',                                    S'Clay crumbles');
subtitles.register_description('x_clay_footstep',                               S'Footsteps on clay');
subtitles.register_description('x_clay_place',                                  S'Clay plops');

-- Scythes and Sickles:

subtitles.register_description('sickles_moss_dug',                              S'Moss dug');
