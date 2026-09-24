function add_clothes_if_applicable(arg0, arg1, arg2 = false)
{
    if (arg2 || shared_savedata_has_clothes(arg1))
        array_push(arg0, arg1);
}

function get_total_clothes()
{
    return 74;
}

function get_cerise_clothes_list(arg0 = false)
{
    var output = [];
    
    if (global.debugging)
        arg0 = true;
    
    add_clothes_if_applicable(output, "cerise_hat_red", true);
    add_clothes_if_applicable(output, "cerise_hat_blue", arg0);
    add_clothes_if_applicable(output, "cerise_hat_green", arg0);
    add_clothes_if_applicable(output, "cerise_hat_pink", arg0);
    add_clothes_if_applicable(output, "cerise_hat_orange", arg0);
    add_clothes_if_applicable(output, "cerise_hat_purple", arg0);
    add_clothes_if_applicable(output, "cerise_hat_beige", arg0);
    add_clothes_if_applicable(output, "cerise_hat_denim", arg0);
    add_clothes_if_applicable(output, "cerise_hat_tracksuit", arg0);
    add_clothes_if_applicable(output, "cerise_hat_wood", arg0);
    add_clothes_if_applicable(output, "cerise_hat_zigzag", arg0);
    add_clothes_if_applicable(output, "cerise_hat_buoy", arg0);
    add_clothes_if_applicable(output, "cerise_hat_contrast", arg0);
    add_clothes_if_applicable(output, "cerise_hat_sunshine", arg0);
    add_clothes_if_applicable(output, "cerise_hat_icey", arg0);
    add_clothes_if_applicable(output, "cerise_hat_scottish", arg0);
    add_clothes_if_applicable(output, "cerise_hat_elegant", arg0);
    add_clothes_if_applicable(output, "cerise_hat_arcade", arg0);
    add_clothes_if_applicable(output, "cerise_hat_lollipop", arg0);
    add_clothes_if_applicable(output, "cerise_hat_pastel", arg0);
    add_clothes_if_applicable(output, "cerise_hat_angel", arg0);
    add_clothes_if_applicable(output, "cerise_hat_hat", arg0);
    add_clothes_if_applicable(output, "cerise_hat_fuzzy", arg0);
    add_clothes_if_applicable(output, "cerise_hat_recycle", arg0);
    add_clothes_if_applicable(output, "cerise_hat_black", arg0);
    return output;
}

function get_ecru_clothes_list(arg0 = false)
{
    var output = [];
    
    if (global.debugging)
        arg0 = true;
    
    add_clothes_if_applicable(output, "ecru_hat_beige", true);
    add_clothes_if_applicable(output, "ecru_hat_white", arg0);
    add_clothes_if_applicable(output, "ecru_hat_red", arg0);
    add_clothes_if_applicable(output, "ecru_hat_green", arg0);
    add_clothes_if_applicable(output, "ecru_hat_yellow", arg0);
    add_clothes_if_applicable(output, "ecru_hat_blue", arg0);
    add_clothes_if_applicable(output, "ecru_hat_gift", arg0);
    add_clothes_if_applicable(output, "ecru_hat_wood", arg0);
    add_clothes_if_applicable(output, "ecru_hat_zigzag", arg0);
    add_clothes_if_applicable(output, "ecru_hat_wet", arg0);
    add_clothes_if_applicable(output, "ecru_hat_camo", arg0);
    add_clothes_if_applicable(output, "ecru_hat_charcoal", arg0);
    add_clothes_if_applicable(output, "ecru_hat_ice", arg0);
    add_clothes_if_applicable(output, "ecru_hat_polka", arg0);
    add_clothes_if_applicable(output, "ecru_hat_tinfoil", arg0);
    add_clothes_if_applicable(output, "ecru_hat_arcade", arg0);
    add_clothes_if_applicable(output, "ecru_hat_twist", arg0);
    add_clothes_if_applicable(output, "ecru_hat_chicken", arg0);
    add_clothes_if_applicable(output, "ecru_hat_angel", arg0);
    add_clothes_if_applicable(output, "ecru_hat_banana", arg0);
    add_clothes_if_applicable(output, "ecru_hat_gaudy", arg0);
    add_clothes_if_applicable(output, "ecru_hat_vintage", arg0);
    add_clothes_if_applicable(output, "ecru_hat_gold", arg0);
    return output;
}

function get_missnoir_clothes_list(arg0 = false)
{
    var output = [];
    
    if (global.debugging)
        arg0 = true;
    
    add_clothes_if_applicable(output, "missnoir_hat_black", true);
    add_clothes_if_applicable(output, "missnoir_hat_azure", arg0);
    add_clothes_if_applicable(output, "missnoir_hat_spearmint", arg0);
    add_clothes_if_applicable(output, "missnoir_hat_lavender", arg0);
    add_clothes_if_applicable(output, "missnoir_hat_chocolate", arg0);
    add_clothes_if_applicable(output, "missnoir_hat_amaranth", arg0);
    add_clothes_if_applicable(output, "missnoir_hat_silk", arg0);
    add_clothes_if_applicable(output, "missnoir_hat_amber", arg0);
    add_clothes_if_applicable(output, "missnoir_hat_denim", arg0);
    add_clothes_if_applicable(output, "missnoir_hat_mahogany", arg0);
    add_clothes_if_applicable(output, "missnoir_hat_zigzag", arg0);
    add_clothes_if_applicable(output, "missnoir_hat_salmon", arg0);
    add_clothes_if_applicable(output, "missnoir_hat_contrast", arg0);
    add_clothes_if_applicable(output, "missnoir_hat_fiery", arg0);
    add_clothes_if_applicable(output, "missnoir_hat_aurora", arg0);
    add_clothes_if_applicable(output, "missnoir_hat_scottish", arg0);
    add_clothes_if_applicable(output, "missnoir_hat_slate", arg0);
    add_clothes_if_applicable(output, "missnoir_hat_moonlight", arg0);
    add_clothes_if_applicable(output, "missnoir_hat_crimson", arg0);
    add_clothes_if_applicable(output, "missnoir_hat_pop", arg0);
    add_clothes_if_applicable(output, "missnoir_hat_angel", arg0);
    add_clothes_if_applicable(output, "missnoir_hat_cursed", arg0);
    add_clothes_if_applicable(output, "missnoir_hat_noise", arg0);
    add_clothes_if_applicable(output, "missnoir_hat_fuzzy", arg0);
    add_clothes_if_applicable(output, "missnoir_hat_time", arg0);
    add_clothes_if_applicable(output, "missnoir_hat_red", arg0);
    return output;
}

