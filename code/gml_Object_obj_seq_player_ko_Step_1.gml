var speed_scalar = 1;
sped_up = false;

if (global.player_lives > 0 && timer >= 0 && timer < time_len && (input_held(0, 5) || input_held(0, 12) || input_held(0, 17) || input_held(0, 6)))
{
    speed_scalar = lerp(1, 6, min(1, timer / 40));
    
    with (obj_control)
        gcamera_timer += (speed_scalar - 1);
    
    sped_up = true;
}

if (!were_playing_fastforward)
{
    if (sped_up)
    {
        fastforward_sound = audi_play_simple(snd_ko_fastforward);
        were_playing_fastforward = true;
    }
}
else if (!sped_up)
{
    audio_stop_sound(snd_ko_fastforward);
    fastforward_pitch = 1;
    were_playing_fastforward = false;
}

if (were_playing_fastforward)
{
    fastforward_pitch = min(2.5, fastforward_pitch + (0.2 * global.tdelta));
    audio_sound_pitch(fastforward_sound, fastforward_pitch);
}

if (instance_exists(obj_seq_endless_over))
{
    with (obj_player_ko_effect)
        instance_destroy();
    
    with (obj_title_card_player_ko)
        instance_destroy();
    
    instance_destroy();
    exit;
}

with (obj_hud)
    fun_power_down_strong();

bg_shake_timer += global.tdelta;
var t = bg_shake_timer / 30;

if (t < 4)
{
    if (t >= 1)
        global.bg_pull = 0;
    else
        global.bg_pull = lengthdir_y(ease_out_cubic(0.2, 0, t), t * 360 * 6);
}

ptimer = timer;
timer += (global.tdelta * speed_scalar);
var damage_type = self.damage_type;

with (obj_player)
    anim_speed = speed_scalar;

