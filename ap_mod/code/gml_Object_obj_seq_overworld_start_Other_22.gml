if (teqs(1))
{
    if (!instance_exists(obj_control) || !instance_exists(obj_overworld_new_level_marker))
        show_error("fatal error in obj_seq_overworld_start ev user 12 - report to developer please, thank you", true);
    
    for (var i = 0; i < 3; i++)
    {
        nlr_camera_from[0][i] = obj_control.gcamera_from[i];
        nlr_camera_to[0][i] = obj_control.gcamera_to[i];
        nlr_camera_up[0][i] = obj_control.gcamera_up[i];
        nlr_camera_from[1][i] = obj_overworld_new_level_marker.out_vector[i];
        nlr_camera_to[1][i] = obj_overworld_new_level_marker.display_pos[i];
        nlr_camera_up[1][i] = -obj_overworld_new_level_marker.up_vector[i];
    }
    
    vec3l_scale(nlr_camera_from[1], 832);
    vec3l_lerp(nlr_camera_to[1], nlr_camera_to[0], 0.25);
    vec3l_add(nlr_camera_from[1], nlr_camera_to[1]);
    nlr_camera_lookat[0] = normalize_array(vector_subtract(nlr_camera_to[0], nlr_camera_from[0]));
    nlr_camera_lookat[1] = normalize_array(vector_subtract(nlr_camera_to[1], nlr_camera_from[1]));
    var dotpro = dot_product_array(nlr_camera_up[0], nlr_camera_up[1]);
    var flighttime = 60;
    var delaytime = 84;
    
    if (dotpro < -0.3)
    {
        nlr_away_distance = 920;
        flighttime = 150;
        delaytime = 80;
    }
    else if (dotpro > 0.6)
    {
        nlr_away_distance = 16;
        flighttime = 60;
        delaytime = 80;
    }
    else
    {
        nlr_away_distance = 240;
        flighttime = 100;
        delaytime = 80;
    }
    
    nlr_time_lerp00 = 4;
    nlr_time_lerp01 = 4 + flighttime;
    nlr_time_lerp10 = 4 + flighttime + delaytime;
    nlr_time_lerp11 = 4 + flighttime + delaytime + (flighttime * 0.8);
    
    // ARCHIPELAGO: actually pan to finale
    if (global.overworld_cleared >= 9 && !AP_is_multiworld_active())
    {
        for (var i = 0; i < 3; i++)
        {
            nlr_camera_from[1][i] = lerp(nlr_camera_from[0][i], nlr_camera_from[1][i], 0.05);
            nlr_camera_to[1][i] = lerp(nlr_camera_to[0][i], nlr_camera_to[1][i], 0.05);
            nlr_camera_lookat[1][i] = nlr_camera_to[1][i] - nlr_camera_from[1][i];
            nlr_camera_up[1][i] = nlr_camera_up[0][i];
        }
        
        vec3l_normalize(nlr_camera_lookat[1]);
    }
}

if (trange(timer, ptimer, nlr_time_lerp00, nlr_time_lerp01))
{
    obj_control.gcamera_mode = UnknownEnum.Value_m1;
    var t = ease_inout_sine(0, 1, global.timer_slider);
    obj_control.gcamera_from = lerp3d(nlr_camera_from[0], nlr_camera_from[1], t);
    obj_control.gcamera_to = slerp_safe(nlr_camera_lookat[0], nlr_camera_lookat[1], t);
    vec3l_add(obj_control.gcamera_to, obj_control.gcamera_from);
    vec3l_scalaradd(obj_control.gcamera_from, lengthdir_y(nlr_away_distance, t * 180), normalize_array(vector_subtract(obj_control.gcamera_to, obj_control.gcamera_from)));
    obj_control.gcamera_up = slerp_safe(nlr_camera_up[0], nlr_camera_up[1], t);
    array_copy(obj_control.pgcamera_from, 0, obj_control.gcamera_from, 0, 3);
    array_copy(obj_control.pgcamera_to, 0, obj_control.gcamera_to, 0, 3);
    array_copy(obj_control.pgcamera_up, 0, obj_control.gcamera_up, 0, 3);
}

if (teqs(nlr_time_lerp01 - 6))
    container_play("cnt_overworld_reveal_start");

if (teqs(nlr_time_lerp01 + 6))
{
    var gx = 0;
    var gy = 0;
    var w1 = ds_grid_width(global.stage_grid) - 1;
    var h1 = ds_grid_height(global.stage_grid) - 1;
    
    for (var xx = 1; xx < w1; xx++)
    {
        for (var yy = 1; yy < h1; yy++)
        {
            var f = ds_grid_get(global.stage_grid, xx, yy);
            
            if (is_struct(f))
            {
                if (f.type == UnknownEnum.Value_129 && f.zone == 1)
                {
                    gx = xx;
                    gy = yy;
                    break;
                }
            }
        }
        
        if (gx > 0)
            break;
    }
    
    if (gx == 0)
    {
        gx = global.player_gx;
        gy = global.player_gy;
    }
    
    var o = instance_create_lay((gx * 32) + 16, (gy * 32) + 16, 300, obj_flood_paint);
    
    with (o)
    {
        flood_paint_action = flood_paint_overworld_reveal;
        radius_left = 9999;
        time = (global.fdelta > 1) ? 1 : 3;
    }
    
    return o;
}

if (trange(timer, ptimer, nlr_time_lerp10, nlr_time_lerp11))
{
    var t = ease_inout_sine(0, 1, global.timer_slider);
    
    with (obj_overworld_decor_display)
        alpha[1] = ease_out_cubic(0, 1, global.timer_slider);
    
    obj_control.gcamera_from = lerp3d(nlr_camera_from[1], nlr_camera_from[0], t);
    obj_control.gcamera_to = slerp_safe(nlr_camera_lookat[1], nlr_camera_lookat[0], t);
    vec3l_add(obj_control.gcamera_to, obj_control.gcamera_from);
    vec3l_scalaradd(obj_control.gcamera_from, lengthdir_y(nlr_away_distance, t * 180), normalize_array(vector_subtract(obj_control.gcamera_to, obj_control.gcamera_from)));
    obj_control.gcamera_up = slerp_safe(nlr_camera_up[1], nlr_camera_up[0], t);
    array_copy(obj_control.pgcamera_from, 0, obj_control.gcamera_from, 0, 3);
    array_copy(obj_control.pgcamera_to, 0, obj_control.gcamera_to, 0, 3);
    array_copy(obj_control.pgcamera_up, 0, obj_control.gcamera_up, 0, 3);
}

if (timer >= (nlr_time_lerp11 + 10))
{
    with (obj_overworld_decor_display)
        alpha[1] = 1;
    
    savedata_autosave();
    global.zone_movement[1].type = UnknownEnum.Value_0;
    global.zone_matrix[1] = matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1);
    obj_control.gcamera_mode = UnknownEnum.Value_0;
    global.gstate = UnknownEnum.Value_1;
    global.overworld_just_cleared = 0;
    event_user(5);
    instance_destroy();
}

enum UnknownEnum
{
    Value_m1 = -1,
    Value_0,
    Value_1,
    Value_129 = 129
}
