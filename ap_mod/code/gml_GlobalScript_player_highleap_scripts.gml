function player_highleap_init()
{
    highleap_component_n = 10;
    highleap_component_activecap = 0;
    var i = highleap_component_n - 1;
    
    while (i >= 0)
    {
        highleap_component[i] = 
        {
            active: false,
            dir: 0,
            distance_done: 0,
            distance_target: 0,
            time1: 0,
            time: 0,
            type: 0
        };
        i--;
    }
    
    highleap_predgx = 0;
    highleap_predgy = 0;
    highleap_predarr = [0, 0, 0, 0, 0, 0];
    highleap_leapdgx = 0;
    highleap_leapdgy = 0;
    highleap_nleapdgx = 0;
    highleap_nleapdgy = 0;
    highleap_turned = [false, false];
    highleap_turns = 0;
}

function player_highleap_reset_components()
{
    highleap_component_activecap = 0;
    highleap_predgx = 0;
    highleap_predgy = 0;
    highleap_turned[0] = false;
    highleap_turned[1] = false;
    highleap_turns = 0;
}

function player_highleap_add_component(arg0, arg1, arg2, arg3, arg4)
{
    var it = highleap_component_activecap;
    
    if (it >= highleap_component_n)
        exit;
    
    with (highleap_component[it])
    {
        active = true;
        dir = arg0;
        distance_done = 0;
        distance_target = arg1;
        time1 = arg2;
        time = arg3 - arg2;
        type = arg4;
    }
    
    highleap_component_activecap++;
}

function player_highleap_lerp(arg0, arg1, arg2, arg3)
{
    if (arg3 > 0)
        return ease_inout_sine(arg0, arg1, arg2);
    
    return lerp(ease_out_sine(arg0, arg1, arg2), lerp(arg0, arg1, arg2), 0.5);
}

function player_highleap_execute_components(arg0)
{
    for (var i = 0; i < highleap_component_activecap; i++)
    {
        var c = highleap_component[i];
        
        if (!c.active)
            continue;
        
        var t = clamp((arg0 - c.time1) / c.time, 0, 1);
        var d1 = c.distance_done;
        var d2 = player_highleap_lerp(0, c.distance_target, t, c.type);
        
        if (d2 != d1)
        {
            var delta = d2 - d1;
            player_move(UnknownEnum.Value_0, -90 + (90 * c.dir), delta / global.fdelta);
            c.distance_done = d2;
        }
        
        if (t >= 1)
            c.active = false;
    }
}

function player_highleap_predict_finish(arg0, arg1)
{
    var a = highleap_predarr;
    a[0] = x / 32;
    a[1] = y / 32;
    a[2] = 0;
    a[3] = 0;
    a[4] = base_down_dir;
    a[5] = false;
    highleap_predgx = gx;
    highleap_predgy = gy;
    
    for (var i = 0; i < highleap_component_activecap; i++)
        highleap_component[i].distance_buffered = highleap_component[i].distance_done;
    
    for (var ti = arg0; ti < (arg1 + 1); ti += 1)
    {
        for (var i = 0; i < highleap_component_activecap; i++)
        {
            var c = highleap_component[i];
            
            if (!c.active)
                continue;
            
            var t = clamp((ti - c.time1) / c.time, 0, 1);
            var d1 = c.distance_buffered;
            var d2 = player_highleap_lerp(0, c.distance_target, t, c.type);
            
            if (d2 != d1)
            {
                var delta = d2 - d1;
                var psx = a[0];
                var psy = a[1];
                a[2] = delta / 32;
                a[3] = c.dir;
                
                if (a[2] < 0)
                {
                    a[2] = -a[2];
                    a[3] = (a[3] + 2) % 4;
                }
                
                stage_gridfrac_move_dir_lite_walkblock(a);
                
                if (a[5])
                {
                    highleap_predgx = floor(a[0]);
                    highleap_predgy = floor(a[1]);
                }
                else
                {
                    a[0] = psx;
                    a[1] = psy;
                    var s = ds_grid_get(global.stage_grid, psx, psy);
                    
                    if (is_struct(s) && s.ledge[(8 + a[3] + a[4]) % 4])
                    {
                        highleap_predgx = 0;
                        highleap_predgy = 0;
                        exit;
                    }
                }
            }
            
            c.distance_buffered = d2;
        }
    }
}