if (timer >= 0 && ptimer < 0)
{
    if (global.gmode != UnknownEnum.Value_0)
        instance_create_lay(0, 0, 3, obj_title_card_player_ko);
    
    global.stage_object_paused = false;
    
    if (!(global.gmode == UnknownEnum.Value_5 && global.player_lives <= 0))
    {
        enemy_despawn_all();
    }
    else
    {
        with (obj_target_mark)
            instance_destroy();
    }
    
    var anim = "lose_knockout_1";
    
    if ((damage_type == UnknownEnum.Value_1 || damage_type == UnknownEnum.Value_7) && global.player_character == UnknownEnum.Value_4)
        damage_type = UnknownEnum.Value_0;
    
    switch (damage_type)
    {
        case UnknownEnum.Value_0:
        case UnknownEnum.Value_6:
        case UnknownEnum.Value_3:
            if (hint_mode)
            {
                anim = (global.player_character == UnknownEnum.Value_4) ? "lose_missnoir_ko_1" : "lose_knockout_1";
            }
            else if (game_is_in_final_level())
            {
                if (global.player_lives == 0)
                    anim = (global.player_character == UnknownEnum.Value_4) ? "lose_missnoir_sorrow_1" : "lose_sorrow_1";
                else
                    anim = (global.player_character == UnknownEnum.Value_4) ? "lose_missnoir_ko_1" : "lose_knockout_1";
            }
            else if (global.player_character == UnknownEnum.Value_4)
            {
                anim = array_choose(["lose_missnoir_ko_1", "lose_missnoir_ko_2", "lose_missnoir_ko_3", "lose_missnoir_ko_4", "lose_missnoir_ko_5", "lose_missnoir_ko_6", "lose_missnoir_ko_7", "lose_missnoir_ko_8"]);
            }
            else if (global.player_character == UnknownEnum.Value_1)
            {
                anim = array_choose(["lose_knockout_1", "lose_knockout_2", "lose_knockout_3", "lose_knockout_4", "lose_knockout_5", "lose_knockout_6", "lose_knockout_7", "lose_knockout_8", "lose_knockout_9", "lose_knockout_11", "lose_knockout_12", "lose_knockout_13", "lose_knockout_14", "lose_knockout_18", "lose_knockout_19"]);
            }
            else
            {
                anim = array_choose(["lose_knockout_1", "lose_knockout_2", "lose_knockout_3", "lose_knockout_5", "lose_knockout_6", "lose_knockout_7", "lose_knockout_8", "lose_knockout_9", "lose_knockout_10", "lose_knockout_11", "lose_knockout_12", "lose_knockout_13", "lose_knockout_16", "lose_knockout_17", "lose_knockout_18", "lose_knockout_19"]);
            }
            
            break;
        
        case UnknownEnum.Value_2:
            if (global.player_character == UnknownEnum.Value_4)
                anim = "lose_missnoir_fall_1";
            else if (hint_mode)
                anim = "lose_fall_1";
            else
                anim = "lose_fall_" + string(irandom_range(1, 1));
            
            break;
        
        case UnknownEnum.Value_1:
            if (hint_mode)
            {
                anim = (global.player_character == UnknownEnum.Value_4) ? "lose_missnoir_hotfloor_1" : "lose_hotfloor_1";
            }
            else if (game_is_in_final_level())
            {
                if (global.player_lives == 0)
                    anim = (global.player_character == UnknownEnum.Value_4) ? "lose_missnoir_sorrow_1" : "lose_sorrow_1";
                else
                    anim = (global.player_character == UnknownEnum.Value_4) ? "lose_missnoir_knockout_1" : "lose_knockout_1";
            }
            else if (global.player_character == UnknownEnum.Value_4)
            {
                anim = "lose_missnoir_hotfloor_" + string(irandom_range(1, 4));
            }
            else
            {
                anim = "lose_hotfloor_" + string(irandom_range(1, 4));
            }
            
            break;
        
        case UnknownEnum.Value_4:
            if (global.player_character == UnknownEnum.Value_4)
                anim = "lose_missnoir_ko_2";
            else if (hint_mode)
                anim = "lose_knockout_2";
            else
                anim = "lose_knockout_2";
            
            break;
        
        case UnknownEnum.Value_5:
            anim = (global.player_character == UnknownEnum.Value_4) ? "lose_missnoir_sorrow_1" : "lose_sorrow_1";
            break;
        
        case UnknownEnum.Value_7:
            if (global.player_character == UnknownEnum.Value_4)
                anim = "lose_missnoir_hotfloor_" + string(irandom_range(1, 4));
            else
                anim = "lose_hotfloor_1";
            
            break;
    }
    
    if (global.gmode == UnknownEnum.Value_0)
        anim = "lose_knockout_1";
    
    if (global.player_character == UnknownEnum.Value_1 && ds_map_exists(global.ani3d_anims, anim + "_ecru"))
        anim = anim + "_ecru";
    
    self.anim = anim;
    
    if (anim == "lose_knockout_5")
        time_len = 260;
    
    with (obj_player)
    {
        camera_track_cx = 0;
        camera_track_cy = 0;
        camera_track_cs = 0.045;
        stage_object_fastforward_forward_matrix();
        
        if (damage_type != UnknownEnum.Value_2 && damage_type != UnknownEnum.Value_3)
        {
            ani_autoswitch_time = -1;
            ani3d_skeleton_play_animation_next(skeleton, anim, 5);
            z = 0;
            stage_object_set_state(player_state_camera_pose);
            gcamera_activate_zoomin();
            player_zoom_scene_activate(20);
        }
        else
        {
            ani_autoswitch_time = -1;
            ani3d_skeleton_play_animation_next(skeleton, anim, 5);
            z = 0;
            gcamera_activate_zoomin();
            player_zoom_scene_activate(12, damage_type != UnknownEnum.Value_2);
            stage_object_set_state(player_state_camera_pose);
        }
    }
}

if (talking)
{
    if (message_window_is_closed())
    {
        hint_mode = false;
        talking = false;
    }
    
    exit;
}

if (ptimer < (time_len - 4) && timer >= (time_len - 4))
    stage_regenerate_broken_fragile_floors();

