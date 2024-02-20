--=====
-- Stand
--=====
item_holders.register_emote("Stand", function(ent, h)
    local yi = h or 0
    ent:set_bone_position("Head", vector.new(0, 6.5, 0), {x=0, y=0, z=0})

    ent:set_bone_position("Body", vector.new(0, 4.75 + (yi*2), 0), {x=0, y=0, z=0})
    
    ent:set_bone_position("Arm_Right", vector.new(-3, 5.75, 0), {x=0, y=0, z=0})
    ent:set_bone_position("Arm_Left", vector.new(3, 5.75, 0), {x=0, y=0, z=0})
    
    ent:set_bone_position("Leg_Right", vector.new(-1, 0, 0), {x=0, y=0, z=0})
    ent:set_bone_position("Leg_Left", vector.new(1, 0, 0), {x=0, y=0, z=0})
end)
item_holders.register_emote("Stand & Hold Right", function(ent, h)
    local yi = h or 0
    ent:set_bone_position("Head", vector.new(0, 6.5, 0), {x=0, y=0, z=0})

    ent:set_bone_position("Body", vector.new(0, 4.75 + (yi*2), 0), {x=0, y=0, z=0})
    
    ent:set_bone_position("Arm_Right", vector.new(3, 5.75, 0), {x=0, y=0, z=0})
    ent:set_bone_position("Arm_Left", vector.new(-3, 5.75, 0), {x=0, y=0, z=-25})
    
    ent:set_bone_position("Leg_Right", vector.new(-1, 0, 0), {x=0, y=0, z=0})
    ent:set_bone_position("Leg_Left", vector.new(1, 0, 0), {x=0, y=0, z=0})
end)
item_holders.register_emote("Stand & Hold Left", function(ent, h)
    local yi = h or 0
    ent:set_bone_position("Head", vector.new(0, 6.5, 0), {x=0, y=0, z=0})

    ent:set_bone_position("Body", vector.new(0, 4.75 + (yi*2), 0), {x=0, y=0, z=0})
    
    ent:set_bone_position("Arm_Right", vector.new(-3, 5.75, 0), {x=0, y=0, z=0})
    ent:set_bone_position("Arm_Left", vector.new(3, 5.75, 0), {x=0, y=0, z=25})
    
    ent:set_bone_position("Leg_Right", vector.new(-1, 0, 0), {x=0, y=0, z=0})
    ent:set_bone_position("Leg_Left", vector.new(1, 0, 0), {x=0, y=0, z=0})
end)
--===
-- Sit
--===
item_holders.register_emote("Sit", function(ent, h)
    local yi = h or 0
    ent:set_bone_position("Head", vector.new(0, 4.5, 0), {x=0, y=0, z=0})

    ent:set_bone_position("Body", vector.new(0, 0 + (yi*1.25), 0), {x=0, y=0, z=0})
    
    ent:set_bone_position("Arm_Right", vector.new(-3, 3.75, 0), {x=0, y=0, z=0})
    ent:set_bone_position("Arm_Left", vector.new(3, 3.75, 0), {x=0, y=0, z=0})
    
    ent:set_bone_position("Leg_Right", vector.new(-1, -1, 0), {x=90, y=0, z=0})
    ent:set_bone_position("Leg_Left", vector.new(1, -1, 0), {x=90, y=0, z=0})
end)
item_holders.register_emote("Sit & Hold Right", function(ent, h)
    local yi = h or 0
    ent:set_bone_position("Head", vector.new(0, 4.5, 0), {x=0, y=0, z=0})

    ent:set_bone_position("Body", vector.new(0, 0 + (yi*1.25), 0), {x=0, y=0, z=0})
    
    ent:set_bone_position("Arm_Right", vector.new(3, 3.75, 0), {x=0, y=0, z=0})
    ent:set_bone_position("Arm_Left", vector.new(-3, 3.75, 0), {x=0, y=0, z=-25})
    
    ent:set_bone_position("Leg_Right", vector.new(-1, -1, 0), {x=90, y=0, z=0})
    ent:set_bone_position("Leg_Left", vector.new(1, -1, 0), {x=90, y=0, z=0})
end)
item_holders.register_emote("Sit & Hold Left", function(ent, h)
    local yi = h or 0
    ent:set_bone_position("Head", vector.new(0, 4.5, 0), {x=0, y=0, z=0})

    ent:set_bone_position("Body", vector.new(0, 0 + (yi*1.25), 0), {x=0, y=0, z=0})
    
    ent:set_bone_position("Arm_Right", vector.new(-3, 3.75, 0), {x=0, y=0, z=0})
    ent:set_bone_position("Arm_Left", vector.new(3, 3.75, 0), {x=0, y=0, z=25})
    
    ent:set_bone_position("Leg_Right", vector.new(-1, -1, 0), {x=90, y=0, z=0})
    ent:set_bone_position("Leg_Left", vector.new(1, -1, 0), {x=90, y=0, z=0})
end)
--=====
-- Lay
--=====
item_holders.register_emote("Lay Front", function(ent, h)
    local yi = h or 0
    ent:set_bone_position("Head", vector.new(0, 6.5, 0), {x=0, y=0, z=0})

    ent:set_bone_position("Body", vector.new(0, -1.25 + (yi*2), 0), {x=90, y=0, z=0})
    
    ent:set_bone_position("Arm_Right", vector.new(-3, 5.75, 0), {x=0, y=0, z=0})
    ent:set_bone_position("Arm_Left", vector.new(3, 5.75, 0), {x=0, y=0, z=0})
    
    ent:set_bone_position("Leg_Right", vector.new(-1, 0, 0), {x=0, y=0, z=0})
    ent:set_bone_position("Leg_Left", vector.new(1, 0, 0), {x=0, y=0, z=0})
end)
item_holders.register_emote("Lay Back", function(ent, h)
    local yi = h or 0
    ent:set_bone_position("Head", vector.new(0, 6.5, 0), {x=0, y=0, z=0})

    ent:set_bone_position("Body", vector.new(0, -1.25 + (yi*2), 0), {x=-90, y=0, z=0})
    
    ent:set_bone_position("Arm_Right", vector.new(-3, 5.75, 0), {x=0, y=0, z=0})
    ent:set_bone_position("Arm_Left", vector.new(3, 5.75, 0), {x=0, y=0, z=0})
    
    ent:set_bone_position("Leg_Right", vector.new(-1, 0, 0), {x=0, y=0, z=0})
    ent:set_bone_position("Leg_Left", vector.new(1, 0, 0), {x=0, y=0, z=0})
end)
--=====
-- Tpose
--=====
item_holders.register_emote("T-pose", function(ent, h)
    local yi = h or 0
    ent:set_bone_position("Head", vector.new(0, 6.5, 0), {x=0, y=0, z=0})

    ent:set_bone_position("Body", vector.new(0, 4.75 + (yi * 1.25), 0), {x=0, y=0, z=0})
    
    ent:set_bone_position("Arm_Right", vector.new(-3, 6, 0), {x = -180, y = 180, z = 90})
    ent:set_bone_position("Arm_Left", vector.new(3, 6, 0), {x = 180, y = 180, z = -90})
    
    ent:set_bone_position("Leg_Right", vector.new(-1, 0, 0), {x=0, y=0, z=0})
    ent:set_bone_position("Leg_Left", vector.new(1, 0, 0), {x=0, y=0, z=0})
end)
--=====
-- Handsup
--=====
item_holders.register_emote("Right Hand Up", function(ent, h)
    local yi = h or 0
    ent:set_bone_position("Head", vector.new(0, 6.5, 0), {x=0, y=0, z=0})

    ent:set_bone_position("Body", vector.new(0, 4.75 + (yi*2), 0), {x=0, y=0, z=0})
    
    ent:set_bone_position("Arm_Right", vector.new(-3, 5.75, 0), {x=0, y=0, z=180})
    ent:set_bone_position("Arm_Left", vector.new(3, 5.75, 0), {x=0, y=0, z=0})
    
    ent:set_bone_position("Leg_Right", vector.new(-1, 0, 0), {x=0, y=0, z=0})
    ent:set_bone_position("Leg_Left", vector.new(1, 0, 0), {x=0, y=0, z=0})
end)