function player_highleap_turn(arg0)
{
    switch (arg0)
    {
        case 0:
            if (highleap_nleapdgy >= 2 || (highleap_nleapdgx == 0 && highleap_nleapdgy == -1))
                exit;
            
            break;
        
        case 1:
            if (highleap_nleapdgx >= 2 || (highleap_nleapdgy == 0 && highleap_nleapdgx == -1))
                exit;
            
            break;
        
        case 2:
            if (highleap_nleapdgy <= -2 || (highleap_nleapdgx == 0 && highleap_nleapdgy == 1))
                exit;
            
            break;
        
        case 3:
            if (highleap_nleapdgx <= -2 || (highleap_nleapdgy == 0 && highleap_nleapdgx == 1))
                exit;
            
            break;
    }
    
    if (!highleap_turned[arg0 % 2])
    {
        highleap_turns++;
        
        if (highleap_turns >= 6)
        {
            highleap_turned[0] = true;
            highleap_turned[1] = true;
            exit;
        }
        
        if (global.goption_jump_style)
            audi_play_at(snd_jump_grid_move, display_x, display_y, display_z);
        else
            audi_play_at(snd_jump_turn, display_x, display_y, display_z);
        
        vividext_player_hover_jump_click();
        invincible_frames = max(invincible_frames, 2);
        time = max(time, timer + (impact_jump ? 16 : 24));
        player_highleap_add_component(arg0, 32, timer, time, 1);
        highleap_nleapdgx += global.dir_to_dx[arg0];
        highleap_nleapdgy += global.dir_to_dy[arg0];
    }
}

