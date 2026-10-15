if (is_demo_version())
{
    if (global.current_savedata_slot < -1)
    {
        menu_screen_add_option(new MENU_OPTION("arcade", spr_menu_icon_none, 0, function()
        {
            text_l = lang("mn_demo_start");
        }, function()
        {
            menu_flow_script_after_shutdown(start_demo_mode_new);
        }, -1));
    }
    else
    {
        menu_screen_add_option(new MENU_OPTION("load", spr_menu_icon_none, 0, function()
        {
            text_l = lang("mn_demo_load");
        }, function()
        {
            menu_flow_script_after_shutdown(start_demo_mode_load);
        }, -1));
        menu_screen_add_option(new MENU_OPTION("new", spr_menu_icon_none, 0, function()
        {
            text_l = lang("mn_demo_new");
        }, function()
        {
            menu_ask_question(function()
            {
                menu_flow_script_after_shutdown(start_demo_mode_new, -1);
            }, lang("que_demo_new"), lang("yes"), lang("no"), 1);
        }, -1));
        
        if (ds_map_find_value(global.cleared_levels, 1))
        {
            menu_screen_add_option(new MENU_OPTION("extra", spr_menu_icon_none, 0, function()
            {
                text_l = lang("mn_demo_extra");
            }, function()
            {
                menu_flow_script_after_shutdown(start_demo_mode_extra);
            }, -1));
        }
    }
}
else
{
    menu_screen_add_option(new MENU_OPTION("story", spr_menu_icon_none, 0, function()
    {
        text_l = lang("mn_story");
    }, function()
    {
        // prompt if not connected to server
        if (!(instance_exists(obj_archipelago_client) && obj_archipelago_client.AP_isAuthenticated())) {
            menu_ask_question(function()
            {
                menu_flow_goto_menu_screen(obj_menu_screen_file_select);
            }, "You aren't connected to a Multiworld. Are you sure you want to continue?", lang("yes"), lang("no"), 1);
        } else {
            menu_flow_goto_menu_screen(obj_menu_screen_file_select);
        }
    }, -1));
    
    // New archipelago option
    menu_screen_add_option(new MENU_OPTION("options", spr_menu_icon_none, 0, function()
    {
        text_l = "Archipelago";
    }, function()
    {
        // Create AP client
        if (!instance_exists(obj_archipelago_client))
            instance_create_depth(0, 0, 0, obj_archipelago_client);
        
        global.AP_server = get_string("Enter server IP:", global.AP_server);
        var port = get_string("Enter server port (blank for default):", string(global.AP_port));
        try
        {
            port = real(port);
        }
        catch (e)
        {
            port = 38281;
        }
        global.AP_port = port;
        global.AP_password = get_string("Enter password (blank for none):", global.AP_password);
        global.AP_name = get_string("Enter slot name:", global.AP_name);
        
        obj_archipelago_client.AP_connect(true);
        
        menu_set_top_caption("Connecting...");
    }, -1));
    
    // debug
    /*menu_screen_add_option(new MENU_OPTION("animviewer", spr_menu_icon_none, 0, function()
    {
        text_l = "Anim Viewer";
    }, function()
    {
        menu_flow_goto_room(rm_animviewer);
    }, -1));*/

    menu_screen_add_option(new MENU_OPTION("endless", spr_menu_icon_none, 0, function()
    {
        text_l = lang("mn_endless");
    }, function()
    {
        menu_flow_goto_menu_screen(obj_menu_screen_endless_select);
    }, -1));
    
    if (global.debugging || global.shared_savedata.unlocked_gauntlet)
    {
        menu_screen_add_option(new MENU_OPTION("gauntlet", spr_menu_icon_none, 0, function()
        {
            text_l = lang("mn_gauntlet");
        }, function()
        {
            menu_flow_goto_menu_screen(obj_menu_screen_gauntlet_select);
        }, -1));
    }
    
    if (custom_stage_exist())
    {
        menu_screen_add_option(new MENU_OPTION("custom", spr_menu_icon_none, 0, function()
        {
            text_l = lang("mn_custom");
        }, function()
        {
            var w = custom_stage_exist_workshop();
            var l = custom_stage_exist_local();
            
            if (w && l)
            {
                menu_flow_goto_menu_screen(obj_menu_screen_custom);
            }
            else if (w)
            {
                global.custom_level_playdata.source = 1;
                menu_flow_goto_menu_screen(obj_menu_screen_custom_select);
            }
            else if (l)
            {
                global.custom_level_playdata.source = 0;
                menu_flow_goto_menu_screen(obj_menu_screen_custom_select);
            }
            else
            {
                menu_flow_goto_menu_screen(obj_menu_screen_custom);
            }
        }, -1));
    }
}

