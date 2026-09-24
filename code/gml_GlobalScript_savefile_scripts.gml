global.current_savedata_slot = -1;
global.current_savedata = {};
global.demo_savedata = {};
global.savedata_preview = [];

repeat (8)
{
    array_push(global.savedata_preview, 
    {
        empty: true
    });
}

global._target_struct = {};

function savedata_version_get()
{
    return 10;
}

function savedata_version_is_compatible(arg0)
{
    return true;
}

function savedata_checksum_add(arg0, arg1 = 1)
{
    if (is_string(arg0))
    {
        var i = string_length(arg0);
        
        while (i >= 1)
        {
            global._checksum = (global._checksum + ceil(arg1 * (ord(string_char_at(arg0, i)) * power(i % 16, 1.8)))) % 999999;
            i--;
        }
    }
    else
    {
        global._checksum = (global._checksum + arg0) % 999999;
    }
}

function savedata_calculate_checksum(arg0 = 0)
{
    if (!is_struct(arg0))
        arg0 = global.current_savedata;
    
    global._target_struct = arg0;
    global._checksum = 128;
    savedata_checksum_add(555 + (235 * global._target_struct.chara));
    var n = min(1000, array_length(global._target_struct.level_access));
    
    for (var i = 0; i < n; i++)
        savedata_checksum_add(floor(power(global._target_struct.level_access[i][0], 1.5)) * 412);
    
    n = min(1000, array_length(global._target_struct.level_clear));
    
    for (var i = 0; i < n; i++)
        savedata_checksum_add(floor(power(global._target_struct.level_clear[i][0], 1.5)) * 222);
    
    n = min(1000, array_length(global._target_struct.rank));
    
    for (var i = 0; i < n; i++)
        savedata_checksum_add(string(global._target_struct.rank[i][0]) + string(global._target_struct.rank[i][1]), 0.8);
    
    n = min(1000, array_length(global._target_struct.stage_clear_count));
    
    for (var i = 0; i < n; i++)
        savedata_checksum_add(string(global._target_struct.stage_clear_count[i][0]) + string(global._target_struct.stage_clear_count[i][1]), 0.99523);
    
    n = min(1000, array_length(global._target_struct.stage_clear_count_for_money));
    
    for (var i = 0; i < n; i++)
        savedata_checksum_add(string(global._target_struct.stage_clear_count_for_money[i][0]) + string(global._target_struct.stage_clear_count_for_money[i][1]), 0.352);
    
    n = min(1000, array_length(global._target_struct.equip_items));
    
    for (var i = 0; i < n; i++)
        savedata_checksum_add(string(global._target_struct.equip_items[i][0]) + string(global._target_struct.equip_items[i][1]), 0.23);
    
    savedata_checksum_add(73345 * global._target_struct.lives);
    savedata_checksum_add(231 * global._target_struct.money);
    savedata_checksum_add(global._target_struct.current_stage, 7);
    savedata_checksum_add(325 * floor(power(global._target_struct.overworld_position, 1.3)));
    savedata_checksum_add(253 * floor(power(global._target_struct.overworld_just_cleared, 1.3)));
    return global._checksum;
}

function savedata_verify(arg0 = 0)
{
    if (!is_struct(arg0))
        arg0 = global.current_savedata;
    
    global._target_struct = arg0;
    
    try
    {
        if (!savedata_version_is_compatible(global._target_struct.version))
            return false;
        
        if (global._target_struct.version == 1)
        {
            if (savedata_calculate_checksum(global._target_struct) != global._target_struct.checksum)
                return false;
        }
        else if (!struct_checksum_verify(global._target_struct))
        {
            return false;
        }
    }
    catch (e)
    {
        return false;
    }
    
    return true;
}

