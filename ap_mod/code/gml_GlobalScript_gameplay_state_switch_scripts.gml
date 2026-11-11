function gstate_activate_overworld_warp(arg0)
{
    if (global.gstate != UnknownEnum.Value_2)
    {
        var o = instance_create_lay(0, 0, 2, obj_seq_overworld_warp);
        o.target_level = arg0;
        global.gstate = UnknownEnum.Value_2;
    }
}

function gstate_activate_bonus_run()
{
    if (!global.objective_fulfilled)
    {
        global.objective_fulfilled = true;
        item_lose_contextual();
        game_player_power_enter_bonus_phase();
        instance_create_lay(0, 0, 2, obj_seq_bonus_run_start);
        var cx = 0;
        var cy = 0;
        
        with (obj_player)
        {
            cx = input.get_xaxis();
            cy = input.get_yaxis();
        }
        
        cd = point_distance(0, 0, cx, cy);
        
        if (cd > 0.45)
            instance_create_lay(0, 0, 4, obj_player_snap_to_grid);
        
        with (obj_player)
            floor_scoring_flood_paint(gx, gy, flood_paint_bonus, 1024, 2);
    }
}

function gstate_activate_stage_clear(arg0 = false)
{
    if (global.gstate != UnknownEnum.Value_6)
    {
        with (obj_falling_star_trigger)
            instance_destroy();
        
        with (obj_falling_star)
            instance_destroy();
        
        global.objective_fulfilled = true;
        
        if (global.player_stage_chain == 0)
            global.just_perfected_chain = true;
        else
            global.just_perfected_chain = false;
        
        global.compound_stat_stages++;
        global.compound_stat_end_percent_sum += (global.player_power / global.__player_power_max);
        game_player_stage_chain_register();
        global.compound_stat_best_chain += (global.player_stage_chain / global.floors_total);
        var cx = 0;
        var cy = 0;
        
        with (obj_player)
        {
            cx = input.get_xaxis();
            cy = input.get_yaxis();
        }
        
        cd = point_distance(0, 0, cx, cy);
        
        if (cd > 0.45)
            instance_create_lay(0, 0, 4, obj_player_snap_to_grid);
        
        global.gstate = UnknownEnum.Value_6;
        
        if (game_is_in_final_level())
        {
            instance_create_lay(0, 0, 2, obj_seq_stage_clear_finale);
        }
        else
        {
            var o = instance_create_lay(0, 0, 2, obj_seq_stage_clear);
            o.speedy_clear = arg0;
        }
    }
}

function gstate_activate_player_ko(arg0)
{
    if (global.objective_fulfilled)
    {
        if (!global.bonus_run_cut_short)
        {
            game_player_stage_chain_register();
            global.bonus_run_cut_short = true;
        }
    }
    else if (global.gstate != UnknownEnum.Value_5)
    {
        global.gstate = UnknownEnum.Value_5;
        var o = instance_create_lay(0, 0, 2, obj_seq_player_ko);
        o.damage_type = arg0;
        o.post_create();
        // Send deathlink
        if (AP_is_multiworld_active(false)) {
            obj_archipelago_client.AP_sendDeathlink(global.AP_name + " was KOed");
            // Reset finale save if we game over
            if (global.player_lives <= 0 && game_is_in_final_level()) {
                obj_archipelago_client.AP_reset_finale_save(true);
            }
        }
    }
}

function gstate_has_player_been_kod()
{
    if (global.gstate == UnknownEnum.Value_5)
        return true;
    
    return false;
}

enum UnknownEnum
{
    Value_2 = 2,
    Value_5 = 5,
    Value_6
}