function player_state_highleap()
{
    can_use_items = false;
    
    if (timer == 0)
    {
        out_vector_mul = 0.036;
        buffered_dir_press[0] = false;
        buffered_dir_press[1] = false;
        buffered_dir_press[2] = false;
        buffered_dir_press[3] = false;
        noir_impact_now = false;
        leap_gx = gx;
        leap_gy = gy;
        player_buffer_snap_to_grid_center_timed(16);
        vividext_player_hover_jump_click();
        
        if (impact_jump)
        {
            time = 28;
            ani3d_skeleton_play_animation_next(skeleton, "impact_lunge");
            audi_play_at(snd_jump_impact, display_x, display_y, display_z);
        }
        else
        {
            if (global.goption_jump_style)
                time = 36;
            else
                time = 20;
            
            if (character == UnknownEnum.Value_4)
                ani3d_skeleton_play_animation_next(skeleton, "jump");
            else
                ani3d_skeleton_play_animation_next(skeleton, "somersault");
            
            audi_play_at(snd_jump, display_x, display_y, display_z);
        }
        
        var o = instance_create_lay((floor(x / 32) * 32) + 16, (floor(y / 32) * 32) + 16, 15, obj_player_jump_start_effect);
        o.impact_mode = impact_jump;
        
        if (!trail_danger && boost_gx != -999)
        {
            if (input.held(1) || input.held(2) || input.held(0) || input.held(3))
            {
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
                
                d = round(point_direction(0, 0, leap_dx, leap_dy) / 22.5) * 22.5;
                leap_dx = lengthdir_x(1, d);
                leap_dy = lengthdir_y(1, d);
            }
        }
        
        if (boost_gx == -999)
            boost_gx = -1;
        
        var dx = 0;
        var dy = 0;
        var d = round(point_direction(0, 0, leap_dx, leap_dy) / 22.5);
        
        switch (d)
        {
            case 0:
            case 16:
                dx = 2;
                dy = 0;
                break;
            
            case 1:
                dx = 2;
                dy = -1;
                break;
            
            case 2:
                dx = 2;
                dy = -2;
                break;
            
            case 3:
                dx = 1;
                dy = -2;
                break;
            
            case 4:
                dx = 0;
                dy = -2;
                break;
            
            case 5:
                dx = -1;
                dy = -2;
                break;
            
            case 6:
                dx = -2;
                dy = -2;
                break;
            
            case 7:
                dx = -2;
                dy = -1;
                break;
            
            case 8:
                dx = -2;
                dy = 0;
                break;
            
            case 9:
                dx = -2;
                dy = 1;
                break;
            
            case 10:
                dx = -2;
                dy = 2;
                break;
            
            case 11:
                dx = -1;
                dy = 2;
                break;
            
            case 12:
                dx = 0;
                dy = 2;
                break;
            
            case 13:
                dx = 1;
                dy = 2;
                break;
            
            case 14:
                dx = 2;
                dy = 2;
                break;
            
            case 15:
                dx = 2;
                dy = 1;
                break;
        }
        
        dx *= 32;
        dy *= 32;
        player_highleap_reset_components();
        
        if (dx != 0)
            player_highleap_add_component(1, dx, 0, time, 0);
        
        if (dy != 0)
            player_highleap_add_component(0, dy, 0, time, 0);
        
        highleap_leapdgx = round(dx / 32);
        highleap_leapdgy = round(dy / 32);
        highleap_nleapdgx = highleap_leapdgx;
        highleap_nleapdgy = highleap_leapdgy;
        voice_contextual_play_jump();
    }
    
    var t = min(1, timer / time);
    var zz = 0;
    
    if (trange(timer, timer - 1, 0, 14))
        zz = ease_out_sine(0, 39, global.timer_slider);
    
    if (trange(timer, timer - 1, 14, time - 20))
        zz = 39;
    
    if (trange(timer, timer - 1, time - 20, time))
        zz = ease_in_sine(39, 0, global.timer_slider);
    
    zz += (impact_jump ? lengthdir_y(-28, t * 180) : lengthdir_y(-14, t * 180));
    z = lerp(z, zz, lerp(1, 0.5, min(1, timer / 10)));
    
    if (impact_jump || noir_impact_now)
        invincible_frames = max(invincible_frames, (time - timer) + 4);
    else
        invincible_jump_frames = max(invincible_jump_frames, time - timer);
    
    if (timer >= 1 && timer <= (impact_jump ? 24 : 32))
    {
        for (var i = 0; i < 4; i++)
        {
            if (input.pressed(i) || buffered_dir_press[i])
            {
                player_highleap_turn(i);
                buffered_dir_press[i] = false;
            }
        }
    }
    
    global.player_power_slow_gravity = max(global.player_power_slow_gravity, 2);
    player_highleap_execute_components(timer);
    
    if (!impact_jump)
        player_try_leap(1);
    
    stage_object_face_direction(point_direction(0, 0, highleap_nleapdgx, highleap_nleapdgy) + (base_down_dir * 90), floor(x / 32), floor(y / 32));
    player_execute_buffered_movement();
    player_highleap_predict_finish(timer, time);
    player_reveal_hidden_tiles();
    leap_direction = (360 + (round(point_direction(0, 0, disapproach(highleap_nleapdgx, 0, 1), disapproach(highleap_nleapdgy, 0, 1)) / 45) * 45) + (base_down_dir * 90)) % 360;
    
    // ARCHIPELAGO: check impact for noir
    if (!impact_jump && noir_trail && !noir_impact_now && input.pressed(17) && AP_has_noir_attack(2))
    {
        audi_play_at(snd_noir_heel1, display_x, display_y, display_z);
        noir_impact_now = true;
        ani3d_skeleton_play_animation_next(skeleton, "heelslam");
        invincible_frames = max(4, invincible_frames);
    }
    
    if (t >= 1)
    {
        z = 0;
        conveyor_ignore_until_frame = max(conveyor_ignore_until_frame, global.game_frame + 4);
        out_vector_mul = 0.16;
        
        if (my_floor.type == UnknownEnum.Value_28)
        {
            x = (floor(x / 32) * 32) + 16;
            y = (floor(y / 32) * 32) + 16;
        }
        else if (my_floor.type == UnknownEnum.Value_14)
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
        
        if (gx != leap_gx || gy != leap_gy)
        {
            player_stand_on_tile(gx, gy, true);
            player_trail_snap_to_current(!impact_jump);
            player_trail_mark_lite(gx, gy);
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
        else if (noir_impact_now)
        {
            ani3d_skeleton_play_animation_next(skeleton, "heelslam_land", 0);
            player_buffer_next_animation("stand", "land", 60);
            state = player_state_impact_land;
            timer = 0;
            time = 0;
            noir_heelslam_fx();
            game_player_power_decrease(UnknownEnum.Value_4, 2.5);
            
            with (obj_hud)
                fun_power_down_light();
        }
        else
        {
            audi_play_at(snd_jump_land, display_x, display_y, display_z);
            instance_create_lay((floor(x / 32) * 32) + 16, (floor(y / 32) * 32) + 16, 15, obj_player_jump_land_effect);
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
        
        if (noir_impact_now)
            noir_heelslam();
    }
}

function player_highleap_interruption()
{
    z = 0;
    audi_play_at(snd_jump_land, display_x, display_y, display_z);
    instance_create_lay((floor(x / 32) * 32) + 16, (floor(y / 32) * 32) + 16, 15, obj_player_jump_land_effect);
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

function noir_heelslam_fx()
{
    audi_play_at(snd_noir_heel2, display_x, display_y, display_z);
    var cent = stage_get_middle_position(gx, gy);
    var o = instance_create_lay((gx * 32) + 16, (gy * 32) + 16, 15, obj_player_impact_effect);
    o.heelslam = true;
    o.smash_model = global.shockwave_model_splash[irandom_range(0, array_length(global.shockwave_model_splash) - 1)];
    screenshake(60, 4, ease_out_cubic, 4, normalize_array(add_vector_array(scale_vector_array(global.cam_up, -0.5), mv(out_vector))));
    var a = get_screenspace_coords(cent[0], cent[1], cent[2]);
    cpart_create_blendsetter(30, 1);
    
    repeat (16)
        cpart_create_lightscreentrail_red(a[0], a[1], random(360));
    
    cpart_create_blendsetter(30, 0);
}

function noir_heelslam()
{
    invincible_hidden_frames = max(invincible_hidden_frames, 2);
    var taken_map = ds_map_create();
    noir_heelslam_affect(gx, gy);
    ds_map_set(taken_map, gx + (gy * 1000), true);
    
    for (var i = 0; i < 4; i++)
    {
        var d = stage_grid_step([gx, gy], i);
        
        if (d[0] < 0 || d[2] < 0)
            continue;
        
        if (!ds_map_exists(taken_map, d[0] + (d[1] * 1000)))
        {
            noir_heelslam_affect(d[0], d[1]);
            ds_map_set(taken_map, d[0] + (d[1] * 1000), true);
        }
        
        var d2 = stage_grid_step(d, (d[2] + 1) % 4);
        
        if (d2[0] >= 0 && d2[2] >= 0 && !ds_map_exists(taken_map, d2[0] + (d2[1] * 1000)))
        {
            noir_heelslam_affect(d2[0], d2[1]);
            ds_map_set(taken_map, d2[0] + (d2[1] * 1000), true);
        }
        
        d2 = stage_grid_step(d, (d[2] + 3) % 4);
        
        if (d2[0] >= 0 && d2[2] >= 0 && !ds_map_exists(taken_map, d2[0] + (d2[1] * 1000)))
        {
            noir_heelslam_affect(d2[0], d2[1]);
            ds_map_set(taken_map, d2[0] + (d2[1] * 1000), true);
        }
    }
    
    ds_map_destroy(taken_map);
}

function noir_heelslam_affect(arg0, arg1)
{
    floor_scoring_mark(arg0, arg1, true, false, true);
    var o = instance_create_lay(arg0 * 32, arg1 * 32, 15, obj_impact_linger);
    o.gx = arg0;
    o.gy = arg1;
}

enum UnknownEnum
{
    Value_0,
    Value_2 = 2,
    Value_4 = 4,
    Value_10 = 10,
    Value_14 = 14,
    Value_18 = 18,
    Value_20 = 20,
    Value_28 = 28,
    Value_34 = 34
}