function savedata_game_state_to_struct(arg0 = 0)
{
    if (!is_struct(arg0))
    {
        global.current_savedata = {};
        arg0 = global.current_savedata;
    }
    
    global._target_struct = arg0;
    global._target_struct.empty = false;
    global._target_struct.version = savedata_version_get();
    global._target_struct.chara = global.player_character;
    
    if (global.gmode == UnknownEnum.Value_2)
        global._target_struct.current_stage = "s_simple";
    else
        global._target_struct.current_stage = global.current_stage;
    
    global._target_struct.level_access = [];
    ds_map_foreachkey(global.accessed_levels, function(arg0)
    {
        array_push(global._target_struct.level_access, [arg0, ds_map_find_value(global.accessed_levels, arg0)]);
    });
    global._target_struct.level_clear = [];
    ds_map_foreachkey(global.cleared_levels, function(arg0)
    {
        array_push(global._target_struct.level_clear, [arg0, ds_map_find_value(global.cleared_levels, arg0)]);
    });
    global._target_struct.rank = [];
    ds_map_foreachkey(global.saved_rank, function(arg0)
    {
        array_push(global._target_struct.rank, [arg0, ds_map_find_value(global.saved_rank, arg0)]);
    });
    global._target_struct.stage_clear_count = [];
    ds_map_foreachkey(global.stage_clear_count, function(arg0)
    {
        array_push(global._target_struct.stage_clear_count, [arg0, ds_map_find_value(global.stage_clear_count, arg0)]);
    });
    global._target_struct.stage_clear_count_for_money = [];
    ds_map_foreachkey(global.stage_clear_count_for_money, function(arg0)
    {
        array_push(global._target_struct.stage_clear_count_for_money, [arg0, ds_map_find_value(global.stage_clear_count_for_money, arg0)]);
    });
    global._target_struct.hint = [];
    ds_map_foreachkey(global.read_hints, function(arg0)
    {
        array_push(global._target_struct.hint, [arg0, ds_map_find_value(global.read_hints, arg0)]);
    });
    global._target_struct.equip_items = [];
    ds_map_foreachkey(global.equip_items, function(arg0)
    {
        array_push(global._target_struct.equip_items, [arg0, ds_map_find_value(global.equip_items, arg0)]);
    });
    global._target_struct.overworld_clear_events = [];
    ds_map_foreachkey(global.overworld_clear_events, function(arg0)
    {
        array_push(global._target_struct.overworld_clear_events, [arg0, ds_map_find_value(global.overworld_clear_events, arg0)]);
    });
    global._target_struct.worn_hat = global.splayer_clothes_hat[0];
    global._target_struct.worn_eyes = global.splayer_clothes_eyes[0];
    global._target_struct.worn_fur = global.splayer_clothes_fur[0];
    global._target_struct.lives = global.player_lives;
    global._target_struct.money = global.money;
    global._target_struct.overworld_position = global.overworld_position;
    global._target_struct.overworld_cleared = global.overworld_cleared;
    global._target_struct.overworld_just_cleared = global.overworld_just_cleared;
    global._target_struct.game_time = global.game_time;
    global._target_struct.shop_visits = global.shop_visits;
    global._target_struct.shop_purchases = global.shop_purchases;
    global._target_struct.shop_codes = global.shop_codes;
    global._target_struct.babby_hints = global.babby_hints;
    global._target_struct.count_kos = global.count_kos;
    global._target_struct.count_fruits = global.count_fruits;
    global._target_struct.count_defeated_enemies = global.count_defeated_enemies;
    global._target_struct.stage_difficulty = global.stage_difficulty;
    
    if (global.level_clear_requirement > 6)
        global._target_struct.level_clear_requirement = 12;
    else
        global._target_struct.level_clear_requirement = 5;
}

