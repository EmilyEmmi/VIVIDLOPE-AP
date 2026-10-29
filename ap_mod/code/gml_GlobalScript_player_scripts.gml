global.player_movement_speed = ds_map_create();
ds_map_set(global.player_movement_speed, UnknownEnum.Value_0, 1);
ds_map_set(global.player_movement_speed, UnknownEnum.Value_1, 2.4);
ds_map_set(global.player_movement_speed, UnknownEnum.Value_2, 2.7);
ds_map_set(global.player_movement_speed, UnknownEnum.Value_3, 3);
ds_map_set(global.player_movement_speed, UnknownEnum.Value_4, 4.8);
ds_map_set(global.player_movement_speed, UnknownEnum.Value_5, 6);
ds_map_set(global.player_movement_speed, UnknownEnum.Value_6, 3);
ds_map_set(global.player_movement_speed, UnknownEnum.Value_7, 2);
ds_map_set(global.player_movement_speed, UnknownEnum.Value_8, 7);
ds_map_set(global.player_movement_speed, UnknownEnum.Value_9, 10);
ds_map_set(global.player_movement_speed, UnknownEnum.Value_10, 1.7777777777777777);

function player_buffer_next_animation(arg0, arg1, arg2)
{
    if (ds_map_exists(global.ani3d_anims, arg0 + "_" + chara_get_constant_name(character)))
        arg0 = arg0 + "_" + chara_get_constant_name(character);
    
    if (ds_map_exists(global.ani3d_anims, arg1 + "_" + chara_get_constant_name(character)))
        arg1 = arg1 + "_" + chara_get_constant_name(character);
    
    ani_autoswitch_target = arg0;
    ani_autoswitch_source = arg1;
    ani_autoswitch_time = arg2;
}

function player_handle_hot_floors(arg0 = true)
{
    if (arg0)
        stage_object_affected_by_conveyors();
    
    if (invincible_frames == 0 && (gx != hotfloor_gx || gy != hotfloor_gy))
    {
        if (!ds_list_empty(mid_gx))
        {
            f = ds_grid_get(global.stage_grid, ds_list_find_value(mid_gx, 0), ds_list_find_value(mid_gy, 0));
            
            if (is_struct(f))
            {
                if (f.type == UnknownEnum.Value_10)
                {
                    player_lose_shield(UnknownEnum.Value_1);
                    hotfloor_gx = gx;
                    hotfloor_gy = gy;
                }
                
                if (f.type == UnknownEnum.Value_15 && (floor(global.stop_go_offset + f.type_param) % 2) == 0)
                {
                    player_lose_shield(UnknownEnum.Value_1);
                    hotfloor_gx = gx;
                    hotfloor_gy = gy;
                }
                
                if (f.type == UnknownEnum.Value_34)
                {
                    stage_object_set_state(player_state_wrapback);
                    hotfloor_gx = gx;
                    hotfloor_gy = gy;
                }
            }
        }
        
        f = ds_grid_get(global.stage_grid, gx, gy);
        
        if (is_struct(f))
        {
            if (f.type == UnknownEnum.Value_10)
            {
                player_lose_shield(UnknownEnum.Value_1);
                hotfloor_gx = gx;
                hotfloor_gy = gy;
            }
            
            if (f.type == UnknownEnum.Value_15 && (floor(global.stop_go_offset + f.type_param) % 2) == 0)
            {
                player_lose_shield(UnknownEnum.Value_1);
                hotfloor_gx = gx;
                hotfloor_gy = gy;
            }
            
            if (f.type == UnknownEnum.Value_34)
            {
                stage_object_set_state(player_state_wrapback);
                hotfloor_gx = gx;
                hotfloor_gy = gy;
            }
        }
    }
    else
    {
        if (!ds_list_empty(mid_gx))
        {
            f = ds_grid_get(global.stage_grid, ds_list_find_value(mid_gx, 0), ds_list_find_value(mid_gy, 0));
            
            if (is_struct(f))
            {
                if (f.type == UnknownEnum.Value_34)
                {
                    stage_object_set_state(player_state_wrapback);
                    hotfloor_gx = gx;
                    hotfloor_gy = gy;
                }
            }
        }
        
        f = ds_grid_get(global.stage_grid, gx, gy);
        
        if (is_struct(f))
        {
            if (f.type == UnknownEnum.Value_34)
            {
                stage_object_set_state(player_state_wrapback);
                hotfloor_gx = gx;
                hotfloor_gy = gy;
            }
        }
    }
    
    var f = ds_grid_get(global.stage_grid, gx, gy);
    
    if (f.type == UnknownEnum.Value_27)
    {
        ani3d_skeleton_play_animation_next(skeleton, "ledge_leap");
        container_play_position("cnt_leap", display_x, display_y, display_z);
        player_activate_freefall_state(-1);
    }
    
    if (f.type != UnknownEnum.Value_11)
        conveyor_ignore_until_frame = max(conveyor_ignore_until_frame, global.game_frame + 5);
}

function player_update_grid_position_and_stand_on_tiles(arg0 = false)
{
    gx = floor(x / 32);
    gy = floor(y / 32);
    
    if (!grid_on || gx < 1)
        exit;
    
    if (gx != pgx || gy != pgy)
    {
        if (!ds_list_empty(mid_gx))
            player_stand_on_tile(ds_list_find_value(mid_gx, 0), ds_list_find_value(mid_gy, 0), true);
        
        player_stand_on_tile(gx, gy, true);
    }
    
    if (global.gstate != UnknownEnum.Value_4 && global.gstate != UnknownEnum.Value_1)
        exit;
    
    var f = ds_grid_get(global.stage_grid, gx, gy);
    
    if (f.type == UnknownEnum.Value_20)
    {
        if (state != player_state_shiftpad)
        {
            var ns = stage_grid_step([gx, gy], f.type_param % 4);
            
            if (ns[0] > 0 && ns[2] >= 0)
            {
                shiftpad_enter_gx = pgx;
                shiftpad_enter_gy = pgy;
                shitpad_enter_lag = 4;
                stage_object_set_state(player_state_shiftpad);
            }
        }
    }
    
    if ((invincible_frames <= 0 || gx != pgx || gy != pgy) && f.type == UnknownEnum.Value_19)
    {
        if (state != player_state_spring)
            stage_object_set_state(player_state_spring);
    }
    
    if (!arg0)
    {
        if (f.type == UnknownEnum.Value_18)
        {
            if (state != player_state_boost)
                boost_jump_lock = global.game_frame;
            
            if (gx != boost_gx || gy != boost_gy)
                player_boost_start(((4 + f.type_param) - base_down_dir) % 4);
        }
        else
        {
            boost_gx = -1;
            boost_gy = -1;
        }
    }
    
    if (f.type == UnknownEnum.Value_28)
    {
        if (state != player_state_spinner)
            stage_object_set_state(player_state_spinner);
    }
}

