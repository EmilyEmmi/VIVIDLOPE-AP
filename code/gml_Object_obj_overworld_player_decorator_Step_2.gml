if (story_progression_has_normal_atrium())
{
    var an_1 = ds_map_find_value(global.stage_anchors, 4);
    var an_2 = ds_map_find_value(global.stage_anchors, 5);
    var d1 = point_distance_3d(global.player_x, global.player_y, global.player_z, an_1.x, an_1.y, an_1.z);
    var d2 = point_distance_3d(global.player_x, global.player_y, global.player_z, an_2.x, an_2.y, an_2.z);
    var s = 0.004166666666666667;
    
    if (snap_volume > 0)
    {
        s = 1;
        snap_volume--;
    }
    
    if (d1 > d2)
    {
        global.vividcore_prep_mode = false;
        global.music_fadeout = min(global.music_fadeout + (s * global.tdelta * 0.75), 1);
        ambience_vol = max(ambience_vol - (s * global.tdelta), 0);
    }
    else
    {
        global.vividcore_prep_mode = true;
        global.music_fadeout = max(global.music_fadeout - (s * global.tdelta), 0);
        ambience_vol = min(ambience_vol + (s * global.tdelta), 1);
    }
    
    audio_sound_gain(ambience_snd, ambience_vol * audi_get_default_gain(snd_atrium_ambience) * 0.6, 0);
    
    if (global.bgm_current != -1 && audio_is_playing(global.bgm_current))
        audio_sound_gain(global.bgm_current, bgm_get_default_target_gain(global.bgm_current_sound), 0);
}

if (global.gstate == UnknownEnum.Value_1 && input_pressed(0, 12))
{
    with (obj_player)
    {
        if (state == player_state_main && is_struct(my_floor) && my_floor.type == UnknownEnum.Value_129)
        {
            var allowed = true;
            
            if (!other.level_allowed_to_enter[my_floor.type_param])
                allowed = false;
            
            if (allowed)
            {
                global.overworld_position = my_floor.type_param;
                other.camera_takeover = true;
                other.camera_takeover_state = UnknownEnum.Value_0;
                other.camera_timer = 0;
                visible = 0;
                cpart_create_overworld_warp(gx, gy);
                var cent = stage_get_middle_position(gx, gy);
                var o = stage_object_spawn_3d_billboard_effect(obj_overworld_warp_effect, cent[0], cent[1], cent[2], out_vector, 12);
                o.right_vector = stage_get_right_vector(gx, gy);
                o.up_vector = stage_get_up_vector(gx, gy);
                o.out_vector = stage_get_out_vector(gx, gy);
                
                with (o)
                    event_user(0);
                
                cent = stage_get_middle_position(gx, gy);
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
                
                var a = get_screenspace_coords(cent[0], cent[1], cent[2]);
                cpart_create_blendsetter(60, 1);
                
                repeat (32)
                {
                    var c = cpart_create_screentrail(a[0], a[1], random(360), random_range(30, 56), choose(spr_lightparticle_blue, spr_lightparticle_red, spr_lightparticle_green, spr_lightparticle_yellow), 0.14);
                    
                    if (is_struct(c))
                        c.time = irandom_range(30, 57);
                }
                
                cpart_create_blendsetter(60, 0);
                gstate_activate_overworld_warp(my_floor.type_param);
                global.camera_tilt_lock = false;
                state = player_state_camera_pose;
            }
        }
    }
}

if (global.debugging && keyboard_check_pressed(vk_f7))
    overworld_debug_change();
    
// ARCHIPELAGO: handle level unlocks
if (instance_exists(obj_overworld_warp_whirl) && instance_exists(obj_archipelago_client) && obj_archipelago_client.AP_isAuthenticated()) {
    with (obj_overworld_warp_whirl) {
        if (level % 2 != 0) { // TEMP: replace with unlock condition
            obj_overworld_player_decorator.level_allowed_to_enter[level] = true;
            unlocked = true;
            lock_as_visible = false;
        } else {
            obj_overworld_player_decorator.level_allowed_to_enter[level] = false;
            unlocked = false;
            lock_as_visible = true;
        }
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_129 = 129
}