if (global.playtest_debugging)
{
    menu_screen_add_option(new MENU_OPTION("stageseldebug", spr_menu_icon_none, 0, function()
    {
        text_l = "TEST StgPick";
    }, function()
    {
        menu_flow_goto_room(rm_stage_picker);
    }, -1));
    menu_screen_add_option(new MENU_OPTION("stageseldebug", spr_menu_icon_none, 0, function()
    {
        text_l = "TEST DebugSc";
    }, function()
    {
        menu_flow_goto_room(rm_debug);
    }, -1));
    
    if (global.debugging)
    {
        menu_screen_add_option(new MENU_OPTION("rapiddebug", spr_menu_icon_none, 0, function()
        {
            text_l = "TEST Rapid";
        }, function()
        {
            instance_create_depth(0, 0, 0, obj_debug_rapidfire_screen_change_test_switch);
            bgm_and_snd_stop();
        }, -1));
        menu_screen_add_option(new MENU_OPTION("rapiddebug2", spr_menu_icon_none, 0, function()
        {
            text_l = "TEST RapidSkel";
        }, function()
        {
            menu_flow_goto_menu_screen(obj_menu_screen_debug_skeletonrapidfire);
        }, -1));
        menu_screen_add_option(new MENU_OPTION("rapiddebug3", spr_menu_icon_none, 0, function()
        {
            text_l = "TEST RapidStPr";
        }, function()
        {
            menu_flow_goto_menu_screen(obj_menu_screen_debug_proprapidfire);
        }, -1));
        menu_screen_add_option(new MENU_OPTION("rapiddebug4", spr_menu_icon_none, 0, function()
        {
            text_l = "TEST RapidStaSel";
        }, function()
        {
            menu_flow_goto_menu_screen(obj_menu_screen_debug_staselrapidfire);
        }, -1));
        menu_screen_add_option(new MENU_OPTION("rapiddebug5", spr_menu_icon_none, 0, function()
        {
            text_l = "TEST RapidStage";
        }, function()
        {
            menu_flow_goto_menu_screen(obj_menu_screen_debug_stagerapidfire);
        }, -1));
    }
}

if (is_demo_version())
{
    menu_screen_add_option(new MENU_OPTION("howto", spr_menu_icon_none, 0, function()
    {
        text_l = lang("mn_howto");
    }, function()
    {
        menu_flow_script_after_shutdown(start_how_to_play);
    }, -1));
}
else
{
    menu_screen_add_option(new MENU_OPTION("extras", spr_menu_icon_none, 0, function()
    {
        text_l = lang("mn_extras");
    }, function()
    {
        menu_flow_goto_menu_screen(obj_menu_screen_extras);
    }, -1));
}

menu_screen_add_option(new MENU_OPTION("options", spr_menu_icon_none, 0, function()
{
    text_l = lang("mn_options");
}, function()
{
    menu_flow_goto_menu_screen(obj_menu_screen_options);
}, -1));
menu_screen_add_option(new MENU_OPTION("credits", spr_menu_icon_none, 0, function()
{
    text_l = lang("mn_credits");
}, function()
{
    menu_flow_goto_menu_screen(obj_menu_screen_credits);
}, -1));
menu_screen_add_option(new MENU_OPTION("exit", spr_menu_icon_none, 0, function()
{
    text_l = lang("mn_exit");
}, function()
{
    menu_ask_question(function()
    {
        game_end();
    }, lang("que_exit"), lang("yes"), lang("no"), 1);
}, -1));

back_action = function()
{
    menu_flow_goto_room(rm_title, true);
};

menu_screen_post_init();
menu_set_top_caption(lang("mc_main"));
menu_set_bottom_caption(lang("mb_select"), lang("mb_back"));