function player_move(arg0, arg1, arg2 = 1, arg3 = false)
{
    arg2 *= global.fdelta;
    var s = ds_map_find_value(global.player_movement_speed, arg0);
    
    if (is_undefined(s))
        s = 2;
    
    if (global.gcamera_type == UnknownEnum.Value_5)
    {
        if (state != player_state_leap)
        {
            leap_dx = lengthdir_x(s, arg1);
            leap_dy = lengthdir_y(s, arg1);
        }
        
        while (s > 0)
        {
            var del = min(0.5, s);
            s -= del;
            dx = lengthdir_x(1, arg1);
            dy = lengthdir_y(1, arg1);
            var bb = player_spherize_direction(dx, dy);
            dx = bb[0];
            dy = bb[1];
            player_move_dyna(del * dx * arg2, del * dy * arg2);
        }
        
        exit;
    }
    
    var dx = lengthdir_x(s, arg1);
    var dy = lengthdir_y(s, arg1);
    snappymove_hori_left = approach(snappymove_hori_left, 0, abs(dx) * arg2);
    snappymove_vert_left = approach(snappymove_vert_left, 0, abs(dy) * arg2);
    
    if (state != player_state_leap && state != player_state_highleap)
    {
        leap_dx = dx;
        leap_dy = dy;
    }
    
    if (arg3)
        movement_distance_passed += (s * arg2);
    
    player_move_dyna(dx * arg2, dy * arg2);
}

function player_move_dyna(arg0, arg1)
{
    if (state == player_state_main || global.gcamera_type == UnknownEnum.Value_5)
        stage_object_move_doubledir_land(arg0, arg1);
    else
        stage_object_move_doubledir(arg0, arg1);
}

function player_stand_on_tile(arg0, arg1, arg2)
{
    if (is_struct(ds_grid_get(global.stage_grid, arg0, arg1)) && ds_grid_get(global.stage_grid, arg0, arg1).type != UnknownEnum.Value_11)
        conveyor_ignore_until_frame = max(conveyor_ignore_until_frame, global.game_frame + 5);
}

function player_force_leap(arg0)
{
    for (var i = 0; i < 4; i++)
        move_fail[i] = 0;
    
    move_fail[arg0] = 1;
    leap_init_time[arg0] = 1;
    player_try_leap(1);
}

function player_try_leap(arg0)
{
    for (var i = 0; i < 4; i++)
    {
        if (move_fail[i])
        {
            if (leap_init_time[i] < 0)
                leap_init_time[i] = global.game_frame;
            
            if (global.game_frame >= (leap_init_time[i] + arg0))
            {
                if (my_floor.ledge[i] && gx > 0)
                {
                    ani3d_skeleton_play_animation_next(skeleton, "ledge_leap");
                    container_play_position("cnt_leap", display_x, display_y, display_z);
                    stage_object_face_direction_now(-90 + (i * 90), gx, gy);
                    player_activate_freefall_state(i);
                    leap_init_time[i] = -1;
                    exit;
                }
                
                leap_init_time[i] = global.game_frame;
            }
        }
    }
}

function player_activate_freefall_state(arg0)
{
    skeleton.choppy_rot_update_freq = 0;
    slowdown_turn_end();
    save_gx = gx;
    save_gy = gy;
    save_display_x = display_x;
    save_display_y = display_y;
    save_display_z = display_z;
    
    if (arg0 >= 0)
        base_down_dir = 0;
    
    player_clear_buffered_movement();
    somove_activate_freefall_state(arg0, function()
    {
    }, function()
    {
        skeleton.choppy_rot_update_freq = skeleton.def_choppy_rot_update_freq;
        direction_to_player_update_countdown = -64;
        container_play_position("cnt_leap_land", display_x, display_y, display_z);
        stage_object_spawn_3d_billboard_effect(obj_land_effect, display_x, display_y, display_z, mv(global.camera_3d_forward), 20);
        ds_map_find_value(skeleton.bone, "_root").property[UnknownEnum.Value_6].value = 0;
        ds_map_find_value(skeleton.bone, "_root").property[UnknownEnum.Value_6].value1 = 0;
        ds_map_find_value(skeleton.bone, "_root").property[UnknownEnum.Value_6].value2 = 0;
        ani3d_skeleton_play_animation_next(skeleton, "land", 2);
        player_buffer_next_animation("stand", "land", 20);
        grid_on = true;
        trail_danger_lock = max(trail_danger_lock, 1);
        
        if (floor_out_dot_product < 0.05)
            stage_object_set_state(player_state_blocking_land);
        else
            stage_object_set_state(player_state_main);
        
        refresh_movement_vector = 6;
        camera_track_cx = 0;
        camera_track_cy = 0;
        camera_track_cs = 0.045;
        player_match_groundleap_dxdy_to_forward();
        player_clear_buffered_movement();
        x = (floor(x / 32) * 32) + 16;
        y = (floor(y / 32) * 32) + 16;
        var tx = floor(x / 32);
        var ty = floor(y / 32);
        var force_ko = false;
        
        if (tx > 0 || ty > 0)
        {
            if (invincible_frames <= 0)
            {
                with (obj_beatdancers)
                {
                    if (hurt[tx][ty] > 0)
                    {
                        if ((frame == 0 && hurt[tx][ty] == 1) || (frame == 4 && hurt[tx][ty] == 2))
                            force_ko = true;
                    }
                }
                
                with (obj_beartraps)
                {
                    if (hurt[tx][ty] > 0)
                        force_ko = true;
                }
            }
        }
        
        if (force_ko)
        {
            player_lose_shield(UnknownEnum.Value_1);
            hotfloor_gx = gx;
            hotfloor_gy = gy;
            exit;
        }
        
        invincible_frames = max(invincible_frames, 30);
        player_call_enemies_to_cast_rays();
    }, function()
    {
        skeleton.choppy_rot_update_freq = skeleton.def_choppy_rot_update_freq;
        var h = 12;
        
        repeat (14)
        {
            var rrr = 24;
            var res = stage_pushout_of_stage(display_x + (out_vector[0] * h), display_y + (out_vector[1] * h), display_z + (out_vector[2] * h), rrr);
            
            if (res[3])
            {
                rrr = 2;
                cling_x += (res[0] * rrr);
                cling_y += (res[1] * rrr);
                cling_z += (res[2] * rrr);
                target_x += (res[0] * rrr);
                target_y += (res[1] * rrr);
                target_z += (res[2] * rrr);
                display_x += (res[0] * rrr);
                display_y += (res[1] * rrr);
                display_z += (res[2] * rrr);
            }
            else
            {
                break;
            }
        }
        
        if (global._somove_state_freefall_fell_off)
            gstate_activate_player_ko(UnknownEnum.Value_2);
        else
            gstate_activate_player_ko(UnknownEnum.Value_3);
        
        stage_object_set_state(player_state_camera_pose);
    });
}

function player_start_jump(arg0, arg1, arg2 = false, arg3 = false)
{
    jump_secondary_input = false;
    
    // ARCHIPELAGO: check for dash for noir
    if (noir_trail && input.held(6) && !arg2 && !arg3 && arg1 == 5 && AP_has_noir_attack(3))
    {
        jump_buffer_start = -30;
        noir_dash_start();
        exit;
    }
    
    if (my_floor.type == UnknownEnum.Value_24)
    {
        stage_object_set_state(player_state_sticky_leap);
        exit;
    }
    
    if (!arg0)
        ani3d_skeleton_play_animation_next(skeleton, "jumpsquat");
    
    jump_key = arg1;
    
    if (!input.pressed(arg1))
    {
        x = approach(x, (floor(x / 32) * 32) + 16, 3);
        y = approach(y, (floor(y / 32) * 32) + 16, 3);
    }
    
    impact_jump = arg2;
    superjump = arg3;
    slowdown_critical_danger_end();
    
    if (arg3)
    {
        player_match_groundleap_dxdy_to_forward();
        stage_object_set_state(player_state_leap_start);
    }
    else if (global.goption_jump_style || global.gmode == UnknownEnum.Value_0)
    {
        stage_object_set_state(player_state_highleap);
    }
    else
    {
        stage_object_set_state(player_state_leap_start);
    }
    
    if (trail_danger)
    {
        trail_danger = false;
        trail_danger_lock = 0;
        player_fx_sweat();
        slowdown_post_danger(6);
        
        if (x != trail_last_safe_x)
            x = lerp(trail_last_safe_x, (floor(trail_last_safe_x / 32) * 32) + 16, 0.2);
        
        if (y != trail_last_safe_y)
            y = lerp(trail_last_safe_y, (floor(trail_last_safe_y / 32) * 32) + 16, 0.2);
    }
}

