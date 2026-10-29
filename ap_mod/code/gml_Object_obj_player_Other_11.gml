var df = global.fdelta;
gear = input.held(6) ? 1 : ((movement_distance_passed >= 24) ? 2 : 1);

if (input.pressed(0))
{
    priority_dir = 0;
    priority_held = 0;
}

if (input.pressed(1))
{
    priority_dir = 1;
    priority_held = 0;
}

if (input.pressed(2))
{
    priority_dir = 2;
    priority_held = 0;
}

if (input.pressed(3))
{
    priority_dir = 3;
    priority_held = 0;
}

if (input.held(priority_dir))
    priority_held++;
else
    priority_held = 0;

var releases = 0;
var helds = 0;

for (var i = 0; i < 4; i++)
{
    if (input.held(i))
        helds++;
    
    if (input.released(i))
        releases++;
}

if (helds == 0 && releases > 0 && (state == player_state_main || state == player_state_leap))
    refresh_movement_vector = max(refresh_movement_vector, 3);

if (hitlag > 0)
{
    if (jump_secondary_input)
    {
        if (input.pressed(8))
            buffered_dir_press[1] = true;
        
        if (input.pressed(7))
            buffered_dir_press[0] = true;
        
        if (input.pressed(10))
            buffered_dir_press[3] = true;
        
        if (input.pressed(9))
            buffered_dir_press[2] = true;
    }
    else
    {
        if (input.pressed(1))
            buffered_dir_press[1] = true;
        
        if (input.pressed(0))
            buffered_dir_press[0] = true;
        
        if (input.pressed(3))
            buffered_dir_press[3] = true;
        
        if (input.pressed(2))
            buffered_dir_press[2] = true;
    }
    
    hitlag = max(hitlag - df, 0);
    exit;
}

global.walkable_threshold = 0.2;
invincible_frames = max(invincible_frames - df, 0);
invincible_hidden_frames = max(invincible_hidden_frames - df, 0);
invincible_jump_frames = max(invincible_jump_frames - df, 0);
can_use_items = false;
grid_ground_mode = false;
ptimer = timer;
timer += df;

if (is_method(state))
    state();
else if (state > 0)
    script_execute(state);

if (!rightstick_enabled || global.camera_tilt_lock || state != player_state_main)
{
    rightstick_digital = true;
    rightstick_x *= 0.25;
    rightstick_y *= 0.25;
    rightstick_last_use = -1;
    rightstick_zero = 0;
}
else
{
    var cx = input.get_camera_xaxis();
    var cy = input.get_camera_yaxis();
    var cd = point_distance(0, 0, cx, cy);
    
    if (cd > 0.2)
    {
        if (abs(cx) > 1 || abs(cy) > 1)
            rightstick_digital = true;
        else
            rightstick_digital = false;
        
        if (rightstick_digital)
        {
            if (cx != 0)
                rightstick_x = lerp(rightstick_x, cx, 0.4);
            
            if (cy != 0)
                rightstick_y = lerp(rightstick_y, cy, 0.4);
        }
        else
        {
            rightstick_x = cx;
            rightstick_y = cy;
        }
        
        cd = point_distance(0, 0, rightstick_x, rightstick_y);
        var ca = point_direction(0, 0, rightstick_x, rightstick_y) + (base_down_dir * 90);
        
        if (cd > (rightstick_digital ? 0.98 : 0.9))
        {
            if (rightstick_last_use < (global.game_frame - 12) && global.splayer_item[player] != UnknownEnum.Value_0 && can_use_items)
            {
                rightstick_last_use = global.game_frame;
                stick_direction_lock = 20;
            }
        }
        
        if (cd > 0.5)
        {
            if (rightstick_last_use == global.game_frame || (!input.held(0) && !input.held(1) && !input.held(2) && !input.held(3)))
            {
                cx = lengthdir_x(1, ca);
                cy = lengthdir_y(1, ca);
                
                if (grid_on)
                {
                    var u = stage_get_up_vector(gx, gy);
                    var r = stage_get_right_vector(gx, gy);
                    forward_vector[0] = (cx * r[0]) - (cy * u[0]);
                    forward_vector[1] = (cx * r[1]) - (cy * u[1]);
                    forward_vector[2] = (cx * r[2]) - (cy * u[2]);
                    
                    for (var i = 0; i < 3; i++)
                    {
                        _forward_vector[i] = forward_vector[i];
                        nforward_vector[i] = forward_vector[i];
                    }
                    
                    player_match_groundleap_dxdy_to_forward();
                }
                
                stick_direction_x = cx;
                stick_direction_y = cy;
            }
        }
        
        if (rightstick_last_use == global.game_frame)
        {
            if (can_use_items)
            {
                if (global.splayer_item[player] != UnknownEnum.Value_0)
                {
                    ds_map_find_value(global.item_use_method, global.splayer_item[player])(player);
                    jump_secondary_input = true;
                }
            }
        }
    }
    else
    {
        if (rightstick_digital && (rightstick_x != 0 || rightstick_y != 0) && rightstick_last_use < 0)
        {
            if (can_use_items)
            {
                if (global.splayer_item[player] != UnknownEnum.Value_0)
                {
                    var ca = point_direction(0, 0, rightstick_x, rightstick_y) + (base_down_dir * 90);
                    cx = lengthdir_x(1, ca);
                    cy = lengthdir_y(1, ca);
                    
                    if (grid_on)
                    {
                        var u = stage_get_up_vector(gx, gy);
                        var r = stage_get_right_vector(gx, gy);
                        forward_vector[0] = (cx * r[0]) - (cy * u[0]);
                        forward_vector[1] = (cx * r[1]) - (cy * u[1]);
                        forward_vector[2] = (cx * r[2]) - (cy * u[2]);
                        
                        for (var i = 0; i < 3; i++)
                        {
                            _forward_vector[i] = forward_vector[i];
                            nforward_vector[i] = forward_vector[i];
                        }
                        
                        player_match_groundleap_dxdy_to_forward();
                    }
                    
                    stick_direction_x = cx;
                    stick_direction_y = cy;
                    rightstick_last_use = global.game_frame;
                    stick_direction_lock = 20;
                    ds_map_find_value(global.item_use_method, global.splayer_item[player])(player);
                    jump_secondary_input = true;
                }
            }
        }
        
        rightstick_x = 0;
        rightstick_y = 0;
        rightstick_last_use = -1;
    }
}

