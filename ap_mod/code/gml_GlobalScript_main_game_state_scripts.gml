global.game_frame = 0;
global.accessed_levels = ds_map_create();
global.cleared_levels = ds_map_create();
global.saved_rank = ds_map_create();
global.stage_clear_count = ds_map_create();
global.stage_clear_count_for_money = ds_map_create();
global.read_hints = ds_map_create();
global.last_stage_clear_count = -1;
global.equip_items = ds_map_create();
global.overworld_clear_events = ds_map_create();
global.__player_power_max = 50;
global.__player_power_speed_1 = 10;
global.__player_power_bonus = 25;
global.__player_power_speed_2 = 40;

function game_state_init()
{
    global.gmode = UnknownEnum.Value_1;
    ds_map_clear(global.accessed_levels);
    ds_map_clear(global.cleared_levels);
    ds_map_clear(global.saved_rank);
    ds_map_clear(global.stage_clear_count);
    ds_map_clear(global.stage_clear_count_for_money);
    ds_map_clear(global.read_hints);
    ds_map_clear(global.overworld_clear_events);
    global.game_time = 0;
    global.stage_time = 0;
    global.stage_time_frames = 0;
    global.shop_visits = 0;
    global.shop_purchases = 0;
    global.shop_codes = [];
    global.shop_just_bought_equip_item = false;
    global.babby_hints = [];
    global.overworld_position = 0;
    global.overworld_cleared = 0;
    global.overworld_just_cleared = 0;
    global.player_score = 0;
    global.player_character = UnknownEnum.Value_0;
    global.player_lives_default = 3;
    global.player_lives_max = 7;
    global.player_lives = global.player_lives_default;
    global.player_total_kos = 0;
    global.player_total_game_overs = 0;
    global.player_stage_kos = 0;
    global.player_any_fruit = false;
    global.player_fruits = 0;
    global.player_power_enabled = true;
    global.player_power_lethal_countdown = false;
    global.player_power = 0;
    global.player_power_at_clear = 0;
    global.player_power_up_momentum = 0;
    global.player_power_down_momentum = 0;
    global.player_power_keep_down_momentum = 0;
    global.player_power_forbid_gravity = 2;
    global.player_power_slow_gravity = 2;
    global.player_speed = 0;
    global.player_speed_countdown = -1;
    global.player_chain = 0;
    global.player_stage_chain = 0;
    global.player_chain_multiplier = 1;
    global.player_item = UnknownEnum.Value_0;
    global.player_item_quantity = 0;
    global.player_shield = false;
    global.ignore_next_hint = false;
    global.just_cleared_level = false;
    global.just_cleared_level_complete = false;
    global.just_cleared_level_perfect = 0;
    global.just_perfected_chain = false;
    global.level_clear_requirement = 12;
    global.stage_difficulty = UnknownEnum.Value_0;
    global.nanny_var = 0;
    global.compound_stat_fruit = 0;
    global.compound_stat_kos = 0;
    global.compound_stat_end_percent_sum = 0;
    global.compound_stat_best_chain = 0;
    global.compound_stat_stages = 0;
    global.count_kos = 0;
    global.count_fruits = 0;
    global.count_defeated_enemies = 0;
    global.splayer_item = array_create(4, UnknownEnum.Value_0);
    global.splayer_item_quantity = array_create(4, 0);
    global.splayer_shield = array_create(4, false);
    global.splayer_power_shield = array_create(4, false);
    global.splayer_equip_item = array_create(4, UnknownEnum.Value_0);
    global.splayer_equip_item_quantity = array_create(4, 0);
    global.splayer_equip_shield = array_create(4, false);
    global.splayer_equip_good_shoes = array_create(4, 0);
    global.splayer_clothes_hat = array_create(4, "");
    global.splayer_clothes_eyes = array_create(4, "");
    global.splayer_clothes_fur = array_create(4, "");
    global.camera_tilt_lock = false;
    global.current_stage = "1-1";
    global.rank_cap = "P";
    global.score_enabled = false;
    global.endless_loop = 1;
    global.endless_level = 1;
    global.endless_stage = 1;
    global.gauntlet_level = 0;
    global.gauntlet_path = [];
    global.gauntlet_rank = [];
    global.gauntlet_stage_score = [];
    global.score_enabled = false;
    global.gstate = UnknownEnum.Value_3;
}