if (timer >= time_len)
{
    if (hint_mode && !talking)
    {
        talking = true;
        message_window_show_simple([lang("hint_ko0"), lang("hint_ko1"), lang("hint_ko2")]);
        exit;
    }
    
    if (!instance_exists(obj_par_transition))
        ani3d_special_player_reset();
    
    global.player_total_kos++;
    
    if (global.player_lives > 0)
    {
        global.player_lives--;
        global.player_stage_kos++;
        global.compound_stat_kos++;
        game_player_fruit_reset(false);
        game_player_power_reset();
        game_player_speed_reset();
        
        if (global.player_power_lethal_countdown)
        {
            global.player_power = global.__player_power_max;
            global.player_speed = 2;
            global.player_speed_countdown = -1;
            
            with (obj_control)
                power_meter_fastforward();
        }
        
        game_player_chain_reset();
        game_player_chain_multiplier_reset();
        player_zoom_scene_deactivate(20);
        vividext_particles_reset();
        item_lose_contextual();
        global.gstate = UnknownEnum.Value_4;
        
        if (damage_type == UnknownEnum.Value_2 || damage_type == UnknownEnum.Value_3)
        {
            gcamera_return_from_zoomin_to_natural();
            gc_collect_please();
            
            with (obj_player)
            {
                var f = ds_grid_get(global.stage_grid, save_gx, save_gy);
                
                // fix deathlink bug
                if (f == undefined || !(struct_exists(f, "walkable")) || f.walkable <= 0 || !cubea_is_floor_safe(f))
                {
                    player_assure_safe_position_is_safe();
                    save_gx = safe_gx;
                    save_gy = safe_gy;
                    var a = stage_get_middle_position(save_gx, save_gy);
                    save_display_x = a[0];
                    save_display_y = a[1];
                    save_display_z = a[2];
                    gcamera_use_captured_properties_for_zoomout(safe_camera_capture);
                }
                
                invincible_frames = 156;
                player_recover_from_failed_freefall();
                ani3d_skeleton_play_animation_next(skeleton, "stand");
                stage_object_set_state(player_state_respawn);
                stage_object_face_direction(0, gx, gy);
            }
        }
        else
        {
            gcamera_return_from_zoomin_to_natural();
            gc_collect_please();
            
            with (obj_player)
            {
                save_gx = gx;
                save_gy = gy;
                var f = ds_grid_get(global.stage_grid, save_gx, save_gy);
                
                // fix deathlink bug
                if (f == undefined || !(struct_exists(f, "walkable")) || f.walkable <= 0 || !cubea_is_floor_safe(f))
                {
                    player_assure_safe_position_is_safe();
                    save_gx = safe_gx;
                    save_gy = safe_gy;
                    pgx = save_gx;
                    pgy = save_gy;
                    gx = save_gx;
                    gy = save_gy;
                    x = (save_gx * 32) + 16;
                    y = (save_gy * 32) + 16;
                    player_trail_snap_to_current(false);
                    var a = stage_get_middle_position(save_gx, save_gy);
                    save_display_x = a[0];
                    save_display_y = a[1];
                    save_display_z = a[2];
                    gcamera_use_captured_properties_for_zoomout(safe_camera_capture);
                }
                
                invincible_frames = 156;
                ani3d_skeleton_play_animation_next(skeleton, "stand");
                hitlag = 10;
                instance_create_lay(0, 0, 2, obj_player_snap_to_grid);
                
                with (obj_player_snap_to_grid)
                    time = 9;
                
                stage_object_set_state(player_state_respawn);
                stage_object_face_direction(0, gx, gy);
            }
        }
        
        with (obj_par_popcorn_enemy)
            instance_destroy();
        
        with (obj_par_standard_enemy)
            instance_destroy();
        
        with (obj_par_powerup)
            instance_destroy();
        
        cubea_spawn_props(global.stage_grid, false);
        instance_destroy();
    }
    else if (global.gmode == UnknownEnum.Value_5)
    {
        instance_create_lay(0, 0, 4, obj_seq_endless_over);
        instance_destroy();
    }
    else if (global.gmode == UnknownEnum.Value_0)
    {
        with (obj_howto_controller)
            event_user(13);
    }
    else if (global.gmode == UnknownEnum.Value_6)
    {
        gauntlet_trigger_game_over();
    }
    else if (global.gmode == UnknownEnum.Value_15)
    {
        room_goto_transition_fade(rm_stageeditor);
    }
    else
    {
        with (obj_control)
            retryable = false;
        
        room_goto_transition_gameover(rm_game_over);
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
    Value_15 = 15
}