function savedata_struct_to_game_state(arg0 = 0)
{
    if (!is_struct(arg0))
        arg0 = global.current_savedata;
    
    global._target_struct = arg0;
    
    if (!savedata_verify(global._target_struct))
        return false;
    
    global.player_character = global._target_struct.chara;
    global.current_stage = global._target_struct.current_stage;
    ds_map_clear(global.accessed_levels);
    var n = min(1000, array_length(global._target_struct.level_access));
    
    for (var i = 0; i < n; i++)
        ds_map_set(global.accessed_levels, global._target_struct.level_access[i][0], global._target_struct.level_access[i][1]);
    
    ds_map_clear(global.cleared_levels);
    n = min(1000, array_length(global._target_struct.level_clear));
    
    for (var i = 0; i < n; i++)
        ds_map_set(global.cleared_levels, global._target_struct.level_clear[i][0], global._target_struct.level_clear[i][1]);
    
    ds_map_clear(global.saved_rank);
    n = min(1000, array_length(global._target_struct.rank));
    
    for (var i = 0; i < n; i++)
        ds_map_set(global.saved_rank, global._target_struct.rank[i][0], global._target_struct.rank[i][1]);
    
    ds_map_clear(global.stage_clear_count);
    n = min(1000, array_length(global._target_struct.stage_clear_count));
    
    for (var i = 0; i < n; i++)
        ds_map_set(global.stage_clear_count, global._target_struct.stage_clear_count[i][0], global._target_struct.stage_clear_count[i][1]);
    
    ds_map_clear(global.stage_clear_count_for_money);
    n = min(1000, array_length(global._target_struct.stage_clear_count_for_money));
    
    for (var i = 0; i < n; i++)
        ds_map_set(global.stage_clear_count_for_money, global._target_struct.stage_clear_count_for_money[i][0], global._target_struct.stage_clear_count_for_money[i][1]);
    
    ds_map_clear(global.read_hints);
    n = min(1000, array_length(global._target_struct.hint));
    
    for (var i = 0; i < n; i++)
        ds_map_set(global.read_hints, global._target_struct.hint[i][0], global._target_struct.hint[i][1]);
    
    global.player_lives = global._target_struct.lives;
    global.overworld_position = global._target_struct.overworld_position;
    global.overworld_just_cleared = global._target_struct.overworld_just_cleared;
    
    if (global._target_struct.version > 2)
    {
        global.overworld_cleared = global._target_struct.overworld_cleared;
        ds_map_clear(global.overworld_clear_events);
        n = min(500, array_length(global._target_struct.overworld_clear_events));
        
        for (var i = 0; i < n; i++)
            ds_map_set(global.overworld_clear_events, global._target_struct.overworld_clear_events[i][0], global._target_struct.overworld_clear_events[i][1]);
    }
    else
    {
        global.overworld_cleared = 0;
        ds_map_clear(global.overworld_clear_events);
    }
    
    if (global._target_struct.version > 3)
    {
        global.splayer_clothes_hat[0] = global._target_struct.worn_hat;
        global.splayer_clothes_eyes[0] = global._target_struct.worn_eyes;
        global.splayer_clothes_fur[0] = global._target_struct.worn_fur;
    }
    else
    {
        global.splayer_clothes_eyes[0] = "";
        global.splayer_clothes_hat[0] = "";
        global.splayer_clothes_fur[0] = "";
    }
    
    if (global._target_struct.version > 4)
        global.game_time = global._target_struct.game_time;
    else
        global.game_time = 0;
    
    if (global._target_struct.version > 5)
    {
        global.shop_visits = global._target_struct.shop_visits;
        global.shop_purchases = global._target_struct.shop_purchases;
        global.shop_codes = global._target_struct.shop_codes;
        global.babby_hints = global._target_struct.babby_hints;
    }
    
    if (global._target_struct.version > 6)
        global.stage_difficulty = global._target_struct.stage_difficulty;
    
    if (global._target_struct.version > 7)
    {
        global.level_clear_requirement = global._target_struct.level_clear_requirement;
        
        if (global._target_struct.version < 10)
        {
            if (global.level_clear_requirement == 12)
                global.level_clear_requirement = 12;
            
            if (global.level_clear_requirement == 5)
                global.level_clear_requirement = 5;
        }
    }
    
    if (global._target_struct.version > 9)
    {
        assure_struct_has_variable(global._target_struct, "count_kos", -1);
        assure_struct_has_variable(global._target_struct, "count_fruits", -1);
        assure_struct_has_variable(global._target_struct, "count_defeated_enemies", -1);
        global.count_kos = global._target_struct.count_kos;
        global.count_fruits = global._target_struct.count_fruits;
        global.count_defeated_enemies = global._target_struct.count_defeated_enemies;
    }
    else
    {
        global.count_kos = -1;
        global.count_fruits = -1;
        global.count_defeated_enemies = -1;
    }
    
    return true;
}