function game_is_current_stage_valid()
{
    var p1 = game_get_current_stage();
    var p2 = game_get_current_substage();
    
    if (!is_string(p1) && !is_string(p2))
        return true;
    
    return false;
}

function game_get_current_stage()
{
    var a = stage_get_level_code(global.current_stage);
    return a[0];
}

function game_get_current_substage()
{
    var a = stage_get_level_code(global.current_stage);
    return a[1];
}

function game_is_in_final_level()
{
    if ((global.gmode == UnknownEnum.Value_3 || global.gmode == UnknownEnum.Value_4 || global.gmode == UnknownEnum.Value_1 || global.gmode == UnknownEnum.Value_2) && level_get_current() == 10)
        return true;
    
    return false;
}

function game_is_in_final_stage()
{
    // ARCHIPELAGO: Change to not force s_love as final stage
    if (game_is_in_final_level() && global.current_stage == global.stage_order[9][6])
        return true;
    
    return false;
}

function game_reset_state_before_debug_room()
{
    global.player_stage_kos = 0;
    game_player_fruit_reset(true);
    game_player_power_reset();
    game_player_speed_reset();
    game_player_chain_reset();
    game_player_chain_multiplier_reset();
    game_player_stage_chain_reset();
    item_lose();
}

function game_setup_next_level(arg0)
{
    global.current_stage = global.stage_order[clamp(round(arg0 - 1), 0, 10)][0];
}

function game_setup_stage_generic(arg0 = false)
{
    global.player_stage_kos = 0;
    global.rank_cap = "P";
    game_player_fruit_reset(true);
    game_player_power_reset();
    game_player_speed_reset();
    game_player_chain_reset();
    game_player_chain_multiplier_reset();
    game_player_stage_chain_reset();
    
    if (!arg0)
        game_player_lives_punish_during_excess();
    
    item_lose();
    global.compound_stat_fruit = 0;
    global.compound_stat_kos = 0;
    global.compound_stat_end_percent_sum = 0;
    global.compound_stat_best_chain = 0;
    global.compound_stat_stages = 0;
}

function game_setup_stage_retry()
{
    game_setup_stage_generic();
    
    if (game_is_in_final_level())
        global.current_stage = global.stage_order[9][0];
    else
        global.just_restarted = true;
    
    if (global.gstate == UnknownEnum.Value_4)
        global.ignore_next_hint = true;
}

