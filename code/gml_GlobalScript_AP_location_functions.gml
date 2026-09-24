/// FUNCTIONS
function AP_get_location_reward_text(location_id)
{
    if (!variable_global_exists("AP_location_item")) return "Unknown Item";
    if !variable_struct_exists(global.AP_location_item, location_id) return "Unknown Item";

    var data = variable_struct_get(global.AP_location_item, location_id);

    if (data.playerName == "Yourself" || data.playerName == "<yourself>")
        var text = string("your {0}", data.itemName);
    else
        var text = string("{0}'s {1}", data.playerName, data.itemName);
    return AP_item_classification_color_text(text, data.flags);
}

function AP_get_location_reward_data(location_id)
{
     if (!variable_global_exists("AP_location_item")) return {playerName: "Unknown", itemName: "Unknown", flags: 000}
    if !variable_struct_exists(global.AP_location_item, location_id) return {playerName: "Unknown", itemName: "Unknown", flags: 000}
    var data = variable_struct_get(global.AP_location_item, location_id)
    if data.playerName == "<yourself>" data.playerName = "Yourself"
    return variable_struct_get(global.AP_location_item, location_id)
}

function AP_item_classification_color_text(text, flags)
{
    switch (flags)
    {
        case 0: 
            return string("\\cf{0}\\c0^2", text);
        case 1: 
            return string("\\cv{0}\\c0^2", text);
        case 2:
            return string("\\cu{0}\\c0^2", text);
        case 3:
            return string("\\cg{0}\\c0^2", text);
        case 4:
            return string("\\ct{0}\\c0^2", text);
        default : 
            return string("\\c0{0}\\c0^2", text);
    }
}

function AP_item_classification_color_shop(flags)
{
    return draw_set_color(AP_item_flag_to_color(flags))
}

function AP_item_flag_to_color(flags)
{
    switch (flags)
    {
        case 0:
            return rgb_to_bgr(hex_to_dec(global.AP_colors.filler))
        case 1:
            return rgb_to_bgr(hex_to_dec(global.AP_colors.progression))
        case 2:
            return rgb_to_bgr(hex_to_dec(global.AP_colors.useful))
        case 3:
            return rgb_to_bgr(hex_to_dec(global.AP_colors.useful_progression))
        case 4:
            return rgb_to_bgr(hex_to_dec(global.AP_colors.trap))
        default:
            return c_white
    }
}

function AP_sendLocation(location_id)
{
    obj_archipelago_client.AP_sendLocation(location_id);
}

function AP_sendHint(location_id)
{
    obj_archipelago_client.AP_sendHint(location_id);
}