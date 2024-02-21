dofile("../tga_encoder/init.lua")

local L = { 128 }
local _ = { 160 }
local O = { 192 }
local W = { 255 }

local pixels = {
	{ W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W },
	{ W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W },
	{ W, W, _, _, _, _, _, _, _, _, _, _, _, _, W, W },
	{ W, W, _, _, _, _, _, _, _, _, _, _, _, _, W, W },
	{ W, W, _, _, _, L, _, _, _, L, L, L, _, _, W, W },
	{ W, W, _, _, _, L, _, _, _, L, L, L, _, _, W, W },
	{ W, W, O, O, O, L, O, O, O, L, L, L, O, O, W, W },
	{ W, W, O, O, L, L, L, O, O, O, O, O, O, O, W, W },
	{ W, W, O, L, L, L, L, L, O, O, O, O, O, O, W, W },
	{ W, W, O, L, L, L, L, L, O, O, O, O, O, O, W, W },
	{ W, W, O, L, L, L, L, L, O, O, _, _, O, O, W, W },
	{ W, W, O, O, L, L, L, O, O, O, _, _, O, O, W, W },
	{ W, W, O, O, O, O, O, O, O, O, O, O, O, O, W, W },
	{ W, W, O, O, O, O, O, O, O, O, O, O, O, O, W, W },
	{ W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W },
	{ W, W, W, W, W, W, W, W, W, W, W, W, W, W, W, W },
}
tga_encoder.image(pixels):save("textures/xcam_photo.tga")