function game_mark_stage_as_cleared(arg0, arg1)
{
    if (global.gmode == UnknownEnum.Value_6)
        gauntlet_ingame_add_stage(arg1);
    
    if (arg0 == "finale")
    {
        level = 10;
        old_rank = ds_map_find_value(global.saved_rank, arg0);
        ds_map_set(global.saved_rank, arg0, rank_get_stronger(arg1, ds_map_find_value(global.saved_rank, arg0)));
        global.just_cleared_level = false;
        
        if (is_undefined(old_rank) && is_undefined(ds_map_find_value(global.cleared_levels, level)))
        {
            global.just_cleared_level = true;
            ds_map_set(global.cleared_levels, level, true);
        }
        
        shared_savedata_register_rank("finale", arg1);
        exit;
    }
    
    var level = level_get_from_stage(arg0);
    var was_complete = level_is_complete(level);
    var was_superb = level_is_superb(level);
    var was_perfect = level_is_perfect(level);
    var beaten = false;
    var old_rank = ds_map_find_value(global.saved_rank, arg0);
    ds_map_set(global.saved_rank, arg0, rank_get_stronger(arg1, ds_map_find_value(global.saved_rank, arg0)));
    
    // ARCHIPELAGO: send stage locations
    if (AP_is_multiworld_active(false)) {
        var stage = game_get_current_substage();
        var rank = ds_map_find_value(global.saved_rank, arg0);
        AP_sendStageLocation(level, stage, rank);
    }
    
    if (is_undefined(old_rank) || old_rank != arg1)
        beaten = true;
    
    if (global.gmode == UnknownEnum.Value_3 || global.gmode == UnknownEnum.Value_4 || global.gmode == UnknownEnum.Value_1 || global.gmode == UnknownEnum.Value_2)
    {
        var r = shared_savedata_register_rank(arg0, arg1);
        ach_new_check_and_exec_stage_achievements();
    }
    
    if (level_is_cleared(level))
    {
        if (is_undefined(old_rank) && is_undefined(ds_map_find_value(global.cleared_levels, level)))
            global.just_cleared_level = true;
        
        if (is_undefined(ds_map_find_value(global.cleared_levels, level)))
        {
            ds_map_set(global.cleared_levels, level, true);
            
            if (level < 10)
            {
                global.overworld_position = level;
                // ARCHIPELAGO: don't set overworld cleared
                if (!AP_is_multiworld_active(false)) {
                    global.overworld_cleared = max(level, global.overworld_cleared);
                    global.overworld_just_cleared = 1;
                }
            }
        }
        
        // ARCHIPELAGO: Send level clear check
        if (AP_is_multiworld_active(false)) {
            AP_sendLocation(90000 + level - 1);
        }
        
        if (!was_complete && level_is_complete(level))
        {
            global.just_cleared_level = true;
            global.just_cleared_level_complete = true;
        }
        
        if (!was_superb && level_is_superb(level))
        {
            global.just_cleared_level = true;
            
            if (story_progression_has_superb_everything() && !instance_exists(obj_perfect_superb_completion_check))
                instance_create_depth(0, 0, 0, obj_perfect_superb_completion_check);
            
            global.just_cleared_level_perfect = 0.5;
        }
        
        if (!was_perfect && level_is_perfect(level))
        {
            global.just_cleared_level = true;
            
            if (story_progression_has_perfect_everything() && !instance_exists(obj_perfect_superb_completion_check))
                instance_create_depth(0, 0, 0, obj_perfect_superb_completion_check);
            
            global.just_cleared_level_perfect = 1;
        }
    }
    
    if (is_undefined(ds_map_find_value(global.stage_clear_count, arg0)))
    {
        ds_map_set(global.stage_clear_count, arg0, 1);
        ds_map_set(global.stage_clear_count_for_money, arg0, 1);
        global.last_stage_clear_count = 1;
    }
    else
    {
        ds_map_set(global.stage_clear_count, arg0, ds_map_find_value(global.stage_clear_count, arg0) + 1);
        
        if (beaten)
            ds_map_set(global.stage_clear_count_for_money, arg0, 1);
        else
            ds_map_set(global.stage_clear_count_for_money, arg0, ds_map_find_value(global.stage_clear_count_for_money, arg0) + 1);
        
        global.last_stage_clear_count = ds_map_find_value(global.stage_clear_count_for_money, arg0);
    }
}

function game_go_to_next_stage(arg0 = -1)
{
    cement_fun = function()
    {
        global.player_stage_kos = 0;
        global.just_perfected_chain = false;
        game_player_fruit_reset(true);
        game_player_power_reset();
        game_player_speed_reset();
        game_player_chain_reset();
        game_player_chain_multiplier_reset();
        game_player_stage_chain_reset();
        
        if (!game_is_in_final_level())
        {
            global.rank_cap = "P";
            game_player_lives_safety_net();
        }
        
        item_lose();
    };
    
    if (room == rm_maingame || is_string(arg0))
    {
        var just_finished_the_game = false;
        var last_stage = global.current_stage;
        
        if (game_is_in_final_stage())
            just_finished_the_game = true;
        
        if (is_real(arg0))
        {
            if (global.demo_version != "")
            {
                var n = array_length(global.demo_stage_order);
                var j = 0;
                
                for (var i = 0; i < n; i++)
                {
                    if (global.demo_stage_order[i] == global.current_stage)
                    {
                        j = i;
                        break;
                    }
                }
                
                if (j >= (n - 1))
                {
                    room_goto_transition_fade(rm_demo_end);
                    exit;
                }
                else
                {
                    global.current_stage = global.demo_stage_order[j + 1];
                }
            }
            else
            {
                var next = false;
                var chosen = false;
                var n1 = array_length(global.stage_order);
                
                for (var i = 0; i < n1; i++)
                {
                    var n2 = array_length(global.stage_order[i]);
                    
                    for (var j = 0; j < n2; j++)
                    {
                        if (next)
                        {
                            global.current_stage = global.stage_order[i][j];
                            chosen = true;
                            break;
                        }
                        
                        if (global.stage_order[i][j] == global.current_stage)
                            next = true;
                    }
                    
                    if (chosen)
                        break;
                }
            }
        }
        else
        {
            global.current_stage = arg0;
        }
        
        if (just_finished_the_game)
        {
            global.current_stage = last_stage;
            room_goto_transition_white_fade(rm_finale_clear, cement_fun);
        }
        else if (game_is_in_final_level())
        {
            room_goto_transition_white_fade(rm_maingame, cement_fun);
        }
        else if (global.gmode == UnknownEnum.Value_3 || global.gmode == UnknownEnum.Value_4 || global.gmode == UnknownEnum.Value_1 || global.gmode == UnknownEnum.Value_2)
        {
            room_goto_transition_quare_level(rm_maingame, cement_fun);
        }
        else
        {
            room_goto_transition_quare(rm_maingame, cement_fun);
        }
    }
    else if (room == rm_test)
    {
        room_goto_transition_quare(rm_testcube, cement_fun);
    }
    else
    {
        room_goto_transition_quare(rm_test, cement_fun);
    }
}