function player_state_main()
{
    can_use_items = true;
    grid_ground_mode = true;
    
    if (abs(z) > 0.01)
        z *= 0.5;
    else
        z = 0;
    
    player_handle_hot_floors(false);
    
    if (state != player_state_main)
        exit;
    
    if (timer == 0)
    {
        out_vector_mul = 0.16;
        player_clear_snappy_movement();
        
        if (my_floor.type == UnknownEnum.Value_20 || my_floor.type == UnknownEnum.Value_19 || my_floor.type == UnknownEnum.Value_18 || my_floor.type == UnknownEnum.Value_28)
        {
            player_update_grid_position_and_stand_on_tiles();
            exit;
        }
    }
    
    if (global.gstate == UnknownEnum.Value_4 || global.gstate == UnknownEnum.Value_1)
    {
        var no_anim = false;
        
        if (skeleton.animation_curr_id == anim_id_item_use || skeleton.animation_curr_id == anim_id_kick || skeleton.animation_curr_id == anim_id_throw || skeleton.animation_curr_id == anim_id_throw2 || ani_switch_lock > 0)
            no_anim = true;
        
        if (!no_anim)
        {
            if (skeleton.animation_curr_id != anim_id_land)
                ani3d_skeleton_play_animation_next(skeleton, (character == UnknownEnum.Value_4) ? "stand_missnoir" : "stand");
        }
        
        if ((timer > 1 || my_floor.type != UnknownEnum.Value_18) && global.game_frame <= (jump_buffer_start + jump_buffer_margin))
        {
            player_start_jump(no_anim, 5);
            exit;
        }
        
        var cx = 0;
        var cy = 0;
        var dx = 0;
        var dy = 0;
        var s = 3;
        var analog = 0;
        cx = input.get_xaxis();
        cy = input.get_yaxis();
        var cd = point_direction(0, 0, cx, cy) % 90;
        
        if (abs(cx) <= 1 && abs(cy) <= 1)
            analog = 1;
        
        global.goption_8way = (input.held(6) || !analog || (cd > 32 && cd < 58)) ? true : false;
        cd = point_distance(0, 0, cx, cy);
        
        if (global.goption_8way || my_floor.type == UnknownEnum.Value_14)
        {
            var ddi = round(point_direction(0, 0, cx, cy) / 45) * 45;
            cx = lengthdir_x(cd, ddi);
            cy = lengthdir_y(cd, ddi);
        }
        else
        {
            var ddi = round(point_direction(0, 0, cx + (global.dir_to_dx[priority_dir] * 0.1), cy + (global.dir_to_dy[priority_dir] * 0.1)) / 90) * 90;
            cx = lengthdir_x(cd, ddi);
            cy = lengthdir_y(cd, ddi);
        }
        
        player_update_movement_track(cx, cy);
        var raw_cx = cx;
        var raw_cy = cy;
        
        if (my_floor.type == UnknownEnum.Value_14)
        {
            buffered_turn_countdown = 0;
            player_clear_buffered_movement();
            player_reset_movement_track();
            movement_distance_passed = 0;
            movement_revving_up = 1;
            snappymove_hori_left = 0;
            snappymove_vert_left = 0;
            snappymove_hori_pressed = false;
            snappymove_vert_pressed = false;
            
            if (cd > 0.35)
            {
                cd = clamp((cd - 0.35) / 0.20000000000000007, 0, 1);
                
                if (input.held(6))
                    var speed_scalar = lerp(0.25, 1, cd * 0.5);
                else
                    var speed_scalar = lerp(0.25, 1, cd);
                
                ground_dx += (cx * 0.1);
                ground_dy += (cy * 0.1);
            }
            
            var dd = point_direction(0, 0, ground_dx, ground_dy);
            var di = point_distance(0, 0, ground_dx, ground_dy);
            
            if (di < 0.02)
            {
                ground_dx = 0;
                ground_dy = 0;
            }
            else
            {
                ground_dx = lengthdir_x(di - 0.02, dd);
                ground_dy = lengthdir_y(di - 0.02, dd);
            }
            
            if (point_distance(0, 0, ground_dx, ground_dy) > 1)
            {
                dd = point_direction(0, 0, ground_dx, ground_dy);
                ground_dx = lengthdir_x(1, dd);
                ground_dy = lengthdir_y(1, dd);
            }
            
            dd = point_direction(0, 0, ground_dx, ground_dy);
            di = point_distance(0, 0, ground_dx, ground_dy);
            
            if (di > 0.02)
            {
                var mconst = UnknownEnum.Value_3;
                
                if (global.player_speed >= 2 && cd >= 0.9 && !input.held(6))
                    mconst = UnknownEnum.Value_3;
                else if (global.player_speed >= 1 && cd >= 0.75 && !input.held(6))
                    mconst = UnknownEnum.Value_2;
                else
                    mconst = UnknownEnum.Value_1;
                
                player_move(mconst, point_direction(0, 0, ground_dx, ground_dy), clamp(di, 0.04, 1));
                
                if (di > 0.3)
                    ani3d_skeleton_play_animation_next(skeleton, "ice_skate");
                
                player_try_leap(5);
            }
        }
        else if (gear == 3)
        {
            player_walking_routine_stiff(no_anim, cx, cy, cd, raw_cx, raw_cy);
        }
        else if (gear == 2)
        {
            player_walking_routine_snappy(no_anim, cx, cy, cd, raw_cx, raw_cy);
        }
        else
        {
            player_walking_routine_standard(no_anim, cx, cy, cd, raw_cx, raw_cy);
        }
        
        player_reach_for_items();
        stage_object_affected_by_conveyors();
        
        if (trail_danger && (cx != 0 || cy != 0))
        {
            var held_a = point_direction(0, 0, cx, cy);
            var prev_a = point_direction(x, y, trail_last_safe_x, trail_last_safe_y);
            
            if (abs(angle_difference(held_a, prev_a)) <= 140)
            {
                trail_danger = false;
                x = trail_last_safe_x;
                y = trail_last_safe_y;
                slowdown_post_danger(6);
                player_fx_sweat();
                player_trail_snap_to_current(false);
            }
        }
        
        player_update_grid_position_and_stand_on_tiles();
        player_trail_update();
    }
    else
    {
        stage_object_affected_by_conveyors();
    }
    
    leap_direction = -1;
}