if (stick_direction_lock > 0)
{
    if (!input.held(12))
    {
        var cx = stick_direction_x;
        var cy = stick_direction_y;
        var u = stage_get_up_vector(gx, gy);
        var r = stage_get_right_vector(gx, gy);
        forward_vector[0] = (cx * r[0]) - (cy * u[0]);
        forward_vector[1] = (cx * r[1]) - (cy * u[1]);
        forward_vector[2] = (cx * r[2]) - (cy * u[2]);
        stick_direction_lock--;
    }
    else
    {
        stick_direction_lock = 0;
    }
}

if (can_use_items)
{
    if (global.splayer_item[player] != UnknownEnum.Value_0)
    {
        if (input.pressed(12) || (input.held(12) && global.splayer_item[player] == UnknownEnum.Value_9 && global.game_frame >= (wrap_paper_last + 10) && (gx != wrap_paper_gx || gy != wrap_paper_gy)))
            ds_map_find_value(global.item_use_method, global.splayer_item[player])(player);
    }
    
    // ARCHIPELAGO: check ground/basic fireball for noir
    if (noir_trail)
    {
        if (input.held(6) && AP_has_noir_attack(1))
        {
            if (input.pressed(17) || (input.held(17) && global.game_frame >= (wrap_paper_last + 10) && (gx != wrap_paper_gx || gy != wrap_paper_gy)))
                emit_wrap_paper(player, true);
        }
        else if (input.pressed(17) && AP_has_noir_attack(0))
        {
            emit_paint_balloon(player, true);
        }
    }
}

if (grid_on)
{
    if (my_floor.is_ledge || my_floor.type == UnknownEnum.Value_14 || (my_floor.type >= UnknownEnum.Value_31 && my_floor.type <= UnknownEnum.Value_33))
        global.player_power_forbid_gravity = max(global.player_power_forbid_gravity, 3);
    
    if (my_floor.type == UnknownEnum.Value_6)
        global.player_power_slow_gravity = max(global.player_power_slow_gravity, 3);
}
else
{
    global.player_power_forbid_gravity = max(global.player_power_forbid_gravity, 3);
}

last_grid_movement_countdown = max(last_grid_movement_countdown - 1, 0);