function game_overworld_clear_event_mark(arg0)
{
    ds_map_set(global.overworld_clear_events, arg0, true);
}

function game_overworld_clear_event_check(arg0)
{
    return ds_map_exists(global.overworld_clear_events, arg0);
}

function game_player_lives_increase()
{
    if (global.player_lives < global.player_lives_max)
    {
        global.player_lives = min(global.player_lives + 1, global.player_lives_max);
        return true;
    }
    
    return false;
}

function game_player_lives_reset()
{
    global.player_lives = global.player_lives_default;
}

function game_player_lives_punish_during_excess()
{
    if (global.player_lives > global.player_lives_default)
        global.player_lives--;
    else
        global.player_lives = global.player_lives_default;
}

function game_player_lives_safety_net()
{
    global.player_lives = max(global.player_lives, global.player_lives_default);
}

function game_player_fruit_increase()
{
    global.player_fruits = min(global.player_fruits + 1, 2);
    global.player_any_fruit = true;
    global.compound_stat_fruit++;
}

function game_player_fruit_reset(arg0)
{
    global.player_fruits = 0;
    
    if (!is_undefined(arg0) && arg0)
        global.player_any_fruit = false;
}

function game_player_stage_chain_register()
{
    global.player_stage_chain = max(global.player_stage_chain, global.player_chain);
}

function game_player_stage_chain_reset()
{
    global.player_stage_chain = 0;
}

function game_player_chain_reset()
{
    global.player_chain = 0;
    
    with (obj_player)
    {
        trail_last_danger_gx = -1;
        trail_last_danger_gy = -1;
    }
}

function game_player_chain_increase()
{
    global.player_chain++;
    
    if (global.player_stage_chain < global.player_chain && global.player_chain == player_chain_get_rank_limit() && global.player_power_enabled && !(global.gmode == UnknownEnum.Value_5))
    {
        audi_play_simple(snd_full_chain);
        var hx = (global.window_x1 > 0) ? global.window_x1 : max(-192, global.window_x1 * 0.75);
        instance_create_lay(hx + 52, 488, 3, obj_hud_power_change_maxchain);
    }
}

function game_player_chain_multiplier_reset()
{
    global.player_chain_multiplier = 1;
}

function game_player_chain_multiplier_increase()
{
    global.player_chain_multiplier = min(2, global.player_chain_multiplier + 0.2);
}

function game_player_power_enter_bonus_phase()
{
    global.player_power_down_momentum = 0;
    global.player_power_keep_down_momentum = 0;
}

