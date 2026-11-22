// Ignore if we enter the overworld
if (global.current_stage == "overworld" || room != rm_maingame) {
    instance_destroy();
    exit;
}

// Send the deathlink once we're in a valid location
var deathlink_valid = false;
with (obj_player) {
    deathlink_valid = (grid_on && global.gstate != 5);
}

if (deathlink_valid) {
    global.AP_deathlink_protected = true;
    if (text != undefined) {
        obj_archipelago_client.AP_create_notification(text, true);
    }
    gstate_activate_player_ko(5); // KO player
    global.AP_deathlink_protected = false;
    instance_destroy();
}