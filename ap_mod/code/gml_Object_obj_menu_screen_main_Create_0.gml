menu_screen_init("main_menu");
shared_savedata_unlock_character(UnknownEnum.Value_1);
shared_savedata_unlock_character(UnknownEnum.Value_4);
shared_savedata_unlock_clothes("cerise_hat_red");
shared_savedata_unlock_clothes("ecru_hat_beige");
shared_savedata_unlock_clothes("missnoir_hat_black");
ach_refresh();

enum UnknownEnum
{
    Value_1 = 1,
    Value_4 = 4
}

// Switch to normal save
if (variable_global_exists("AP_is_playing") && global.AP_is_playing) {
    global.save_base_dir = game_save_id;
    global.steem_is_initialised = (steem_initialised());
    
    // Load save
    prep_legacy_savefiles();
    loading_buffer_shared_savedata_load();
    
    for (var i = 0; i < 8; i++)
        loading_buffer_savedata_preview_load(i);
    
    // reset stages
    global.AP_is_playing = false;
    stage_index_setup();
}
global.AP_is_playing = false;