function get_clothes_overlay_properties(arg0)
{
    _over_properties_sprite_cosicon = -1;
    _over_properties_sprite = -1;
    _over_properties_scale = 1;
    _over_properties_no_zoom = false;
    
    switch (arg0)
    {
        case "cerise_hat_denim":
            _over_properties_sprite = spr_cerise_hattex_denim;
            _over_properties_no_zoom = true;
            break;
        
        case "cerise_hat_tracksuit":
            _over_properties_sprite = spr_cerise_hattex_tracksuit;
            _over_properties_no_zoom = true;
            break;
        
        case "cerise_hat_wood":
            _over_properties_sprite = spr_cerise_hattex_wood;
            break;
        
        case "cerise_hat_zigzag":
            _over_properties_sprite = spr_cerise_hattex_zigzag;
            _over_properties_scale = 0.7;
            break;
        
        case "cerise_hat_buoy":
            _over_properties_sprite = spr_cerise_hattex_buoy;
            _over_properties_scale = 0.7;
            break;
        
        case "cerise_hat_contrast":
            _over_properties_sprite = spr_cerise_hattex_contrast;
            _over_properties_no_zoom = true;
            break;
        
        case "cerise_hat_sunshine":
            _over_properties_sprite = spr_cerise_hattex_sunshine;
            break;
        
        case "cerise_hat_icey":
            _over_properties_sprite = spr_cerise_hattex_icey;
            _over_properties_scale = 0.7;
            break;
        
        case "cerise_hat_scottish":
            _over_properties_sprite = spr_cerise_hattex_scottish;
            break;
        
        case "cerise_hat_elegant":
            _over_properties_sprite = spr_cerise_hattex_elegant;
            _over_properties_no_zoom = true;
            break;
        
        case "cerise_hat_arcade":
            _over_properties_sprite = spr_cerise_hattex_arcade;
            _over_properties_scale = 0.7;
            break;
        
        case "cerise_hat_lollipop":
            _over_properties_sprite = spr_cerise_hattex_lollipop;
            _over_properties_scale = 0.5;
            break;
        
        case "cerise_hat_pastel":
            _over_properties_sprite = spr_cerise_hattex_pastel;
            _over_properties_scale = 0.5;
            break;
        
        case "cerise_hat_hat":
            _over_properties_sprite = spr_cerise_hattex_hat;
            _over_properties_scale = 0.44;
            break;
        
        case "cerise_hat_recycle":
            _over_properties_sprite = spr_cerise_hattex_recycle;
            _over_properties_scale = 0.7;
            break;
        
        case "ecru_hat_wood":
            _over_properties_sprite = spr_ecru_hattex_wood;
            break;
        
        case "ecru_hat_zigzag":
            _over_properties_sprite = spr_ecru_hattex_zigzag;
            _over_properties_scale = 0.7;
            break;
        
        case "ecru_hat_camo":
            _over_properties_sprite = spr_ecru_hattex_camo;
            break;
        
        case "ecru_hat_charcoal":
            _over_properties_sprite = spr_ecru_hattex_charcoal;
            _over_properties_no_zoom = true;
            break;
        
        case "ecru_hat_ice":
            _over_properties_sprite = spr_ecru_hattex_ice;
            break;
        
        case "ecru_hat_polka":
            _over_properties_sprite = spr_ecru_hattex_polka;
            break;
        
        case "ecru_hat_tinfoil":
            _over_properties_sprite = spr_ecru_hattex_tinfoil;
            break;
        
        case "ecru_hat_arcade":
            _over_properties_sprite = spr_ecru_hattex_arcade;
            _over_properties_scale = 0.7;
            break;
        
        case "ecru_hat_twist":
            _over_properties_sprite = spr_ecru_hattex_twist;
            _over_properties_scale = 0.7;
            break;
        
        case "ecru_hat_chicken":
            _over_properties_sprite = spr_ecru_hattex_chicken;
            _over_properties_scale = 0.75;
            break;
        
        case "ecru_hat_gold":
            _over_properties_sprite = spr_ecru_hattex_gold;
            break;
        
        case "ecru_hat_vintage":
            _over_properties_sprite = spr_ecru_hattex_vintage;
            _over_properties_scale = 0.7;
            break;
        
        case "ecru_hat_gaudy":
            _over_properties_sprite = spr_ecru_hattex_gaudy;
            _over_properties_scale = 0.7;
            break;
        
        case "missnoir_hat_azure":
            _over_properties_sprite = spr_missnoir_hattex_azure;
            _over_properties_no_zoom = true;
            break;
        
        case "missnoir_hat_spearmint":
            _over_properties_sprite = spr_missnoir_hattex_spearmint;
            _over_properties_no_zoom = true;
            break;
        
        case "missnoir_hat_lavender":
            _over_properties_sprite = spr_missnoir_hattex_lavender;
            _over_properties_no_zoom = true;
            break;
        
        case "missnoir_hat_chocolate":
            _over_properties_sprite = spr_missnoir_hattex_chocolate;
            _over_properties_no_zoom = true;
            break;
        
        case "missnoir_hat_amaranth":
            _over_properties_sprite = spr_missnoir_hattex_amaranth;
            _over_properties_no_zoom = true;
            break;
        
        case "missnoir_hat_silk":
            _over_properties_sprite = spr_missnoir_hattex_silk;
            _over_properties_scale = 0.7;
            break;
        
        case "missnoir_hat_amber":
            _over_properties_sprite = spr_missnoir_hattex_amber;
            _over_properties_scale = 0.7;
            break;
        
        case "missnoir_hat_denim":
            _over_properties_sprite = spr_cerise_hattex_denim;
            _over_properties_no_zoom = true;
            break;
        
        case "missnoir_hat_mahogany":
            _over_properties_sprite = spr_missnoir_hattex_mahogany;
            break;
        
        case "missnoir_hat_zigzag":
            _over_properties_sprite = spr_missnoir_hattex_zigzag;
            _over_properties_scale = 0.7;
            break;
        
        case "missnoir_hat_salmon":
            _over_properties_sprite = spr_missnoir_hattex_salmon;
            _over_properties_scale = 0.7;
            break;
        
        case "missnoir_hat_contrast":
            _over_properties_sprite = spr_cerise_hattex_contrast;
            _over_properties_no_zoom = true;
            break;
        
        case "missnoir_hat_fiery":
            _over_properties_sprite = spr_missnoir_hattex_fiery;
            _over_properties_scale = 0.44;
            break;
        
        case "missnoir_hat_aurora":
            _over_properties_sprite = spr_missnoir_hattex_aurora;
            _over_properties_scale = 0.44;
            break;
        
        case "missnoir_hat_scottish":
            _over_properties_sprite = spr_missnoir_hattex_scottish;
            break;
        
        case "missnoir_hat_slate":
            _over_properties_sprite = spr_missnoir_hattex_slate;
            _over_properties_no_zoom = true;
            break;
        
        case "missnoir_hat_moonlight":
            _over_properties_sprite = spr_missnoir_hattex_moonlight;
            _over_properties_scale = 0.7;
            break;
        
        case "missnoir_hat_crimson":
            _over_properties_sprite = spr_missnoir_hattex_crimson;
            _over_properties_no_zoom = true;
            break;
        
        case "missnoir_hat_pop":
            _over_properties_sprite = spr_missnoir_hattex_pop;
            _over_properties_scale = 0.44;
            break;
        
        case "missnoir_hat_angel":
            break;
        
        case "missnoir_hat_cursed":
            _over_properties_sprite = spr_missnoir_hattex_cursed;
            _over_properties_scale = 0.7;
            break;
        
        case "missnoir_hat_noise":
            _over_properties_sprite = spr_missnoir_hattex_noise;
            _over_properties_no_zoom = true;
            break;
        
        case "missnoir_hat_fuzzy":
            break;
        
        case "missnoir_hat_time":
            _over_properties_sprite = spr_missnoir_hattex_time;
            _over_properties_scale = 0.7;
            break;
        
        case "missnoir_hat_red":
            break;
    }
    
    if (_over_properties_sprite != -1)
    {
        if (string_pos("cerise", arg0) > 0 || string_pos("missnoir", arg0) > 0)
            _over_properties_sprite_cosicon = spr_cosicon_cerise_hat_template;
        
        if (string_pos("ecru", arg0) > 0)
            _over_properties_sprite_cosicon = spr_cosicon_ecru_hat_template;
    }
}