function game_player_power_increase(arg0 = 1, arg1 = 42)
{
    if (!global.player_power_enabled)
        exit;
    
    if (global.player_power_down_momentum > 0)
    {
        if (true && !global.objective_fulfilled)
        {
            global.player_power_down_momentum = max(min(150, global.player_power_down_momentum - ((global.player_power_keep_down_momentum > 0) ? 10 : 120)), 0);
        }
        else
        {
            global.player_power_up_momentum = 0;
            global.player_power_down_momentum = max(min(12, global.player_power_down_momentum - 2), 0);
        }
        
        global.player_power_keep_down_momentum = max(global.player_power_keep_down_momentum - 1, 0);
    }
    else
    {
        global.player_power_keep_down_momentum = 0;
    }
    
    var m = 1;
    
    if (global.objective_fulfilled)
    {
        if (global.player_power < global.__player_power_speed_1)
            m = 1;
        else if (global.player_power < global.__player_power_bonus)
            m = min(1, global.player_power_up_momentum * 0.125);
        else if (global.player_power < global.__player_power_speed_2)
            m = min(1, global.player_power_up_momentum * 0.1);
        else
            m = min(1, global.player_power_up_momentum * 0.05);
    }
    else if (global.player_power < global.__player_power_speed_1)
    {
        m = 1;
    }
    else if (global.player_power < global.__player_power_speed_2)
    {
        m = min(1, global.player_power_up_momentum * 0.125);
    }
    else
    {
        m = min(1, global.player_power_up_momentum * 0.0625);
    }
    
    if (global.objective_fulfilled && global.player_power_up_momentum < 4)
        m *= 0.5;
    
    if (global.player_character == UnknownEnum.Value_1)
        arg0 *= ((global.player_power < global.__player_power_speed_1) ? 0.9 : 0.8);
    
    if (global.gmode == UnknownEnum.Value_0)
        arg0 *= 2.5;
    
    global.player_power = min(global.__player_power_max, global.player_power + (m * arg0));
    global.player_power_up_momentum++;
    global.player_power_slow_gravity = max(global.player_power_slow_gravity, arg1);
    
    with (obj_hud)
        fun_power_up_light();
}

function game_player_power_increase_powerup()
{
    if (!global.player_power_enabled)
        exit;
    
    if (true && !global.objective_fulfilled)
    {
        global.player_power_down_momentum = 0;
        var mul = 1;
        
        switch (global.player_character)
        {
            case UnknownEnum.Value_1:
                mul = 0.6;
                break;
            
            case UnknownEnum.Value_4:
                mul = (global.player_power >= global.__player_power_speed_2) ? 0.9 : 1.2;
                break;
        }
        
        global.player_power = min(global.__player_power_max, global.player_power + (8 * mul));
        
        with (obj_hud)
            fun_power_up_strong();
    }
}

function game_player_power_increase_sweep()
{
    if (!global.player_power_enabled)
        exit;
    
    if (true && !global.objective_fulfilled)
    {
        global.player_power_down_momentum = 0;
        var mul = 1;
        
        switch (global.player_character)
        {
            case UnknownEnum.Value_1:
                mul = 0.6;
                break;
            
            case UnknownEnum.Value_4:
                mul = (global.player_power >= global.__player_power_speed_2) ? 0.9 : 1;
                break;
        }
        
        global.player_power = min(global.__player_power_max, global.player_power + (4 * mul));
        
        with (obj_hud)
            fun_power_up_strong();
    }
}

function game_player_power_increase_enemy()
{
    if (!global.player_power_enabled)
        exit;
    
    if (true && !global.objective_fulfilled)
    {
        global.player_power_down_momentum = 0;
        var mul = 1;
        
        switch (global.player_character)
        {
            case UnknownEnum.Value_1:
                mul = 0.8;
                break;
            
            case UnknownEnum.Value_4:
                mul = (global.player_power >= global.__player_power_speed_2) ? 0.9 : 1;
                break;
        }
        
        global.player_power = min(global.__player_power_max, global.player_power + (4 * mul));
        
        with (obj_hud)
            fun_power_up_strong();
    }
}

