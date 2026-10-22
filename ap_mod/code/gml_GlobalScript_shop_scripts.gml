function update_shop_codes()
{
    var old_map = ds_map_create();
    var got_new = false;
    var test_array = [];
    add_items_to_shop(test_array);
    add_clothes_to_shop(test_array);
    var new_array = array_create(array_length(test_array), "");
    var i = array_length(global.shop_codes) - 1;
    
    while (i >= 0)
    {
        ds_map_set(old_map, global.shop_codes[i], true);
        i--;
    }
    
    i = array_length(test_array) - 1;
    
    while (i >= 0)
    {
        new_array[i] = test_array[i].code;
        
        if (!ds_map_exists(old_map, new_array[i]))
            got_new = true;
        
        i--;
    }
    
    global.shop_codes = new_array;
    ds_map_destroy(old_map);
    return got_new;
}

function add_items_to_shop(arg0, doHint = false)
{
    if (AP_is_multiworld_active()) {
        add_shop_items_ap(arg0, doHint);
        exit;
    }
    
    var i = 0;
    var n = array_length(global.equip_items_data);
    
    while (i < n)
    {
        var s = global.equip_items_data[i];
        
        if (s.level_requirement <= 0 || !is_undefined(ds_map_find_value(global.cleared_levels, s.level_requirement)))
        {
            array_push(arg0, 
            {
                name: lang(s.name_lang),
                description: lang(s.desc_lang),
                spr: s.spr,
                code: s.code,
                price: s.price,
                owned: equip_item_get_owned_number(s.code),
                maxed: equip_item_is_maxed_out(s.code),
                is_cloth: false
            });
        }
        
        i++;
    }
}

function add_ap_item_to_shop(arg0, location_id, doHint = false)
{
    if (!(array_contains(global.AP_remaining_locations, location_id)))
        exit;
 
    if (doHint)
        AP_sendHint(location_id);
    var rewardData = AP_get_location_reward_data(location_id);
    var name = rewardData.itemName;
    var desc = string("A strange item from {0}'s world.", rewardData.playerName);
    if (rewardData.playerName == "Yourself") {
        desc = "A item that belongs to you.";
    }
    var price = 500;
    switch (rewardData.flags)
    {
        case 0: // filler
            desc += " Looks like junk...";
            price = 100;
            break;
        case 1: // progression or progression + useful
        case 3:
            desc += " It looks really important!";
            price = 1000;
            break;
        case 2: // useful
            desc += " Seems like it might be useful...";
            price = 500;
            break;
        case 4: // trap
            desc += " Looks... bad. Is it worth the extra cash?";
            price = -1000;
            break;
    }
        
    array_push(arg0, 
    {
        name: name,
        description: desc,
        spr: spr_ap_item,
        location_id: location_id,
        code: string("AP_{0}", location_id),
        price: price,
        owned: 0,
        maxed: false,
        is_ap_item: true,
        is_cloth: false,
   });
}

// ARCHIPELAGO: handle AP shop items
function add_shop_items_ap(arg0, doHint = false)
{
    var max_shop_items = global.AP_shop_upgrades * 5;
    for (var location_id = 150000; location_id < max_shop_items + 150000; location_id++) {
        add_ap_item_to_shop(arg0, location_id, doHint);
    }
}