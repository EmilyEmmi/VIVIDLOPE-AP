if (minput_pressed(5))
{
    with (obj_hud)
        visible = 1;
    
    money_display_hide(0);
    instance_destroy();
    exit;
}

if (global.playtest_debugging && false && gamepad_button_check_pressed(global._in_key[0][4][0].device, gp_shoulderrb))
{
    global.money += 5000;
    
    with (obj_money_display)
        money_target = global.money;
}

if (scroll_offset == 0)
    unroll_timer += (global.tdelta * 10.5);

if (minput_menu(2))
{
    menu_play_sound_choose();
    scroll_offset = -104;
    chosen[page] = ((chosen[page] + array_length(menu_option[page])) - 1) % array_length(menu_option[page]);
    unroll = -1;
}

if (minput_menu(0))
{
    menu_play_sound_choose();
    scroll_offset = 104;
    chosen[page] = (chosen[page] + 1) % array_length(menu_option[page]);
    unroll = -1;
}

if (page_n > 1)
{
    if (minput_pressed(3) || minput_pressed(1))
    {
        menu_play_sound_change();
        page = !page;
        scroll_offset = 0;
        unroll = -1;
    }
}

var try_purchase = false;

if (minput_pressed(4))
{
    buy_combo = 0;
    
    if (menu_option[page][chosen[page]].price > global.money || equip_item_is_maxed_out(menu_option[page][chosen[page]].code))
        menu_play_sound_disabled();
    else
        try_purchase = true;
}

if (minput_held(4))
{
    var p = buy_combo;
    buy_combo += global.tdelta;
    var c = buy_combo;
    var t = 0;
    var i = 0;
    var n = array_length(buy_combo_times);
    
    while (i < n)
    {
        t += buy_combo_times[i];
        
        if (p < t && c >= t)
            try_purchase = true;
        
        i++;
    }
    
    if (c >= (t + 4))
        buy_combo = t - 1;
}

if (try_purchase)
{
    // handle AP item purchasing
    if (struct_exists(menu_option[page][chosen[page]], "is_ap_item") && menu_option[page][chosen[page]].is_ap_item)
    {
        if (menu_option[page][chosen[page]].price <= global.money && !menu_option[page][chosen[page]].maxed)
        {
            global.money -= menu_option[page][chosen[page]].price;
            global.shop_purchases++;
            
            with (obj_money_display)
                money_target = global.money;
            
            container_play("cnt_menu_purchase");
            
            with (obj_seq_npc_dialogue)
                should_save = true;
            
            menu_play_sound_change();
            
            AP_sendLocation(menu_option[page][chosen[page]].location_id);
            
            menu_option[page][chosen[page]].owned = 1;
            menu_option[page][chosen[page]].maxed = true;
        }
    } else if (!menu_option[page][chosen[page]].is_cloth)
    {
        if (menu_option[page][chosen[page]].price <= global.money && !equip_item_is_maxed_out(menu_option[page][chosen[page]].code))
        {
            global.money -= menu_option[page][chosen[page]].price;
            global.shop_purchases++;
            
            with (obj_money_display)
                money_target = global.money;
            
            container_play("cnt_menu_purchase");
            
            with (obj_seq_npc_dialogue)
                should_save = true;
            
            menu_play_sound_change();
            equip_item_add(menu_option[page][chosen[page]].code, 1);
            
            if (menu_option[page][chosen[page]].code != "1up")
                global.shop_just_bought_equip_item = true;
            
            menu_option[page][chosen[page]].owned = equip_item_get_owned_number(menu_option[page][chosen[page]].code);
            menu_option[page][chosen[page]].maxed = equip_item_is_maxed_out(menu_option[page][chosen[page]].code);
        }
    }
    
    if (menu_option[page][chosen[page]].is_cloth)
    {
        if (menu_option[page][chosen[page]].price <= global.money && !shared_savedata_has_clothes(menu_option[page][chosen[page]].code))
        {
            global.money -= menu_option[page][chosen[page]].price;
            global.shop_purchases++;
            
            with (obj_money_display)
                money_target = global.money;
            
            container_play("cnt_menu_purchase");
            menu_play_sound_change();
            shared_savedata_unlock_clothes(menu_option[page][chosen[page]].code);
            menu_option[page][chosen[page]].owned = 1;
            menu_option[page][chosen[page]].maxed = true;
            
            if (!bought_clothes)
            {
                with (obj_seq_npc_dialogue)
                    should_save = true;
                
                bought_clothes = true;
                
                with (obj_seq_npc_dialogue)
                    array_push(event_array, UnknownEnum.Value_1);
            }
        }
    }
}

scroll_offset = approach(scroll_offset, 0, 32 * global.tdelta);

if (!is_struct(unroll))
{
    unroll = unroll_text_create_adapting(menu_option[page][chosen[page]].description, global.fnt_info, 0.3, 0.3, 0, 1);
    unroll_text_prepare_linebreaks(unroll, 620);
    unroll_timer = 0;
}

enum UnknownEnum
{
    Value_1 = 1
}
