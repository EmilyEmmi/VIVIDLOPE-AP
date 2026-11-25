function helpful_text_display(arg0)
{
    with (obj_helpful_text)
        close = true;
    
    var o = instance_create_lay(0, 0, 2, obj_helpful_text);
    
    with (o)
    {
        text = lang(arg0);
        
        if (arg0 == "hint_live_item")
            close_on_no_items = true;
        
        if (arg0 == "hint_live_bomb")
            close_on_no_items = true;
    }
    
    return o;
}

function helpful_text_display_raw(arg0)
{
    with (obj_helpful_text)
        close = true;
    
    var o = instance_create_lay(0, 0, 2, obj_helpful_text);
    
    with (o)
        text = arg0;
    
    return o;
}

function helpful_text_display_conditional_on_hint(arg0, arg1)
{
    var n = array_length(arg1);
    
    for (var i = 0; i < n; i++)
    {
        if (!ds_map_exists(global.read_hints, arg1[i]))
        {
            ds_map_set(global.read_hints, @@array_get@@(arg1, i), true);
            return helpful_text_display(arg0);
        }
    }
    
    return -4;
}

function helpful_text_display_item_hint()
{
    helpful_text_display_conditional_on_hint("hint_live_item", ["context_itemget1", "context_itemget2", "context_itemget3", "context_itemget4", "context_itemget5"]);
}

function helpful_text_display_bomb_hint()
{
    helpful_text_display_conditional_on_hint("hint_live_bomb", ["context_bombget1", "context_bombget2", "context_bombget3", "context_bombget4"]);
}

function helpful_text_display_bonus_phase_hint()
{
    helpful_text_display_conditional_on_hint("hint_live_jump", ["context_bonusphase1", "context_bonusphase2", "context_bonusphase3", "context_bonusphase4"]);
}

function helpful_text_display_attire_hint()
{
    var lan = "hint_live_attire_unk";
    
    if (input_is_key_available(16))
        lan = "hint_live_attire_1";
    else if (input_is_key_available(15))
        lan = "hint_live_attire_2";
    else if (input_is_key_available(11))
        lan = "hint_live_attire_3";
    
    helpful_text_display_conditional_on_hint(lan, ["context_attire1", "context_attire2", "context_attire3"]);
}

function helpful_text_display_equip_item_hint()
{
    var lan = "hint_live_equip";
    helpful_text_display_conditional_on_hint(lan, ["context_equipitem1", "context_equipitem2", "context_equipitem3", "context_equipitem4"]);
}

function helpful_text_display_missnoir_fireball()
{
    if (!(global.gmode == UnknownEnum.Value_3 || global.gmode == UnknownEnum.Value_4 || global.gmode == UnknownEnum.Value_1 || global.gmode == UnknownEnum.Value_2))
        return -4;
    
    for (var i = 1; i <= 4; i++)
    {
        if (!ds_map_exists(global.read_hints, "context_msnoirfireA" + string(i)) && AP_has_noir_attack(0))
        {
            ds_map_set(global.read_hints, "context_msnoirfireA" + string(i), true);
            return helpful_text_display("hint_msnoir_special");
        }
        
        if (!ds_map_exists(global.read_hints, "context_msnoirfireB" + string(i)) && AP_has_noir_attack(1))
        {
            ds_map_set(global.read_hints, "context_msnoirfireB" + string(i), true);
            return helpful_text_display("hint_msnoir_special2");
        }
    }
    
    return -4;
}

enum UnknownEnum
{
    Value_1 = 1,
    Value_2,
    Value_3,
    Value_4
}