item_holders.register_emote("Hands Up!", function(ent, h)
    local yi = h or 0
    ent:set_bone_position("Head", vector.new(0, 6.5, 0), {x=0, y=0, z=0})

    ent:set_bone_position("Body", vector.new(0, 4.75 + (yi*2), 0), {x=0, y=0, z=0})
    
    ent:set_bone_position("Arm_Right", vector.new(-3, 5.75, 0), {x=0, y=0, z=180})
    ent:set_bone_position("Arm_Left", vector.new(3, 5.75, 0), {x=0, y=0, z=180})
    
    ent:set_bone_position("Leg_Right", vector.new(-1, 0, 0), {x=0, y=0, z=0})
    ent:set_bone_position("Leg_Left", vector.new(1, 0, 0), {x=0, y=0, z=0})
end)

item_holders.register_emote("Left Hand Up", function(ent, h)
    local yi = h or 0
    ent:set_bone_position("Head", vector.new(0, 6.5, 0), {x=0, y=0, z=0})

    ent:set_bone_position("Body", vector.new(0, 4.75 + (yi*2), 0), {x=0, y=0, z=0})
    
    ent:set_bone_position("Arm_Right", vector.new(-3, 5.75, 0), {x=0, y=0, z=0})
    ent:set_bone_position("Arm_Left", vector.new(3, 5.75, 0), {x=0, y=0, z=180})
    
    ent:set_bone_position("Leg_Right", vector.new(-1, 0, 0), {x=0, y=0, z=0})
    ent:set_bone_position("Leg_Left", vector.new(1, 0, 0), {x=0, y=0, z=0})
end)

