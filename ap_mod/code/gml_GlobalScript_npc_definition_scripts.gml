function overworld_progress()
{
    for (var i = 1; i <= 11; i++)
    {
        if (!ds_map_exists(global.cleared_levels, i))
            return i - 1;
    }
    
    return 11;
}

function npc_initialize(arg0)
{
    event_repeat_array = -1;
    original_param = arg0;
    
    switch (arg0)
    {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
            skeleton = ani3d_get_skeleton("npc_wobbler");
            flap_bone = "";
            animation_idle = "en_wobbler_patience";
            animation_talk = "en_wobbler_dance";
            shadow_r = 11;
            event_array = [];
            
            if (arg0 == 1)
            {
                // ARCHIPELAGO: Don't spawn intro guy
                if (AP_is_multiworld_active()) {
                    instance_destroy();
                    exit;
                }
                else if (overworld_progress() == 0 && !level_is_accessed(1))
                {
                    if (global.player_character == UnknownEnum.Value_4)
                    {
                        event_array = npc_get_event_array_auto("npc_wobbler_noir_welcome");
                        event_repeat_array = npc_get_event_array_auto("npc_wobbler_noir_welcome");
                    }
                    else
                    {
                        event_array = npc_get_event_array_auto("npc_wobbler_welcome");
                        event_repeat_array = npc_get_event_array_auto("npc_wobbler_repeat_welcome");
                    }
                    
                    autofire = true;
                }
                else
                {
                    instance_destroy();
                    exit;
                }
            }
            
            if (arg0 == 2)
            {
                // ARCHIPELAGO: Treat as if we've accessed level 1 in archi
                if (overworld_progress() == 0 && (level_is_accessed(1) || AP_is_multiworld_active()))
                {
                    if (global.player_character == UnknownEnum.Value_4)
                        event_array = npc_get_event_array_auto("npc_wobbler_noir_welcomeb");
                    else
                        event_array = npc_get_event_array_auto("npc_wobbler_nag");
                }
                else if (overworld_progress() == 1)
                {
                    if (global.player_character == UnknownEnum.Value_4)
                    {
                        event_array = npc_get_event_array_auto("npc_wobbler_noir_encourage");
                        event_repeat_array = npc_get_event_array_auto("npc_wobbler_noir_repeat_encourage");
                    }
                    else
                    {
                        event_array = npc_get_event_array_auto("npc_wobbler_encourage");
                        event_repeat_array = npc_get_event_array_auto("npc_wobbler_repeat_encourage");
                    }
                }
                else
                {
                    instance_destroy();
                    exit;
                }
            }
            
            if (arg0 == 3)
            {
                if (global.player_character == UnknownEnum.Value_4)
                {
                    instance_destroy();
                    exit;
                }
                else if (overworld_progress() >= 2 && overworld_progress() <= 8)
                {
                    event_array = npc_get_event_array_auto("npc_wobbler_chitchat");
                }
                else
                {
                    instance_destroy();
                    exit;
                }
            }
            
            if (arg0 == 4)
            {
                if (overworld_progress() == 9)
                {
                    if (!level_is_accessed(10))
                    {
                        if (global.player_character == UnknownEnum.Value_4)
                            event_array = npc_get_event_array_auto("npc_wobbler_noir_farewell");
                        else
                            event_array = npc_get_event_array_auto("npc_wobbler_farewell");
                        
                        autofire = true;
                    }
                    else
                    {
                        event_array = npc_get_event_array_auto("npc_wobbler_farewell2");
                    }
                }
                else
                {
                    instance_destroy();
                    exit;
                }
            }
            
            if (arg0 == 5)
            {
                if (overworld_progress() == 10)
                {
                    event_array = npc_get_event_array_auto("npc_wobbler_welcomeback");
                }
                else
                {
                    instance_destroy();
                    exit;
                }
            }
            
            break;
        
        case 10:
            // ARCHIPELAGO: Change shopkeeper spawning conditions
            if (AP_is_multiworld_active()) {
                if (global.AP_shop_upgrades == 0)
                {
                    instance_destroy();
                    exit;
                }
            }
            else if (!story_progression_has_passed_level(1))
            {
                instance_destroy();
                exit;
            }
            
            var bname = "";
            
            if (global.player_character == UnknownEnum.Value_0)
            {
                skeleton = ani3d_get_skeleton("pal");
                animation_idle = "stand";
                animation_talk = "npc_rose_chat";
                bname = "rose";
            }
            else if (global.player_character == UnknownEnum.Value_1)
            {
                skeleton = ani3d_get_skeleton("gal");
                animation_idle = "stand";
                animation_talk = "npc_lime_chat";
                bname = "lime";
            }
            else
            {
                bname = "realsalesman";
                skeleton = -1;
                flap_bone = "";
                shadow_r = 10.5;
                sprite = new QUEUE_SPRITE(spr_viruse_salesman, 0, 0, 0, 0, 0, 0.1, 0.1, 0, 16777215, 1);
                
                draw_fun = function()
                {
                    hh = 13.5;
                    xx = x + (out_vector[0] * hh);
                    yy = y + (out_vector[1] * hh);
                    zz = z + (out_vector[2] * hh);
                    sprite.x = xx;
                    sprite.y = yy;
                    sprite.z = zz;
                    sprite.xscale = ((current_time % 1000) < 500) ? 0.1 : -0.1;
                    squeue_enqueue(sprite);
                };
            }
            
            if (is_struct(skeleton))
            {
                flap_bone = "head";
                shadow_r = 13.5;
            }
            
            if (global.shop_visits == 0)
                event_array = npc_get_event_array_auto("npc_" + bname + "_intro");
            else if (overworld_progress() == 10)
                event_array = npc_get_event_array_auto("npc_" + bname + "_clear");
            else
                event_array = npc_get_event_array_auto("npc_" + bname + "_regular");
            
            array_push(event_array, UnknownEnum.Value_0);
            break;
        
        case 11:
            skeleton = ani3d_get_skeleton("gal");
            flap_bone = "head";
            animation_idle = "stand";
            animation_talk = "npc_lime_chat";
            shadow_r = 13.5;
            event_array = [["My dad could beat up your dad!"]];
            break;
        
        case 21:
            if (global.player_character == UnknownEnum.Value_4)
            {
                instance_destroy();
                exit;
            }
            
            skeleton = ani3d_get_skeleton("npc_leaper");
            flap_bone = "";
            animation_idle = "en_leaper_patience";
            animation_talk = "en_leaper_chat";
            shadow_r = 11.5;
            event_array = npc_get_standard_event_array("npc_leaper");
            break;
        
        case 22:
            if (global.player_character == UnknownEnum.Value_4)
            {
                skeleton = ani3d_get_skeleton("pufferfish");
                animation_idle = "en_pufferfish_npc_idle";
                
                if (overworld_progress() >= 11)
                {
                    animation_talk = "en_pufferfish_npc_talk";
                    flap_bone = "";
                }
                else
                {
                    animation_talk = "en_pufferfish_npc_idle";
                    flap_bone = "";
                }
                
                shadow_r = 13.5;
                event_array = npc_get_standard_event_array("npc_fish");
                break;
            }
            
            skeleton = ani3d_get_skeleton("npc_octi");
            flap_bone = "";
            animation_idle = "en_octi_npc_idle";
            animation_talk = "en_octi_npc_talk";
            shadow_r = 14.5;
            event_array = npc_get_standard_event_array("npc_octi");
            break;
        
        case 23:
            skeleton = ani3d_get_skeleton("npc_spectre");
            flap_bone = "";
            animation_idle = "en_spectre_walk";
            animation_talk = "en_spectre_walk";
            shadow_r = 12.5;
            
            if (global.player_character == UnknownEnum.Value_4)
            {
                var p = string(irandom_range(1, 8));
                var l = "npc_spectre_missnoir_" + p;
                event_array = [[lang(l)]];
            }
            else
            {
                event_array = npc_get_standard_event_array("npc_spectre");
            }
            
            break;
        
        case 24:
            skeleton = ani3d_get_skeleton("npc_giraffe");
            flap_bone = "";
            animation_idle = "en_giraffe_stand";
            animation_talk = "en_giraffe_chat";
            shadow_r = 13.5;
            hook_z_offset = 96;
            hud_marker_prompt_frame = 1;
            event_array = npc_get_standard_event_array("npc_giraffe");
            break;
        
        case 25:
            break;
        
        case 26:
            skeleton = ani3d_get_skeleton("npc_gero");
            flap_bone = "";
            animation_idle = "en_gero_patience";
            animation_talk = "en_gero_chat";
            shadow_r = 11.5;
            event_array = npc_get_standard_event_array("npc_gero");
            break;
        
        case 27:
            skeleton = -1;
            flap_bone = "";
            shadow_r = 10.5;
            var crazy = false;
            
            if (random(256) < 1)
                crazy = true;
            
            sprite = new QUEUE_SPRITE(spr_npc_fuse, 0, 0, 0, 0, 0, 0.1, 0.1, 0, 16777215, 1);
            
            if (random(8) < 1)
                sprite.subimage = irandom_range(2, 4);
            
            if (crazy)
                sprite.subimage = 1;
            
            draw_fun = function()
            {
                hh = 12;
                xx = x + (out_vector[0] * hh);
                yy = y + (out_vector[1] * hh);
                zz = z + (out_vector[2] * hh);
                sprite.x = xx;
                sprite.y = yy;
                sprite.z = zz;
                squeue_enqueue(sprite);
            };
            
            event_array = [["..."]];
            
            if (crazy)
                event_array = [UnknownEnum.Value_4];
            
            break;
        
        case 28:
            if (global.player_character == UnknownEnum.Value_4)
            {
                skeleton = -1;
                flap_bone = "";
                shadow_r = 10.5;
                sprite[0] = new QUEUE_SPRITE(spr_npc_mole, 0, 0, 0, 0, 0, 0.1, 0.1, 0, 16777215, 1);
                sprite[1] = new QUEUE_SPRITE(spr_npc_mole, 1, 0, 0, 0, 2, 0.1, 0.1, 0, 16777215, 1);
                sprite[2] = new QUEUE_SPRITE(spr_npc_mole, 2, 0, 0, 0, 3, 0.1, 0.1, 0, 16777215, 1);
                
                draw_fun = function()
                {
                    hh = 13;
                    xx = x + (out_vector[0] * hh);
                    yy = y + (out_vector[1] * hh);
                    zz = z + (out_vector[2] * hh);
                    sprite[0].angle = (current_time / 1000) * 180;
                    
                    for (var i = 0; i < 3; i++)
                    {
                        sprite[i].x = xx;
                        sprite[i].y = yy;
                        sprite[i].z = zz;
                        sprite[i].xscale = 0.1;
                        sprite[i].yscale = 0.1;
                        squeue_enqueue(sprite[i]);
                    }
                };
                
                if (overworld_progress() > 10)
                    event_array = [lang("npc_mole_5")];
                else
                    event_array = npc_get_standard_event_array("npc_mole");
                
                break;
            }
            
            skeleton = ani3d_get_skeleton("npc_seeker");
            flap_bone = "";
            animation_idle = "en_seeker_patience";
            animation_talk = "en_seeker_chat";
            shadow_r = 13.5;
            event_array = npc_get_standard_event_array("npc_seeker");
            break;
        
        case 29:
            skeleton = ani3d_get_skeleton("npc_toro");
            flap_bone = "";
            animation_idle = "en_toro_patience";
            animation_talk = "en_toro_chat";
            shadow_r = 15;
            hud_marker_height = 32;
            var p = string(irandom_range(1, 10));
            var l = "npc_toro_" + p;
            
            if (global.player_character == UnknownEnum.Value_0 && p == "10")
                l = "npc_toro_10_cerise";
            
            if (global.player_character == UnknownEnum.Value_1 && p == "10")
                l = "npc_toro_10_ecru";
            
            event_array = [[lang(l)]];
            break;
        
        case 30:
            skeleton = ani3d_get_skeleton("playcat");
            flap_bone = "";
            animation_idle = "en_playcat_patience";
            animation_talk = "en_playcat_chat";
            shadow_r = 10;
            
            if (level_is_complete(11) || global.debugging)
            {
                animation_idle = "en_playcat_patience";
                animation_talk = "en_playcat_chat";
                flap_bone = "";
                event_array = npc_get_event_array_auto("npc_playcat_awaken");
                array_push(event_array, UnknownEnum.Value_3);
            }
            else
            {
                animation_idle = "en_playcat_sleep";
                animation_talk = "en_playcat_sleep";
                flap_bone = "";
                event_array = npc_get_event_array_auto("npc_playcat_sleep");
            }
            
            break;
        
        case 31:
            skeleton = ani3d_get_skeleton("babby");
            flap_bone = "";
            animation_idle = "en_babby_patience";
            animation_talk = "en_babby_chat";
            shadow_r = 11;
            hint_id = babby_hint_pull();
            event_array = npc_get_event_array_auto("npc_babby_h" + string(hint_id));
            array_push(event_array, UnknownEnum.Value_2);
            break;
        
        case 32:
            if (!story_progression_has_passed_level(8) || global.player_character == UnknownEnum.Value_4)
            {
                instance_destroy();
                exit;
            }
            
            skeleton = -1;
            flap_bone = "";
            shadow_r = 10.5;
            sprite = new QUEUE_SPRITE(spr_viruse_salesman, 0, 0, 0, 0, 0, 0.1, 0.1, 0, 16777215, 1);
            
            draw_fun = function()
            {
                hh = 13.5;
                xx = x + (out_vector[0] * hh);
                yy = y + (out_vector[1] * hh);
                zz = z + (out_vector[2] * hh);
                sprite.x = xx;
                sprite.y = yy;
                sprite.z = zz;
                sprite.xscale = ((current_time % 1000) < 500) ? 0.1 : -0.1;
                squeue_enqueue(sprite);
            };
            
            var s = lang("npc_salesman_" + string(irandom_range(1, 15)));
            
            if (current_month == 12 && current_day >= 24 && current_day <= 26)
                s = lang("npc_salesman_xmas");
            
            event_array = [[s]];
            break;
        
        case 33:
            break;
        
        case 34:
            if (!story_progression_has_passed_level(8))
            {
                instance_destroy();
                exit;
            }
            
            skeleton = -1;
            flap_bone = "";
            shadow_r = 10.5;
            sprite = new QUEUE_SPRITE(spr_npc_kuso, 0, 0, 0, 0, 0, 0.1, 0.1, 0, 16777215, 1);
            
            draw_fun = function()
            {
                hh = 14;
                xx = x + (out_vector[0] * hh);
                yy = y + (out_vector[1] * hh);
                zz = z + (out_vector[2] * hh);
                sprite.x = xx;
                sprite.y = yy;
                sprite.z = zz;
                sprite.xscale = 0.1 + lengthdir_x(0.01, (current_time / 3000) * 360);
                sprite.yscale = 0.1 - lengthdir_x(0.01, (current_time / 3000) * 360);
                squeue_enqueue(sprite);
            };
            
            var s = lang("npc_kuso_" + string(irandom_range(1, 8)));
            event_array = [[s]];
            break;
        
        case 35:
            skeleton = ani3d_get_skeleton("curious");
            flap_bone = "";
            animation_idle = "en_curious_patience";
            animation_talk = "en_curious_chat";
            shadow_r = 11;
            var base_line = lang1("npc_curious_1c", "!@#$%");
            
            if (global.count_defeated_enemies >= 0)
            {
                if (global.count_defeated_enemies < 1)
                    base_line = lang("npc_curious_1a");
                else if (global.count_defeated_enemies < 2)
                    base_line = lang("npc_curious_1b");
                else if (global.count_defeated_enemies < 200)
                    base_line = lang1("npc_curious_1c", string(global.count_defeated_enemies));
                else if (global.count_defeated_enemies < 1000)
                    base_line = lang1("npc_curious_1d", string(global.count_defeated_enemies));
                else
                    base_line = lang1("npc_curious_1e", string(global.count_defeated_enemies));
            }
            
            event_array = [base_line];
            break;
        
        case 36:
            skeleton = -1;
            flap_bone = "";
            shadow_r = 10.5;
            sprite = new QUEUE_SPRITE(spr_npc_munchman, 0, 0, 0, 0, 0, 0.1, 0.1, 0, 16777215, 1);
            
            draw_fun = function()
            {
                hh = 14;
                xx = x + (out_vector[0] * hh);
                yy = y + (out_vector[1] * hh);
                zz = z + (out_vector[2] * hh);
                sprite.x = xx;
                sprite.y = yy;
                sprite.z = zz;
                sprite.xscale = 0.1 + lengthdir_x(0.001, (current_time / 3000) * 360);
                sprite.yscale = 0.1 - lengthdir_x(0.001, (current_time / 3000) * 360);
                squeue_enqueue(sprite);
            };
            
            var base_line = lang("npc_glutton_2b");
            
            if (global.count_fruits >= 0)
            {
                if (global.count_fruits < 1)
                    base_line = lang("npc_glutton_1a");
                else if (global.count_fruits < 2)
                    base_line = lang("npc_glutton_2b");
                else if (global.count_fruits < 1000)
                    base_line = lang1("npc_glutton_2c", string(global.count_fruits));
                else
                    base_line = lang1("npc_glutton_2d", string(global.count_fruits));
            }
            
            event_array = [base_line];
            break;
        
        case 37:
            skeleton = ani3d_get_skeleton("nerd");
            flap_bone = "";
            animation_idle = "en_nerd_patience";
            animation_talk = "en_nerd_chat";
            shadow_r = 15;
            hud_marker_height = 56;
            var base_line;
            
            if (global.count_kos < 0)
                base_line = lang1("npc_accountant", "525582");
            else if (global.count_kos < 1)
                base_line = lang1("npc_accountant", "!!!!!");
            else
                base_line = lang1("npc_accountant", string(global.count_kos) + "00");
            
            event_array = [base_line];
            break;
        
        default:
            skeleton = ani3d_get_skeleton("gal");
            flap_bone = "head";
            animation_idle = "stand";
            animation_talk = "npc_lime_chat";
            shadow_r = 13.5;
            event_array = [["Test message! Test message! Test message! Test message! Test message! Test message! Test message!", "Wow! Wow! Wow! Wow! Wow! Wow! Wow! Wow! Wow! Wow! Wow! Wow! Wow! Wow! Wow! Wow! Wow!"], UnknownEnum.Value_0, "Test message! Test message! Test message! Test message! Test message! Test message! Test message! Wow!"];
    }
    
    try
    {
        if (is_struct(skeleton))
            ani3d_skeleton_play_animation_next(skeleton, animation_idle);
    }
    catch (e)
    {
        if (global.debugging)
            show_message("npc_initialize - animation playback caught exception in enemy with param " + string(arg0) + "\n" + string(e));
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4
}
