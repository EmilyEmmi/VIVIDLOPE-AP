if (global.gstate == UnknownEnum.Value_4)
{
    if (false && global.playtest_debugging && gamepad_button_check(0, gp_shoulderrb))
    {
        if (gamepad_button_check(0, gp_shoulderlb))
        {
            forced_rank = "P";
            gstate_activate_stage_clear(true);
        }
        
        if (gamepad_button_check(0, gp_shoulderl))
        {
            forced_rank = "S";
            gstate_activate_stage_clear(true);
        }
        
        if (gamepad_button_check(0, gp_shoulderr))
        {
            forced_rank = "A";
            gstate_activate_stage_clear(true);
        }
    }
    
    if (keyboard_check(vk_f6) && keyboard_check(vk_f10) && room != rm_bgtester)
    {
        if (keyboard_check_pressed(ord("1")))
        {
            forced_rank = "E";
            gstate_activate_stage_clear(true);
        }
        
        if (keyboard_check_pressed(ord("2")))
        {
            forced_rank = "D";
            gstate_activate_stage_clear(true);
        }
        
        if (keyboard_check_pressed(ord("3")))
        {
            forced_rank = "D+";
            gstate_activate_stage_clear(true);
        }
        
        if (keyboard_check_pressed(ord("4")))
        {
            forced_rank = "C";
            gstate_activate_stage_clear(true);
        }
        
        if (keyboard_check_pressed(ord("5")))
        {
            forced_rank = "C+";
            gstate_activate_stage_clear(true);
        }
        
        if (keyboard_check_pressed(ord("6")))
        {
            forced_rank = "B";
            gstate_activate_stage_clear(true);
        }
        
        if (keyboard_check_pressed(ord("7")))
        {
            forced_rank = "B+";
            gstate_activate_stage_clear(true);
        }
        
        if (keyboard_check_pressed(ord("8")))
        {
            forced_rank = "A";
            gstate_activate_stage_clear(true);
        }
        
        if (keyboard_check_pressed(ord("9")))
        {
            forced_rank = "A+";
            gstate_activate_stage_clear(true);
        }
        
        if (keyboard_check_pressed(ord("0")))
        {
            forced_rank = "S";
            gstate_activate_stage_clear(true);
        }
        
        if (keyboard_check_pressed(ord("P")))
        {
            forced_rank = "P";
            gstate_activate_stage_clear(true);
        }
        
        if (keyboard_check_pressed(ord("I")))
        {
            with (obj_player)
                invincible_hidden_frames = max(invincible_hidden_frames, 99999);
        }
    }
    
    if (!global.objective_fulfilled)
    {
        if (global.floors_percent >= global.floors_required_percent)
        {
            global.player_power_at_clear = global.player_power;
            
            // ARCHIPELAGO: Don't do bonus time in Finale
            if (global.floors_required_percent < 100 && level_get_current() != 10)
                gstate_activate_bonus_run();
            else
                gstate_activate_stage_clear();
        }
    }
    else if (global.floors_percent >= 100 || global.bonus_run_cut_short)
    {
        gstate_activate_stage_clear();
    }
    
    global.stage_time_frames++;
}

if ((global.gstate == UnknownEnum.Value_4 || global.gstate == UnknownEnum.Value_1) && !global.stage_object_paused)
{
    global.zone_matrix_request_update = max(1, global.zone_matrix_request_update);
    global.stop_go_offset = (global.stop_go_offset + (1 / global.stop_go_period)) % 2;
}

global.zone_matrix_updated = false;