function savedata_adapt_to_fileselect(arg0 = 0)
{
    if (!is_struct(arg0))
        arg0 = global.current_savedata;
    
    global._target_struct = arg0;
    var total_stages = 151;
    
    with (global._target_struct)
    {
        preview_mode = 0;
        
        if (version > savedata_version_get() && room == rm_init)
            error_window_add(false, "err_savetoonew");
        
        if (version > 7 && level_clear_requirement <= 5)
            preview_mode = 1;
        
        preview_perfect_ranks = 0;
        preview_superb_ranks = 0;
        preview_superb_subp_ranks = 0;
        preview_stage_clears = array_length(rank);
        var i = 0;
        var n = array_length(rank);
        
        while (i < n)
        {
            if (!ds_map_exists(global.stage_index_to_level, rank[i][0]) && rank[i][0] != "finale")
            {
                preview_stage_clears--;
            }
            else
            {
                shared_savedata_register_rank(rank[i][0], rank[i][1], true);
                
                if (rank[i][1] == "P")
                {
                    preview_superb_ranks++;
                    preview_perfect_ranks++;
                }
                
                if (rank[i][1] == "S" || rank[i][1] == "S+")
                {
                    preview_superb_ranks++;
                    preview_superb_subp_ranks++;
                }
                
                if (rank[i][1] == "Y")
                    preview_stage_clears--;
            }
            
            i++;
        }
        
        var levels = 11;
        preview_level_status = array_create(levels, 0);
        n = array_length(level_access);
        
        for (i = 0; i < n; i++)
        {
            var ind = level_access[i][0] - 1;
            
            if (ind >= 0 && ind < 11)
                preview_level_status[ind] = 1;
        }
        
        n = array_length(level_clear);
        
        for (i = 0; i < n; i++)
        {
            var ind = level_clear[i][0] - 1;
            
            if ((ind >= 0 && ind < 9) || ind == 10)
            {
                preview_level_status[ind] = 2;
                var clears = 0;
                var sears = 0;
                var peers = 0;
                var j = 0;
                var n2 = array_length(rank);
                
                while (j < n2)
                {
                    if (ds_map_exists(global.stage_index_to_level, rank[j][0]) && ds_map_find_value(global.stage_index_to_level, @@array_get@@(@@array_get@@(rank, j), 0)) == (ind + 1))
                    {
                        if (rank[j][1] == "P")
                        {
                            clears++;
                            sears++;
                        }
                        
                        if (rank[j][1] == "S" || rank[j][1] == "S+")
                            sears++;
                        
                        peers++;
                    }
                    
                    j++;
                }
                
                var nnn = array_length(global.stage_order[ind]);
                
                if (clears == nnn)
                    preview_level_status[ind] = 5;
                else if (sears == nnn)
                    preview_level_status[ind] = 4;
                else if (peers == nnn)
                    preview_level_status[ind] = 3;
            }
            
            if (ind == 9)
            {
                for (var j = 0; j < preview_stage_clears; j++)
                {
                    if (rank[j][0] == "finale")
                    {
                        if (rank[j][1] == "P")
                            preview_level_status[ind] = 5;
                        else if (rank[j][1] == "S" || rank[j][1] == "S+")
                            preview_level_status[ind] = 4;
                        else
                            preview_level_status[ind] = 3;
                        
                        break;
                    }
                }
            }
        }
        
        if (preview_level_status[9] > 1)
        {
            preview_game_beaten = true;
            
            if (chara == UnknownEnum.Value_0)
                global.shared_savedata.story_beaten_as_cerise = true;
            
            if (chara == UnknownEnum.Value_1)
                global.shared_savedata.story_beaten_as_ecru = true;
            
            if (chara == UnknownEnum.Value_4)
                global.shared_savedata.story_beaten_as_missnoir = true;
        }
        else
        {
            preview_game_beaten = false;
        }
        
        if (preview_stage_clears >= total_stages)
        {
            preview_all_stage_clear = true;
            
            if (chara == UnknownEnum.Value_0)
                global.shared_savedata.story_allcleared_as_cerise = true;
            
            if (chara == UnknownEnum.Value_1)
                global.shared_savedata.story_allcleared_as_ecru = true;
            
            if (chara == UnknownEnum.Value_4)
                global.shared_savedata.story_allcleared_as_missnoir = true;
        }
        else
        {
            preview_all_stage_clear = false;
        }
        
        var all_stages_min_status = min(preview_level_status[0], preview_level_status[1], preview_level_status[2], preview_level_status[3], preview_level_status[4], preview_level_status[5], preview_level_status[6], preview_level_status[7], preview_level_status[8], preview_level_status[9], preview_level_status[10]);
        
        if (all_stages_min_status >= 5)
        {
            preview_game_perfected = true;
            preview_game_superbd = true;
            ach_unlock("splendid");
            ach_unlock("vividlove");
            
            if (chara == UnknownEnum.Value_0)
                global.shared_savedata.story_perfected_as_cerise = true;
            
            if (chara == UnknownEnum.Value_1)
                global.shared_savedata.story_perfected_as_ecru = true;
            
            if (chara == UnknownEnum.Value_4)
                global.shared_savedata.story_perfected_as_missnoir = true;
        }
        else if (all_stages_min_status >= 4)
        {
            ach_unlock("splendid");
            preview_game_perfected = false;
            preview_game_superbd = true;
        }
        else
        {
            preview_game_perfected = false;
            preview_game_superbd = false;
        }
    }
}

