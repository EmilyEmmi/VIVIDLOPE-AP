// ARCHIPELAGO: Prevent picking up superjump if we haven't unlocked it
if (global.splayer_item[0] != item_to_check_against || global.splayer_item_quantity[0] <= 0
&& (!AP_is_multiworld_active() || array_contains(global.AP_unlocked_items, item_to_spawn)))
{
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
