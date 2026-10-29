function player_get_walk_speed()
{
    if (global.player_speed >= 2 && !input.held(6))
        return ds_map_find_value(global.player_movement_speed, UnknownEnum.Value_3);
    else if (global.player_speed >= 1 && !input.held(6))
        return ds_map_find_value(global.player_movement_speed, UnknownEnum.Value_2);
    else
        return ds_map_find_value(global.player_movement_speed, UnknownEnum.Value_1);
    
    return 1;
}

function player_update_modified_walk_speed(arg0)
{
    var base = player_get_walk_speed();
    var slow = 1;
    
    if (my_floor.type == UnknownEnum.Value_24)
        slow = 0.6 + (global.player_speed * 0.1);
    
    var speed_scalar;
    
    if (input.held(6))
    {
        movement_revving_up = 1;
        speed_scalar = lerp(0.25, 1, arg0 * 0.5);
        movement_speed = base * slow * speed_scalar;
    }
    else
    {
        speed_scalar = lerp(0.25, 1, arg0);
        
        if (movement_revving_up < 1)
            speed_scalar *= lerp(0.25, 1, movement_revving_up);
        
        movement_revving_up = min(movement_revving_up + (((my_floor.type == UnknownEnum.Value_11) ? 0.1 : 0.145) * global.fdelta), 1);
        movement_speed = base * slow * speed_scalar;
        var skid_point = 1.8;
        
        if (skid >= 0 && movement_speed >= skid_point)
        {
            var real_skid = 0;
            var skid_time = (global.fdelta > 1) ? 0.15 : 0.33;
            
            if (trange(skid, skid, 0, skid_time))
                real_skid = ease_inout_sine(0, 1, global.timer_slider);
            
            if (trange(skid, skid, skid_time, 1))
                real_skid = ease_inout_sine(1, 0, global.timer_slider);
            
            movement_speed = lerp(movement_speed, lerp(movement_speed, skid_point, (global.fdelta > 1) ? 0.66 : 0.5), real_skid);
        }
    }
    
    movement_slow = slow;
    movement_speed_scalar = speed_scalar;
}

function player_get_modified_walk_speed()
{
    return movement_speed;
}

function player_reset_movement_track()
{
    movement_track[0] = 0;
    movement_track[1] = 0;
    movement_last_skid_gx = 0;
    movement_last_skid_gy = 0;
    skid = -1;
}

function player_update_movement_track(arg0, arg1)
{
    var m = movement_track;
    
    if (skid >= 0)
    {
        skid += ((global.fdelta > 1) ? 0.125 : 0.07142857142857142);
        
        if (skid >= 1)
            skid = -1;
    }
    
    var cd = point_distance(0, 0, arg0, arg1);
    
    if (cd > 0)
    {
        var dd = point_direction(0, 0, arg0, arg1);
        arg0 = lengthdir_x(1, dd);
        arg1 = lengthdir_y(1, dd);
        movement_track_timeout = 3;
        
        if (m[0] == 0 && m[1] == 0)
        {
            m[0] = arg0;
            m[1] = arg1;
        }
        else
        {
            var dotpro = dot_product(m[0], m[1], arg0, arg1);
            
            if (dotpro < -0.1)
            {
                m[0] = arg0;
                m[1] = arg1;
            }
            else
            {
                if (dotpro < 0.64)
                {
                    if (movement_last_skid_gx != gx || movement_last_skid_gy != gy)
                    {
                        skid = 0;
                        movement_last_skid_gx = gx;
                        movement_last_skid_gy = gy;
                    }
                }
                
                var sc = (global.fdelta > 1) ? 0.36 : 0.2;
                m[0] = lerp(m[0], arg0, sc);
                m[1] = lerp(m[1], arg1, sc);
                cd = point_distance(0, 0, m[0], m[1]);
                dd = point_direction(0, 0, m[0], m[1]);
                m[0] = lengthdir_x(1, dd);
                m[1] = lengthdir_y(1, dd);
            }
        }
    }
    else if (movement_track_timeout <= 0)
    {
        m[0] = 0;
        m[1] = 0;
    }
    else
    {
        movement_track_timeout -= global.fdelta;
    }
}