if (global.zone_matrix_request_update > 0)
{
    for (var i = 1; i < 12; i++)
    {
        if (!global.zone_used[i])
            continue;
        
        array_copy(global.zone_matrix_prev[i], 0, global.zone_matrix[i], 0, 16);
        global.zone_translate_delta[i][0] = -global.zone_matrix[i][12];
        global.zone_translate_delta[i][1] = -global.zone_matrix[i][13];
        global.zone_translate_delta[i][2] = -global.zone_matrix[i][14];
        
        if (ds_map_exists(global.zone_movement_map, global.zone_movement[i].type % 1000))
            script_execute(ds_map_find_value(global.zone_movement_map, global.zone_movement[i].type % 1000), i, floor(global.zone_movement[i].type / 1000) - 1);
        
        global.zone_translate_delta[i][0] += global.zone_matrix[i][12];
        global.zone_translate_delta[i][1] += global.zone_matrix[i][13];
        global.zone_translate_delta[i][2] += global.zone_matrix[i][14];
        array_copy(global.zone_matrix_rot[i], 0, global.zone_matrix[i], 0, 16);
        global.zone_matrix_rot[i][3] = 0;
        global.zone_matrix_rot[i][7] = 0;
        global.zone_matrix_rot[i][11] = 0;
        global.zone_matrix_rot[i][14] = 0;
        global.zone_matrix_rot[i][13] = 0;
        global.zone_matrix_rot[i][12] = 0;
        global.zone_matrix_rot_delta[i] = matrix_multiply(global.zone_matrix_rot[i], global.zone_matrix_rot_inv[i]);
        mat_invert_target(global.zone_matrix_rot_inv[i], global.zone_matrix_rot[i]);
        mat_invert_target(global.zone_matrix_inv[i], global.zone_matrix[i]);
        vividext_zone_matrix_set_iterator(i);
        vividext_zone_matrix_set(global.zone_matrix[i][0], global.zone_matrix[i][1], global.zone_matrix[i][2], global.zone_matrix[i][3], global.zone_matrix[i][4], global.zone_matrix[i][5], global.zone_matrix[i][6], global.zone_matrix[i][7], global.zone_matrix[i][8], global.zone_matrix[i][9], global.zone_matrix[i][10], global.zone_matrix[i][11], global.zone_matrix[i][12], global.zone_matrix[i][13], global.zone_matrix[i][14], global.zone_matrix[i][15]);
        vividext_zone_matrix_set_rot(global.zone_matrix_rot[i][0], global.zone_matrix_rot[i][1], global.zone_matrix_rot[i][2], global.zone_matrix_rot[i][3], global.zone_matrix_rot[i][4], global.zone_matrix_rot[i][5], global.zone_matrix_rot[i][6], global.zone_matrix_rot[i][7], global.zone_matrix_rot[i][8], global.zone_matrix_rot[i][9], global.zone_matrix_rot[i][10], global.zone_matrix_rot[i][11], global.zone_matrix_rot[i][12], global.zone_matrix_rot[i][13], global.zone_matrix_rot[i][14], global.zone_matrix_rot[i][15]);
        vividext_zone_matrix_set_rot_delta(global.zone_matrix_rot_delta[i][0], global.zone_matrix_rot_delta[i][1], global.zone_matrix_rot_delta[i][2], global.zone_matrix_rot_delta[i][3], global.zone_matrix_rot_delta[i][4], global.zone_matrix_rot_delta[i][5], global.zone_matrix_rot_delta[i][6], global.zone_matrix_rot_delta[i][7], global.zone_matrix_rot_delta[i][8], global.zone_matrix_rot_delta[i][9], global.zone_matrix_rot_delta[i][10], global.zone_matrix_rot_delta[i][11], global.zone_matrix_rot_delta[i][12], global.zone_matrix_rot_delta[i][13], global.zone_matrix_rot_delta[i][14], global.zone_matrix_rot_delta[i][15]);
    }
    
    global.zone_matrix_updated = true;
    global.zone_matrix_request_update--;
}
else
{
    for (var i = 1; i < 12; i++)
    {
        if (!global.zone_used[i])
            continue;
        
        array_copy(global.zone_matrix_prev[i], 0, global.zone_matrix[i], 0, 16);
        array_copy(global.zone_matrix_rot[i], 0, global.zone_matrix[i], 0, 16);
        global.zone_matrix_rot[i][3] = 0;
        global.zone_matrix_rot[i][7] = 0;
        global.zone_matrix_rot[i][11] = 0;
        global.zone_matrix_rot[i][14] = 0;
        global.zone_matrix_rot[i][13] = 0;
        global.zone_matrix_rot[i][12] = 0;
        global.zone_matrix_rot_delta[i] = matrix_multiply(global.zone_matrix_rot[i], global.zone_matrix_rot_inv[i]);
        mat_invert_target(global.zone_matrix_rot_inv[i], global.zone_matrix_rot[i]);
        mat_invert_target(global.zone_matrix_inv[i], global.zone_matrix[i]);
        vividext_zone_matrix_set_iterator(i);
        vividext_zone_matrix_set(global.zone_matrix[i][0], global.zone_matrix[i][1], global.zone_matrix[i][2], global.zone_matrix[i][3], global.zone_matrix[i][4], global.zone_matrix[i][5], global.zone_matrix[i][6], global.zone_matrix[i][7], global.zone_matrix[i][8], global.zone_matrix[i][9], global.zone_matrix[i][10], global.zone_matrix[i][11], global.zone_matrix[i][12], global.zone_matrix[i][13], global.zone_matrix[i][14], global.zone_matrix[i][15]);
        vividext_zone_matrix_set_rot(global.zone_matrix_rot[i][0], global.zone_matrix_rot[i][1], global.zone_matrix_rot[i][2], global.zone_matrix_rot[i][3], global.zone_matrix_rot[i][4], global.zone_matrix_rot[i][5], global.zone_matrix_rot[i][6], global.zone_matrix_rot[i][7], global.zone_matrix_rot[i][8], global.zone_matrix_rot[i][9], global.zone_matrix_rot[i][10], global.zone_matrix_rot[i][11], global.zone_matrix_rot[i][12], global.zone_matrix_rot[i][13], global.zone_matrix_rot[i][14], global.zone_matrix_rot[i][15]);
        vividext_zone_matrix_set_rot_delta(global.zone_matrix_rot_delta[i][0], global.zone_matrix_rot_delta[i][1], global.zone_matrix_rot_delta[i][2], global.zone_matrix_rot_delta[i][3], global.zone_matrix_rot_delta[i][4], global.zone_matrix_rot_delta[i][5], global.zone_matrix_rot_delta[i][6], global.zone_matrix_rot_delta[i][7], global.zone_matrix_rot_delta[i][8], global.zone_matrix_rot_delta[i][9], global.zone_matrix_rot_delta[i][10], global.zone_matrix_rot_delta[i][11], global.zone_matrix_rot_delta[i][12], global.zone_matrix_rot_delta[i][13], global.zone_matrix_rot_delta[i][14], global.zone_matrix_rot_delta[i][15]);
    }
}

if (global.gstate != UnknownEnum.Value_5)
    hitbox_sys_clear();
else
    hitbox_sys_prevent_overflow();

enum UnknownEnum
{
    Value_1 = 1,
    Value_4 = 4,
    Value_5
}
