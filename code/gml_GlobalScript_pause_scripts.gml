global.pause_objects = ds_list_create();
global.pause_controller_object = -4;

function game_pause()
{
    screencap_update_now();
    ds_list_clear(global.pause_objects);
    
    with (all)
    {
        if (object_index == obj_global)
            continue;
        
        if (object_index == obj_gmlive)
            continue;
        
        if (object_index == obj_custom_level_holder)
            continue;
        
        if (object_index == obj_buffer_music_playback)
            continue;
        
        if (object_index == obj_save_indicator_n_commiter)
            continue;
        
        if (object_index == obj_switch_controller_probe)
            continue;
        
        if (object_index == obj_handle_pad_disconnection)
            continue;
        
        if (object_index == obj_OLDTVFilter_PresetBase)
            continue;
        
        if (object_index == obj_OLDTVFilter_CUSTOM)
            continue;
        
        // don't delete this!
        if (object_index == obj_archipelago_client)
            continue;
        
        ds_list_add(global.pause_objects, self.id);
        instance_deactivate_object_hook(self.id);
    }
    
    instance_create_depth(0, 0, -99999, global.pause_controller_object);
}

function game_unpause()
{
    var i = ds_list_size(global.pause_objects) - 1;
    
    while (i >= 0)
    {
        instance_activate_object(ds_list_find_value(global.pause_objects, i));
        i--;
    }
    
    ds_list_clear(global.pause_objects);
}

function game_unpause_and_kill()
{
    var i = ds_list_size(global.pause_objects) - 1;
    
    while (i >= 0)
    {
        instance_activate_object(ds_list_find_value(global.pause_objects, i));
        
        with (ds_list_find_value(global.pause_objects, i))
            instance_destroy();
        
        i--;
    }
    
    ds_list_clear(global.pause_objects);
}