--=====
-- Kicks
--=====
item_holders.register_emote("Low Kick", function(ent, h)
    local yi = h or 0
    ent:set_bone_position("Head", vector.new(0, 6.5, 0), {x=0, y=0, z=0})

    ent:set_bone_position("Body", vector.new(0, 4.75 + (yi*2), 0), {x=0, y=0, z=0})
    
    ent:set_bone_position("Arm_Right", vector.new(-3, 5.75, 0), {x=0, y=0, z=0})
    ent:set_bone_position("Arm_Left", vector.new(3, 5.75, 0), {x=0, y=0, z=0})
    
    ent:set_bone_position("Leg_Right", vector.new(-1, 0, 0), {x=45, y=0, z=0})
    ent:set_bone_position("Leg_Left", vector.new(1, 0, 0), {x=0, y=0, z=0})
end)

item_holders.register_emote("Middle Kick", function(ent, h)
    local yi = h or 0
    ent:set_bone_position("Head", vector.new(0, 6.5, 0), {x=0, y=0, z=0})

    ent:set_bone_position("Body", vector.new(0, 4.75 + (yi*2), 0), {x=0, y=0, z=0})
    
    ent:set_bone_position("Arm_Right", vector.new(-3, 5.75, 0), {x=0, y=0, z=0})
    ent:set_bone_position("Arm_Left", vector.new(3, 5.75, 0), {x=0, y=0, z=0})
    
    ent:set_bone_position("Leg_Right", vector.new(-1, 0, 0), {x=90, y=0, z=0})
    ent:set_bone_position("Leg_Left", vector.new(1, 0, 0), {x=0, y=0, z=0})
end)
--====
-- Walk
--====
item_holders.register_emote("Walk", function(ent, h)
    local yi = h or 0
    ent:set_bone_position("Head", vector.new(0, 6.5, 0), {x=0, y=0, z=0})

    ent:set_bone_position("Body", vector.new(0, 4.75 + (yi*2), 0), {x=0, y=0, z=0})
    
    ent:set_bone_position("Arm_Right", vector.new(-3, 5.75, 0), {x=45, y=0, z=0})
    ent:set_bone_position("Arm_Left", vector.new(3, 5.75, 0), {x=-45, y=0, z=0})
    
    ent:set_bone_position("Leg_Right", vector.new(-1, 0, 0), {x=45, y=0, z=0})
    ent:set_bone_position("Leg_Left", vector.new(1, 0, 0), {x=-45, y=0, z=0})
end)
item_holders.register_emote("Run", function(ent, h)
    local yi = h or 0
    ent:set_bone_position("Head", vector.new(0, 6.5, 0), {x=0, y=0, z=0})

    ent:set_bone_position("Body", vector.new(0, 4.75 + (yi*2), 0), {x=0, y=0, z=0})
    
    ent:set_bone_position("Arm_Right", vector.new(-3, 5.75, 0), {x=75, y=0, z=0})
    ent:set_bone_position("Arm_Left", vector.new(3, 5.75, 0), {x=-75, y=0, z=0})
    
    ent:set_bone_position("Leg_Right", vector.new(-1, 0, 0), {x=75, y=0, z=0})
    ent:set_bone_position("Leg_Left", vector.new(1, 0, 0), {x=-75, y=0, z=0})
end)
--====
-- Grip
--====
item_holders.register_emote("Backhand Grip", function(ent, h)
    local yi = h or 0
    ent:set_bone_position("Head", vector.new(0, 6.5, 0), {x=0, y=0, z=0})

    ent:set_bone_position("Body", vector.new(0, 4.75 + (yi*2), 0), {x=0, y=0, z=0})
    
    ent:set_bone_position("Arm_Right", vector.new(-3, 5.75, 0), {x=0, y=180, z=0})
    ent:set_bone_position("Arm_Left", vector.new(3, 5.75, 0), {x=0, y=0, z=0})
    
    ent:set_bone_position("Leg_Right", vector.new(-1, 0, 0), {x=0, y=0, z=0})
    ent:set_bone_position("Leg_Left", vector.new(1, 0, 0), {x=0, y=0, z=0})
end)
--=====
-- Trick
--=====
item_holders.register_emote("Trick 1", function(ent, h)
    local yi = h or 0
    ent:set_bone_position("Head", vector.new(0, 6.5, 0), {x=0, y=0, z=0})

    ent:set_bone_position("Body", vector.new(0, 10.5 + (yi*2), 0), {x=180, y=180, z=0})
    
    ent:set_bone_position("Arm_Right", vector.new(-3, 5.75, 0), {x=180, y=0, z=0})
    ent:set_bone_position("Arm_Left", vector.new(3, 5.75, 0), {x=180, y=0, z=0})
    
    ent:set_bone_position("Leg_Right", vector.new(-1, 0, 0), {x=0, y=0, z=0})
    ent:set_bone_position("Leg_Left", vector.new(1, 0, 0), {x=0, y=0, z=0})
end)