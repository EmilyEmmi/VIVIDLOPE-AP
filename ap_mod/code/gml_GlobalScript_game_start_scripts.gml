function start_demo_mode_new()
{
    game_state_init();
    global.gmode = UnknownEnum.Value_1;
    global.current_stage = global.stage_order[0][0];
    room_goto_transition_slow_fade(rm_level_dream);
}

function start_demo_mode_load()
{
    global.gmode = UnknownEnum.Value_1;
    room_goto_transition_slow_fade(rm_stage_select);
}

function start_demo_mode_extra()
{
    global.gmode = UnknownEnum.Value_2;
    room_goto_transition_slow_fade(rm_stage_select);
}

function start_story_mode_new(arg0 = -1, arg1 = -1)
{
    if (arg0 < 0)
        arg0 = global.current_savedata_slot;
    
    if (arg1 < 0)
        arg1 = global.player_character;
    
    game_state_init();
    
    if (arg0 >= 1000)
    {
        import_demo_data();
        arg0 -= 1000;
    }
    
    global.gmode = UnknownEnum.Value_3;
    global.player_character = arg1;
    global.current_savedata_slot = arg0;
    global.current_stage = "overworld";
    
    // ARCHIPELAGO: allow accessing all levels except Finale
    if (AP_is_multiworld_active()) {
        global.overworld_cleared = max(global.overworld_cleared, 8);
        global.overworld_just_cleared = 0;
        ds_map_clear(global.overworld_clear_events);
    }
    
    if (arg1 == UnknownEnum.Value_4)
        room_goto_transition_slow_fade(rm_maingame);
    else
        room_goto_transition_slow_fade(rm_story_intro);
}

function start_story_mode_load(arg0)
{
    game_state_init();
    global.gmode = UnknownEnum.Value_3;
    
    if (!is_undefined(arg0))
        global.current_savedata_slot = arg0;
    
    savedata_struct_to_game_state(global.savedata_preview[global.current_savedata_slot]);
    global.current_stage = "overworld";
    
    // ARCHIPELAGO: allow accessing all levels except Finale
    if (AP_is_multiworld_active()) {
        global.overworld_cleared = max(global.overworld_cleared, 8);
        global.overworld_just_cleared = 0;
        ds_map_clear(global.overworld_clear_events);
    }
    
    show_story_debug_dump();
    room_goto_transition_slow_fade(rm_maingame);
}

function show_story_debug_dump()
{
    if (global.debugging)
        show_message("overworld_position: " + string(global.overworld_position) + "\noverworld_just_cleared: " + string(global.overworld_just_cleared) + "\noverworld_cleared: " + string(global.overworld_cleared) + "\n\n" + "accessed levels: " + string(ds_map_to_readable(global.accessed_levels)) + "\n\n" + "cleared levels: " + string(ds_map_to_readable(global.cleared_levels)) + "\n\n" + "overworld clear events: " + string(ds_map_to_readable(global.overworld_clear_events)));
}

function start_single_mode()
{
    game_state_init();
    global.gmode = UnknownEnum.Value_1;
    global.current_stage = global.stage_order[0][0];
    room_goto_transition_slow_fade(rm_level_dream);
}

function start_endless_mode(arg0 = false)
{
    game_state_init();
    global.gmode = UnknownEnum.Value_5;
    global.player_lives_default = 3;
    global.player_lives = global.player_lives_default;
    global.player_character = global.shared_savedata.menuchoice_chara;
    global.endless_level = endless_get_level_from_compressed(global.shared_savedata.menuchoice_endless_stage);
    global.endless_stage = endless_get_stage_from_compressed(global.shared_savedata.menuchoice_endless_stage);
    
    if (global.player_character == UnknownEnum.Value_0)
        global.splayer_clothes_hat[0] = global.shared_savedata.clothes_hat_cerise;
    
    if (global.player_character == UnknownEnum.Value_1)
        global.splayer_clothes_hat[0] = global.shared_savedata.clothes_hat_ecru;
    
    if (global.player_character == UnknownEnum.Value_4)
        global.splayer_clothes_hat[0] = global.shared_savedata.clothes_hat_missnoir;
    
    global.score_enabled = true;
    global.stage_difficulty = UnknownEnum.Value_1;
    
    if (!arg0)
        room_goto_transition_slow_fade(rm_maingame);
}

function start_gauntlet_mode(arg0 = false)
{
    game_state_init();
    global.gmode = UnknownEnum.Value_6;
    global.player_lives_default = 3;
    global.player_lives = global.player_lives_default;
    global.player_character = global.shared_savedata.menuchoice_chara;
    
    if (global.player_character == UnknownEnum.Value_0)
        global.splayer_clothes_hat[0] = global.shared_savedata.clothes_hat_cerise;
    
    if (global.player_character == UnknownEnum.Value_1)
        global.splayer_clothes_hat[0] = global.shared_savedata.clothes_hat_ecru;
    
    if (global.player_character == UnknownEnum.Value_4)
        global.splayer_clothes_hat[0] = global.shared_savedata.clothes_hat_missnoir;
    
    global.score_enabled = true;
    global.stage_difficulty = UnknownEnum.Value_1;
    
    if (!arg0)
        room_goto_transition_slow_fade(rm_gauntlet_roulette);
}

function start_custom_mode(arg0 = false)
{
    obj_custom_level_holder.text_test_mode = 0;
    game_state_init();
    custom_level_ranks_port_to_game_state();
    global.gmode = UnknownEnum.Value_13;
    global.player_character = global.shared_savedata.menuchoice_chara;
    
    if (global.player_character == UnknownEnum.Value_0)
        global.splayer_clothes_hat[0] = global.shared_savedata.clothes_hat_cerise;
    
    if (global.player_character == UnknownEnum.Value_1)
        global.splayer_clothes_hat[0] = global.shared_savedata.clothes_hat_ecru;
    
    if (global.player_character == UnknownEnum.Value_4)
        global.splayer_clothes_hat[0] = global.shared_savedata.clothes_hat_missnoir;
    
    loading_buffer_custom_level_sprite_load_bundle();
    
    if (!arg0)
    {
        if (ds_map_empty(global.saved_rank))
            room_goto_transition_slow_fade(rm_level_intro);
        else
            room_goto_transition_slow_fade(rm_stage_select);
    }
}

function start_multi_mode()
{
    show_message("not yet dude");
    room_goto(rm_mainmenu);
}

function start_how_to_play(arg0 = false)
{
    global.score_enabled = false;
    
    if (!arg0)
        room_goto_transition_slow_fade(rm_howto);
}

function start_bestiary(arg0 = false)
{
    global.score_enabled = false;
    
    if (!arg0)
        room_goto_transition_slow_fade(rm_bestiary);
}

function start_level_editor()
{
    room_goto_transition_slow_fade(rm_stageeditor_consumer);
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_13 = 13
}
