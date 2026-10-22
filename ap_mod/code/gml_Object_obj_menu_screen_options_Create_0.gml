menu_screen_init("options");
language_list = lang_get_list();

if (room == rm_mainmenu)
{
    menu_screen_add_option(new MENU_OPTION("language", spr_menu_icon_none, 0, function()
    {
        text_l = lang("mn_language");
        text_r = "???";
        var codename = global.chosen_language_codename;
        var a = obj_menu_screen_options.language_list;
        var n = array_length(a);
        
        for (var i = 0; i < n; i++)
        {
            if (a[i].filename == codename)
            {
                if (global.fnt_using_compatible == true)
                    text_r = a[i].name_compat;
                else
                    text_r = a[i].name;
                
                break;
            }
        }
    }, -1, function(arg0)
    {
        menu_play_sound_choose();
        var codename = global.chosen_language_codename;
        var a = obj_menu_screen_options.language_list;
        var n = array_length(a);
        var choice = 0;
        
        for (var i = 0; i < n; i++)
        {
            if (a[i].filename == codename)
                choice = i;
        }
        
        var pchoice = choice;
        choice = (choice + n + arg0) % n;
        global.chosen_language_codename = a[choice].filename;
        lang_load(global.chosen_language_codename);
        menu_set_top_caption(lang("mc_options"));
        menu_set_bottom_caption(lang("mb_select"), lang("mb_back"));
        menu_register_option_change();
    }));
}

menu_screen_add_option(new MENU_OPTION("game", spr_menu_icon_none, 0, function()
{
    text_l = lang("mn_game_options");
}, function()
{
    menu_flow_goto_menu_screen(obj_menu_screen_game_options);
}, -1));
menu_screen_add_option(new MENU_OPTION("video", spr_menu_icon_none, 0, function()
{
    text_l = lang("mn_video_options");
}, function()
{
    menu_flow_goto_menu_screen(obj_menu_screen_video_options);
}, -1));
menu_screen_add_option(new MENU_OPTION("audio", spr_menu_icon_none, 0, function()
{
    text_l = lang("mn_audio_options");
}, function()
{
    menu_flow_goto_menu_screen(obj_menu_screen_audio_options);
}, -1));
menu_screen_add_option(new MENU_OPTION("controls", spr_menu_icon_none, 0, function()
{
    text_l = lang("mn_controls");
}, function()
{
    menu_flow_goto_menu_screen(obj_menu_screen_controls);
}, -1));

// AP settings
if (AP_is_multiworld_active(false)){
    menu_screen_add_option(new MENU_OPTION("ap_options", spr_menu_icon_none, 0, function()
    {
        text_l = "AP Options";
        color = #FF45C4;
        color_secondary = #FF7AD5;
    }, function()
    {
        menu_flow_goto_menu_screen(obj_menu_screen_ap_options);
    }, -1));
}

if (!is_demo_version() && room == rm_mainmenu && true)
{
    menu_screen_add_option(new MENU_OPTION("savedata", spr_menu_icon_none, 0, function()
    {
        text_l = lang("mn_save_options");
    }, function()
    {
        menu_flow_goto_menu_screen(obj_menu_screen_savedata_options);
    }, -1));
}

back_action = function()
{
    if (obj_menu_controller.save_config_please)
    {
        obj_menu_controller.save_config_please = false;
        config_save_delayed();
    }
    
    if (room == rm_mainmenu)
        menu_flow_goto_menu_screen(obj_menu_screen_main, true);
    else
        menu_flow_goto_menu_screen(obj_menu_screen_pause, true);
};

menu_screen_post_init();
menu_set_top_caption(lang("mc_options"));
menu_set_bottom_caption(lang("mb_select"), lang("mb_back"));
