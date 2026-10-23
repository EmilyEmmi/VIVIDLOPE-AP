global.shared_savedata = {};
shared_savedata_reset();

function shared_savedata_has_multiple_characters()
{
    return array_length(global.shared_savedata.unlocked_characters) > 1;
}

function shared_savedata_has_character(arg0)
{
    if (array_find_index_legacy(global.shared_savedata.unlocked_characters, arg0) > -1)
        return true;
    
    return false;
}

function shared_savedata_unlock_character(arg0)
{
    if (array_find_index_legacy(global.shared_savedata.unlocked_characters, arg0) <= -1)
        array_push(global.shared_savedata.unlocked_characters, arg0);
}

function shared_savedata_unlock_clothes(arg0)
{
    if (array_find_index_legacy(global.shared_savedata.unlocked_clothes, arg0) <= -1)
        array_push(global.shared_savedata.unlocked_clothes, arg0);
    
    if (array_length(global.shared_savedata.unlocked_clothes) >= get_total_clothes())
        ach_unlock("fashionista");
}

function shared_savedata_has_clothes(arg0)
{
    if (array_find_index_legacy(global.shared_savedata.unlocked_clothes, arg0) > -1)
        return true;
    
    return false;
}

function shared_savedata_has_cutscene(arg0)
{
    if (global.debugging || array_find_index_legacy(global.shared_savedata.unlocked_cutscenes, arg0) > -1)
        return true;
    
    return false;
}

function shared_savedata_unlock_cutscene(arg0)
{
    if (array_find_index_legacy(global.shared_savedata.unlocked_cutscenes, arg0) <= -1)
    {
        array_push(global.shared_savedata.unlocked_cutscenes, arg0);
        savedata_save_shared();
    }
}

function shared_savedata_has_background_code(arg0)
{
    if (array_find_index_legacy(global.shared_savedata.unlocked_backgrounds, arg0) > -1)
        return true;
    
    return false;
}

function shared_savedata_unlock_background_code(arg0)
{
    if (array_find_index_legacy(global.shared_savedata.unlocked_backgrounds, arg0) <= -1)
        array_push(global.shared_savedata.unlocked_backgrounds, arg0);
}

function shared_savedata_has_background_bg(arg0)
{
    var li = get_unlockable_backgrounds();
    var in = array_find_index_legacy(li, arg0);
    
    if (in < 0)
        return false;
    
    if (array_find_index_legacy(global.shared_savedata.unlocked_backgrounds, in) > -1)
        return true;
    
    return false;
}

function shared_savedata_unlock_background_bg(arg0)
{
    var li = get_unlockable_backgrounds();
    var in = array_find_index_legacy(li, arg0);
    
    if (in < 0)
        exit;
    
    if (array_find_index_legacy(global.shared_savedata.unlocked_backgrounds, in) <= -1)
        array_push(global.shared_savedata.unlocked_backgrounds, in);
}

function shared_savedata_get_achievement(arg0)
{
    with (global.shared_savedata)
    {
        var i = array_length(unlocked_achievements) - 1;
        
        while (i >= 0)
        {
            if (unlocked_achievements[i].code == arg0)
                return unlocked_achievements[i];
            
            i--;
        }
    }
    
    return -1;
}

function shared_savedata_add_achievement(arg0)
{
    with (global.shared_savedata)
    {
        var i = array_length(unlocked_achievements) - 1;
        
        while (i >= 0)
        {
            if (unlocked_achievements[i].code == arg0)
                return false;
            
            i--;
        }
        
        var s = {};
        s.code = arg0;
        s.date_year = current_year;
        s.date_month = current_month;
        s.date_day = current_day;
        s.date_minute = current_minute;
        s.date_second = current_second;
        array_push(unlocked_achievements, s);
    }
    
    return true;
}

function shared_savedata_get_stage_clear_data(arg0)
{
    with (global.shared_savedata)
    {
        var i = array_length(stage_clear_stats) - 1;
        
        while (i >= 0)
        {
            if (stage_clear_stats[i].stage_code == arg0)
            {
                var ol = stage_clear_stats[i];
                return ol;
            }
            
            i--;
        }
        
        var nu = 
        {
            time_frames: 0,
            time_frames_clothes: "",
            time_frames_chara: UnknownEnum.Value_0,
            time_frames_name: "",
            time_frames_version: "",
            time_ms: 0,
            time_ms_clothes: "",
            time_ms_chara: UnknownEnum.Value_0,
            time_ms_name: "",
            time_ms_version: ""
        };
        nu.stage_code = arg0;
        array_push(stage_clear_stats, nu);
        return nu;
    }
}

