menu_screen_init("archipelago");

// Create AP client
if (!instance_exists(obj_archipelago_client))
    instance_create_depth(0, 0, 0, obj_archipelago_client);

menu_screen_add_option(new MENU_OPTION("ap_server", spr_menu_icon_none, 0, function()
    {
        text_l = "Server IP";
        text_r = global.AP_server;
    }, function()
    {
        global.AP_server = get_string("Enter server IP:", global.AP_server);
        text_r = global.AP_server;
    }, -1));
menu_screen_add_option(new MENU_OPTION("ap_port", spr_menu_icon_none, 0, function()
    {
        text_l = "Port";
        text_r = string(global.AP_port);
    }, function()
    {
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
        text_r = string(global.AP_port);
    }, -1));
menu_screen_add_option(new MENU_OPTION("ap_password", spr_menu_icon_none, 0, function()
    {
        text_l = "Password";
        text_r = global.AP_password;
    }, function()
    {
        global.AP_password = get_string("Enter password (blank for none):", global.AP_password);
    }, -1));
menu_screen_add_option(new MENU_OPTION("ap_name", spr_menu_icon_none, 0, function()
    {
        text_l = "Slot Name";
        text_r = global.AP_name;
    }, function()
    {
        global.AP_name = get_string("Enter slot name:", global.AP_name);
        text_r = global.AP_name;
    }, -1));
menu_screen_add_option(new MENU_OPTION("ap_connect", spr_menu_icon_none, 0, function()
    {
        text_l = "Connect";
        color = $FF45C4;
        color_secondary = $FF7AD5;
    }, function()
    {
        obj_archipelago_client.AP_connect(true);
        menu_set_top_caption("Connecting...");
    }, -1));

back_action = function()
{
    menu_flow_goto_menu_screen(obj_menu_screen_main, true);
};

menu_screen_post_init();
menu_set_top_caption("Archipelago");
menu_set_bottom_caption(lang("mb_select"), lang("mb_back"));
