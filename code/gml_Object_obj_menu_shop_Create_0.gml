with (obj_hud)
    visible = 0;

money_display_create(64, 48);
chosen[0] = 0;
chosen[1] = 0;
scroll_offset = 0;
dull_color = merge_color(c_ltgray, c_aqua, 0.1);
page = 0;
menu_option[0] = [];
menu_option[1] = [];
add_items_to_shop(menu_option[0], true);
add_clothes_to_shop(menu_option[1]);

if (array_length(menu_option[1]) > 0)
    page_n = 2;
else if (array_length(menu_option[0]) > 0)
    page_n = 1;
else {
    with (obj_hud)
        visible = 1;
    
    money_display_hide(0);
    instance_destroy();
    exit;
}

text_price = lang("shop_price");
text_own = lang("shop_own");
page_name = [string_upper(lang("shop_page_items")), string_upper(lang("shop_page_attires"))];
unroll = -1;
unroll_timer = 0;
buy_combo = 0;
buy_combo_times = [60, 50, 30, 10, 10, 10, 10, 10, 10, 5];
bought_clothes = false;
global.shop_visits++;