function shared_savedata_update_best_time_frames_for_stage(arg0, arg1)
{
    if (arg1 <= 0)
        return UnknownEnum.Value_0;
    
    if (arg0.time_frames <= 0)
    {
        arg0.time_frames = arg1;
        arg0.time_frames_chara = global.player_character;
        arg0.time_frames_name = chr(65 + global.current_savedata_slot);
        arg0.time_frames_clothes = global.splayer_clothes_hat[0];
        arg0.time_frames_version = "1.4.6";
        return UnknownEnum.Value_1;
    }
    
    if (arg0.time_frames > arg1)
    {
        arg0.time_frames = arg1;
        arg0.time_frames_chara = global.player_character;
        arg0.time_frames_name = chr(65 + global.current_savedata_slot);
        arg0.time_frames_clothes = global.splayer_clothes_hat[0];
        arg0.time_frames_version = "1.4.6";
        return UnknownEnum.Value_2;
    }
    
    return UnknownEnum.Value_0;
}

function shared_savedata_update_best_time_ms_for_stage(arg0, arg1)
{
    if (arg1 <= 0)
        return UnknownEnum.Value_0;
    
    if (arg0.time_ms <= 0)
    {
        arg0.time_ms = arg1;
        arg0.time_ms_chara = global.player_character;
        arg0.time_ms_name = chr(65 + global.current_savedata_slot);
        arg0.time_ms_clothes = global.splayer_clothes_hat[0];
        arg0.time_ms_version = "1.4.6";
        return UnknownEnum.Value_1;
    }
    
    if (arg0.time_ms > arg1)
    {
        arg0.time_ms = arg1;
        arg0.time_ms_chara = global.player_character;
        arg0.time_ms_name = chr(65 + global.current_savedata_slot);
        arg0.time_ms_clothes = global.splayer_clothes_hat[0];
        arg0.time_ms_version = "1.4.6";
        return UnknownEnum.Value_2;
    }
    
    return UnknownEnum.Value_0;
}

function shared_savedata_register_rank(arg0, arg1, arg2 = false)
{
    with (global.shared_savedata)
    {
        var found = false;
        var map = ds_map_create();
        var out = 0;
        var i = array_length(ranks) - 1;
        
        while (i >= 0)
        {
            if (ranks[i][0] == arg0)
            {
                found = true;
                ranks[i][1] = rank_get_stronger(arg1, ranks[i][1]);
            }
            
            ds_map_set(map, @@array_get@@(@@array_get@@(ranks, i), 0), ranks[i][1]);
            i--;
        }
        
        if (!found)
            array_push(ranks, [arg0, arg1]);
        
        ds_map_set(map, arg0, arg1);
        
        if (arg0 == "finale")
        {
            if (!level_clear[9])
            {
                out += 1;
                level_clear[9] = true;
                level_complete[9] = true;
            }
            
            if (arg1 == "S" || arg1 == "S+" || arg1 == "P")
            {
                if (!level_s[9])
                    out += 2;
                
                level_s[9] = true;
            }
            
            if (arg1 == "P")
            {
                if (!level_perfect[9])
                    out += 4;
                
                level_perfect[9] = true;
            }
            
            ds_map_destroy(map);
            return out;
        }
        
        if (arg2 && found)
        {
            ds_map_destroy(map);
            return out;
        }
        
        for (i = 0; i < 11; i++)
        {
            if (i == 9)
                continue;
            
            var x_ranks = 0;
            var s_ranks = 0;
            var p_ranks = 0;
            var j = array_length(global.stage_order[i]) - 1;
            
            while (j >= 0)
            {
                var r = ds_map_find_value(map, global.stage_order[i][j]);
                
                if (!is_undefined(r))
                {
                    x_ranks++;
                    
                    if (r == "S" || r == "S+")
                        s_ranks++;
                    
                    if (r == "P")
                    {
                        s_ranks++;
                        p_ranks++;
                    }
                }
                
                j--;
            }
            
            if (x_ranks >= 12)
                level_clear[i] = true;
            
            if (x_ranks == array_length(global.stage_order[i]))
            {
                if (!level_complete[i] && (out % 2) == 0)
                    out += 1;
                
                level_complete[i] = true;
            }
            
            if (s_ranks == array_length(global.stage_order[i]))
            {
                if (!level_s[i] && (out % 4) < 2)
                    out += 2;
                
                level_s[i] = true;
            }
            
            if (p_ranks == array_length(global.stage_order[i]))
            {
                if (!level_perfect[i] && (out % 8) < 4)
                    out += 4;
                
                level_perfect[i] = true;
            }
        }
        
        ds_map_destroy(map);
        return out;
    }
}

function shared_savedata_reset()
{
    global.money = 0;
    ds_map_clear(global.equip_items);
    // ARCHIPELAGO: Clear received filler
    if (AP_is_multiworld_active(false)) {
        ds_map_clear(global.AP_received_filler);
    }
    global.shared_savedata = {};
    shared_savedata_ensure_compatibility(global.shared_savedata);
}