function add_cloth_to_shop(arg0, arg1, arg2)
{
    if (!shared_savedata_has_clothes(arg1))
    {
        get_clothes_overlay_properties(arg1);
        array_push(arg0, 
        {
            name: lang("clothns_" + string(arg1)),
            description: lang("clothde_" + string(arg1)),
            spr: (_over_properties_sprite > -1) ? _over_properties_sprite_cosicon : asset_get_index("spr_cosicon_" + string(arg1)),
            tex_overlay_spr: _over_properties_sprite,
            tex_overlay_scale: _over_properties_scale,
            tex_overlay_no_zoom: _over_properties_no_zoom,
            code: arg1,
            price: arg2,
            owned: 0,
            maxed: false,
            is_cloth: true
        });
    }
}

function add_clothes_to_shop(arg0)
{
    if (instance_exists(obj_archipelago_client) && obj_archipelago_client.AP_isAuthenticated()) {
        add_shop_items_ap(arg0);
        exit;
    }
    
    if (global.player_character == UnknownEnum.Value_0)
    {
        add_cloth_to_shop(arg0, "cerise_hat_blue", 1000);
        add_cloth_to_shop(arg0, "cerise_hat_green", 1000);
        add_cloth_to_shop(arg0, "cerise_hat_pink", 1000);
        add_cloth_to_shop(arg0, "cerise_hat_orange", 1000);
        add_cloth_to_shop(arg0, "cerise_hat_purple", 1000);
        add_cloth_to_shop(arg0, "cerise_hat_beige", 1000);
        add_cloth_to_shop(arg0, "cerise_hat_denim", 3000);
        add_cloth_to_shop(arg0, "cerise_hat_tracksuit", 3000);
        add_cloth_to_shop(arg0, "cerise_hat_wood", 3000);
        
        if (story_progression_has_passed_level(2))
            add_cloth_to_shop(arg0, "cerise_hat_zigzag", 3000);
        
        if (story_progression_has_passed_level(3))
            add_cloth_to_shop(arg0, "cerise_hat_buoy", 3000);
        
        if (story_progression_has_passed_level(4))
            add_cloth_to_shop(arg0, "cerise_hat_contrast", 3000);
        
        if (story_progression_has_passed_level(5))
            add_cloth_to_shop(arg0, "cerise_hat_sunshine", 3000);
        
        if (story_progression_has_passed_level(6))
            add_cloth_to_shop(arg0, "cerise_hat_icey", 3000);
        
        if (story_progression_has_passed_level(7))
            add_cloth_to_shop(arg0, "cerise_hat_scottish", 3000);
        
        if (story_progression_has_passed_level(8))
            add_cloth_to_shop(arg0, "cerise_hat_elegant", 3000);
        
        if (story_progression_has_passed_level(9))
            add_cloth_to_shop(arg0, "cerise_hat_arcade", 3000);
        
        if (is_struct(shared_savedata_get_achievement("showoff")))
            add_cloth_to_shop(arg0, "cerise_hat_lollipop", 3000);
        
        if (is_struct(shared_savedata_get_achievement("superb")))
            add_cloth_to_shop(arg0, "cerise_hat_pastel", 3000);
        
        if (story_progression_has_passed_level(10))
            add_cloth_to_shop(arg0, "cerise_hat_angel", 5000);
        
        if (is_struct(shared_savedata_get_achievement("legend")))
            add_cloth_to_shop(arg0, "cerise_hat_hat", 5000);
        
        if (is_struct(shared_savedata_get_achievement("challenger")))
            add_cloth_to_shop(arg0, "cerise_hat_fuzzy", 5000);
        
        if (is_struct(shared_savedata_get_achievement("loopdeloop")))
            add_cloth_to_shop(arg0, "cerise_hat_recycle", 5000);
        
        if (is_struct(shared_savedata_get_achievement("splendid")))
            add_cloth_to_shop(arg0, "cerise_hat_black", 5000);
    }
    
    if (global.player_character == UnknownEnum.Value_1)
    {
        add_cloth_to_shop(arg0, "ecru_hat_white", 500);
        add_cloth_to_shop(arg0, "ecru_hat_red", 500);
        add_cloth_to_shop(arg0, "ecru_hat_green", 500);
        add_cloth_to_shop(arg0, "ecru_hat_yellow", 500);
        add_cloth_to_shop(arg0, "ecru_hat_blue", 500);
        add_cloth_to_shop(arg0, "ecru_hat_gift", 500);
        add_cloth_to_shop(arg0, "ecru_hat_wood", 3000);
        
        if (story_progression_has_passed_level(2))
            add_cloth_to_shop(arg0, "ecru_hat_zigzag", 3000);
        
        if (story_progression_has_passed_level(3))
            add_cloth_to_shop(arg0, "ecru_hat_wet", 3000);
        
        if (story_progression_has_passed_level(4))
            add_cloth_to_shop(arg0, "ecru_hat_camo", 3000);
        
        if (story_progression_has_passed_level(5))
            add_cloth_to_shop(arg0, "ecru_hat_charcoal", 3000);
        
        if (story_progression_has_passed_level(6))
            add_cloth_to_shop(arg0, "ecru_hat_ice", 3000);
        
        if (story_progression_has_passed_level(7))
            add_cloth_to_shop(arg0, "ecru_hat_polka", 3000);
        
        if (story_progression_has_passed_level(8))
            add_cloth_to_shop(arg0, "ecru_hat_tinfoil", 3000);
        
        if (story_progression_has_passed_level(9))
            add_cloth_to_shop(arg0, "ecru_hat_arcade", 3000);
        
        if (is_struct(shared_savedata_get_achievement("showoff")))
            add_cloth_to_shop(arg0, "ecru_hat_twist", 3000);
        
        if (is_struct(shared_savedata_get_achievement("superb")))
            add_cloth_to_shop(arg0, "ecru_hat_chicken", 3000);
        
        if (story_progression_has_passed_level(10))
            add_cloth_to_shop(arg0, "ecru_hat_angel", 5000);
        
        if (is_struct(shared_savedata_get_achievement("legend")))
            add_cloth_to_shop(arg0, "ecru_hat_banana", 5000);
        
        if (is_struct(shared_savedata_get_achievement("challenger")))
            add_cloth_to_shop(arg0, "ecru_hat_gaudy", 5000);
        
        if (is_struct(shared_savedata_get_achievement("loopdeloop")))
            add_cloth_to_shop(arg0, "ecru_hat_vintage", 5000);
        
        if (is_struct(shared_savedata_get_achievement("splendid")))
            add_cloth_to_shop(arg0, "ecru_hat_gold", 5000);
    }
    
    if (global.player_character == UnknownEnum.Value_4)
    {
        add_cloth_to_shop(arg0, "missnoir_hat_azure", 2000);
        add_cloth_to_shop(arg0, "missnoir_hat_spearmint", 2000);
        add_cloth_to_shop(arg0, "missnoir_hat_lavender", 2000);
        add_cloth_to_shop(arg0, "missnoir_hat_chocolate", 2000);
        add_cloth_to_shop(arg0, "missnoir_hat_amaranth", 3000);
        add_cloth_to_shop(arg0, "missnoir_hat_silk", 2000);
        add_cloth_to_shop(arg0, "missnoir_hat_amber", 2000);
        add_cloth_to_shop(arg0, "missnoir_hat_denim", 3000);
        add_cloth_to_shop(arg0, "missnoir_hat_mahogany", 3000);
        
        if (story_progression_has_passed_level(2))
            add_cloth_to_shop(arg0, "missnoir_hat_zigzag", 3000);
        
        if (story_progression_has_passed_level(3))
            add_cloth_to_shop(arg0, "missnoir_hat_salmon", 3000);
        
        if (story_progression_has_passed_level(4))
            add_cloth_to_shop(arg0, "missnoir_hat_contrast", 3000);
        
        if (story_progression_has_passed_level(5))
            add_cloth_to_shop(arg0, "missnoir_hat_fiery", 3000);
        
        if (story_progression_has_passed_level(6))
            add_cloth_to_shop(arg0, "missnoir_hat_aurora", 3000);
        
        if (story_progression_has_passed_level(7))
            add_cloth_to_shop(arg0, "missnoir_hat_scottish", 3000);
        
        if (story_progression_has_passed_level(8))
            add_cloth_to_shop(arg0, "missnoir_hat_slate", 3000);
        
        if (story_progression_has_passed_level(9))
            add_cloth_to_shop(arg0, "missnoir_hat_moonlight", 3000);
        
        if (is_struct(shared_savedata_get_achievement("showoff")))
            add_cloth_to_shop(arg0, "missnoir_hat_crimson", 3000);
        
        if (is_struct(shared_savedata_get_achievement("superb")))
            add_cloth_to_shop(arg0, "missnoir_hat_pop", 3000);
        
        if (story_progression_has_passed_level(10))
            add_cloth_to_shop(arg0, "missnoir_hat_angel", 5000);
        
        if (is_struct(shared_savedata_get_achievement("legend")))
        {
            add_cloth_to_shop(arg0, "missnoir_hat_cursed", 5000);
            add_cloth_to_shop(arg0, "missnoir_hat_noise", 5000);
        }
        
        if (is_struct(shared_savedata_get_achievement("challenger")))
            add_cloth_to_shop(arg0, "missnoir_hat_fuzzy", 5000);
        
        if (is_struct(shared_savedata_get_achievement("loopdeloop")))
            add_cloth_to_shop(arg0, "missnoir_hat_time", 5000);
        
        if (is_struct(shared_savedata_get_achievement("splendid")))
            add_cloth_to_shop(arg0, "missnoir_hat_red", 5000);
    }
}

