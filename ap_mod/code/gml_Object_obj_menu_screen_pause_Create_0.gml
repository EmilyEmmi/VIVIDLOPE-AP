menu_screen_init("pause");
menu_screen_add_option(new MENU_OPTION("Continue", spr_menu_icon_none, 0, function()
{
    text_l = lang("mn_resume");
}, function()
{
    with (obj_menu_bars)
        open_close_animation = -1;
    
    menu_play_sound_unpause();
    menu_flow_script_after_shutdown(function()
    {
        with (obj_pause_control)
            unpause_please = true;
    }, -1);
}, -1));

if (((global.gmode == UnknownEnum.Value_3 || global.gmode == UnknownEnum.Value_4 || global.gmode == UnknownEnum.Value_1 || global.gmode == UnknownEnum.Value_2) && !(global.current_stage == "overworld")) || global.gmode == UnknownEnum.Value_13 || global.gmode == UnknownEnum.Value_15)
{
    menu_screen_add_option(new MENU_OPTION("retry", spr_menu_icon_none, 0, function()
    {
        text_l = lang("mn_retry");
    }, function()
    {
        menu_ask_question(function()
        {
            with (obj_pause_control)
            {
                go_to_retry = true;
                leaving = true;
            }
            
            with (obj_menu_screen_pause)
            {
                animation_lock_in_place = true;
                animation = -1;
                animation_timer = 0;
            }
        }, lang("que_retry"), lang("yes"), lang("no"), 1);
    }, -1));
    
    if (((global.gmode == UnknownEnum.Value_3 || global.gmode == UnknownEnum.Value_4 || global.gmode == UnknownEnum.Value_1 || global.gmode == UnknownEnum.Value_2) && !game_is_in_final_level()) || global.gmode == UnknownEnum.Value_13)
    {
        menu_screen_add_option(new MENU_OPTION("retreat", spr_menu_icon_none, 0, function()
        {
            text_l = lang("mn_change_stage");
        }, function()
        {
            menu_ask_question(function()
            {
                with (obj_pause_control)
                {
                    go_to_stagesel = true;
                    leaving = true;
                }
                
                with (obj_menu_screen_pause)
                {
                    animation_lock_in_place = true;
                    animation = -1;
                    animation_timer = 0;
                }
            }, lang("que_change_stage"), lang("yes"), lang("no"), 1);
        }, -1));
    }
    
    if ((global.gmode == UnknownEnum.Value_3 || global.gmode == UnknownEnum.Value_4 || global.gmode == UnknownEnum.Value_1 || global.gmode == UnknownEnum.Value_2) && !is_demo_version())
    {
        menu_screen_add_option(new MENU_OPTION("overworld", spr_menu_icon_none, 0, function()
        {
            text_l = lang("mn_overworld");
        }, function()
        {
            menu_ask_question(function()
            {
                with (obj_pause_control)
                {
                    go_to_overworld = true;
                    leaving = true;
                }
                
                with (obj_menu_screen_pause)
                {
                    animation_lock_in_place = true;
                    animation = -1;
                    animation_timer = 0;
                }
            }, lang("que_overworld"), lang("yes"), lang("no"), 1);
        }, -1));
    }
}