function player_state_leap_start()
{
    can_use_items = true;
    
    if (is_struct(my_floor))
        player_handle_hot_floors();
    
    if (state != player_state_leap_start)
        exit;
    
    if (timer == 0)
    {
        player_clear_snappy_movement();
        jump_equalized = false;
        leap_gx = gx;
        leap_gy = gy;
        jump_cx = 0;
        jump_cy = 0;
        
        if (!trail_danger)
        {
            if (input.held(1) || input.held(2) || input.held(0) || input.held(3))
            {
                ani3d_skeleton_play_animation_next(skeleton, "land");
                leap_somersault = !leap_somersault;
                leap_dx = 0;
                leap_dy = 0;
                
                if (input.held(1))
                    leap_dx = 1;
                
                if (input.held(3))
                    leap_dx = -1;
                
                if (input.held(0))
                    leap_dy = 1;
                
                if (input.held(2))
                    leap_dy = -1;
                
                var d = round(point_direction(0, 0, leap_dx, leap_dy) / 22.5) * 22.5;
                leap_dx = lengthdir_x(1, d);
                leap_dy = lengthdir_y(1, d);
                stage_object_set_state(player_state_leap_squat);
                exit;
            }
        }
    }
    
    var cx = 0;
    var cy = 0;
    var dx = 0;
    var dy = 0;
    
    if (input.held(1))
        cx = 1;
    
    if (input.held(0))
        cy = 1;
    
    if (input.held(3))
        cx = -1;
    
    if (input.held(2))
        cy = -1;
    
    if (stick_direction_lock > 0)
    {
        cx = stick_direction_x;
        cy = stick_direction_y;
    }
    
    if (cx != 0 || cy != 0)
    {
        var dd = point_direction(0, 0, cx, cy);
        dx = lengthdir_x(1, dd);
        dy = lengthdir_y(1, dd);
        
        if (timer < 8)
        {
            leap_dx = dx;
            leap_dy = dy;
        }
        else
        {
            var d2 = point_direction(0, 0, leap_dx, leap_dy);
            var analog_dir = input.get_analog_direction();
            var max_turn = 3.75 * global.fdelta;
            
            if (analog_dir != -1)
            {
                dd = analog_dir;
                max_turn = 60;
            }
            
            var ddd = clamp(angle_difference(dd, d2), -max_turn, max_turn);
            leap_dx = lengthdir_x(1, d2 + ddd);
            leap_dy = lengthdir_y(1, d2 + ddd);
        }
    }
    
    global.player_power_slow_gravity = 2;
    
    if ((!superjump && !input.held(jump_key)) || (superjump && timer > 1 && input.pressed(12)))
    {
        if (timer >= 10 || superjump)
        {
            var d;
            
            if (!superjump)
            {
                x = lerp(x, (floor(x / 32) * 32) + 16, 0.5);
                y = lerp(y, (floor(y / 32) * 32) + 16, 0.5);
                jump_equalized = true;
                d = round(point_direction(0, 0, leap_dx, leap_dy) / 22.5) * 22.5;
            }
            else
            {
                jump_equalized = false;
                d = point_direction(0, 0, leap_dx, leap_dy);
            }
            
            leap_dx = lengthdir_x(1, d);
            leap_dy = lengthdir_y(1, d);
        }
        else
        {
            jump_equalized = false;
        }
        
        ani3d_skeleton_play_animation_next(skeleton, "jump");
        stage_object_set_state(player_state_leap);
    }
    
    if ((superjump && (input.released(5) || input.pressed(6))) || (!superjump && input.pressed(6)))
    {
        ani3d_skeleton_play_animation_next(skeleton, "impact_land", 0);
        player_buffer_next_animation("stand", "land", 60);
        jump_buffer_start = -30;
        stage_object_set_state(player_state_main);
        exit;
    }
}

function player_state_leap_squat()
{
    if (timer >= 0)
    {
        if (global.player_speed >= 2)
        {
            if (character == UnknownEnum.Value_1 || character == UnknownEnum.Value_2)
                ani3d_skeleton_play_animation_next(skeleton, "run_leap");
            else
                ani3d_skeleton_play_animation_next(skeleton, "somersault");
        }
        else
        {
            ani3d_skeleton_play_animation_next(skeleton, "leap");
        }
        
        stage_object_set_state(player_state_leap);
    }
}

