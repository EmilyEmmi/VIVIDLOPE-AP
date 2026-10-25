/// FUNCTIONS
function AP_get_location_reward_text(location_id, capital = false)
{
    if (!variable_global_exists("AP_location_item")) return "Unknown Item";
    if !variable_struct_exists(global.AP_location_item, location_id) return "Unknown Item";

    var data = variable_struct_get(global.AP_location_item, location_id);

    if (data.playerName == "Yourself" || data.playerName == "<yourself>")
        if (capital) {
            var text = string("Your {0}", data.itemName);
        } else {
            var text = string("your {0}", data.itemName);
        }
    else
        var text = string("{0}'s {1}", data.playerName, data.itemName);
    return text; // AP_item_classification_color_text(text, data.flags);
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

function AP_sendStageLocation(level, stage, rank) {
    // Send base clear check
    var stage_id = (level - 1) * 100 + (stage - 1);
    AP_sendLocation(stage_id);
    
    if (level == 10) exit;
    
    // Send checks for all ranks that we achieved and lower
    var rankPower = ds_map_exists(global.rank_power, rank) ? ds_map_find_value(global.rank_power, rank) : 0;
    var rank_id = rankPower - 1; // Lowest is D
    if (rank_id > 0) {
        for (var i = 1; i <= rank_id; i++) {
            AP_sendLocation(10000 * i + stage_id);
        }
    }
    
    // helpful_text_display_raw("Checked location " + string(locationID)); // TEMP
}

function AP_handleLevelClear(level) {
    if (!AP_is_multiworld_active(false)) exit;
    
    AP_sendLocation(200000 + level - 1);
    AP_initiate_overworld();
    
    if (level == 10 && global.AP_goal_condition == 0) || (level == 11 && global.AP_goal_condition == 1) {
        obj_archipelago_client.AP_goal();
    }
}

function AP_initiate_overworld() {
    if (!AP_is_multiworld_active()) exit;
    
    obj_archipelago_client.AP_handle_received_items(true);
    
    global.overworld_just_cleared = 0;
    ds_map_clear(global.overworld_clear_events);
    
    var maxOverworldClear = (global.AP_goal_condition == 1) ? 9 : 8;
    // Unlock Finale or Level X if we've cleared enough levels
    var clearedLevelCount = 0;
    for (var level = 1; level <= 11; level++) {
        if (!is_undefined(ds_map_find_value(global.cleared_levels, level))) {
            clearedLevelCount++;
        }
    }
    if (clearedLevelCount >= global.AP_goal_unlock) {
        if (global.AP_goal_condition == 0) {
            maxOverworldClear = 9;
            global.overworld_just_cleared = (global.overworld_cleared < maxOverworldClear) ? 1 : 0;
            global.AP_unlocked_levels[9] = true;
        } else if (global.AP_goal_condition == 1) {
            global.AP_override_level_x_reveal = !global.AP_unlocked_levels[10];
            global.AP_unlocked_levels[10] = true;
        }
    }
    
    global.overworld_cleared = max(global.overworld_cleared, maxOverworldClear);
}

function AP_is_multiworld_active(requireAuthentication = false) {
    return (instance_exists(obj_archipelago_client) && variable_global_exists("AP_is_playing") && global.AP_is_playing && (!requireAuthentication || obj_archipelago_client.AP_isAuthenticated()));
}

function AP_is_powerup_obj_unlocked(obj) {
    if (!AP_is_multiworld_active()) return true;
    
    var powerup_names = struct_get_names(global.AP_POWERUP_OBJ_MAP);
    for (var i = 0; i < array_length(powerup_names); i++)
    {
        if (struct_get(global.AP_POWERUP_OBJ_MAP, powerup_names[i]) == obj) {
            return array_contains(global.AP_unlocked_items, powerup_names[i]);
        }
    }
    return true;
}

function AP_element_is_unlocked(prop) {
    if (!AP_is_multiworld_active()) return true;
    
    // Treat weed (negative flower) as flower
    if (prop == 8) prop = 1;
    
    return (!array_contains(global.AP_UNLOCKABLE_ELEMENTS, prop) || array_contains(global.AP_unlocked_elements, prop));
}