if (global.gmode == UnknownEnum.Value_3 || global.gmode == UnknownEnum.Value_4 || global.gmode == UnknownEnum.Value_1 || global.gmode == UnknownEnum.Value_2)
{
    if (global.playtest_debugging)
    {
        test_levelclrwarp = 1;
        test_levelclr_mode = 0;
        
        if (global.current_stage == "overworld")
        {
            menu_screen_add_option(new MENU_OPTION("test_levelclrwarp", spr_menu_icon_none, 0, function()
            {
                text_l = "TEST LvCW";
                var mm = obj_menu_screen_pause.test_levelclrwarp;
                text_r = string(mm);
            }, function()
            {
                var mm = obj_menu_screen_pause.test_levelclrwarp;
                var tex = "This option will simulate completing the selected level by A-ranking all of it, then activating the overworld reveal sequence. It will erase all your progress in that level and after it. You will be brought to the Level Clear screen.";
                menu_ask_question(function()
                {
                    var mm = obj_menu_screen_pause.test_levelclrwarp;
                    bgm_and_snd_stop();
                    var o = instance_create_lay(0, 0, 301, obj_debug_ingame_pause_command_atriumlevelcomplete);
                    o.level = mm;
                    
                    with (obj_menu_bars)
                        open_close_animation = -1;
                    
                    menu_play_sound_accept();
                    menu_flow_script_after_shutdown(function()
                    {
                        with (obj_pause_control)
                            unpause_please = true;
                    }, -1);
                }, tex, lang("yes"), lang("no"), 1);
            }, function(arg0)
            {
                menu_play_sound_change();
                
                with (obj_menu_screen_pause)
                {
                    test_levelclrwarp += arg0;
                    
                    if (test_levelclrwarp <= 0)
                        test_levelclrwarp = 11;
                    
                    if (test_levelclrwarp > 11)
                        test_levelclrwarp = 1;
                }
            }));
        }
        
        if (!(global.current_stage == "overworld"))
        {
            menu_screen_add_option(new MENU_OPTION("test_levelclr", spr_menu_icon_none, 0, function()
            {
                text_l = "TEST LvClr";
                text_r = "???";
                var mm = obj_menu_screen_pause.test_levelclr_mode;
                
                switch (mm)
                {
                    case 0:
                        text_r = "12 A";
                        break;
                    
                    case 1:
                        text_r = "15 A";
                        break;
                    
                    case 2:
                        text_r = "15 S";
                        break;
                    
                    case 3:
                        text_r = "15 V";
                        break;
                }
            }, function()
            {
                var mm = obj_menu_screen_pause.test_levelclr_mode;
                var tex = "?";
                
                switch (mm)
                {
                    case 0:
                        tex = "This option will clear the level by A-ranking 12 first stages within it. You will be brought to the Level Clear screen.";
                        break;
                    
                    case 1:
                        tex = "This option will complete the level by A-ranking all stages within it. You will be brought to the Level Clear screen.";
                        break;
                    
                    case 2:
                        tex = "This option will superb the level by S-ranking all stages within it. You will be brought to the Level Clear screen.";
                        break;
                    
                    case 3:
                        tex = "This option will perfect the level by V-ranking all stages within it. You will be brought to the Level Clear screen.";
                        break;
                }
                
                menu_ask_question(function()
                {
                    var mm = obj_menu_screen_pause.test_levelclr_mode;
                    bgm_and_snd_stop();
                    var o = instance_create_lay(0, 0, 301, obj_debug_ingame_pause_command_skiplevel);
                    
                    switch (mm)
                    {
                        case 1:
                            o.stage_no = 30;
                            o.rank = "A";
                            break;
                        
                        case 2:
                            o.stage_no = 30;
                            o.rank = "S";
                            break;
                        
                        case 3:
                            o.stage_no = 30;
                            o.rank = "P";
                            break;
                    }
                    
                    with (obj_menu_bars)
                        open_close_animation = -1;
                    
                    menu_play_sound_accept();
                    menu_flow_script_after_shutdown(function()
                    {
                        with (obj_pause_control)
                            unpause_please = true;
                    }, -1);
                }, tex, lang("yes"), lang("no"), 0);
            }, function(arg0)
            {
                menu_play_sound_change();
                
                with (obj_menu_screen_pause)
                    test_levelclr_mode = (test_levelclr_mode + 4 + arg0) % 4;
            }));
        }
    }
}

if (global.gmode == UnknownEnum.Value_6)
{
    if (global.playtest_debugging)
    {
        test_gauntlet_mode = 0;
        menu_screen_add_option(new MENU_OPTION("test_levelgau", spr_menu_icon_none, 0, function()
        {
            text_l = "TEST ScoSet";
            text_r = "???";
            var mm = obj_menu_screen_pause.test_gauntlet_mode;
            text_r = "Rank " + string(mm + 1);
        }, function()
        {
            var mm = obj_menu_screen_pause.test_gauntlet_mode;
            var tex = "?";
            tex = "This option will set your score to the value needed to reach the given bracket and null out your lives, so you can smash yourself and obtain the desired rank. If you want to try the no-miss clear, use the stage skip instead.";
            menu_ask_question(function()
            {
                var mm = obj_menu_screen_pause.test_gauntlet_mode;
                var brackets = missnoir_gauntlet_score_brackets();
                global.player_score = brackets[mm][0];
                global.player_lives = 0;
                
                with (obj_menu_bars)
                    open_close_animation = -1;
                
                menu_play_sound_accept();
                menu_flow_script_after_shutdown(function()
                {
                    with (obj_pause_control)
                        unpause_please = true;
                }, -1);
            }, tex, lang("yes"), lang("no"), 0);
        }, function(arg0)
        {
            menu_play_sound_change();
            
            with (obj_menu_screen_pause)
                test_gauntlet_mode = (test_gauntlet_mode + 13 + arg0) % 13;
        }));
    }
}

menu_screen_add_option(new MENU_OPTION("options", spr_menu_icon_none, 0, function()
{
    text_l = lang("mn_options");
}, function()
{
    menu_flow_goto_menu_screen(obj_menu_screen_options);
}, -1));