function player_state_leap()
{
    can_use_items = true;
    
    if (timer == 0)
    {
        for (var i = 0; i < 4; i++)
            buffered_dir_press[i] = false;
        
        voice_contextual_play_jump();
        
        if (superjump)
        {
            can_use_items = false;
            stage_crack_fragile_floor(gx, gy);
            var bd = base_down_dir;
            container_play_position("cnt_jump", display_x, display_y, display_z);
            container_play_position("cnt_superjump", display_x, display_y, display_z);
            var d = dir;
            dir = stage_get_dir_from_forward_vector_8dir(gx, gy, forward_vector);
            player_activate_freefall_state(dir);
            time = 2;
            
            if (leap_dy > -0.1)
                camera_track_cy = 0.5;
            
            dir = (point_direction(0, 0, leap_dx, leap_dy) + 360 + (bd * 90)) % 360;
            stage_object_face_direction_now(dir, gx, gy);
            stage_object_fastforward_forward_matrix();
            jump_time = 80;
            gravity_speed = 2;
            dx = lengthdir_x(126, dir);
            dy = lengthdir_y(-126, dir);
            var dz = 272;
            var right = array_clone(stage_get_right_vector(gx, gy));
            var up = array_clone(stage_get_up_vector(gx, gy));
            var out = stage_get_out_vector(gx, gy);
            var cent = [display_x + out[0], display_y + out[1], display_z + out[2]];
            var o = stage_object_spawn_3d_billboard_effect(obj_superjump_effect, cent[0], cent[1], cent[2], out, 1.5);
            o.spread_x = right;
            o.spread_x[3] = 0;
            o.spread_y = up;
            o.spread_y[3] = 0;
            target_x = cling_x + (right[0] * dx) + (up[0] * dy) + (out[0] * dz);
            target_y = cling_y + (right[1] * dx) + (up[1] * dy) + (out[1] * dz);
            target_z = cling_z + (right[2] * dx) + (up[2] * dy) + (out[2] * dz);
            
            repeat (12)
            {
                var ddx = random_range(-16, 16);
                var ddy = random_range(-16, 16);
                var xx = cent[0] + (ddx * right[0]) + (ddy * up[0]) + (out[0] * 4);
                var yy = cent[1] + (ddx * right[1]) + (ddy * up[1]) + (out[1] * 4);
                var zz = cent[2] + (ddx * right[2]) + (ddy * up[2]) + (out[2] * 4);
                var ss = random_range(2, 6);
                var _xs = ss * out[0];
                var _ys = ss * out[1];
                var _zs = ss * out[2];
                cpart_create_paint_drip(16777215, xx, yy, zz, _xs, _ys, _zs, out, irandom_range(10, 40), random_range(0.8, 1.2));
            }
            
            ani3d_skeleton_play_animation_next(skeleton, "superjump");
            dir = d;
            exit;
        }
        
        player_buffer_snap_to_grid_center_timed(18);
        leap_direction = point_direction(0, 0, leap_dx, leap_dy);
        container_play_position("cnt_jump", display_x, display_y, display_z);
        
        if (impact_jump)
            ani3d_skeleton_play_animation_next(skeleton, "impact_lunge");
    }
    
    if (teqs(1))
    {
        if (jump_equalized)
        {
            x = (floor(x / 32) * 32) + 16;
            y = (floor(y / 32) * 32) + 16;
        }
        
        decoy_countdown = (decoy_countdown <= 0) ? -30 : decoy_countdown;
        decoy_gx = leap_gx;
        decoy_gy = leap_gy;
    }
    
    var dx = 0;
    var dy = 0;
    var b = ease_in_sine(lerp(0.75, 1, timer / 16), 2.5, min(1, timer / 24));
    
    if (timer < 16)
    {
        var turned = false;
        
        if (jump_secondary_input)
        {
            if (input.pressed(8) || buffered_dir_press[1])
            {
                if (jump_cx == 0)
                {
                    jump_cx = b;
                    turned = true;
                }
                
                buffered_dir_press[1] = false;
            }
            
            if (input.pressed(7) || buffered_dir_press[0])
            {
                if (jump_cy == 0)
                {
                    jump_cy = b;
                    turned = true;
                }
                
                buffered_dir_press[0] = false;
            }
            
            if (input.pressed(10) || buffered_dir_press[3])
            {
                if (jump_cx == 0)
                {
                    jump_cx = -b;
                    turned = true;
                }
                
                buffered_dir_press[3] = false;
            }
            
            if (input.pressed(9) || buffered_dir_press[2])
            {
                if (jump_cy == 0)
                {
                    jump_cy = -b;
                    turned = true;
                }
                
                buffered_dir_press[2] = false;
            }
        }
        else
        {
            if (input.pressed(1) || buffered_dir_press[1])
            {
                if (jump_cx == 0)
                {
                    jump_cx = b;
                    turned = true;
                }
                
                buffered_dir_press[1] = false;
            }
            
            if (input.pressed(0) || buffered_dir_press[0])
            {
                if (jump_cy == 0)
                {
                    jump_cy = b;
                    turned = true;
                }
                
                buffered_dir_press[0] = false;
            }
            
            if (input.pressed(3) || buffered_dir_press[3])
            {
                if (jump_cx == 0)
                {
                    jump_cx = -b;
                    turned = true;
                }
                
                buffered_dir_press[3] = false;
            }
            
            if (input.pressed(2) || buffered_dir_press[2])
            {
                if (jump_cy == 0)
                {
                    jump_cy = -b;
                    turned = true;
                }
                
                buffered_dir_press[2] = false;
            }
        }
        
        if (turned)
        {
            invincible_frames = max(invincible_frames, 2);
            container_play_position("cnt_jump_turn", display_x, display_y, display_z);
        }
    }
    
    cx = jump_cx;
    cy = jump_cy;
    global.player_power_slow_gravity = 2;
    
    if (impact_jump)
    {
        if (timer <= 1)
            invincible_frames = max(invincible_frames, 32 - timer);
    }
    else if (timer <= 1)
    {
        invincible_jump_frames = max(invincible_jump_frames, 19 - timer);
    }
    
    var _rtimer = (timer - global.fdelta) + 1;
    var t;
    
    while (_rtimer <= timer)
    {
        var thrust_power = 0.1;
        
        if (jump_equalized)
            thrust_power *= 0.25;
        
        leap_dx += (jump_cx * thrust_power);
        leap_dy += (jump_cy * thrust_power);
        var dd = point_direction(0, 0, leap_dx, leap_dy);
        var di = point_distance(0, 0, leap_dx, leap_dy);
        var c = max(max(jump_cx, jump_cy), 1);
        
        if (di > c)
        {
            leap_dx = lengthdir_x(c, dd);
            leap_dy = lengthdir_y(c, dd);
        }
        
        t = _rtimer / 26;
        
        if (_rtimer >= 1)
        {
            z = lengthdir_y(-17, t * 180);
            
            if (impact_jump)
                z *= 3.6;
            else
                z *= 2.8;
            
            var s = lerp(6.45, 0.25, t);
            var spagr = (round(point_direction(0, 0, leap_dx, leap_dy)) / 22.5) % 4;
            var spag = (point_direction(0, 0, leap_dx, leap_dy) / 22.5) % 4;
            var spagm;
            
            if (spag < 2)
                spagm = ease_in_sine(0, 1, spag / 2);
            else
                spagm = ease_in_sine(0, 1, (4 - spag) / 2);
            
            s *= (1 + (0.44 * spagm));
            s *= 0.7692307692307693;
            stage_object_move_doubledir(s * leap_dx, s * leap_dy);
            player_try_leap(1);
            
            if (state != player_state_leap)
                exit;
        }
        
        _rtimer++;
    }
    
    if (timer >= 1)
        player_execute_buffered_movement();
    
    player_reveal_hidden_tiles();
    
    if (t >= 1)
    {
        z = 0;
        conveyor_ignore_until_frame = max(conveyor_ignore_until_frame, global.game_frame + 4);
        out_vector_mul = 0.16;
        
        if (my_floor.type == UnknownEnum.Value_14)
        {
            if (abs(x - (floor(x / 32) * 32) - 16) < 6 && abs(y - (floor(y / 32) * 32) - 16) < 6)
            {
                x = (floor(x / 32) * 32) + 16;
                y = (floor(y / 32) * 32) + 16;
            }
        }
        else
        {
            player_buffer_snap_to_grid_center_timed(6);
        }
        
        ground_dx = leap_dx;
        ground_dy = leap_dy;
        
        if (gx != leap_gx || gy != leap_gy)
        {
            player_stand_on_tile(gx, gy, true);
            player_trail_snap_to_current(!impact_jump);
            player_hurt_from_spikes(gx, gy);
        }
        else
        {
            player_trail_snap_to_current(false);
        }
        
        if (impact_jump)
        {
            container_play_position("cnt_slam", display_x, display_y, display_z);
            ani3d_skeleton_play_animation_next(skeleton, "impact_land", 0);
            player_buffer_next_animation("stand", "land", 60);
            state = player_state_impact_land;
            timer = 0;
            time = 0;
            item_reduce(player, UnknownEnum.Value_2);
        }
        else
        {
            ani3d_skeleton_play_animation_next(skeleton, "land");
            player_buffer_next_animation("stand", "land", 20);
            
            if (my_floor.type == UnknownEnum.Value_28 || my_floor.type == UnknownEnum.Value_20 || my_floor.type == UnknownEnum.Value_10 || my_floor.type == UnknownEnum.Value_34 || my_floor.type == UnknownEnum.Value_18)
            {
                stage_object_set_state(player_state_main);
            }
            else
            {
                state = player_state_main;
                timer = 0;
                ptimer = 0;
            }
        }
        
        if (impact_jump)
            player_impact_item();
    }
}

function player_state_sticky_leap()
{
    if (timer == 0)
    {
        ani3d_skeleton_play_animation_next(skeleton, "jump_sticked");
        container_play("cnt_sticky_jump_attempt");
        create_sticky_effect(gx, gy);
    }
    
    global.player_power_slow_gravity = max(global.player_power_slow_gravity, 2);
    
    if (timer >= 10)
    {
        if (input.held(1) || input.held(0) || input.held(2) || input.held(3) || jump_buffer_start >= (global.game_frame - jump_buffer_margin))
            timer = 52;
    }
    
    if (timer >= 52)
    {
        ani3d_skeleton_play_animation_next(skeleton, "stand");
        state = player_state_main;
        timer = 0;
        ptimer = 0;
    }
}

function player_state_impact_land()
{
    global.player_power_forbid_gravity = 2;
    
    if (timer >= 22)
    {
        if (is_struct(my_floor) && my_floor.type == UnknownEnum.Value_14)
        {
            ground_dx = 0;
            ground_dy = 0;
        }
        
        state = player_state_main;
        timer = 0;
        ptimer = 0;
    }
}