function player_get_distance_to_border(arg0)
{
    var dd = (arg0 + 4 + base_down_dir) % 4;
    
    switch (dd)
    {
        case 0:
            return ((floor(y / 32) * 32) + 32) - y;
        
        case 1:
            return ((floor(x / 32) * 32) + 32) - x;
        
        case 2:
            return y - (floor(y / 32) * 32);
        
        case 3:
            return x - (floor(x / 32) * 32);
    }
    
    return 16;
}

function player_walking_routine_stiff(arg0, arg1, arg2, arg3, arg4, arg5)
{
    ground_dx = 0;
    ground_dy = 0;
    
    if (arg3 > 0.35 && snappymove_hori_left == 0 && snappymove_vert_left == 0)
    {
        var dd = round(point_direction(0, 0, arg1 + (global.dir_to_dx[priority_dir] * 0.1), arg2 + (global.dir_to_dy[priority_dir] * 0.1)) / 90) % 4;
        
        switch (dd)
        {
            case 0:
                if (somove_get_accessible_dir(1))
                    snappymove_hori_left = player_get_distance_to_border(1) + 16;
                
                break;
            
            case 1:
                if (somove_get_accessible_dir(2))
                    snappymove_vert_left = -player_get_distance_to_border(2) - 16;
                
                break;
            
            case 2:
                if (somove_get_accessible_dir(3))
                    snappymove_hori_left = -player_get_distance_to_border(3) - 16;
                
                break;
            
            case 3:
                if (somove_get_accessible_dir(0))
                    snappymove_vert_left = player_get_distance_to_border(0) + 16;
                
                break;
        }
    }
    
    if (snappymove_hori_left != 0 || snappymove_vert_left != 0)
    {
        arg1 = sign(snappymove_hori_left);
        arg2 = sign(snappymove_vert_left);
        arg3 = point_distance(0, 0, arg1, arg2);
        arg1 /= arg3;
        arg2 /= arg3;
        ground_dx = arg1;
        ground_dy = arg2;
        arg3 = clamp((arg3 - 0.35) / 0.20000000000000007, 0, 1);
        player_core_walking(arg1, arg2, arg3, arg0);
    }
}

function player_walking_routine_snappy(arg0, arg1, arg2, arg3, arg4, arg5)
{
    ground_dx = 0;
    ground_dy = 0;
    
    if (arg3 > 0.35 || snappymove_hori_left != 0 || snappymove_vert_left != 0)
    {
        if (snappymove_vert_left == 0)
        {
            if (!snappymove_vert_pressed)
            {
                if (arg5 > 0 && dir_held[0] >= max_dir_held)
                {
                    var dis = player_get_distance_to_border(0);
                    
                    if (dis <= 16)
                        snappymove_vert_left = dis + 3;
                    
                    snappymove_vert_pressed = true;
                }
                
                if (arg5 < 0 && dir_held[2] >= max_dir_held)
                {
                    var dis = player_get_distance_to_border(2);
                    
                    if (dis <= 16)
                        snappymove_vert_left = -dis - 3;
                    
                    snappymove_vert_pressed = true;
                }
            }
            else if (arg5 == 0)
            {
                snappymove_vert_pressed = false;
            }
        }
        else if (arg5 == 0)
        {
            snappymove_vert_pressed = false;
        }
        
        if (snappymove_hori_left == 0)
        {
            if (!snappymove_hori_pressed)
            {
                if (arg4 > 0 && dir_held[1] >= max_dir_held)
                {
                    var dis = player_get_distance_to_border(1);
                    
                    if (dis <= 16)
                        snappymove_hori_left = dis + 3;
                    
                    snappymove_hori_pressed = true;
                }
                
                if (arg4 < 0 && dir_held[3] >= max_dir_held)
                {
                    var dis = player_get_distance_to_border(3);
                    
                    if (dis <= 16)
                        snappymove_hori_left = -dis - 3;
                    
                    snappymove_hori_pressed = true;
                }
            }
            else if (arg4 == 0)
            {
                snappymove_hori_pressed = false;
            }
        }
        else if (arg4 == 0)
        {
            snappymove_hori_pressed = false;
        }
        
        if (snappymove_hori_left != 0)
        {
            if (sign(arg4) == -sign(snappymove_hori_left))
                snappymove_hori_left = 0;
            
            if (arg1 == 0)
                arg1 = sign(snappymove_hori_left);
        }
        
        if (snappymove_vert_left != 0)
        {
            if (sign(arg5) == -sign(snappymove_vert_left))
                snappymove_vert_left = 0;
            
            if (arg2 == 0)
                arg2 = sign(snappymove_vert_left);
        }
        
        arg3 = point_distance(0, 0, arg1, arg2);
        arg1 /= arg3;
        arg2 /= arg3;
        ground_dx = arg1;
        ground_dy = arg2;
        arg3 = clamp((arg3 - 0.35) / 0.20000000000000007, 0, 1);
        player_core_walking(arg1, arg2, arg3, arg0);
    }
    else
    {
        snappymove_vert_pressed = false;
        snappymove_hori_pressed = false;
        buffered_turn_countdown = 0;
        var t = 3 + (17 * (movement_distance_passed >= 18));
        
        if (abs(x - (floor(x / 32) * 32) - 16) < t && abs(y - (floor(y / 32) * 32) - 16) < t)
            player_buffer_snap_to_grid_center_timed(6);
        
        movement_distance_passed = 0;
        movement_revving_up = max(movement_revving_up - (0.25 * global.fdelta), 0);
    }
    
    player_execute_buffered_movement();
}