function add_ap_item_to_shop(arg0, name, desc, price, location_id, purchased)
{
    var rewardData = AP_get_location_reward_data(location_id);
    var name = AP_get_location_reward_name(location_id, true);
    var desc = string("A strange item from {0}'s world.", rewardData.playerName);
    var price = 500;
    var purchased = (array_contains(obj_archipelago_client.AP_remaining_locations, location_id));
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
        //spr: (_over_properties_sprite > -1) ? _over_properties_sprite_cosicon : asset_get_index("spr_cosicon_" + string(arg1)),
        //tex_overlay_spr: _over_properties_sprite,
        //tex_overlay_scale: _over_properties_scale,
        //tex_overlay_no_zoom: _over_properties_no_zoom,
        location_id: location_id,
        price: price,
        owned: 0,
        maxed: purchased,
        is_ap_item: true
   });
}

// ARCHIPELAGO: handle AP shop items
function add_shop_items_ap(arg0)
{
    var max_shop_items = 25;
    for (var location_id = 299; location_id < max_shop_items + 299) {
        add_ap_item_to_shop(arg0);
    }
}

function adapt_cerise_to_worn_clothes(arg0)
{
    ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_player_hat;
    ds_map_find_value(bone, "hat").display_squeue_sprite[1].sprite = spr_player_beretantennae;
    
    with (ds_map_find_value(bone, "hat"))
    {
        tex_overlay_sprite = -1;
        tex_overlay_sprite_scale = 1;
        tex_overlay_no_zoom = false;
        display_squeue_sprite[0].target_object = -4;
    }
    
    ds_map_find_value(bone, "hat").display_method = ani3d_bone_display_custom_hat;
    ds_map_find_value(bone, "rleg").display_squeue_sprite.sprite = spr_player_leg;
    ds_map_find_value(bone, "lleg").display_squeue_sprite.sprite = spr_player_leg;
    
    if (!is_struct(arg0))
        exit;
    
    assure_struct_has_variable(arg0, "hat", "");
    get_clothes_overlay_properties(arg0.hat);
    
    if (_over_properties_sprite > -1)
    {
        ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_cerise_hat_template;
        ds_map_find_value(bone, "hat").tex_overlay_sprite = _over_properties_sprite;
        ds_map_find_value(bone, "hat").tex_overlay_sprite_scale = _over_properties_scale;
        ds_map_find_value(bone, "hat").tex_overlay_no_zoom = _over_properties_no_zoom;
    }
    
    var legs = spr_player_leg;
    
    switch (arg0.hat)
    {
        case "cerise_hat_blue":
            ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_cerise_hat_blue;
            legs = spr_cerise_leg_blue;
            break;
        
        case "cerise_hat_green":
            ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_cerise_hat_green;
            legs = spr_cerise_leg_green;
            break;
        
        case "cerise_hat_pink":
            ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_cerise_hat_pink;
            legs = spr_cerise_leg_pink;
            break;
        
        case "cerise_hat_orange":
            ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_cerise_hat_orange;
            legs = spr_cerise_leg_orange;
            break;
        
        case "cerise_hat_purple":
            ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_cerise_hat_purple;
            legs = spr_cerise_leg_purple;
            break;
        
        case "cerise_hat_beige":
            ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_cerise_hat_beige;
            legs = spr_cerise_leg_beige;
            break;
        
        case "cerise_hat_denim":
            legs = spr_cerise_leg_black;
            break;
        
        case "cerise_hat_tracksuit":
            legs = spr_cerise_leg_blue;
            break;
        
        case "cerise_hat_wood":
            legs = spr_cerise_leg_beige;
            break;
        
        case "cerise_hat_zigzag":
            legs = spr_cerise_leg_purple;
            break;
        
        case "cerise_hat_buoy":
            legs = spr_cerise_leg_blue;
            break;
        
        case "cerise_hat_sunshine":
            legs = spr_cerise_leg_orange;
            break;
        
        case "cerise_hat_icey":
            legs = spr_cerise_leg_white;
            break;
        
        case "cerise_hat_scottish":
            legs = spr_cerise_leg_black;
            break;
        
        case "cerise_hat_elegant":
            legs = spr_cerise_leg_beige;
            break;
        
        case "cerise_hat_arcade":
            legs = spr_cerise_leg_purple;
            break;
        
        case "cerise_hat_lollipop":
            legs = spr_player_leg;
            break;
        
        case "cerise_hat_angel":
            ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_cerise_hat_angel;
            legs = spr_cerise_leg_white;
            break;
        
        case "cerise_hat_black":
            ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_cerise_hat_black;
            ds_map_find_value(bone, "hat").display_squeue_sprite[1].sprite = spr_cerise_hat_black_antennae;
            legs = spr_cerise_leg_black;
            break;
        
        case "cerise_hat_ecru":
            ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_friend_hat2;
            ds_map_find_value(bone, "hat").display_method = ani3d_bone_display_custom_friend_hat;
            legs = spr_cerise_leg_beige;
            break;
        
        case "cerise_hat_fuzzy":
            ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_cm_hat_fuzzy;
            legs = spr_cerise_leg_beige;
            break;
        
        case "cerise_hat_recycle":
            legs = spr_cerise_leg_mint;
            break;
        
        case "cerise_hat_hat":
            legs = spr_cerise_leg_white;
            break;
    }
    
    ds_map_find_value(bone, "rleg").display_squeue_sprite.sprite = legs;
    ds_map_find_value(bone, "lleg").display_squeue_sprite.sprite = legs;
    
    if (arg0.hat == "cerise_hat_contrast")
    {
        ds_map_find_value(bone, "rleg").display_squeue_sprite.sprite = spr_cerise_leg_white;
        ds_map_find_value(bone, "lleg").display_squeue_sprite.sprite = spr_cerise_leg_black;
    }
    
    if (arg0.hat == "cerise_hat_pastel")
    {
        ds_map_find_value(bone, "rleg").display_squeue_sprite.sprite = spr_cerise_leg_orange;
        ds_map_find_value(bone, "lleg").display_squeue_sprite.sprite = spr_cerise_leg_pink;
    }
}