function shared_savedata_version_is_compatible(arg0)
{
    if (arg0 > 1)
        error_window_add(false, "err_savetoonew");
    
    return true;
}

function shared_savedata_ensure_compatibility(arg0 = 0)
{
    if (!is_struct(arg0))
        arg0 = global.shared_savedata;
    
    global._target_struct = arg0;
    global._target_struct.version = 1;
    assure_struct_has_variable(global._target_struct, "menuchoice_story_file", 0);
    assure_struct_has_variable(global._target_struct, "menuchoice_chara", UnknownEnum.Value_0);
    assure_struct_has_variable(global._target_struct, "menuchoice_endless_chara", UnknownEnum.Value_0);
    assure_struct_has_variable(global._target_struct, "menuchoice_endless_stage", 101);
    assure_struct_has_variable(global._target_struct, "unlocked_gauntlet", false);
    assure_struct_has_variable(global._target_struct, "menuchoice_gauntlet_chara", UnknownEnum.Value_0);
    assure_struct_has_variable(global._target_struct, "unlocked_characters", [UnknownEnum.Value_0]);
    assure_struct_has_variable(global._target_struct, "endless_farthest_stage", 101);
    assure_struct_has_variable(global._target_struct, "endless_highscore_table", []);
    assure_struct_has_variable(global._target_struct, "gauntlet_highscore_table", []);
    assure_struct_has_variable(global._target_struct, "money", 0);
    assure_struct_has_variable(global._target_struct, "equip_items", []);
    assure_struct_has_variable(global._target_struct, "unlocked_clothes", []);
    assure_struct_has_variable(global._target_struct, "clothes_hat_cerise", "");
    assure_struct_has_variable(global._target_struct, "clothes_hat_ecru", "");
    assure_struct_has_variable(global._target_struct, "clothes_hat_missnoir", "");
    assure_struct_has_variable(global._target_struct, "unlocked_cutscenes", []);
    assure_struct_has_variable(global._target_struct, "unlocked_backgrounds", []);
    assure_struct_has_variable(global._target_struct, "unlocked_enemies", []);
    assure_struct_has_variable(global._target_struct, "unlocked_achievements", []);
    assure_struct_has_variable(global._target_struct, "unlock_register", []);
    assure_struct_has_variable(global._target_struct, "ranks", []);
    assure_struct_has_variable(global._target_struct, "stage_clear_stats", []);
    assure_struct_has_variable(global._target_struct, "level_clear", array_create(11, false));
    assure_struct_array_length(global._target_struct, "level_clear", 11, false);
    assure_struct_has_variable(global._target_struct, "level_complete", array_create(11, false));
    assure_struct_array_length(global._target_struct, "level_complete", 11, false);
    assure_struct_has_variable(global._target_struct, "level_s", array_create(11, false));
    assure_struct_array_length(global._target_struct, "level_s", 11, false);
    assure_struct_has_variable(global._target_struct, "level_perfect", array_create(11, false));
    assure_struct_array_length(global._target_struct, "level_perfect", 11, false);
    assure_struct_has_variable(global._target_struct, "gauntlet_seen_cutscenes", []);
    assure_struct_has_variable(global._target_struct, "bestiary_seen_enemies", []);
    assure_struct_has_variable(global._target_struct, "unlocked_animviewer", false);
    assure_struct_has_variable(global._target_struct, "unlocked_varp", false);
    assure_struct_has_variable(global._target_struct, "varp_growth", 0);
    assure_struct_has_variable(global._target_struct, "varp_growth_cycle", 0);
    assure_struct_has_variable(global._target_struct, "story_beaten_as_cerise", false);
    assure_struct_has_variable(global._target_struct, "story_beaten_as_ecru", false);
    assure_struct_has_variable(global._target_struct, "story_beaten_as_missnoir", false);
    assure_struct_has_variable(global._target_struct, "story_allcleared_as_cerise", false);
    assure_struct_has_variable(global._target_struct, "story_allcleared_as_ecru", false);
    assure_struct_has_variable(global._target_struct, "story_allcleared_as_missnoir", false);
    assure_struct_has_variable(global._target_struct, "story_perfected_as_cerise", false);
    assure_struct_has_variable(global._target_struct, "story_perfected_as_ecru", false);
    assure_struct_has_variable(global._target_struct, "story_perfected_as_missnoir", false);
}

function shared_savedata_check_consistency(arg0 = 0)
{
    if (!is_struct(arg0))
        arg0 = global.shared_savedata;
    
    global._target_struct = arg0;
    return true;
}

