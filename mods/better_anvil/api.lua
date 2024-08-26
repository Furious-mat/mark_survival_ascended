function better_anvil.register_repair(def)
    local registered = better_anvil.registered_repairs
    registered[def.name] = {item = def.item, wear = def.wear}
end

function better_anvil.get_formspec(x, nm)
    local formspec
    if nm == nil then
        nm = ""
    end
    if x then
        formspec = "formspec_version[6]"..
        "size[10.5,12]"..
        "list[context;input;1.1,5.1;1,1;0]"..
        "label[4.8,2.5;Anvil]"..
        "image[4.1,0.1;2.1,2.1;better_anvil_icon.png]"..
        "image[6.6,5.1;1,1;gui_furnace_arrow_bg.png^[transformR270]]"..
        "list[context;output;8.4,5.1;1,1;0]"..
        "list[context;modifier;4.7,5.1;1,1;0]"..
        "image[6.5,5;1.2,1.2;server_incompatible.png]"..
        "image[2.9,5.1;1,1;gui_better_anvil_plus_bg.png]"..
        "field[2.9,3.2;4.7,0.8;name;Name;"..nm.."]"..
        "list[current_player;main;0.4,6.9;8,4;0]"..
        "button[3.7,4.1;3,0.6;upd;Update]"
    else
        formspec = "formspec_version[6]"..
        "size[10.5,12]"..
        "list[context;input;1.1,5.1;1,1;0]"..
        "label[4.8,2.5;Anvil]"..
        "image[4.1,0.1;2.1,2.1;better_anvil_icon.png]"..
        "image[6.6,5.1;1,1;gui_furnace_arrow_bg.png^[transformR270]]"..
        "list[context;output;8.4,5.1;1,1;0]"..
        "list[context;modifier;4.7,5.1;1,1;0]"..
        "image[2.9,5.1;1,1;gui_better_anvil_plus_bg.png]"..
        "field[2.9,3.2;4.7,0.8;name;Name;"..nm.."]"..
        "list[current_player;main;0.4,6.9;8,4;0]"..
        "button[3.7,4.1;3,0.6;upd;Update]"
    end
    return formspec
end

function better_anvil.update(pos, fields)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local instack = inv:get_stack("input", 1)
    local mdstack = inv:get_stack("modifier", 1)
    local imeta = instack:get_meta()
    local nm = instack:get_description()
    local mnm = mdstack:get_name()
    local name
    if not instack:is_empty() then
        if (fields.name == "") or (fields.name == " ") then
            name = nm
        else
            name = fields.name
        end
        local desc = minetest.registered_items[instack:get_name()].description
        if fields.name == desc then
            imeta:set_string("description", desc)
        else
            imeta:set_string("description", core.colorize("lightgrey", name))
        end
        if mdstack:is_empty() then
            meta:set_string("formspec", better_anvil.get_formspec(false, name))
        else
            local mname = string.sub(mnm, string.find(mnm, ":")+1)
            if mdstack:get_definition().groups.dye == 1 then
                imeta:set_string("color", mname)
            else
                meta:set_string("formspec", better_anvil.get_formspec(true, name))
            end
        end
        inv:set_stack("output", 1, instack)
    else
        inv:set_stack("output", 1, "")
        meta:set_string("formspec", better_anvil.get_formspec(true))
    end
end