function player_astate_stamphammer_trace_set_sprite(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
{
    vividext_particles_set_sprite(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
}

function player_astate_stamphammer_trace(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
{
    vividext_particles_create_trace(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
}

function player_astate_stamphammer()
{
    var pat = atimer - (global.gdelta * global.tdelta);
    var delta = 0.25;
    var t = 1;
    
    for (var i = 0; i < 1; i += delta)
    {
        t = lerp(2, 6, i);
        
        if (teq(atimer, pat, t))
        {
            var a1 = lerp(135, 0, i);
            var a2 = lerp(135, 0, i + delta);
            var da = 2.5;
            
            for (var a = a1; a > a2; a -= da)
            {
                player_astate_stamphammer_trace_set_sprite(spr_landing_circle, 0, 0.3, 0.3, random(360), merge_color(c_white, make_color_hsv(a * 2, 255, 255), 0.5), 0.25);
                var x1 = lengthdir_x(72, a);
                var y1 = 10 - lengthdir_y(72, a);
                var x2 = lengthdir_x(72, a - da);
                var y2 = 10 - lengthdir_y(72, a - da);
                player_astate_stamphammer_trace(10, 1, atimer - t, atimer - t - 1, 4, 2, display_x + (forward_vector[0] * x1) + (out_vector[0] * y1), display_y + (forward_vector[1] * x1) + (out_vector[1] * y1), display_z + (forward_vector[2] * x1) + (out_vector[2] * y1), display_x + (forward_vector[0] * x2) + (out_vector[0] * y2), display_y + (forward_vector[1] * x2) + (out_vector[1] * y2), display_z + (forward_vector[2] * x2) + (out_vector[2] * y2), true);
            }
        }
    }
}

function player_astate_stamphammer_create_blur(arg0)
{
    var o = instance_create_lay(0, 0, 15, obj_stamphammer_blur);
    o.father = self.id;
    o.angle2 = arg0;
    
    with (o)
        event_user(0);
}

function player_state_stamphammer()
{
    if (timer == 0)
    {
        time = 24;
        swing_angle = -90;
        swing_tx = 0;
        swing_ty = 0;
        held_hammer = 1;
        skeleton.animation_transition = 0;
        skeleton.animation_transition_length = 0;
        gx = floor(x / 32);
        gy = floor(y / 32);
        container_play_position("cnt_stamphammer_swing", display_x, display_y, display_z);
        stage_object_fastforward_forward_matrix();
        var out = stage_get_out_vector(gx, gy);
        var middle = stage_get_middle_position(gx, gy);
        var marg = 2;
        var r = [69, 61, 32];
        var ri = [0, 9, 18];
        
        for (var i = 90; i >= -45; i -= 5)
        {
            for (var j = 0; j < array_length(r); j++)
            {
                var dx1 = lengthdir_x(r[j], i + 1 + ri[j]);
                var dy1 = lengthdir_y(-r[j], i + 1 + ri[j]);
                var dx2 = lengthdir_x(r[j], (i - 4) + ri[j]);
                var dy2 = lengthdir_y(-r[j], (i - 4) + ri[j]);
                var x1 = middle[0] + (out[0] * (dy1 + marg)) + (forward_vector[0] * dx1);
                var y1 = middle[1] + (out[1] * (dy1 + marg)) + (forward_vector[1] * dx1);
                var z1 = middle[2] + (out[2] * (dy1 + marg)) + (forward_vector[2] * dx1);
                var x2 = middle[0] + (out[0] * (dy2 + marg)) + (forward_vector[0] * dx2);
                var y2 = middle[1] + (out[1] * (dy2 + marg)) + (forward_vector[1] * dx2);
                var z2 = middle[2] + (out[2] * (dy2 + marg)) + (forward_vector[2] * dx2);
                var res = stage_check_3d_collision(x2, y2, z2, x1, y1, z1);
                
                if (is_array(res))
                {
                    if (r[j] < 56)
                        swing_angle = -90;
                    else
                        swing_angle = i;
                    
                    swing_tx = res[0];
                    swing_ty = res[1];
                    break;
                }
            }
            
            if (swing_tx > 0)
                break;
        }
        
        if (swing_angle <= -90)
        {
            ani3d_skeleton_play_animation_next(skeleton, "hammer_swing_fail", 0);
            player_astate_stamphammer_create_blur(0);
            swing_tx = 0;
            swing_ty = 0;
        }
        else
        {
            ani3d_skeleton_play_animation_next(skeleton, "hammer_swing", 0);
            player_astate_stamphammer_create_blur(swing_angle);
        }
    }
    
    global.player_power_forbid_gravity = max(global.player_power_forbid_gravity, 2);
    x = approach(x, (floor(x / 32) * 32) + 16, 3.2);
    y = approach(y, (floor(y / 32) * 32) + 16, 3.2);
    
    if (teqs(3))
    {
        invincible_hidden_frames = max(4, invincible_hidden_frames);
        
        if (swing_tx > 0 && swing_ty > 0)
        {
            var cent = stage_get_middle_position(swing_tx, swing_ty);
            container_play_position("cnt_stamphammer_hit", cent[0], cent[1], cent[2]);
            voice_contextual_play_stamp();
        }
        else
        {
            container_play_position("cnt_stamphammer_fail", display_x, display_y, display_z);
            voice_contextual_play_caution();
        }
    }
    
    if (timer < 6 && global.objective_fulfilled)
    {
        with (obj_stamphammer_blur)
            instance_destroy();
        
        z = 0;
        state = player_state_main;
        timer = 0;
        ptimer = 0;
        exit;
    }
    
    if (teqs(4))
    {
        if (swing_tx > 0 && swing_ty > 0)
        {
            var cent = stage_get_middle_position(swing_tx, swing_ty);
            instance_create_lay((swing_tx * 32) + 16, (swing_ty * 32) + 16, 15, obj_player_stamphammer_effect);
            screenshake(30, 9, ease_out_cubic, 4, normalize_array(add_vector_array(scale_vector_array(global.camera_3d_up, -0.8), mulv(stage_get_out_vector(gx, gy), -0.2))));
            hammer_squish = 0;
            var a = get_screenspace_coords(cent[0], cent[1], cent[2]);
            cpart_create_blendsetter(30, 1);
            
            repeat (16)
                cpart_create_lightscreentrail_yellow(a[0], a[1], random(360));
            
            cpart_create_blendsetter(30, 0);
            var xx = 14;
            var yy = 8;
            eliminate_enemy_at_display_position_vectorsafe(display_x + (forward_vector[0] * xx) + (out_vector[0] * yy), display_y + (forward_vector[1] * xx) + (out_vector[1] * yy), display_z + (forward_vector[2] * xx) + (out_vector[2] * yy), 26, out_vector);
            var taken_map = ds_map_create();
            stamp_scored = 0;
            item_stamphammer_affect(swing_tx, swing_ty);
            ds_map_set(taken_map, swing_tx + (swing_ty * 1000), true);
            
            for (var i = 0; i < 4; i++)
            {
                var d = stage_grid_step([swing_tx, swing_ty], i);
                
                if (d[0] < 0 || d[2] < 0)
                    continue;
                
                if (!ds_map_exists(taken_map, d[0] + (d[1] * 1000)))
                {
                    item_stamphammer_affect(d[0], d[1]);
                    ds_map_set(taken_map, d[0] + (d[1] * 1000), true);
                }
                
                var d2 = stage_grid_step(d, (d[2] + 1) % 4);
                
                if (d2[0] >= 0 && d2[2] >= 0 && !ds_map_exists(taken_map, d2[0] + (d2[1] * 1000)))
                {
                    item_stamphammer_affect(d2[0], d2[1]);
                    ds_map_set(taken_map, d2[0] + (d2[1] * 1000), true);
                }
                
                d2 = stage_grid_step(d, (d[2] + 3) % 4);
                
                if (d2[0] >= 0 && d2[2] >= 0 && !ds_map_exists(taken_map, d2[0] + (d2[1] * 1000)))
                {
                    item_stamphammer_affect(d2[0], d2[1]);
                    ds_map_set(taken_map, d2[0] + (d2[1] * 1000), true);
                }
            }
            
            ds_map_destroy(taken_map);
            
            if (stamp_scored > 0)
                eliminate_enemy_handle_multiko(stamp_scored, cent[0], cent[1], cent[2]);
        }
        else
        {
            player_fx_sweat();
            
            with (obj_player_sweat_effect)
                time = 12;
        }
    }
    
    if (teqs(time - 8))
    {
        hammer_putback = 1;
        
        if (skeleton.vividext_id >= 0)
            vividext_skeleton_player_reset_hammerheld(skeleton.vividext_id);
        
        ani3d_skeleton_play_animation_next(skeleton, "stand", 10);
    }
    
    if (timer >= (time - 8))
    {
        if (input.held(1) || input.held(3) || input.held(2) || input.held(0))
            timer = time;
    }
    
    if (timer >= time)
    {
        if (swing_tx > 0 && swing_ty > 0)
            item_reduce(player, UnknownEnum.Value_5);
        
        z = 0;
        state = player_state_main;
        timer = 0;
        ptimer = 0;
    }
}

function player_dodge_despawn_effect()
{
    container_play_position("cnt_dodge_end", display_x, display_y, display_z);
    var o = stage_object_spawn_3d_billboard_effect(obj_dodge_poof_effect, display_x, display_y, display_z, out_vector, 12);
    o.out_vector = out_vector;
    sprite_display = UnknownEnum.Value_0;
}

function player_state_dodge()
{
    invincible_hidden_frames = 3;
    
    if (timer == 0)
    {
        container_play_position("cnt_dodge_start", display_x, display_y, display_z);
        var o = stage_object_spawn_3d_billboard_effect(obj_dodge_poof_effect, display_x, display_y, display_z, out_vector, 12);
        o.out_vector = out_vector;
        sprite_display = UnknownEnum.Value_1;
        dodge_stepped = false;
        dodge_timeout = 0;
        o = instance_create_lay(0, 0, 5, obj_dodge_countdown_display);
        o.stick_object = self.id;
        o.x2 = display_x;
        o.y2 = display_y;
        o.z2 = display_z;
        o.x1 = o.x2;
        o.y1 = o.y2;
        o.z1 = o.z2;
        o.x = o.x2;
        o.y = o.y2;
        o.z = o.z2;
        decoy_gx = gx;
        decoy_gy = gy;
        decoy_x = x;
        decoy_y = y;
        o = instance_create_lay(x, y, 300, obj_player_decoy);
        o.parent = self.id;
    }
    
    decoy_countdown = max(decoy_countdown, 10);
    
    if (global.gstate == UnknownEnum.Value_4 || global.gstate == UnknownEnum.Value_1)
    {
        player_update_grid_position_and_stand_on_tiles();
        player_trail_update();
    }
    
    player_handle_hot_floors();
    
    if (state != player_state_dodge)
        exit;
    
    if (gstate_has_player_been_kod() || global.objective_fulfilled || global.gstate == UnknownEnum.Value_6)
    {
        player_dodge_despawn_effect();
        state = player_state_camera_pose;
        exit;
    }
    
    if (state != player_state_dodge)
    {
        player_dodge_despawn_effect();
        exit;
    }
    
    var cx = 0;
    var cy = 0;
    var dx = 0;
    var dy = 0;
    var s = 3;
    cx = input.get_xaxis();
    cy = input.get_yaxis();
    var cd = point_distance(0, 0, cx, cy);
    ground_dx = 0;
    ground_dy = 0;
    ani3d_skeleton_play_animation_next(skeleton, "stand");
    
    if (cd > 0.35)
    {
        var hd = 0;
        var hds = 0;
        
        for (var i = 0; i < 4; i++)
        {
            if (input.held(i))
            {
                hd = i;
                hds++;
            }
        }
        
        if (input.held((buffered_turn_dir + 2) % 4))
            buffered_turn_countdown = 0;
        
        if (buffered_turn_countdown > 0)
        {
            buffered_turn_countdown = max(buffered_turn_countdown - global.fdelta, 0);
            
            if (hds <= 1)
            {
                cx += global.dir_to_dx[buffered_turn_dir];
                cy += global.dir_to_dy[buffered_turn_dir];
            }
            else
            {
                buffered_turn_countdown = 0;
            }
        }
        else if (hds == 1 && dir_held[hd] < 3)
        {
            var r = (hd + 1) % 4;
            var l = (hd + 3) % 4;
            
            if (dir_held[r] > 0)
            {
                buffered_turn_countdown = 3;
                buffered_turn_dir = r;
                buffered_turn_cx = global.dir_to_dx[hd] + global.dir_to_dx[r];
                buffered_turn_cy = global.dir_to_dy[hd] + global.dir_to_dy[r];
            }
            else if (dir_held[l] > 0)
            {
                buffered_turn_countdown = 3;
                buffered_turn_dir = l;
                buffered_turn_cx = global.dir_to_dx[hd] + global.dir_to_dx[l];
                buffered_turn_cy = global.dir_to_dy[hd] + global.dir_to_dy[l];
            }
        }
        
        ground_dx = cx;
        ground_dy = cy;
        cd = clamp((cd - 0.35) / 0.65, 0, 1);
        var slow = 1;
        var speed_scalar;
        
        if (input.held(6))
            speed_scalar = lerp(0.25, 1, cd * 0.5);
        else
            speed_scalar = lerp(0.25, 1, cd);
        
        player_movement_magnet(cx, cy, true);
        player_move(UnknownEnum.Value_3, point_direction(0, 0, cx, cy), speed_scalar * slow * 1.2);
        ani3d_skeleton_play_animation_next(skeleton, "run");
    }
    else
    {
        buffered_turn_countdown = 0;
    }
    
    if (gx != pgx || gy != pgy)
    {
        dodge_stepped = true;
        dodge_timeout = 0;
        item_reduce(player, UnknownEnum.Value_7);
    }
    
    dodge_timeout++;
    
    if (dodge_timeout >= 60)
    {
        dodge_stepped = true;
        dodge_timeout -= 60;
        item_reduce(player, UnknownEnum.Value_7);
    }
    
    if ((timer > 0 && input.pressed(12)) || global.splayer_item_quantity[player] <= 0 || global.splayer_item[player] != UnknownEnum.Value_7)
    {
        player_dodge_despawn_effect();
        state = player_state_main;
        timer = 0;
        ptimer = 0;
        
        if (!dodge_stepped)
            item_reduce(player, UnknownEnum.Value_7);
        
        if (global.splayer_item_quantity[player] <= 0 || global.splayer_item[player] != UnknownEnum.Value_7)
            invincible_frames = max(invincible_frames, 60);
    }
}

function player_state_respawn()
{
    visible = 0;
    
    if (timer >= 3)
        refresh_movement_vector = max(refresh_movement_vector, 2);
    
    if (timer >= 6)
    {
        visible = 1;
        
        if (character == UnknownEnum.Value_4)
            ani3d_tail_set_default_values(skeleton);
        
        shadow_scalar = 1;
        alpha = 1;
        boost_gx = -1;
        boost_gy = -1;
        boost_sound_gx = -1;
        boost_sound_gy = -1;
        ground_dx = 0;
        ground_dy = 0;
        grid_lerp_on = false;
        prevent_negative_any = 0;
        conveyor_ignore_until_frame = global.game_frame + invincible_frames;
        conveyor_ignore_until_step_away = true;
        var cent = stage_get_middle_position(gx, gy);
        var r = stage_get_right_vector(gx, gy);
        var u = stage_get_up_vector(gx, gy);
        var ou = stage_get_out_vector(gx, gy);
        
        repeat (20)
        {
            var dx = random_range(-24, 24);
            var dy = random_range(-24, 24);
            var xx = cent[0] + (dx * r[0]) + (dy * u[0]) + (ou[0] * 4);
            var yy = cent[1] + (dx * r[1]) + (dy * u[1]) + (ou[1] * 4);
            var zz = cent[2] + (dx * r[2]) + (dy * u[2]) + (ou[2] * 4);
            var ss = random_range(3, 7);
            var _xs = ss * ou[0];
            var _ys = ss * ou[1];
            var _zs = ss * ou[2];
            cpart_create_paint_drip(16777215, xx, yy, zz, _xs, _ys, _zs, ou, irandom_range(20, 32), random_range(0.8, 1.5));
        }
        
        container_play("cnt_player_spawn");
        player_clear_buffered_movement();
        stage_object_fastforward_forward_matrix();
        stage_object_set_state(player_state_main);
    }
}

function player_state_blocking_land()
{
    if (timer == 0)
        invincible_frames = max(invincible_frames, 15);
    
    var s = 5 - timer;
    
    if (s > 0)
    {
        x = approach(x, (floor(x / 32) * 32) + 16, s);
        y = approach(y, (floor(y / 32) * 32) + 16, s);
    }
    
    if (timer >= 15)
    {
        refresh_movement_vector = 6;
        stage_object_set_state(player_state_main);
    }
}

function player_state_camera_pose()
{
    if (abs(z) > 0.01)
        z *= 0.5;
    else
        z = 0;
}

function player_state_camera_pose_with_buffered_movement()
{
    if (abs(z) > 0.01)
        z *= 0.5;
    else
        z = 0;
    
    player_execute_buffered_movement();
}

function player_state_cancel_jump_and_goto_main()
{
    if (abs(z) > 0.01)
        z *= 0.5;
    else
        z = 0;
    
    player_execute_buffered_movement();
    
    if (timer >= 3)
    {
        jump_buffer_start = -30;
        stage_object_set_state(player_state_main);
    }
}

function player_recover_from_failed_freefall()
{
    direction_to_player_update_countdown = -64;
    gx = save_gx;
    gy = save_gy;
    pgx = save_gx;
    pgy = save_gy;
    x = (gx * 32) + 16;
    y = (gy * 32) + 16;
    room_x = x;
    room_y = y;
    display_px = save_display_x;
    display_x = save_display_x;
    display_py = save_display_y;
    display_y = save_display_y;
    display_pz = save_display_z;
    display_z = save_display_z;
    my_floor = ds_grid_get(global.stage_grid, gx, gy);
    grid_on = true;
    ani3d_skeleton_play_animation_next(skeleton, "land");
    player_buffer_next_animation("stand", "land", 20);
    player_trail_snap_to_current(false);
    stage_object_set_state(player_state_main);
}

function player_match_groundleap_dxdy_to_forward()
{
    var r = stage_get_right_vector(floor(x / 32), floor(y / 32));
    var u = stage_get_up_vector(floor(x / 32), floor(y / 32));
    var acto = forward_vector;
    var dx = dot_product_array(acto, r);
    var dy = -dot_product_array(acto, u);
    
    if (point_distance(0, 0, dx, dy) < 0.001)
    {
        if (!global.debugging)
        {
            if (!is_struct(ds_grid_get(global.stage_grid, gx, gy)))
                exit;
            
            if (!is_struct(ds_grid_get(global.stage_grid, lgx, lgy)))
                exit;
        }
        
        acto = vector_subtract(stage_get_middle_position(gx, gy), stage_get_middle_position(lgx, lgy));
        var len = point_distance_3d(acto[0], acto[1], acto[2], 0, 0, 0);
        
        if (len < 2 || len > 64)
            exit;
        else
            vec3l_normalize(acto);
        
        dx = dot_product_array(acto, r);
        dy = -dot_product_array(acto, u);
    }
    
    var dd = (round(point_direction(0, 0, dx, dy) / 90) * 90) - (base_down_dir * 90);
    ground_dx = lengthdir_x(1, dd);
    ground_dy = lengthdir_y(1, dd);
}

function player_movement_magnet_dependence_on_edge_distance_multiplier(arg0, arg1)
{
    var dist = abs(arg0 - arg1) / 16;
    return ease_in_cubic(0.25, 1.5, dist);
}

function player_movement_magnet(arg0, arg1, arg2 = false)
{
    var analog = 0;
    
    if (global.gcamera_type == UnknownEnum.Value_5)
        exit;
    
    if (abs(arg0) <= 1 && abs(arg1) <= 1)
        analog = 1;
    
    if (0 && analog)
        exit;
    
    if (is_struct(my_floor) && my_floor.type == UnknownEnum.Value_11)
        exit;
    
    if (abs(arg0) < 0.1 || abs(arg1) < 0.1)
    {
        if (abs(arg0) < 0.1)
            arg0 = 0;
        
        if (abs(arg1) < 0.1)
            arg1 = 0;
        
        var f = ds_grid_get(global.stage_grid, floor(x / 32), floor(y / 32));
        var d = (round(((point_direction(0, 0, arg0, arg1) + 90) % 360) / 90) + base_down_dir) % 4;
        
        if (!(f.type == UnknownEnum.Value_11 && (f.type_param % 2) != (d % 2)))
        {
            var snap_speed = ((gear >= 2 && !arg2) ? max(movement_speed * 0.5, 1.2) : ((1 - (analog * 0.5)) * 1.2)) * global.fdelta;
            
            if (d % 2)
            {
                snap_speed = snap_speed * player_movement_magnet_dependence_on_edge_distance_multiplier(y, (floor(y / 32) * 32) + 16);
                y = approach(y, (floor(y / 32) * 32) + 16, snap_speed);
            }
            else
            {
                snap_speed = snap_speed * player_movement_magnet_dependence_on_edge_distance_multiplier(x, (floor(x / 32) * 32) + 16);
                x = approach(x, (floor(x / 32) * 32) + 16, snap_speed);
            }
        }
    }
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
    Value_7,
    Value_8,
    Value_9,
    Value_10,
    Value_11,
    Value_14 = 14,
    Value_15,
    Value_18 = 18,
    Value_19,
    Value_20,
    Value_24 = 24,
    Value_27 = 27,
    Value_28,
    Value_34 = 34
}