function shared_savedata_prepare_for_save()
{
    global.shared_savedata.money = global.money;
    global.shared_savedata.equip_items = array_create(ds_map_size(global.equip_items));
    
    var k = ds_map_find_first(global.equip_items);
    var i = 0;
    
    repeat (ds_map_size(global.equip_items))
    {
        global.shared_savedata.equip_items[i++] = [k, ds_map_find_value(global.equip_items, k)];
        k = ds_map_find_next(global.equip_items, k);
    }
    
    // ARCHIPELAGO: count received filler
    if (AP_is_multiworld_active(false)) {
        global.shared_savedata.AP_received_filler = array_create(ds_map_size(global.AP_received_filler));
        
        var k = ds_map_find_first(global.AP_received_filler);
        var i = 0;
        
        repeat (ds_map_size(global.AP_received_filler))
        {
            global.shared_savedata.AP_received_filler[i++] = [k, ds_map_find_value(global.AP_received_filler, k)];
            k = ds_map_find_next(global.AP_received_filler, k);
        }
    }
}

function shared_savedata_prepare_after_load()
{
    global.money = global.shared_savedata.money;
    ds_map_clear(global.equip_items);
    
    try
    {
        var i = array_length(global.shared_savedata.equip_items) - 1;
        
        while (i >= 0)
        {
            ds_map_set(global.equip_items, global.shared_savedata.equip_items[i][0], global.shared_savedata.equip_items[i][1]);
            i--;
        }
    }
    catch (e)
    {
    }
    
    // ARCHIPELAGO: load received filler
    if (AP_is_multiworld_active(false)) {
        ds_map_clear(global.AP_received_filler);
        try
        {
            var i = array_length(global.shared_savedata.AP_received_filler) - 1;
            
            while (i >= 0)
            {
                ds_map_set(global.AP_received_filler, global.shared_savedata.AP_received_filler[i][0], global.shared_savedata.AP_received_filler[i][1]);
                i--;
            }
        }
        catch (e)
        {
        }
    }
    
    shared_savedata_unlock_character(UnknownEnum.Value_1);
    shared_savedata_unlock_character(UnknownEnum.Value_4);
    shared_savedata_unlock_clothes("cerise_hat_red");
    shared_savedata_unlock_clothes("ecru_hat_beige");
    shared_savedata_unlock_clothes("missnoir_hat_black");
}

function shared_savedata_verify(arg0 = 0)
{
    if (!is_struct(arg0))
        arg0 = global.shared_savedata;
    
    global._target_struct = arg0;
    
    try
    {
        if (!shared_savedata_version_is_compatible(global._target_struct.version))
            return false;
        
        if (global._target_struct.version == 0)
        {
            var s = variable_struct_get_names(global._target_struct);
            var i = 0;
            var n = array_length(s);
            
            while (i < n)
            {
                variable_struct_remove(global._target_struct, s[i]);
                i++;
            }
            
            return true;
        }
        else
        {
            if (!struct_checksum_verify(global._target_struct))
                return false;
            
            if (!shared_savedata_check_consistency(global._target_struct))
                return false;
        }
    }
    catch (e)
    {
        return false;
    }
    
    return true;
}

function shared_savedata_get_filename()
{
    return global.save_base_dir + "sharedsave.vivi";
    return global.save_base_dir + "sharedsave.viv";
}

function shared_savedata_get_legacy_filename()
{
    return global.save_base_dir + "sharedsave.viv";
}

function shared_savedata_reset_highscore()
{
    global.shared_savedata.endless_highscore_table = [];
    global.shared_savedata.gauntlet_highscore_table = [];
    savedata_save_shared();
}

function shared_savedata_delete()
{
    shared_savedata_reset();
    var filename = shared_savedata_get_filename();
    
    if (file_exists(filename))
        file_delete(filename);
}

function savedata_wipeout()
{
    for (var i = 0; i < 8; i++)
        savedata_delete(i);
    
    shared_savedata_delete();
}

function savedata_write_to_cloud()
{
    if (!global.cloud_enabled_in_this_game_run_write)
        exit;
    
    steem_write_cloud_file("sharedsave.viv", shared_savedata_get_filename());
    
    for (var i = 0; i < 8; i++)
        steem_write_cloud_file("save" + string(i + 1) + ".viv", savedata_get_filename(i));
    
    steem_write_cloud_file("demosave.viv", savedata_get_demo_filename());
}

function savedata_read_from_cloud()
{
    if (!global.cloud_enabled_in_this_game_run_read)
        exit;
    
    steem_read_cloud_file("sharedsave.viv", shared_savedata_get_filename());
    
    for (var i = 0; i < 8; i++)
        steem_read_cloud_file("save" + string(i + 1) + ".viv", savedata_get_filename(i));
    
    steem_read_cloud_file("demosave.viv", savedata_get_demo_filename());
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_4 = 4
}