function savedata_get_filename(arg0)
{
    return global.save_base_dir + "save" + string(arg0 + 1) + ".vivi";
    return global.save_base_dir + "save" + string(arg0 + 1) + ".viv";
}

function savedata_get_legacy_filename(arg0)
{
    return global.save_base_dir + "save" + string(arg0 + 1) + ".viv";
}

function savedata_get_demo_filename()
{
    return global.save_base_dir + "demosave.viv";
}

function savedata_autosave()
{
    if (global.gmode == UnknownEnum.Value_3 || global.gmode == UnknownEnum.Value_4 || global.gmode == UnknownEnum.Value_1 || global.gmode == UnknownEnum.Value_2)
    {
        savedata_game_state_to_struct();
        
        if (is_demo_version())
            loading_buffer_demo_savedata_save();
        else
            loading_buffer_savedata_save(global.current_savedata_slot);
    }
    
    savedata_save_shared();
}

function savedata_save_shared()
{
    shared_savedata_prepare_for_save();
    loading_buffer_shared_savedata_save();
}

function savedata_save(arg0)
{
    savedata_game_state_to_struct();
    loading_buffer_savedata_save(arg0);
}

function savedata_load(arg0)
{
    loading_buffer_savedata_load(arg0);
}

function savedata_delete(arg0)
{
    global.savedata_preview[arg0].empty = true;
    loading_buffer_savedata_save(arg0, true);
}

function save_inc_show(arg0)
{
    if (!instance_exists(obj_save_indicator_n_commiter))
        instance_create_depth(0, 0, 0, obj_save_indicator_n_commiter);
    
    obj_save_indicator_n_commiter.watched_loading = arg0;
}

function save_inc_show_dud()
{
    if (!instance_exists(obj_save_indicator_n_commiter))
    {
        instance_create_depth(0, 0, 0, obj_save_indicator_n_commiter);
        obj_save_indicator_n_commiter.dud = true;
    }
}

function prep_legacy_savefiles()
{
    var files_to_unpack = [];
    var new_files = [];
    array_push(files_to_unpack, shared_savedata_get_legacy_filename());
    array_push(new_files, shared_savedata_get_filename());
    
    for (i = 0; i < 8; i++)
    {
        array_push(files_to_unpack, savedata_get_legacy_filename(i));
        array_push(new_files, savedata_get_filename(i));
    }
    
    var i = 0;
    var n = array_length(files_to_unpack);
    
    while (i < n)
    {
        if (file_exists(files_to_unpack[i]) && !file_exists(new_files[i]))
            file_copy(files_to_unpack[i], new_files[i]);
        
        i++;
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4
}
