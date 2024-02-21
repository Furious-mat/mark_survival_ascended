-- fishing_rod/fishing_rod.lua

-- This Is Where The Crafting Recipes And Functionality Are For The Fishing Rod

-- Fishing Rod
XBows:register_bow("fishing_rod", {
    description = ("Fishing Rod"),
    short_description = ("Fishing Rod"),
    inventory_image = "fishing_rod.png",
    wield_image = "fishing_rod.png^[transformFX",
    custom = {
        inventory_image_charged = "fishing_rod_ready.png",
        wield_image_charged = "fishing_rod_ready.png^[transformFX",
        uses = 100,
        recipe = {
            { "", "", "group:stick" },
            { "", "group:stick", "farming:string" },
            { "group:stick", "", "farming:string" }
        },
        fuel_burntime = 30,
        mod_name = "fishing_rod",
        strength_min = 15,
        strength_max = 20,
        allowed_ammunition = {
            "fishing_rod:basic_fishing_bait",
            "fishing_rod:good_fishing_bait",
            "fishing_rod:great_fishing_bait",
            "fishing_rod:super_fishing_bait",
            "fishing_rod:awesome_fishing_bait",
            "fishing_rod:grand_fishing_bait"
        },
    }
})
