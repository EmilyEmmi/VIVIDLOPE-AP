if (controller_picking)
    exit;

spinner_on = false;
open_timer += global.tdelta;

if (shut_timer >= 0)
    shut_timer += global.tdelta;

if (open_timer >= 50)
{
    if (load_on_next_frame == 0)
        load_on_next_frame = 1;
}

if (load_on_next_frame == 1 && shut_timer < 0)
{
    spinner_prog++;
    spinner_on = true;
    
    if (loading_is_ongoing())
        exit;
    
    loading_timer++;
    show_debug_msg("loading_timer: " + string(loading_timer));
    
    switch (loading_timer)
    {
        case 1:
            loading_create_fonts(1);
            break;
        
        case 2:
            loading_create_fonts(2);
            break;
        
        case 3:
            loading_create_fonts(3);
            break;
        
        case 4:
            loading_create_fonts(4);
            break;
        
        case 5:
            loading_create_fonts(5);
            break;
        
        case 6:
            loading_create_fonts(6);
            break;
        
        case 7:
            loading_create_fonts(7);
            break;
        
        case 8:
            loading_create_fonts(8);
            break;
        
        case 9:
            textures_unload();
            textures_reload();
            break;
        
        case 10:
            ani3d_animation_generate_bone_codes();
            
            if (global.debugging)
            {
                if (file_exists(global.base_dir + "anim.json"))
                    ani3d_animation_load_all();
                else
                    loading_buffer_compressed_animation_load();
            }
            else if (file_exists(global.base_dir + "anim.bin"))
            {
                loading_buffer_compressed_animation_load();
            }
            else
            {
                ani3d_animation_load_all();
            }
            
            stage_index_setup();
            break;
        
        case 11:
            floor_scoring_absorb_color_prep();
            break;
        
        case 12:
            lang_load_contextual();
            config_load_delayed();
            break;
        
        case 13:
            lang_load_contextual_2();
            
            if (global.fnt_using_compatible == true)
                loading_buffer_texturegroup_fetch("LocalizationFonts");
            
            break;
        
        case 15:
            prep_legacy_savefiles();
            loading_buffer_shared_savedata_load();
            
            for (var i = 0; i < 8; i++)
                loading_buffer_savedata_preview_load(i);
            
            break;
        
        case 17:
            if (loading_is_ongoing())
                loading_timer--;
            
            break;
        
        case 18:
            model_system_init();
            show_debug_msg("obj_global game start 1");
            shockwave_model_init();
            show_debug_msg("obj_global game start 2");
            heater_model_init();
            show_debug_msg("obj_global game start 3");
            superjump_predictor_init();
            show_debug_msg("obj_global game start 4");
            ufo_model_init();
            show_debug_msg("obj_global game start 5");
            dash_model_init();
            show_debug_msg("obj_global game start 6");
            break;
        
        case 19:
            cussprite_init();
            break;
        
        case 20:
            loading_buffer_audi_init();
            break;
        
        case 22:
            var s = ani3d_get_skeleton("leaper");
            ani3d_skeleton_free(s);
            s = ani3d_get_skeleton("giraffe");
            ani3d_skeleton_free(s);
            s = ani3d_get_skeleton("gero");
            ani3d_skeleton_free(s);
            s = ani3d_get_skeleton("seeker");
            ani3d_skeleton_free(s);
            global.glow_threshold = 1;
            break;
        
        case 23:
            global.vividext_tempbuffer = buffer_create(4096, buffer_fixed, 1);
            buffer_fill(global.vividext_tempbuffer, 0, buffer_u8, 0, 4096);
            global.vividext_tempbuffer_address = buffer_get_address(global.vividext_tempbuffer);
            vividext_assign_extb(global.vividext_tempbuffer_address);
            global.vividext_tempbuffer2 = buffer_create(65536, buffer_fixed, 1);
            buffer_fill(global.vividext_tempbuffer2, 0, buffer_u8, 0, 65536);
            global.vividext_tempbuffer2_address = buffer_get_address(global.vividext_tempbuffer2);
            break;
        
        case 24:
            global.stage_display_type = UnknownEnum.Value_0;
            break;
        
        case 25:
            tempest_text_build(1);
            break;
        
        case 28:
            if (!audi_preload_progress())
                loading_timer -= 2;
            
            break;
        
        case 29:
            audio_stop_all();
            shut_timer = 0;
            break;
    }
}

if (shut_timer >= 15)
{
    input_system_refresh_key_array_lengths();
    end_action();
}

enum UnknownEnum
{
    Value_0
}