function game_player_power_decrease(arg0 = UnknownEnum.Value_0, arg1 = 1)
{
    if (!global.player_power_enabled)
        exit;
    
    if (true && !global.objective_fulfilled && arg0 != UnknownEnum.Value_2 && arg0 != UnknownEnum.Value_4)
    {
        global.player_power_up_momentum = 0;
        exit;
    }
    
    if (global.player_power_up_momentum > 0)
    {
        global.player_power_up_momentum = 0;
        global.player_power_down_momentum = 0;
    }
    
    var m = lerp(0.5, 2.5, global.player_power / global.__player_power_max);
    
    if (global.objective_fulfilled)
        m *= (lerp(2, 6, min(1, global.player_power_down_momentum / 4)) * 1.75);
    else
        m *= lerp(1, 4, min(1, global.player_power_down_momentum / 6));
    
    if (arg0 == UnknownEnum.Value_1)
    {
        if (global.player_power_down_momentum < 1)
            m *= 0.75;
    }
    
    if (arg0 == UnknownEnum.Value_4)
    {
        m = 1;
        global.player_power_down_momentum = max(global.player_power_down_momentum, 60);
        global.player_power_keep_down_momentum = 1;
    }
    
    if (global.player_character == UnknownEnum.Value_1)
        arg1 *= 1.2;
    
    m *= arg1;
    
    if (global.player_power > global.__player_power_speed_1 && (global.player_power - m) < global.__player_power_speed_1)
    {
        if (global.player_power_down_momentum >= 2)
            global.player_power -= m;
        else
            global.player_power = global.__player_power_speed_1;
    }
    else if (global.player_power > global.__player_power_speed_2 && (global.player_power - m) < global.__player_power_speed_2)
    {
        if (global.player_power_down_momentum >= 2)
            global.player_power -= m;
        else
            global.player_power = global.__player_power_speed_2;
    }
    else
    {
        global.player_power -= m;
    }
    
    global.player_power = max(global.player_power, 0);
    global.player_power_down_momentum++;
}

function game_player_power_stop_downward_momentum()
{
    global.player_power_down_momentum = 0;
}

function game_player_power_reset()
{
    global.player_power = 0;
    global.player_power_up_momentum = 0;
    global.player_power_down_momentum = 0;
    global.player_power_keep_down_momentum = 0;
    global.player_power_forbid_gravity = 2;
    global.player_power_slow_gravity = 2;
    
    for (var i = 0; i < 4; i++)
        global.splayer_power_shield[i] = false;
}

function game_player_speed_update()
{
    if (true && !global.objective_fulfilled)
    {
        if (global.player_power_forbid_gravity > 0)
        {
            global.player_power_forbid_gravity = max(global.player_power_forbid_gravity - global.fdelta, 0);
        }
        else
        {
            global.player_power_down_momentum += global.fdelta;
            var start = lerp(20, 10, global.player_power / global.__player_power_max);
            
            if (global.player_power_down_momentum >= start)
            {
                var grav = lerp(0.1, 0.3, global.player_power / global.__player_power_max);
                var max_time = lerp(320, 180, global.player_power / global.__player_power_max);
                var gravity_mul = 1;
                
                if (global.player_character == UnknownEnum.Value_1)
                    gravity_mul = 1.2;
                
                if (global.player_power_slow_gravity > 0)
                    gravity_mul *= 0.25;
                
                if (global.player_power_lethal_countdown && global.player_power < global.__player_power_speed_1)
                    gravity_mul *= 0.5;
                
                if (global.stage_difficulty == UnknownEnum.Value_0)
                    gravity_mul *= 0.5;
                
                gravity_mul /= (1 + (global.player_fruits * 0.5));
                global.player_power = max(0, global.player_power - (gravity_mul * lerp(0, grav, min(1, (global.player_power_down_momentum - start) / max_time))));
                
                if (global.player_power <= 0)
                {
                    global.player_power_down_momentum = 0;
                    global.player_power_keep_down_momentum = 0;
                }
            }
        }
        
        if (global.stage_difficulty == UnknownEnum.Value_0)
            global.player_power_slow_gravity = max(global.player_power_slow_gravity - (0.8 * global.fdelta), 0);
        else
            global.player_power_slow_gravity = max(global.player_power_slow_gravity - global.fdelta, 0);
    }
    
    if (global.player_power_lethal_countdown && global.player_power <= 0 && global.gstate == UnknownEnum.Value_4)
    {
        with (obj_player)
        {
            if (grid_on)
                gstate_activate_player_ko(UnknownEnum.Value_5);
        }
    }
}

function game_player_speed_reset()
{
    global.player_speed = 0;
    global.player_speed_countdown = -1;
    global.splayer_power_shield[0] = false;
    
    with (obj_control)
        power_meter_fastforward();
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6
}
