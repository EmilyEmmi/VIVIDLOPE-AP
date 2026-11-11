// ARCHIPELAGO: Load into saved stage in Finale if it exists
if (timer == 0 && AP_is_multiworld_active()) {
    obj_archipelago_client.AP_load_finale_save();
    
    if (global.compound_stat_stages != 0) {
        global.current_stage = global.stage_order[9][global.compound_stat_stages];
        flash = 1;
        room_goto_transition_white_fade(rm_maingame);
    }
}

timer += global.tdelta;

if (flash >= 0)
    flash = (flash + (0.2 * global.tdelta)) % 2;

if (timer >= 20 && !instance_exists(obj_par_transition))
{
    if (minput_pressed(3))
    {
        if (global.stage_difficulty == UnknownEnum.Value_1)
        {
            menu_play_sound_choose();
            global.stage_difficulty = UnknownEnum.Value_0;
        }
    }
    
    if (minput_pressed(1))
    {
        if (global.stage_difficulty == UnknownEnum.Value_0)
        {
            menu_play_sound_choose();
            global.stage_difficulty = UnknownEnum.Value_1;
        }
    }
    
    if (minput_pressed(4))
    {
        menu_play_sound_accept();
        flash = 1;
        room_goto_transition_white_fade(rm_maingame);
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1
}