function adapt_ecru_to_worn_clothes(arg0)
{
    ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_friend_hat2;
    
    with (ds_map_find_value(bone, "hat"))
    {
        tex_overlay_sprite = -1;
        tex_overlay_sprite_scale = 1;
        tex_overlay_no_zoom = false;
        display_squeue_sprite[0].target_object = -4;
    }
    
    if (!is_struct(arg0))
        exit;
    
    assure_struct_has_variable(arg0, "hat", "");
    get_clothes_overlay_properties(arg0.hat);
    
    if (_over_properties_sprite > -1)
    {
        ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_ecru_hat_template;
        ds_map_find_value(bone, "hat").tex_overlay_sprite = _over_properties_sprite;
        ds_map_find_value(bone, "hat").tex_overlay_sprite_scale = _over_properties_scale;
        ds_map_find_value(bone, "hat").tex_overlay_no_zoom = _over_properties_no_zoom;
    }
    
    var legs = spr_friend_leg;
    
    switch (arg0.hat)
    {
        case "ecru_hat_white":
            ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_ecru_hat_white;
            break;
        
        case "ecru_hat_red":
            ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_ecru_hat_red;
            break;
        
        case "ecru_hat_green":
            ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_ecru_hat_green;
            break;
        
        case "ecru_hat_yellow":
            ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_ecru_hat_yellow;
            break;
        
        case "ecru_hat_blue":
            ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_ecru_hat_blue;
            break;
        
        case "ecru_hat_gift":
            ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_ecru_hat_gift;
            break;
        
        case "ecru_hat_wet":
            ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_ecru_hat_wet;
            break;
        
        case "ecru_hat_angel":
            ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_ecru_hat_angel;
            break;
        
        case "ecru_hat_banana":
            ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_ecru_hat_banana;
            break;
    }
    
    ds_map_find_value(bone, "rleg").display_squeue_sprite.sprite = legs;
    ds_map_find_value(bone, "lleg").display_squeue_sprite.sprite = legs;
}

