sprite_set_live(spr_hud_equip_window, true);
sprite_set_live(spr_hud_equip_window_selector, true);
audi_play_simple(snd_equip_open);
yscale = 0;
text_caption = string_upper(lang("eqw_title"));
text_rank_cap = lang("eqw_max_stage_rank");
text_activate = lang("eqw_activate");
textex_activate_scale = (global.fnt_using_compatible == true) ? (0.35 * global.fnt_info_compatible_scale) : 0.35;
textex_activate = new TEXTEX("[[[JUMP]]] " + string(text_activate), (global.fnt_using_compatible == true) ? fnt_info_compatible : global.fnt_info);
warn_color = merge_color(merge_color(c_yellow, c_ltgray, 0.3), c_white, 0.3);
remembered_pcon = global.pause_controller_object;
global.pause_controller_object = -4;
timer = 0;
ptimer = 0;
time = 10;
state = UnknownEnum.Value_0;
state_initialized = false;

change_state = function(arg0)
{
    state = arg0;
    timer = 0;
    ptimer = 0;
    state_initialized = false;
};

chosen = 0;
var refmap = ds_map_create();
var i = 0;
var n = array_length(global.equip_items_data);

while (i < n)
{
    ds_map_set(refmap, global.equip_items_data[i].code, i);
    i++;
}

options = [];
var it = 0;
i = 0;
n = array_length(global.equip_items_usable_ingame);

while (i < n)
{
    var refobj = @@array_get@@(global.equip_items_data, ds_map_find_value(refmap, global.equip_items_usable_ingame[i]));
    
    // ARCHIPELAGO: Allow powerups at any time
    if ((!AP_is_multiworld_active()) && refobj.level_requirement != 0 && !ds_map_exists(global.cleared_levels, refobj.level_requirement))
    {
    }
    else
    {
        array_push(options, refobj);
        options_owned[it] = equip_item_get_owned_number(refobj.code);
        
        if (array_find_index_legacy(global.equip_ban, refobj.code) >= 0)
        {
            options_warning[it] = lang("eqw_banned");
            options_locked[it] = true;
        }
        else if ((refobj.type == UnknownEnum.Value_2 || refobj.type == UnknownEnum.Value_4) && global.objective_fulfilled)
        {
            options_warning[it] = lang("eqw_bonus");
            options_locked[it] = true;
        }
        else if (refobj.type == UnknownEnum.Value_2 && global.splayer_item[0] == UnknownEnum.Value_10 && global.splayer_item_quantity[0] > 0)
        {
            options_warning[it] = lang("eqw_superjump");
            options_locked[it] = true;
        }
        else if (refobj.type == UnknownEnum.Value_2 && global.splayer_item_quantity[0] > 0)
        {
            options_warning[it] = lang("eqw_warning");
            options_locked[it] = false;
        }
        else if (refobj.type == UnknownEnum.Value_3 && !floors_method_is_reversing())
        {
            options_warning[it] = lang("eqw_reverse");
            options_locked[it] = true;
        }
        else
        {
            options_warning[it] = "";
            options_locked[it] = false;
        }
        
        // ARCHIPELAGO: Prevent equipping locked items
        if (AP_is_multiworld_active() && !options_locked[it]) {
            if (!array_contains(global.AP_unlocked_items, refobj.code)) {
                options_warning[it] = "You haven't unlocked this item.";
                options_locked[it] = true;
            }
        }
        
        it++;
    }
    
    i++;
}

ds_map_destroy(refmap);
options_n = array_length(options);
option_w = 80;
flashing = false;
flash = 0;

enum UnknownEnum
{
    Value_0,
    Value_2 = 2,
    Value_3,
    Value_4,
    Value_10 = 10
}