if (gx != pgx || gy != pgy)
{
    if (global.gstate == UnknownEnum.Value_4 || global.gstate == UnknownEnum.Value_1)
        stage_crack_fragile_floor(ground_gx, ground_gy);
    
    var pf = ds_grid_get(global.stage_grid, pgx, pgy);
    var f = ds_grid_get(global.stage_grid, gx, gy);
    
    if (is_struct(f))
    {
        switch (f.type)
        {
            case UnknownEnum.Value_100:
                if (global.gcamera_type == UnknownEnum.Value_3)
                    obj_control.gcamera_switch_speed = 1;
                else
                    obj_control.gcamera_switch_speed = 0.03;
                
                global.gcamera_type = UnknownEnum.Value_2;
                break;
            
            case UnknownEnum.Value_101:
                if (global.gcamera_type == UnknownEnum.Value_2)
                    obj_control.gcamera_switch_speed = 1;
                else
                    obj_control.gcamera_switch_speed = 0.03;
                
                global.gcamera_type = UnknownEnum.Value_3;
                break;
            
            case UnknownEnum.Value_102:
                obj_control.gcamera_switch_speed = 0.03;
                global.gcamera_type = UnknownEnum.Value_4;
                break;
        }
        
        if (is_struct(pf))
        {
            if (!cubea_is_floor_safe(f) && cubea_is_floor_safe(pf))
            {
                safe_gx = pgx;
                safe_gy = pgy;
                safe_camera_capture = gcamera_capture_properties_update(safe_camera_capture);
            }
            
            if (cubea_is_floor_safe(f) && !cubea_is_floor_safe(pf))
            {
                safe_gx = gx;
                safe_gy = gy;
                safe_camera_capture = gcamera_capture_properties_update(safe_camera_capture);
            }
        }
    }
    
    if (state == player_state_main && f.type == UnknownEnum.Value_24)
    {
        container_play("cnt_sticky_step");
        
        if (!instance_exists(obj_sticky_draw))
            instance_create_lay(0, 0, 6, obj_sticky_draw);
        
        create_sticky_effect(gx, gy);
    }
    
    var angle_lerpfactor = stage_get_angle_lerpfactor(pgx, pgy, gx, gy);
    
    if (angle_lerpfactor > 0.9 && !(global.current_stage == "overworld"))
    {
        if (state != somove_state_freefall && state != player_state_shiftpad && z <= 1 && !teleport_last_ignore_next)
        {
            if (last_turn_slowdown < (global.game_frame - 4))
            {
                slowdown_turn();
                last_turn_slowdown = global.game_frame;
            }
        }
    }
    
    if (dot_product_array(stage_get_out_vector(pgx, pgy), stage_get_out_vector(gx, gy)) < 0.8)
    {
        if (angle_lerpfactor > 0.5)
            out_vector_mul = (z > 1) ? 0.05 : 0.16;
        else
            out_vector_mul = (z > 1) ? 0.18 : 0.16;
    }
    
    if (global.splayer_item[player] == UnknownEnum.Value_9)
    {
        if (rightstick_last_use > (global.game_frame - 7))
            rightstick_last_use = global.game_frame - 7;
    }
    
    lgx = pgx;
    lgy = pgy;
    var d = stage_get_dir_from_forward_vector(gx, gy, forward_vector);
    tile_enter_x = x - (global.dir_to_dx[d] * 8);
    tile_enter_y = y - (global.dir_to_dy[d] * 8);
    hotfloor_gx = -1;
    hotfloor_gy = -1;
    conveyor_ignore_until_step_away = false;
    global.player_gx = gx;
    global.player_gy = gy;
    last_grid_movement_countdown = 8;
    
    if (teleport_last_ignore_next)
    {
        teleport_last_ignore_next = false;
    }
    else
    {
        teleport_last_gx = -1;
        teleport_last_gy = -1;
    }
    
    colli_register_player(false);
    player_call_enemies_to_cast_rays();
}

if (z < 1)
{
    if (gx != ground_gx || gy != ground_gy)
    {
        ground_gx = gx;
        ground_gy = gy;
    }
}

global.walkable_threshold = 1;

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_6 = 6,
    Value_9 = 9,
    Value_14 = 14,
    Value_24 = 24,
    Value_31 = 31,
    Value_33 = 33,
    Value_100 = 100,
    Value_101,
    Value_102
}