function player_walking_routine_standard(arg0, arg1, arg2, arg3, arg4, arg5)
{
    ground_dx = 0;
    ground_dy = 0;
    snappymove_hori_left = 0;
    snappymove_vert_left = 0;
    snappymove_hori_pressed = false;
    snappymove_vert_pressed = false;
    
    if (arg3 > 0.35)
    {
        if (state == player_state_highleap)
        {
            var mm = max(abs(arg1), abs(arg2));
            arg1 /= mm;
            arg2 /= mm;
            arg3 = point_distance(0, 0, arg1, arg2);
        }
        
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
            buffered_turn_countdown--;
            
            if (hds <= 1)
            {
                arg1 += global.dir_to_dx[buffered_turn_dir];
                arg2 += global.dir_to_dy[buffered_turn_dir];
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
        
        ground_dx = arg1;
        ground_dy = arg2;
        arg3 = clamp((arg3 - 0.35) / 0.20000000000000007, 0, 1);
        player_core_walking(arg1, arg2, arg3, arg0);
    }
    else
    {
        buffered_turn_countdown = 0;
        var t = 3 + (17 * (movement_distance_passed >= 24));
        
        if (abs(x - (floor(x / 32) * 32) - 16) < t && abs(y - (floor(y / 32) * 32) - 16) < t)
            player_buffer_snap_to_grid_center_timed(6);
        
        movement_distance_passed = 0;
        movement_revving_up = max(movement_revving_up - (0.25 * global.fdelta), 0);
    }
    
    player_execute_buffered_movement();
}

function player_core_walking(arg0, arg1, arg2, arg3)
{
    player_update_modified_walk_speed(arg2);
    player_movement_magnet(arg0, arg1);
    
    if (global.player_speed >= 2 && arg2 >= 0.9 && !input.held(6))
    {
        if (!arg3)
        {
            if (movement_slow < 1)
                ani3d_skeleton_play_animation_next(skeleton, "ice_skate");
            else if (movement_speed_scalar <= 0.5)
                ani3d_skeleton_play_animation_next(skeleton, "walk");
            else
                ani3d_skeleton_play_animation_next(skeleton, "run");
        }
    }
    else if (global.player_speed >= 1 && arg2 >= 0.75 && !input.held(6))
    {
        if (!arg3)
        {
            if (movement_slow < 1)
                ani3d_skeleton_play_animation_next(skeleton, "ice_skate");
            else if (movement_speed_scalar <= 0.5)
                ani3d_skeleton_play_animation_next(skeleton, "walk");
            else
                ani3d_skeleton_play_animation_next(skeleton, "jog");
        }
    }
    else if (!arg3)
    {
        if (movement_slow < 1)
            ani3d_skeleton_play_animation_next(skeleton, "ice_skate");
        else
            ani3d_skeleton_play_animation_next(skeleton, "walk");
    }
    
    player_move(UnknownEnum.Value_0, point_direction(0, 0, arg0, arg1), movement_speed, true);
    
    if (global.splayer_item[player] == UnknownEnum.Value_9 && global.splayer_item_quantity[player] > 0 && !input.pressed(12) && input.held(12))
        stage_object_face_direction(forward_dir_locked + (base_down_dir * 90), floor(x / 32), floor(y / 32));
    
    // ARCHIPELAGO: check ground fireball for noir
    if (noir_trail && !input.pressed(17) && input.held(17) && input.held(6) && AP_has_noir_attack(1))
        stage_object_face_direction(forward_dir_locked + (base_down_dir * 90), floor(x / 32), floor(y / 32));
    
    player_try_leap(5);
}

function player_buffer_snap_to_grid_center(arg0)
{
    var dx = ((floor(x / 32) * 32) + 16) - x;
    var dy = ((floor(y / 32) * 32) + 16) - y;
    player_clear_snappy_movement();
    buffered_movement[0] = 0;
    buffered_movement[1] = 0;
    
    switch (base_down_dir)
    {
        case 0:
            buffered_movement[0] += dy;
            buffered_movement[1] += dx;
            break;
        
        case 1:
            buffered_movement[0] += dx;
            buffered_movement[1] -= dy;
            break;
        
        case 2:
            buffered_movement[0] -= dy;
            buffered_movement[1] -= dx;
            break;
        
        case 3:
            buffered_movement[0] -= dx;
            buffered_movement[1] += dy;
            break;
    }
    
    buffered_movement_speed[0] = arg0;
    buffered_movement_speed[1] = arg0;
}

function player_buffer_snap_to_grid_center_timed(arg0)
{
    var dx = ((floor(x / 32) * 32) + 16) - x;
    var dy = ((floor(y / 32) * 32) + 16) - y;
    player_clear_snappy_movement();
    buffered_movement[0] = 0;
    buffered_movement[1] = 0;
    
    switch (base_down_dir)
    {
        case 0:
            buffered_movement[0] += dy;
            buffered_movement[1] += dx;
            break;
        
        case 1:
            buffered_movement[0] += dx;
            buffered_movement[1] -= dy;
            break;
        
        case 2:
            buffered_movement[0] -= dy;
            buffered_movement[1] -= dx;
            break;
        
        case 3:
            buffered_movement[0] -= dx;
            buffered_movement[1] += dy;
            break;
    }
    
    buffered_movement_speed[0] = abs(buffered_movement[0]) / arg0;
    buffered_movement_speed[1] = abs(buffered_movement[1]) / arg0;
}

function player_clear_buffered_movement()
{
    buffered_movement[0] = 0;
    buffered_movement[1] = 0;
}

function player_execute_buffered_movement()
{
    if (buffered_movement[0] != 0)
    {
        var d = min(abs(buffered_movement[0]), buffered_movement_speed[0] * global.fdelta);
        
        if (buffered_movement[0] > 0)
            stage_object_move_dir(d, 0, false);
        else
            stage_object_move_dir(d, 2, false);
        
        buffered_movement[0] = approach(buffered_movement[0], 0, buffered_movement_speed[0] * global.fdelta);
    }
    
    if (buffered_movement[1] != 0)
    {
        var d = min(abs(buffered_movement[1]), buffered_movement_speed[1] * global.fdelta);
        
        if (buffered_movement[1] > 0)
            stage_object_move_dir(d, 1, false);
        else
            stage_object_move_dir(d, 3, false);
        
        buffered_movement[1] = approach(buffered_movement[1], 0, buffered_movement_speed[1] * global.fdelta);
    }
}

function player_clear_snappy_movement()
{
    snappymove_hori_left = 0;
    snappymove_vert_left = 0;
    snappymove_hori_pressed = false;
    snappymove_vert_pressed = false;
    player_reset_movement_track();
}

function player_reach_for_items()
{
    var dx = display_x;
    var dy = display_y;
    var dz = display_z;
    
    for (var i = 0; i < 4; i++)
    {
        if (input.pressed(i))
        {
            var pointy_ray = array_clone((i % 2) ? stage_get_right_vector(gx, gy) : stage_get_up_vector(gx, gy));
            
            if (i == 0 || i == 3)
                vec3l_scale(pointy_ray, -1);
            
            var p_to_it_ray = [0, 0, 0];
            
            with (obj_par_powerup)
            {
                p_to_it_ray[0] = display_x - dx;
                p_to_it_ray[1] = display_y - dy;
                p_to_it_ray[2] = display_z - dz;
                vec3l_normalize(p_to_it_ray);
                
                if (dot_product_array(pointy_ray, p_to_it_ray) > 0.7)
                    radius = 32;
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
    Value_9 = 9,
    Value_11 = 11,
    Value_24 = 24
}