function adapt_missnoir_to_worn_clothes(arg0)
{
    ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_wench_hat;
    ds_map_find_value(bone, "hat").display_squeue_sprite[1].sprite = spr_wench_beretantennae;
    
    with (ds_map_find_value(bone, "hat"))
    {
        tex_overlay_sprite = -1;
        tex_overlay_sprite_scale = 1;
        tex_overlay_no_zoom = false;
        display_squeue_sprite[0].target_object = -4;
    }
    
    ds_map_find_value(bone, "hat").display_method = ani3d_bone_display_custom_hat;
    ds_map_find_value(bone, "rleg").display_squeue_sprite.sprite = spr_wench_leg;
    ds_map_find_value(bone, "lleg").display_squeue_sprite.sprite = spr_wench_leg;
    ds_map_find_value(bone, "rfoot").display_squeue_sprite[0].sprite = spr_wench_footHEEL;
    ds_map_find_value(bone, "rfoot").display_squeue_sprite[1].sprite = spr_wench_footHEEL2;
    ds_map_find_value(bone, "lfoot").display_squeue_sprite[0].sprite = spr_wench_footHEEL;
    ds_map_find_value(bone, "lfoot").display_squeue_sprite[1].sprite = spr_wench_footHEEL2;
    
    if (!is_struct(arg0))
        exit;
    
    assure_struct_has_variable(arg0, "hat", "");
    assure_struct_has_variable(arg0, "bruising", 0);
    get_clothes_overlay_properties(arg0.hat);
    
    if (_over_properties_sprite > -1)
    {
        ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_cerise_hat_template;
        ds_map_find_value(bone, "hat").tex_overlay_sprite = _over_properties_sprite;
        ds_map_find_value(bone, "hat").tex_overlay_sprite_scale = _over_properties_scale;
        ds_map_find_value(bone, "hat").tex_overlay_no_zoom = _over_properties_no_zoom;
    }
    
    var legs = spr_wench_leg;
    var heel1 = spr_wench_footHEEL;
    var heel2 = spr_wench_footHEEL2;
    var hands = spr_wench_hand;
    
    switch (arg0.hat)
    {
        case "missnoir_hat_azure":
            heel1 = spr_missnoir_footHEEL_azure;
            heel2 = spr_missnoir_footHEEL2_azure;
            break;
        
        case "missnoir_hat_spearmint":
            heel1 = spr_missnoir_footHEEL_spearmint;
            heel2 = spr_missnoir_footHEEL2_spearmint;
            break;
        
        case "missnoir_hat_lavender":
            heel1 = spr_missnoir_footHEEL_lavender;
            heel2 = spr_missnoir_footHEEL2_lavender;
            break;
        
        case "missnoir_hat_chocolate":
            heel1 = spr_missnoir_footHEEL_chocolate;
            heel2 = spr_missnoir_footHEEL2_chocolate;
            break;
        
        case "missnoir_hat_amaranth":
            heel1 = spr_missnoir_footHEEL_amaranth;
            heel2 = spr_missnoir_footHEEL2_amaranth;
            break;
        
        case "missnoir_hat_silk":
            heel1 = spr_missnoir_footHEEL_beige;
            heel2 = spr_missnoir_footHEEL2_beige;
            break;
        
        case "missnoir_hat_amber":
            heel1 = spr_missnoir_footHEEL_orange;
            heel2 = spr_missnoir_footHEEL2_orange;
            hands = spr_wench_handWHITE;
            break;
        
        case "missnoir_hat_denim":
            heel1 = spr_missnoir_footHEEL_blue;
            heel2 = spr_missnoir_footHEEL2_blue;
            break;
        
        case "missnoir_hat_mahogany":
            heel1 = spr_missnoir_footHEEL_chocolate;
            heel2 = spr_missnoir_footHEEL2_chocolate;
            break;
        
        case "missnoir_hat_zigzag":
            heel1 = spr_missnoir_footHEEL_amaranth;
            heel2 = spr_missnoir_footHEEL2_amaranth;
            break;
        
        case "missnoir_hat_salmon":
            heel1 = spr_missnoir_footHEEL_orange;
            heel2 = spr_missnoir_footHEEL2_orange;
            break;
        
        case "missnoir_hat_contrast":
            break;
        
        case "missnoir_hat_fiery":
            hands = spr_wench_handWHITE;
            break;
        
        case "missnoir_hat_aurora":
            heel1 = spr_missnoir_footHEEL_spearmint;
            heel2 = spr_missnoir_footHEEL2_spearmint;
            hands = spr_wench_handWHITE;
            break;
        
        case "missnoir_hat_scottish":
            hands = spr_wench_handWHITE;
            break;
        
        case "missnoir_hat_slate":
            heel1 = spr_missnoir_footHEEL_gray;
            heel2 = spr_missnoir_footHEEL2_gray;
            hands = spr_wench_handWHITE;
            break;
        
        case "missnoir_hat_moonlight":
            heel1 = spr_missnoir_footHEEL_azure;
            heel2 = spr_missnoir_footHEEL2_azure;
            hands = spr_wench_handWHITE;
            break;
        
        case "missnoir_hat_crimson":
            heel1 = spr_missnoir_footHEEL_crimson;
            heel2 = spr_missnoir_footHEEL2_crimson;
            hands = spr_wench_handWHITE;
            break;
        
        case "missnoir_hat_pop":
            hands = spr_wench_handWHITE;
            break;
        
        case "missnoir_hat_angel":
            ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_cerise_hat_angel;
            heel1 = spr_missnoir_footHEEL_white;
            heel2 = spr_missnoir_footHEEL2_white;
            hands = spr_wench_handWHITE;
            break;
        
        case "missnoir_hat_cursed":
            heel1 = spr_missnoir_footHEEL_crimson;
            heel2 = spr_missnoir_footHEEL2_crimson;
            break;
        
        case "missnoir_hat_noise":
            hands = spr_wench_handWHITE;
            break;
        
        case "missnoir_hat_fuzzy":
            ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_cm_hat_fuzzy;
            heel1 = spr_missnoir_footHEEL_beige;
            heel2 = spr_missnoir_footHEEL2_beige;
            hands = spr_wench_handWHITE;
            break;
        
        case "missnoir_hat_time":
            heel1 = spr_missnoir_footHEEL_blue;
            heel2 = spr_missnoir_footHEEL2_blue;
            hands = spr_wench_handWHITE;
            break;
        
        case "missnoir_hat_red":
            ds_map_find_value(bone, "hat").display_squeue_sprite[0].sprite = spr_player_hat;
            ds_map_find_value(bone, "hat").display_squeue_sprite[1].sprite = spr_player_beretantennae;
            legs = spr_player_leg;
            heel1 = spr_missnoir_footHEEL_chocolate;
            heel2 = spr_missnoir_footHEEL2_chocolate;
            hands = spr_wench_handWHITE;
            break;
    }
    
    ds_map_find_value(bone, "rleg").display_squeue_sprite.sprite = legs;
    ds_map_find_value(bone, "lleg").display_squeue_sprite.sprite = legs;
    ds_map_find_value(bone, "rfoot").display_squeue_sprite[0].sprite = heel1;
    ds_map_find_value(bone, "rfoot").display_squeue_sprite[1].sprite = heel2;
    ds_map_find_value(bone, "lfoot").display_squeue_sprite[0].sprite = heel1;
    ds_map_find_value(bone, "lfoot").display_squeue_sprite[1].sprite = heel2;
    ds_map_find_value(bone, "rhand").display_squeue_sprite.sprite = hands;
    ds_map_find_value(bone, "lhand").display_squeue_sprite.sprite = hands;
    
    if (arg0.hat == "missnoir_hat_contrast")
    {
        ds_map_find_value(bone, "rfoot").display_squeue_sprite[0].sprite = spr_wench_footHEEL;
        ds_map_find_value(bone, "rfoot").display_squeue_sprite[1].sprite = spr_wench_footHEEL2;
        ds_map_find_value(bone, "lfoot").display_squeue_sprite[0].sprite = spr_missnoir_footHEEL_white;
        ds_map_find_value(bone, "lfoot").display_squeue_sprite[1].sprite = spr_missnoir_footHEEL2_white;
    }
    
    if (arg0.hat == "missnoir_hat_pop")
    {
        ds_map_find_value(bone, "rfoot").display_squeue_sprite[0].sprite = spr_missnoir_footHEEL_pink;
        ds_map_find_value(bone, "rfoot").display_squeue_sprite[1].sprite = spr_missnoir_footHEEL2_pink;
        ds_map_find_value(bone, "lfoot").display_squeue_sprite[0].sprite = spr_missnoir_footHEEL_white;
        ds_map_find_value(bone, "lfoot").display_squeue_sprite[1].sprite = spr_missnoir_footHEEL2_white;
    }
    
    if (arg0.bruising == 1)
    {
        ds_map_find_value(bone, "head").bruising = 1;
        ds_map_find_value(bone, "head").display_squeue_sprite[0].sprite = spr_wench_headlemonOUTSIDE_bruised1;
        ds_map_find_value(bone, "head").display_squeue_sprite[1].sprite = spr_wench_headlemonINSIDE_bruised1;
        ds_map_find_value(bone, "head").model_tuft_texspr = spr_wench_tuft_bruised1;
        ds_map_find_value(bone, "head").model_ear_texspr = spr_wench_ear_bruised;
        ds_map_find_value(bone, "body").display_squeue_sprite.sprite = spr_wench_body_bruised1;
        
        if (ds_map_find_value(bone, "lleg").display_squeue_sprite.sprite == spr_wench_leg)
            ds_map_find_value(bone, "lleg").display_squeue_sprite.sprite = spr_wench_leg_bruised;
        
        if (ds_map_find_value(bone, "rleg").display_squeue_sprite.sprite == spr_wench_leg)
            ds_map_find_value(bone, "rleg").display_squeue_sprite.sprite = spr_wench_leg_bruised;
        
        for (var t = 0; t < 4; t++)
            ds_map_find_value(bone, "tail" + string(t + 1)).display_squeue_sprite.sprite = spr_wench_tail_bruised1;
    }
    
    if (arg0.bruising == 2)
    {
        ds_map_find_value(bone, "head").bruising = 2;
        ds_map_find_value(bone, "head").display_squeue_sprite[0].sprite = spr_wench_headlemonOUTSIDE_bruised2;
        ds_map_find_value(bone, "head").display_squeue_sprite[1].sprite = spr_wench_headlemonINSIDE_bruised2;
        ds_map_find_value(bone, "head").model_tuft_texspr = spr_wench_tuft_bruised2;
        ds_map_find_value(bone, "head").model_ear_texspr = spr_wench_ear_bruised;
        ds_map_find_value(bone, "body").display_squeue_sprite.sprite = spr_wench_body_bruised2;
        ds_map_find_value(bone, "body").bruising = 2;
        
        if (ds_map_find_value(bone, "lleg").display_squeue_sprite.sprite == spr_wench_leg)
            ds_map_find_value(bone, "lleg").display_squeue_sprite.sprite = spr_wench_leg_bruised;
        
        if (ds_map_find_value(bone, "rleg").display_squeue_sprite.sprite == spr_wench_leg)
            ds_map_find_value(bone, "rleg").display_squeue_sprite.sprite = spr_wench_leg_bruised;
        
        for (var t = 0; t < 4; t++)
            ds_map_find_value(bone, "tail" + string(t + 1)).display_squeue_sprite.sprite = spr_wench_tail_bruised2;
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_4 = 4
}