// ARCHIPELAGO: reconnect button
if (variable_global_exists("AP_is_playing") && global.AP_is_playing && !AP_is_multiworld_active(true)) {
    menu_screen_add_option(new MENU_OPTION("options", spr_menu_icon_none, 0, function()
    {
        text_l = "Reconnect";
        color = #C445FF;
        color_secondary = #D57AFF;
    }, function()
    {
        obj_archipelago_client.AP_connect(true);
        menu_set_top_caption("Connecting...");
    }, -1));
}

if (global.gmode == UnknownEnum.Value_15 || global.gmode == UnknownEnum.Value_13)
{
    menu_screen_add_option(new MENU_OPTION("exit", spr_menu_icon_none, 0, function()
    {
        text_l = lang("mn_resign");
    }, function()
    {
        menu_ask_question(function()
        {
            with (obj_pause_control)
                leaving = true;
            
            with (obj_menu_screen_pause)
            {
                animation_lock_in_place = true;
                animation = -1;
                animation_timer = 0;
            }
        }, lang("que_resign"), lang("yes"), lang("no"), 1);
    }, -1));
}
else if (global.gmode == UnknownEnum.Value_6)
{
    menu_screen_add_option(new MENU_OPTION("exit", spr_menu_icon_none, 0, function()
    {
        text_l = lang("mn_resign_gauntlet");
    }, function()
    {
        menu_ask_question(function()
        {
            with (obj_pause_control)
                leaving = true;
            
            with (obj_menu_screen_pause)
            {
                animation_lock_in_place = true;
                animation = -1;
                animation_timer = 0;
            }
        }, lang("que_resign_endless"), lang("yes"), lang("no"), 1);
    }, -1));
}
else if (global.gmode == UnknownEnum.Value_5)
{
    menu_screen_add_option(new MENU_OPTION("exit", spr_menu_icon_none, 0, function()
    {
        text_l = lang("mn_resign_endless");
    }, function()
    {
        menu_ask_question(function()
        {
            with (obj_menu_bars)
                open_close_animation = -1;
            
            menu_flow_script_after_shutdown(function()
            {
                with (obj_pause_control)
                {
                    unpause_please = true;
                    endless_resign = true;
                }
            }, -1);
        }, lang("que_resign_endless"), lang("yes"), lang("no"), 1);
    }, -1));
}
else
{
    menu_screen_add_option(new MENU_OPTION("exit", spr_menu_icon_none, 0, function()
    {
        text_l = lang("mn_resign");
    }, function()
    {
        menu_ask_question(function()
        {
            with (obj_pause_control)
                leaving = true;
            
            with (obj_menu_screen_pause)
            {
                animation_lock_in_place = true;
                animation = -1;
                animation_timer = 0;
            }
        }, lang("que_resign"), lang("yes"), lang("no"), 1);
    }, -1));
}

menu_screen_post_init();

back_action = function()
{
    with (obj_menu_bars)
        open_close_animation = -1;
    
    menu_play_sound_unpause();
    menu_flow_script_after_shutdown(function()
    {
        with (obj_pause_control)
            unpause_please = true;
    }, -1);
};

menu_set_top_caption(lang("mc_paused"));
menu_set_bottom_caption(lang("mb_select"), lang("mb_resume"));
gc_collect_please();

// ARCHIPELAGO: Build pause menu tip from unlocked attacks
var full_noir_pause_tip = lang("miss_noir_pause_tech_tip") + "\n";
if (!AP_is_multiworld_active(false)) {
    full_noir_pause_tip += "[[[SPECIAL]]]\n[[[SLOW]]] + [[[SPECIAL]]]\n[[[JUMP]]] + [[[SPECIAL]]]\n[[[SLOW]]] + [[[JUMP]]]";
} else {
    var prev_noir_pause_tip = full_noir_pause_tip;
    if (AP_has_noir_attack(0)) full_noir_pause_tip += "[[[SPECIAL]]]\n";
    if (AP_has_noir_attack(1)) full_noir_pause_tip += "[[[SLOW]]] + [[[SPECIAL]]]\n";
    if (AP_has_noir_attack(2)) full_noir_pause_tip += "[[[JUMP]]] + [[[SPECIAL]]]\n";
    if (AP_has_noir_attack(3)) full_noir_pause_tip += "[[[SLOW]]] + [[[JUMP]]]";
    if (prev_noir_pause_tip == full_noir_pause_tip) {
        full_noir_pause_tip += "None";
    }
}
noir_tech_textex = new TEXTEX(full_noir_pause_tip, global.fnt_hud, 128);

enum UnknownEnum
{
    Value_1 = 1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_13 = 13,
    Value_15 = 15
}
