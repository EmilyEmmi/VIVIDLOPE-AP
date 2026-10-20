menu_screen_init("ap_options");

// deathlink settings
menu_screen_add_option(new MENU_OPTION("deathlink_toggle", spr_menu_icon_none, 0, function()
{
    text_l = "DeathLink";
    
    if (global.AP_deathlink)
        text_r = lang("on");
    else
        text_r = lang("off");
}, -1, function(arg0)
{
    if (AP_is_multiworld_active(false)) {
        menu_play_sound_change();
        menu_register_option_change();
        global.AP_deathlink = !global.AP_deathlink;
        obj_archipelago_client.AP_write_settings_file();
    }
}, "When you get KOed, all other players with Deathlink enabled receive a death, and vice versa."));

menu_screen_add_option(new MENU_OPTION("deathlink_amnesty", spr_menu_icon_none, 0, function()
{
    text_l = "DL Amnesty";
    text_r = string(global.AP_deathlink_amnesty);
}, -1, function(arg0)
{
    if (AP_is_multiworld_active(false)) {
        menu_play_sound_change();
        menu_register_option_change();
        global.AP_deathlink_amnesty = (global.AP_deathlink_amnesty + arg0 - 1) % 50 + 1;
        obj_archipelago_client.AP_write_settings_file();
    }
}, "You won't send a DeathLink until you are KOed this many times."));

back_action = function()
{
    menu_flow_goto_menu_screen(obj_menu_screen_options, true);
};

menu_screen_post_init();
menu_set_top_caption("AP Options");
menu_set_bottom_caption(lang("mb_select"), lang("mb_back"));
