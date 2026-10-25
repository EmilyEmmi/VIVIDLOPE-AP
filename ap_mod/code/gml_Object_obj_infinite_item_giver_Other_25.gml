if (global.splayer_item[0] != item_to_check_against || global.splayer_item_quantity[0] <= 0)
{
    // ARCHIPELAGO: Prevent picking up superjump if we haven't unlocked it
    if (AP_is_multiworld_active() && !AP_is_powerup_obj_unlocked(item_to_spawn)) exit;
    
    pet_item = instance_create_lay(obj_player.x, obj_player.y, 300, item_to_spawn);
    
    with (pet_item)
    {
        visible = 0;
        display_x = global.player_x;
        display_y = global.player_y;
        display_z = global.player_z;
        powerup_handle_picking();
        instance_destroy();
        exit;
    }
}
