function add_enemy_spawn(arg0, arg1, arg2 = -1)
{
    ds_map_set(global.enemy_used_map, arg1, true);
    
    if (arg2 < 0)
    {
        if (array_length(global.enemy_spawn_delay_after) > 0)
            arg2 = global.enemy_spawn_delay_after[array_length(global.enemy_spawn_delay_after) - 1];
        else
            arg2 = 100;
    }
    
    if (!is_array(global.enemy_spawn_delay_after))
        global.enemy_spawn_delay_after = [];
    
    repeat (arg0)
    {
        array_push(global.enemy_spawn_order, arg1);
        array_push(global.enemy_spawn_delay_after, arg2);
    }
}

function arcade_add_enemy_spawn_string(arg0)
{
    var shown_error = false;
    
    if (global.endless_loop > 1 || global.endless_level > 5)
    {
        var late_str = arg0;
        arg0 = string_replace_all(arg0, "$s", "");
        arg0 = string_replace_all(arg0, "$B", "");
        
        if (global.endless_loop > 2 || (global.endless_loop > 1 && global.endless_level > 5))
            arg0 = arg0 + arg0 + late_str;
        else
            arg0 += late_str;
    }
    
    var list_repeats = (global.endless_loop > 1) ? 5 : 1;
    
    repeat (list_repeats)
    {
        var i = 1;
        var n = string_length(arg0);
        
        while (i <= n)
        {
            var s = string_char_at(arg0, i) + string_char_at(arg0, i + 1);
            
            switch (s)
            {
                case "  ":
                case "_ ":
                case " _":
                case "__":
                case ", ":
                case " ,":
                case ",,":
                    arcade_add_enemy_spawn();
                    break;
                
                case "Bl":
                    arcade_add_enemy_spawn(obj_blob);
                    break;
                
                case "Bi":
                    arcade_add_enemy_spawn(obj_blib);
                    break;
                
                case "Bu":
                    arcade_add_enemy_spawn(obj_blub);
                    break;
                
                case "Ge":
                    arcade_add_enemy_spawn(obj_gem);
                    break;
                
                case "St":
                    arcade_add_enemy_spawn(obj_star);
                    break;
                
                case "Wo":
                    arcade_add_enemy_spawn(obj_wobbler);
                    break;
                
                case "Sp":
                    arcade_add_enemy_spawn(obj_stopper);
                    break;
                
                case "Sl":
                    arcade_add_enemy_spawn(obj_slinky);
                    break;
                
                case "Le":
                    arcade_add_enemy_spawn(obj_leaper);
                    break;
                
                case "He":
                    arcade_add_enemy_spawn(obj_strongman);
                    break;
                
                case "Ac":
                    arcade_add_enemy_spawn(obj_ace);
                    break;
                
                case "Fu":
                    arcade_add_enemy_spawn(obj_fuse);
                    break;
                
                case "Pr":
                    arcade_add_enemy_spawn(obj_prodigy);
                    break;
                
                case "Oc":
                    arcade_add_enemy_spawn(obj_octi);
                    break;
                
                case "Gh":
                    arcade_add_enemy_spawn(obj_spectre);
                    break;
                
                case "Sn":
                    arcade_add_enemy_spawn(obj_snake);
                    break;
                
                case "Dr":
                    arcade_add_enemy_spawn(obj_draco);
                    break;
                
                case "Re":
                    arcade_add_enemy_spawn(obj_remover);
                    break;
                
                case "Do":
                    arcade_add_enemy_spawn(obj_seeker);
                    break;
                
                case "Mo":
                    arcade_add_enemy_spawn(obj_mole);
                    break;
                
                case "Mm":
                    arcade_add_enemy_spawn(obj_molemage);
                    break;
                
                case "Hm":
                    arcade_add_enemy_spawn(obj_hypermole);
                    break;
                
                case "Ke":
                    arcade_add_enemy_spawn(obj_gero);
                    break;
                
                case "No":
                    arcade_add_enemy_spawn(obj_nooter);
                    break;
                
                case "Uf":
                    arcade_add_enemy_spawn(obj_ufo);
                    break;
                
                case "Vi":
                    arcade_add_enemy_spawn(obj_viruse);
                    break;
                
                case "Gi":
                    arcade_add_enemy_spawn(obj_giraffe);
                    break;
                
                case "Fl":
                    arcade_add_enemy_spawn(obj_flub);
                    break;
                
                case "Cr":
                    arcade_add_enemy_spawn(obj_crescent);
                    break;
                
                case "Ma":
                    arcade_add_enemy_spawn(obj_marble);
                    break;
                
                case "Dc":
                    arcade_add_enemy_spawn(obj_dream);
                    break;
                
                case "Cl":
                    arcade_add_enemy_spawn(obj_clover);
                    break;
                
                case "Pa":
                    arcade_add_enemy_spawn(obj_parrot);
                    break;
                
                case "Ca":
                    arcade_add_enemy_spawn(obj_capsule);
                    break;
                
                case "Vl":
                    arcade_add_enemy_spawn(obj_vlad);
                    break;
                
                case "Ku":
                    arcade_add_enemy_spawn(obj_kuso);
                    break;
                
                case "Su":
                    arcade_add_enemy_spawn(obj_sunsan);
                    break;
                
                case "Sk":
                    arcade_add_enemy_spawn(obj_sparkun);
                    break;
                
                case "Ar":
                    arcade_add_enemy_spawn(obj_arachnid);
                    break;
                
                case "Fb":
                    arcade_add_enemy_spawn(obj_funbag);
                    break;
                
                case "$i":
                    arcade_add_enemy_spawn(obj_powerup_impact);
                    break;
                
                case "$b":
                    arcade_add_enemy_spawn(obj_powerup_bomb);
                    break;
                
                case "$B":
                    arcade_add_enemy_spawn(obj_powerup_instant_bomb);
                    break;
                
                case "$d":
                    arcade_add_enemy_spawn(obj_powerup_dash);
                    break;
                
                case "$p":
                    arcade_add_enemy_spawn(obj_powerup_paint_burst);
                    break;
                
                case "$D":
                    arcade_add_enemy_spawn(obj_powerup_dodge);
                    break;
                
                case "$h":
                    arcade_add_enemy_spawn(obj_powerup_stamphammer);
                    break;
                
                case "$t":
                    arcade_add_enemy_spawn(obj_powerup_paint_balloon);
                    break;
                
                case "$w":
                    arcade_add_enemy_spawn(obj_powerup_wrap_paper);
                    break;
                
                case "$s":
                    arcade_add_enemy_spawn(obj_powerup_shield);
                    break;
                
                default:
                    if (global.debugging && !shown_error)
                    {
                        shown_error = true;
                        show_message("Unknown sequence '" + string(s) + "' detected in endless spawn script '" + string(arg0) + "' at " + string(i) + ". Defaulting to adding an empty spot.");
                    }
                    
                    arcade_add_enemy_spawn();
                    break;
            }
            
            i += 2;
        }
    }
}

function arcade_add_enemy_spawn(arg0 = -1)
{
    if (arg0 < 0)
    {
        if (is_array(global.enemy_spawn_delay_after))
            global.enemy_spawn_delay_after[array_length(global.enemy_spawn_delay_after) - 1] += ceil(global.arcade_delay * 0.5);
        
        exit;
    }
    
    arg0 = endless_swap_enemy(arg0);
    ds_map_set(global.enemy_used_map, arg0, true);
    
    if (!is_array(global.enemy_spawn_delay_after))
        global.enemy_spawn_delay_after = [];
    
    array_push(global.enemy_spawn_order, arg0);
    array_push(global.enemy_spawn_delay_after, global.arcade_delay);
}

function stage_load_properties1()
{
    ds_map_clear(global.enemy_specific_limit);
    global.background_object = obj_bg_ao;
    global.enemy_spawn_order = [];
    ds_map_clear(global.enemy_used_map);
    global.enemy_spawn_delay_after = 100;
    global.floors_palette[UnknownEnum.Value_4] = 3745429;
    floor_scoring_absorb_color(spr_color_set, 1, 3);
    global.equip_ban = [];
    global.enemy_speed_scalar = 1;
}

function stage_load_properties(arg0)
{
    arg0 = string_replace(arg0, "nocounts_", "s_");
    
    if (room == rm_testmobius)
        arg0 = "mobius";
    
    var easy_hand_adjusted = false;
    stage_load_properties1();
    
    switch (arg0)
    {
        case "howto":
        case "playground":
            global.floors_fruit_percent = [90, 95];
            global.floors_required_percent = 85;
            add_enemy_spawn(1, obj_blob, 44);
            global.enemy_popcorn_limit = 16;
            floor_scoring_absorb_color(spr_color_set, 0, 9);
            global.background_object = obj_bg_ao;
            break;
        
        case "overworld":
            global.floors_fruit_percent = [30, 50];
            global.floors_required_percent = 85;
            add_enemy_spawn(1, obj_blob, 44);
            global.enemy_popcorn_limit = 16;
            floor_scoring_absorb_color(spr_color_set, 0, 9);
            global.background_object = obj_bg_atrium;
            break;
        
        case "mobius":
            global.floors_fruit_percent = [20, 40];
            global.floors_required_percent = 70;
            global.enemy_spawn_order = [obj_blob, obj_gem, obj_blib, obj_blib, obj_blob];
            global.enemy_popcorn_limit = 25;
            global.enemy_spawn_delay_after = [4, 4, 4, 4, 100];
            global.floors_palette[0] = 8283204;
            global.floors_palette[2] = 3194600;
            break;
        
        case "elevation":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 75;
            global.enemy_spawn_order = [obj_wobbler, obj_wobbler, obj_wobbler, obj_wobbler, obj_wobbler];
            global.enemy_popcorn_limit = 12;
            global.enemy_spawn_delay_after = 120;
            global.floors_palette[0] = 9982596;
            global.floors_palette[2] = 12881440;
            break;
        
        case "revolve":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 75;
            global.enemy_spawn_order = [obj_blob, obj_gem, obj_gem, obj_gem, obj_blib, obj_blob, obj_blob, obj_gem, obj_blub];
            global.enemy_popcorn_limit = 14;
            global.enemy_standard_limit = 3;
            global.enemy_spawn_delay_after = 120;
            global.floors_palette[0] = 7094404;
            global.floors_palette[2] = 3437272;
            break;
        
        case "gem":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 95;
            add_enemy_spawn(1, obj_draco, 120);
            global.enemy_popcorn_limit = 6;
            global.enemy_standard_limit = 6;
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_sweat;
            break;
        
        case "s_simple":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 80;
            global.enemy_speed_scalar = 0.6;
            add_enemy_spawn(2, obj_blob, 120);
            add_enemy_spawn(1, obj_blob, 180);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(3, obj_blob, 180);
            global.enemy_popcorn_limit = 3;
            global.enemy_standard_limit = 3;
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_air;
            break;
        
        case "s_cyllinder":
            global.floors_fruit_percent = [20, 50];
            global.floors_required_percent = 85;
            global.enemy_speed_scalar = 0.8;
            add_enemy_spawn(1, obj_blob, 180);
            add_enemy_spawn(1, obj_wobbler, 170);
            add_enemy_spawn(1, obj_blob, 140);
            add_enemy_spawn(1, obj_powerup_stamphammer, 120);
            add_enemy_spawn(5, obj_blob, 140);
            add_enemy_spawn(1, obj_powerup_bomb, 120);
            add_enemy_spawn(3, obj_blob, 140);
            global.enemy_popcorn_limit = 7;
            global.enemy_spawn_delay_after = 120;
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_depart;
            break;
        
        case "s_S":
            global.floors_fruit_percent = [35, 60];
            global.floors_required_percent = 80;
            add_enemy_spawn(3, obj_blob, 200);
            add_enemy_spawn(1, obj_powerup_bomb, 150);
            add_enemy_spawn(4, obj_blob, 200);
            global.enemy_popcorn_limit = 5;
            floor_scoring_absorb_color(spr_color_set, 0, 1);
            global.background_object = obj_bg_birdeye;
            break;
        
        case "s_toilet":
            global.floors_fruit_percent = [30, 60];
            global.floors_required_percent = 90;
            add_enemy_spawn(3, obj_blub, 200);
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(1, obj_powerup_impact, 150);
            add_enemy_spawn(4, obj_blub, 200);
            global.enemy_popcorn_limit = 3;
            global.enemy_standard_limit = 7;
            floor_scoring_absorb_color(spr_color_set, 0, 1);
            global.background_object = obj_bg_leap;
            break;
        
        case "s_firstdiamond":
            global.floors_fruit_percent = [30, 40];
            global.floors_required_percent = 80;
            global.enemy_speed_scalar = 0.8;
            add_enemy_spawn(8, obj_gem, 150);
            add_enemy_spawn(1, obj_powerup_bomb, 150);
            add_enemy_spawn(7, obj_gem, 140);
            add_enemy_spawn(1, obj_blob, 140);
            global.enemy_popcorn_limit = 9;
            floor_scoring_absorb_color(spr_color_set, 0, 1);
            global.background_object = obj_bg_memory;
            break;
        
        case "s_clockflower":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 80;
            add_enemy_spawn(2, obj_blob, 120);
            add_enemy_spawn(1, obj_powerup_stamphammer, 120);
            add_enemy_spawn(8, obj_blob, 120);
            add_enemy_spawn(1, obj_powerup_bomb, 120);
            add_enemy_spawn(6, obj_blob, 120);
            global.enemy_popcorn_limit = 9;
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_air;
            break;
        
        case "s_dropthedrop":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 90;
            global.enemy_speed_scalar = 0.8;
            add_enemy_spawn(5, obj_blob, 170);
            add_enemy_spawn(1, obj_powerup_bomb, 180);
            add_enemy_spawn(6, obj_blob, 150);
            add_enemy_spawn(1, obj_gem, 140);
            add_enemy_spawn(1, obj_powerup_bomb, 180);
            global.enemy_popcorn_limit = 8;
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_depart;
            break;
        
        case "s_crossbullet":
            global.floors_fruit_percent = [20, 40];
            global.floors_required_percent = 80;
            global.enemy_speed_scalar = 0.9;
            add_enemy_spawn(1, obj_blob, 190);
            add_enemy_spawn(2, obj_blob, 140);
            add_enemy_spawn(1, obj_blob, 150);
            add_enemy_spawn(2, obj_blob, 140);
            add_enemy_spawn(1, obj_blub, 140);
            add_enemy_spawn(1, obj_powerup_impact, 150);
            add_enemy_spawn(1, obj_blob, 180);
            add_enemy_spawn(2, obj_blob, 100);
            global.enemy_popcorn_limit = 6;
            global.enemy_standard_limit = 2;
            floor_scoring_absorb_color(spr_color_set, 0, 2);
            global.background_object = obj_bg_birdeye;
            break;
        
        case "s_doublebendplane":
            global.floors_fruit_percent = [20, 40];
            global.floors_required_percent = 90;
            add_enemy_spawn(2, obj_blob, 150);
            add_enemy_spawn(2, obj_wobbler, 150);
            add_enemy_spawn(2, obj_blob, 150);
            add_enemy_spawn(2, obj_wobbler, 150);
            add_enemy_spawn(1, obj_leaper, 100);
            global.enemy_popcorn_limit = 12;
            ds_map_set(global.enemy_specific_limit, obj_wobbler, 4);
            ds_map_set(global.enemy_specific_limit, obj_leaper, 1);
            floor_scoring_absorb_color(spr_color_set, 0, 5);
            global.background_object = obj_bg_leap;
            break;
        
        case "s_jumpdown":
            global.floors_fruit_percent = [10, 45];
            global.floors_required_percent = 90;
            global.enemy_speed_scalar = 0.9;
            add_enemy_spawn(4, obj_blob, 160);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 180);
            add_enemy_spawn(1, obj_wobbler, 140);
            add_enemy_spawn(4, obj_blob, 120);
            add_enemy_spawn(2, obj_blub, 120);
            add_enemy_spawn(1, obj_powerup_bomb, 180);
            global.enemy_popcorn_limit = 6;
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_memory;
            break;
        
        case "s_keyhammer":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 90;
            global.enemy_speed_scalar = 0.8;
            add_enemy_spawn(3, obj_blob, 150);
            add_enemy_spawn(2, obj_wobbler, 150);
            add_enemy_spawn(2, obj_blob, 120);
            add_enemy_spawn(1, obj_powerup_stamphammer, 180);
            add_enemy_spawn(2, obj_blob, 120);
            add_enemy_spawn(1, obj_wobbler, 120);
            add_enemy_spawn(3, obj_blob, 120);
            add_enemy_spawn(1, obj_wobbler, 120);
            add_enemy_spawn(1, obj_powerup_bomb, 180);
            global.enemy_popcorn_limit = 5;
            ds_map_set(global.enemy_specific_limit, obj_blob, 4);
            ds_map_set(global.enemy_specific_limit, obj_wobbler, 3);
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_air;
            break;
        
        case "s_racetrack":
            global.floors_fruit_percent = [20, 40];
            global.floors_required_percent = 80;
            add_enemy_spawn(4, obj_blob, 120);
            add_enemy_spawn(1, obj_powerup_stamphammer, 120);
            add_enemy_spawn(6, obj_blob, 120);
            add_enemy_spawn(2, obj_leaper, 120);
            global.enemy_popcorn_limit = 5;
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_depart;
            break;
        
        case "s_firststair":
            global.floors_fruit_percent = [10, 50];
            global.floors_required_percent = 85;
            add_enemy_spawn(5, obj_blob, 160);
            add_enemy_spawn(1, obj_powerup_impact, 180);
            add_enemy_spawn(2, obj_gem, 140);
            add_enemy_spawn(3, obj_blob, 120);
            add_enemy_spawn(1, obj_powerup_bomb, 180);
            add_enemy_spawn(2, obj_gem, 140);
            global.enemy_popcorn_limit = 8;
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_leap;
            break;
        
        case "s_invader":
            global.floors_fruit_percent = [20, 40];
            global.floors_required_percent = 80;
            add_enemy_spawn(1, obj_flub, 180);
            add_enemy_spawn(1, obj_powerup_stamphammer, 150);
            add_enemy_spawn(1, obj_gem, 180);
            add_enemy_spawn(1, obj_blob, 130);
            add_enemy_spawn(1, obj_flub, 180);
            add_enemy_spawn(1, obj_gem, 180);
            add_enemy_spawn(1, obj_blob, 130);
            add_enemy_spawn(1, obj_powerup_stamphammer, 150);
            add_enemy_spawn(3, obj_blob, 200);
            add_enemy_spawn(3, obj_blob, 190);
            add_enemy_spawn(2, obj_gem, 120);
            global.enemy_popcorn_limit = 7;
            floor_scoring_absorb_color(spr_color_set, 0, 2);
            global.background_object = obj_bg_memory;
            break;
        
        case "s_thefoxbox":
            global.floors_fruit_percent = [20, 45];
            global.floors_required_percent = 90;
            add_enemy_spawn(1, obj_blob, 140);
            add_enemy_spawn(2, obj_leaper, 200);
            add_enemy_spawn(1, obj_blob, 140);
            add_enemy_spawn(2, obj_leaper, 140);
            add_enemy_spawn(1, obj_powerup_impact, 150);
            add_enemy_spawn(1, obj_blob, 140);
            add_enemy_spawn(2, obj_leaper, 200);
            add_enemy_spawn(1, obj_blob, 140);
            add_enemy_spawn(2, obj_leaper, 140);
            global.enemy_popcorn_limit = 6;
            global.enemy_standard_limit = 4;
            ds_map_set(global.enemy_specific_limit, obj_leaper, 3);
            floor_scoring_absorb_color(spr_color_set, 0, 2);
            global.background_object = obj_bg_memory;
            break;
        
        case "s_springstripe":
            global.floors_fruit_percent = [20, 40];
            global.floors_required_percent = 90;
            add_enemy_spawn(1, obj_blob, 160);
            add_enemy_spawn(1, obj_blob, 160);
            add_enemy_spawn(1, obj_blob, 160);
            add_enemy_spawn(1, obj_blob, 160);
            add_enemy_spawn(2, obj_blub, 160);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(2, obj_blob, 160);
            add_enemy_spawn(2, obj_gem, 164);
            add_enemy_spawn(1, obj_leaper, 164);
            add_enemy_spawn(1, obj_blub, 144);
            add_enemy_spawn(1, obj_powerup_bomb, 120);
            add_enemy_spawn(2, obj_blob, 134);
            add_enemy_spawn(1, obj_leaper, 140);
            add_enemy_spawn(3, obj_blob, 134);
            global.enemy_popcorn_limit = 7;
            global.enemy_standard_limit = 7;
            global.enemy_speed_scalar = 0.8;
            floor_scoring_absorb_color(spr_color_set, 0, 9);
            global.background_object = obj_bg_prime;
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_ticktockgrid":
            global.floors_fruit_percent = [20, 40];
            global.floors_required_percent = 90;
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(1, obj_blob, 200);
            add_enemy_spawn(1, obj_dream, 200);
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(1, obj_wobbler, 160);
            add_enemy_spawn(1, obj_dream, 200);
            add_enemy_spawn(3, obj_blob, 200);
            add_enemy_spawn(1, obj_dream, 200);
            add_enemy_spawn(1, obj_wobbler, 160);
            global.enemy_popcorn_limit = 4;
            global.enemy_standard_limit = 4;
            global.enemy_speed_scalar = 0.75;
            floor_scoring_absorb_color(spr_color_set, 0, 9);
            global.background_object = obj_bg_aqua;
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_switchtable":
            global.floors_fruit_percent = [25, 40];
            global.floors_required_percent = 85;
            add_enemy_spawn(3, obj_blub, 200);
            add_enemy_spawn(2, obj_dream, 200);
            add_enemy_spawn(1, obj_powerup_impact, 150);
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(2, obj_blub, 200);
            add_enemy_spawn(3, obj_blub, 200);
            add_enemy_spawn(2, obj_stopper, 200);
            add_enemy_spawn(1, obj_powerup_impact, 150);
            add_enemy_spawn(1, obj_leaper, 200);
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(2, obj_blub, 200);
            global.enemy_speed_scalar = 0.9;
            global.enemy_popcorn_limit = 5;
            global.enemy_standard_limit = 2;
            floor_scoring_absorb_color(spr_color_set, 0, 1);
            global.background_object = obj_bg_reflex;
            break;
        
        case "s_shuricube":
            global.floors_fruit_percent = [20, 40];
            global.floors_required_percent = 80;
            add_enemy_spawn(1, obj_stopper, 180);
            add_enemy_spawn(1, obj_powerup_dash, 150);
            add_enemy_spawn(1, obj_slinky, 180);
            add_enemy_spawn(1, obj_stopper, 130);
            add_enemy_spawn(1, obj_stopper, 180);
            add_enemy_spawn(1, obj_slinky, 180);
            add_enemy_spawn(1, obj_stopper, 130);
            add_enemy_spawn(1, obj_powerup_dash, 150);
            add_enemy_spawn(3, obj_stopper, 100);
            add_enemy_spawn(3, obj_stopper, 90);
            add_enemy_spawn(2, obj_blob, 120);
            global.enemy_popcorn_limit = 10;
            global.enemy_standard_limit = 4;
            global.enemy_speed_scalar = 0.8;
            floor_scoring_absorb_color(spr_color_set, 0, 3);
            global.background_object = obj_bg_mandel;
            break;
        
        case "s_PARTY":
            global.floors_fruit_percent = [30, 65];
            global.floors_required_percent = 90;
            add_enemy_spawn(4, obj_blob, 200);
            add_enemy_spawn(1, obj_flub, 200);
            add_enemy_spawn(4, obj_blob, 200);
            add_enemy_spawn(1, obj_powerup_impact, 200);
            global.enemy_popcorn_limit = 8;
            global.background_object = obj_bg_reflex;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_1;
            break;
        
        case "s_lungertrail":
            global.floors_fruit_percent = [60, 75];
            global.floors_required_percent = 95;
            add_enemy_spawn(3, obj_blob, 160);
            add_enemy_spawn(1, obj_blub, 160);
            add_enemy_spawn(3, obj_blob, 160);
            add_enemy_spawn(2, obj_gem, 160);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            global.enemy_popcorn_limit = 11;
            floor_scoring_absorb_color(spr_color_set, 0, 9);
            global.background_object = obj_bg_aqua;
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_summit":
            global.floors_fruit_percent = [30, 50];
            global.floors_required_percent = 70;
            global.enemy_speed_scalar = 0.85;
            add_enemy_spawn(3, obj_blob, 100);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(1, obj_wobbler, 104);
            add_enemy_spawn(1, obj_blob, 104);
            add_enemy_spawn(1, obj_gem, 124);
            add_enemy_spawn(1, obj_wobbler, 104);
            add_enemy_spawn(1, obj_blob, 104);
            add_enemy_spawn(1, obj_powerup_bomb, 120);
            add_enemy_spawn(1, obj_blub, 104);
            global.enemy_popcorn_limit = 12;
            ds_map_set(global.enemy_specific_limit, obj_wobbler, 4);
            floor_scoring_absorb_color(spr_color_set, 0, 9);
            global.background_object = obj_bg_leap;
            break;
        
        case "s_crosstokeytosix":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 80;
            add_enemy_spawn(1, obj_powerup_shield, 150);
            add_enemy_spawn(1, obj_blob, 220);
            add_enemy_spawn(1, obj_dream, 220);
            add_enemy_spawn(1, obj_gem, 220);
            add_enemy_spawn(2, obj_snake, 220);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 150);
            add_enemy_spawn(3, obj_flub, 220);
            add_enemy_spawn(2, obj_snake, 220);
            add_enemy_spawn(1, obj_blob, 220);
            add_enemy_spawn(1, obj_dream, 220);
            add_enemy_spawn(1, obj_blob, 220);
            add_enemy_spawn(1, obj_powerup_bomb, 150);
            add_enemy_spawn(1, obj_blob, 220);
            global.enemy_popcorn_limit = 12;
            global.enemy_standard_limit = 5;
            floor_scoring_absorb_color(spr_color_set, 0, 2);
            global.background_object = obj_bg_bond;
            global.floors_method = UnknownEnum.Value_1;
            break;
        
        case "s_bouncepark":
            global.floors_fruit_percent = [20, 40];
            global.floors_required_percent = 70;
            add_enemy_spawn(1, obj_blob, 200);
            add_enemy_spawn(1, obj_snake, 200);
            add_enemy_spawn(2, obj_stopper, 200);
            add_enemy_spawn(2, obj_flub, 200);
            add_enemy_spawn(1, obj_powerup_stamphammer, 120);
            add_enemy_spawn(3, obj_blob, 200);
            add_enemy_spawn(1, obj_wobbler, 160);
            add_enemy_spawn(3, obj_flub, 200);
            add_enemy_spawn(1, obj_snake, 160);
            global.enemy_popcorn_limit = 11;
            global.enemy_standard_limit = 11;
            ds_map_set(global.enemy_specific_limit, obj_snake, 3);
            floor_scoring_absorb_color(spr_color_set, 0, 9);
            global.background_object = obj_bg_aqua;
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_bronx":
            global.floors_fruit_percent = [20, 40];
            global.floors_required_percent = 85;
            add_enemy_spawn(4, obj_gem, 200);
            add_enemy_spawn(1, obj_stopper, 200);
            add_enemy_spawn(1, obj_gem, 150);
            add_enemy_spawn(2, obj_blub, 150);
            add_enemy_spawn(1, obj_stopper, 150);
            add_enemy_spawn(1, obj_gem, 150);
            add_enemy_spawn(1, obj_snake, 150);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 150);
            add_enemy_spawn(2, obj_gem, 200);
            add_enemy_spawn(1, obj_stopper, 150);
            add_enemy_spawn(2, obj_gem, 200);
            global.enemy_popcorn_limit = 8;
            global.enemy_standard_limit = 2;
            ds_map_set(global.enemy_specific_limit, obj_snake, 2);
            global.background_object = obj_bg_veridisquo;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_simplerevert":
            global.floors_fruit_percent = [30, 60];
            global.floors_required_percent = 90;
            add_enemy_spawn(5, obj_blob, 200);
            add_enemy_spawn(1, obj_powerup_bomb, 120);
            add_enemy_spawn(6, obj_blob, 140);
            global.enemy_popcorn_limit = 6;
            global.background_object = obj_bg_cock;
            floor_scoring_absorb_color(spr_color_set, 2, 0);
            global.floors_method = UnknownEnum.Value_2;
            break;
        
        case "s_stairshift":
            global.floors_fruit_percent = [30, 50];
            global.floors_required_percent = 85;
            add_enemy_spawn(1, obj_leaper, 220);
            add_enemy_spawn(3, obj_flub, 120);
            add_enemy_spawn(1, obj_powerup_impact, 150);
            add_enemy_spawn(3, obj_flub, 220);
            add_enemy_spawn(3, obj_blob, 220);
            add_enemy_spawn(3, obj_flub, 220);
            add_enemy_spawn(1, obj_leaper, 220);
            add_enemy_spawn(1, obj_powerup_bomb, 150);
            add_enemy_spawn(1, obj_blob, 220);
            global.enemy_popcorn_limit = 15;
            global.enemy_standard_limit = 5;
            ds_map_set(global.enemy_specific_limit, obj_leaper, (global.stage_difficulty > 0.5) ? 2 : 1);
            floor_scoring_absorb_color(spr_color_set, 0, 2);
            global.background_object = obj_bg_veridisquo;
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_hingedbackloop":
            global.floors_fruit_percent = [15, 40];
            global.floors_required_percent = 70;
            add_enemy_spawn(2, obj_blob, 120);
            add_enemy_spawn(1, obj_powerup_stamphammer, 120);
            add_enemy_spawn(2, obj_blob, 120);
            add_enemy_spawn(2, obj_gem, 120);
            add_enemy_spawn(3, obj_blob, 120);
            add_enemy_spawn(1, obj_snake, 120);
            add_enemy_spawn(1, obj_slinky, 120);
            add_enemy_spawn(1, obj_powerup_dash, 120);
            add_enemy_spawn(2, obj_gem, 120);
            add_enemy_spawn(3, obj_blob, 120);
            add_enemy_spawn(1, obj_snake, 120);
            add_enemy_spawn(1, obj_slinky, 120);
            add_enemy_spawn(1, obj_stopper, 120);
            global.enemy_popcorn_limit = 7;
            global.background_object = obj_bg_platinum;
            floor_scoring_absorb_color(spr_color_set, 1, 3);
            global.floors_method = UnknownEnum.Value_1;
            break;
        
        case "s_bop":
            global.floors_fruit_percent = [20, 40];
            global.floors_required_percent = 75;
            add_enemy_spawn(1, obj_blob, 160);
            add_enemy_spawn(1, obj_dream, 160);
            add_enemy_spawn(2, obj_wobbler, 160);
            add_enemy_spawn(1, obj_powerup_shield, 120);
            add_enemy_spawn(2, obj_blob, 160);
            add_enemy_spawn(2, obj_gem, 164);
            add_enemy_spawn(1, obj_wobbler, 164);
            add_enemy_spawn(1, obj_clover, 144);
            add_enemy_spawn(1, obj_powerup_bomb, 120);
            add_enemy_spawn(2, obj_dream, 134);
            add_enemy_spawn(1, obj_wobbler, 140);
            add_enemy_spawn(3, obj_blob, 134);
            global.enemy_popcorn_limit = 11;
            global.enemy_standard_limit = 3;
            floor_scoring_absorb_color(spr_color_set, 0, 9);
            global.background_object = obj_bg_prime;
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_castleibiza":
            global.floors_fruit_percent = [20, 40];
            global.floors_required_percent = 80;
            add_enemy_spawn(2, obj_wobbler, 200);
            add_enemy_spawn(1, obj_blob, 220);
            add_enemy_spawn(2, obj_clover, 200);
            add_enemy_spawn(1, obj_blob, 200);
            add_enemy_spawn(1, obj_dream, 200);
            add_enemy_spawn(1, obj_blob, 200);
            add_enemy_spawn(1, obj_powerup_stamphammer, 120);
            add_enemy_spawn(1, obj_leaper, 200);
            add_enemy_spawn(1, obj_blob, 200);
            add_enemy_spawn(1, obj_dream, 200);
            add_enemy_spawn(1, obj_wobbler, 200);
            add_enemy_spawn(1, obj_blob, 200);
            add_enemy_spawn(1, obj_clover, 200);
            add_enemy_spawn(1, obj_blob, 200);
            add_enemy_spawn(2, obj_dream, 200);
            add_enemy_spawn(1, obj_blob, 200);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 120);
            add_enemy_spawn(1, obj_blub, 200);
            add_enemy_spawn(1, obj_blob, 200);
            add_enemy_spawn(1, obj_dream, 200);
            global.enemy_popcorn_limit = 8;
            global.enemy_standard_limit = 3;
            global.background_object = obj_bg_ascent;
            global.enemy_speed_scalar = 0.9;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_1;
            
            break;
        
        case "s_beachcube":
            global.floors_fruit_percent = [30, 50];
            global.floors_required_percent = 80;
            add_enemy_spawn(1, obj_octi, 160);
            add_enemy_spawn(2, obj_blub, 160);
            add_enemy_spawn(1, obj_powerup_stamphammer, 120);
            add_enemy_spawn(2, obj_octi, 164);
            add_enemy_spawn(1, obj_blob, 164);
            add_enemy_spawn(1, obj_blub, 154);
            add_enemy_spawn(3, obj_blob, 144);
            add_enemy_spawn(1, obj_powerup_bomb, 120);
            add_enemy_spawn(2, obj_octi, 134);
            add_enemy_spawn(1, obj_blub, 140);
            add_enemy_spawn(3, obj_blob, 134);
            global.enemy_popcorn_limit = 12;
            floor_scoring_absorb_color(spr_color_set, 0, 9);
            global.background_object = obj_bg_breeze;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_1;
            
            break;
        
        case "s_lanecapsule":
            global.floors_fruit_percent = [10, 30];
            global.floors_required_percent = 90;
            add_enemy_spawn(1, obj_blob, 150);
            add_enemy_spawn(1, obj_powerup_dash, 140);
            add_enemy_spawn(2, obj_slinky, 150);
            add_enemy_spawn(2, obj_leaper, 120);
            add_enemy_spawn(1, obj_stopper, 150);
            add_enemy_spawn(1, obj_powerup_dash, 120);
            add_enemy_spawn(3, obj_octi, 150);
            add_enemy_spawn(2, obj_slinky, 180);
            add_enemy_spawn(2, obj_clover, 120);
            add_enemy_spawn(1, obj_dream, 150);
            global.enemy_popcorn_limit = 12;
            global.enemy_standard_limit = 4;
            global.background_object = obj_bg_ao;
            floor_scoring_absorb_color(spr_color_set, 1, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_1;
            
            break;
        
        case "s_slider":
            global.floors_fruit_percent = [20, 40];
            global.floors_required_percent = 95;
            add_enemy_spawn(1, obj_snake, 200);
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(1, obj_wobbler, 300);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(1, obj_snake, 200);
            add_enemy_spawn(2, obj_flub, 200);
            add_enemy_spawn(1, obj_snake, 200);
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(1, obj_wobbler, 300);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(1, obj_leaper, 200);
            add_enemy_spawn(2, obj_flub, 200);
            global.enemy_popcorn_limit = 7;
            global.enemy_standard_limit = 3;
            global.enemy_speed_scalar = 0.9;
            ds_map_set(global.enemy_specific_limit, obj_leaper, 1);
            ds_map_set(global.enemy_specific_limit, obj_wobbler, 2);
            ds_map_set(global.enemy_specific_limit, obj_snake, 2);
            global.background_object = obj_bg_reflex;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_mobius":
            global.floors_fruit_percent = [15, 50];
            global.floors_required_percent = 85;
            add_enemy_spawn(1, obj_slinky, 200);
            add_enemy_spawn(1, obj_powerup_dash, 120);
            add_enemy_spawn(1, obj_wobbler, 200);
            add_enemy_spawn(1, obj_blob, 200);
            add_enemy_spawn(2, obj_gem, 200);
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(1, obj_blub, 200);
            add_enemy_spawn(1, obj_slinky, 200);
            add_enemy_spawn(2, obj_gem, 200);
            add_enemy_spawn(2, obj_blob, 220);
            global.enemy_popcorn_limit = 15;
            global.enemy_standard_limit = 4;
            global.background_object = obj_bg_trance;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_1;
            break;
        
        case "s_handkerchief":
            global.floors_fruit_percent = [20, 50];
            global.floors_required_percent = 85;
            add_enemy_spawn(3, obj_blob, 230);
            add_enemy_spawn(1, obj_wobbler, 230);
            add_enemy_spawn(1, obj_snake, 230);
            add_enemy_spawn(1, obj_powerup_instant_bomb, 120);
            add_enemy_spawn(4, obj_blob, 200);
            add_enemy_spawn(1, obj_snake, 200);
            add_enemy_spawn(2, obj_blub, 200);
            global.enemy_popcorn_limit = 16;
            global.enemy_standard_limit = 3;
            global.background_object = obj_bg_hope;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_tumorbone":
            global.floors_fruit_percent = [20, 40];
            global.floors_required_percent = 75;
            add_enemy_spawn(1, obj_octi, 120);
            add_enemy_spawn(1, obj_wobbler, 120);
            add_enemy_spawn(1, obj_octi, 120);
            add_enemy_spawn(1, obj_wobbler, 120);
            add_enemy_spawn(1, obj_blub, 120);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(2, obj_octi, 124);
            add_enemy_spawn(1, obj_wobbler, 124);
            add_enemy_spawn(3, obj_blob, 124);
            add_enemy_spawn(1, obj_blub, 124);
            add_enemy_spawn(3, obj_blob, 124);
            add_enemy_spawn(1, obj_powerup_bomb, 120);
            add_enemy_spawn(2, obj_octi, 114);
            add_enemy_spawn(1, obj_blub, 120);
            add_enemy_spawn(3, obj_blob, 124);
            global.enemy_popcorn_limit = 18;
            global.enemy_standard_limit = 6;
            floor_scoring_absorb_color(spr_color_set, 0, 9);
            global.background_object = obj_bg_citrus;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_1;
            
            break;
        
        case "s_opposites":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 75;
            add_enemy_spawn(2, obj_blob, 160);
            add_enemy_spawn(2, obj_clover, 160);
            add_enemy_spawn(1, obj_powerup_paint_balloon, 120);
            add_enemy_spawn(2, obj_gem, 164);
            add_enemy_spawn(3, obj_blob, 164);
            add_enemy_spawn(1, obj_blub, 144);
            add_enemy_spawn(1, obj_powerup_stamphammer, 120);
            add_enemy_spawn(1, obj_blob, 134);
            add_enemy_spawn(1, obj_clover, 134);
            add_enemy_spawn(1, obj_blub, 140);
            add_enemy_spawn(3, obj_blob, 134);
            global.enemy_popcorn_limit = 15;
            floor_scoring_absorb_color(spr_color_set, 0, 9);
            global.background_object = obj_bg_citrus;
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_droppertriangle":
            global.floors_fruit_percent = [30, 60];
            global.floors_required_percent = 85;
            add_enemy_spawn(2, obj_wobbler, 80);
            add_enemy_spawn(1, obj_blob, 80);
            add_enemy_spawn(1, obj_blub, 130);
            add_enemy_spawn(1, obj_blob, 130);
            add_enemy_spawn(1, obj_powerup_impact, 150);
            add_enemy_spawn(1, obj_blob, 100);
            add_enemy_spawn(1, obj_stopper, 100);
            add_enemy_spawn(1, obj_blob, 100);
            add_enemy_spawn(1, obj_blub, 90);
            add_enemy_spawn(1, obj_blob, 120);
            add_enemy_spawn(1, obj_stopper, 120);
            add_enemy_spawn(1, obj_powerup_dash, 150);
            global.enemy_popcorn_limit = 10;
            floor_scoring_absorb_color(spr_color_set, 0, 2);
            global.background_object = obj_bg_breathe;
            global.floors_method = UnknownEnum.Value_1;
            break;
        
        case "s_starfish":
            global.floors_fruit_percent = [30, 50];
            global.floors_required_percent = 80;
            add_enemy_spawn(3, obj_blob, 160);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(2, obj_gem, 164);
            add_enemy_spawn(3, obj_blob, 164);
            add_enemy_spawn(1, obj_octi, 144);
            add_enemy_spawn(1, obj_powerup_bomb, 120);
            add_enemy_spawn(2, obj_blob, 134);
            add_enemy_spawn(1, obj_blub, 140);
            add_enemy_spawn(3, obj_blob, 134);
            global.enemy_popcorn_limit = 9;
            floor_scoring_absorb_color(spr_color_set, 0, 9);
            global.background_object = obj_bg_dip;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_1;
            else
                global.floors_method = UnknownEnum.Value_3;
            
            break;
        
        case "s_curvedH":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 80;
            add_enemy_spawn(3, obj_blob, 220);
            add_enemy_spawn(1, obj_octi, 220);
            add_enemy_spawn(1, obj_powerup_dash, 150);
            add_enemy_spawn(2, obj_flub, 220);
            add_enemy_spawn(2, obj_slinky, 220);
            add_enemy_spawn(3, obj_blob, 220);
            add_enemy_spawn(1, obj_powerup_bomb, 150);
            add_enemy_spawn(2, obj_blob, 220);
            global.enemy_popcorn_limit = 14;
            global.enemy_standard_limit = 6;
            floor_scoring_absorb_color(spr_color_set, 0, 2);
            global.background_object = obj_bg_deep;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_1;
            
            break;
        
        case "s_oceanman":
            global.floors_fruit_percent = [20, 40];
            global.floors_required_percent = 90;
            add_enemy_spawn(2, obj_clover, 30);
            add_enemy_spawn(1, obj_flub, 120);
            add_enemy_spawn(2, obj_blub, 230);
            add_enemy_spawn(2, obj_blob, 330);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(3, obj_leaper, 230);
            add_enemy_spawn(2, obj_flub, 230);
            add_enemy_spawn(1, obj_blub, 330);
            add_enemy_spawn(2, obj_blob, 230);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 120);
            add_enemy_spawn(1, obj_flub, 230);
            add_enemy_spawn(2, obj_leaper, 230);
            add_enemy_spawn(2, obj_clover, 30);
            global.enemy_popcorn_limit = 14;
            global.enemy_standard_limit = 10;
            ds_map_set(global.enemy_specific_limit, obj_leaper, 3);
            ds_map_set(global.enemy_specific_limit, obj_octi, 3);
            ds_map_set(global.enemy_specific_limit, obj_clover, 3);
            global.background_object = obj_bg_millennium;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_1;
            break;
        
        case "s_upupspringstairs":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 75;
            add_enemy_spawn(2, obj_blob, 160);
            add_enemy_spawn(2, obj_wobbler, 160);
            add_enemy_spawn(1, obj_powerup_paint_balloon, 120);
            add_enemy_spawn(2, obj_blob, 164);
            add_enemy_spawn(1, obj_blub, 164);
            add_enemy_spawn(1, obj_blob, 144);
            add_enemy_spawn(1, obj_wobbler, 144);
            add_enemy_spawn(1, obj_powerup_stamphammer, 120);
            add_enemy_spawn(2, obj_blob, 134);
            add_enemy_spawn(1, obj_blub, 140);
            add_enemy_spawn(3, obj_blob, 134);
            global.enemy_popcorn_limit = 15;
            floor_scoring_absorb_color(spr_color_set, 0, 9);
            global.background_object = obj_bg_breeze;
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_binarystair":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 75;
            add_enemy_spawn(2, obj_clover, 200);
            add_enemy_spawn(1, obj_blob, 200);
            add_enemy_spawn(1, obj_dream, 200);
            add_enemy_spawn(1, obj_blub, 150);
            add_enemy_spawn(1, obj_blob, 150);
            add_enemy_spawn(1, obj_clover, 150);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 150);
            add_enemy_spawn(1, obj_stopper, 150);
            add_enemy_spawn(1, obj_blob, 150);
            add_enemy_spawn(1, obj_dream, 150);
            add_enemy_spawn(1, obj_blub, 100);
            add_enemy_spawn(1, obj_blob, 100);
            add_enemy_spawn(1, obj_leaper, 100);
            global.enemy_popcorn_limit = 10;
            global.enemy_standard_limit = 5;
            ds_map_set(global.enemy_specific_limit, obj_leaper, 3);
            ds_map_set(global.enemy_specific_limit, obj_snake, 6);
            global.background_object = obj_bg_veridisquo;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_keyfisher":
            global.floors_fruit_percent = [10, 40];
            global.floors_required_percent = 70;
            add_enemy_spawn(3, obj_blob, 120);
            add_enemy_spawn(2, obj_wobbler, 120);
            add_enemy_spawn(1, obj_flub, 120);
            add_enemy_spawn(1, obj_powerup_stamphammer, 120);
            add_enemy_spawn(3, obj_blob, 120);
            add_enemy_spawn(1, obj_flub, 120);
            add_enemy_spawn(2, obj_blob, 120);
            global.enemy_popcorn_limit = 8;
            ds_map_set(global.enemy_specific_limit, obj_blob, 7);
            ds_map_set(global.enemy_specific_limit, obj_flub, 3);
            ds_map_set(global.enemy_specific_limit, obj_wobbler, 3);
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_breeze;
            break;
        
        case "s_pill":
            global.floors_fruit_percent = [20, 40];
            global.floors_required_percent = 90;
            add_enemy_spawn(2, obj_seeker, 100);
            add_enemy_spawn(1, obj_powerup_dash, 120);
            add_enemy_spawn(1, obj_flub, 120);
            add_enemy_spawn(2, obj_snake, 230);
            add_enemy_spawn(2, obj_blub, 230);
            add_enemy_spawn(2, obj_blob, 330);
            add_enemy_spawn(3, obj_seeker, 230);
            add_enemy_spawn(2, obj_flub, 230);
            add_enemy_spawn(1, obj_blub, 330);
            add_enemy_spawn(2, obj_blob, 230);
            global.enemy_popcorn_limit = 14;
            global.enemy_standard_limit = 10;
            ds_map_set(global.enemy_specific_limit, obj_seeker, 4);
            ds_map_set(global.enemy_specific_limit, obj_snake, 2);
            global.background_object = obj_bg_millennium;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_1;
            break;
        
        case "s_spookhouse":
            global.floors_fruit_percent = [15, 40];
            global.floors_required_percent = 80;
            add_enemy_spawn(1, obj_blob, 230);
            add_enemy_spawn(3, obj_spectre, 230);
            add_enemy_spawn(2, obj_blob, 230);
            add_enemy_spawn(1, obj_powerup_paint_balloon, 120);
            add_enemy_spawn(3, obj_spectre, 230);
            add_enemy_spawn(2, obj_blob, 230);
            add_enemy_spawn(2, obj_snake, 230);
            global.enemy_popcorn_limit = 13;
            global.enemy_standard_limit = 4;
            ds_map_set(global.enemy_specific_limit, obj_spectre, 7);
            ds_map_set(global.enemy_specific_limit, obj_snake, 2);
            global.background_object = obj_bg_overover;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_tick":
            global.floors_fruit_percent = [20, 40];
            global.floors_required_percent = 95;
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(1, obj_crescent, 200);
            add_enemy_spawn(1, obj_blob, 200);
            add_enemy_spawn(1, obj_spectre, 200);
            add_enemy_spawn(2, obj_blub, 200);
            add_enemy_spawn(4, obj_flub, 200);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(1, obj_spectre, 200);
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(2, obj_flub, 200);
            global.enemy_popcorn_limit = 12;
            global.enemy_standard_limit = 4;
            global.background_object = obj_bg_inward;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_1;
            break;
        
        case "s_shieldface":
            global.floors_fruit_percent = [10, 35];
            global.floors_required_percent = 85;
            add_enemy_spawn(3, obj_blob, 160);
            add_enemy_spawn(1, obj_blub, 200);
            add_enemy_spawn(1, obj_snake, 200);
            add_enemy_spawn(4, obj_blob, 160);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(6, obj_blob, 160);
            add_enemy_spawn(2, obj_blub, 200);
            global.enemy_popcorn_limit = 14;
            ds_map_set(global.enemy_specific_limit, obj_blob, 8);
            ds_map_set(global.enemy_specific_limit, obj_blub, 3);
            ds_map_set(global.enemy_specific_limit, obj_snake, 2);
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_luna;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_invadertable":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 80;
            add_enemy_spawn(1, obj_blob, 300);
            add_enemy_spawn(1, obj_crescent, 300);
            add_enemy_spawn(2, obj_spectre, 300);
            add_enemy_spawn(1, obj_powerup_impact, 300);
            add_enemy_spawn(1, obj_crescent, 300);
            add_enemy_spawn(1, obj_gem, 300);
            add_enemy_spawn(1, obj_crescent, 300);
            add_enemy_spawn(1, obj_gem, 300);
            add_enemy_spawn(2, obj_spectre, 300);
            add_enemy_spawn(1, obj_powerup_paint_balloon, 300);
            add_enemy_spawn(2, obj_gem, 300);
            global.enemy_popcorn_limit = 9;
            global.enemy_standard_limit = 3;
            global.background_object = obj_bg_descent;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_1;
            
            break;
        
        case "s_bearcourse":
            global.floors_fruit_percent = [30, 50];
            global.floors_required_percent = 90;
            add_enemy_spawn(2, obj_crescent, 230);
            add_enemy_spawn(1, obj_blub, 230);
            add_enemy_spawn(2, obj_flub, 230);
            add_enemy_spawn(2, obj_spectre, 230);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 120);
            add_enemy_spawn(3, obj_flub, 230);
            add_enemy_spawn(2, obj_crescent, 230);
            add_enemy_spawn(2, obj_blub, 230);
            global.enemy_popcorn_limit = 13;
            global.enemy_standard_limit = 6;
            ds_map_set(global.enemy_specific_limit, obj_snake, 4);
            global.background_object = obj_bg_descent;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_humanloop":
            global.floors_fruit_percent = [30, 50];
            global.floors_required_percent = 90;
            add_enemy_spawn(2, obj_slinky, 230);
            add_enemy_spawn(1, obj_snake, 230);
            add_enemy_spawn(1, obj_flub, 230);
            add_enemy_spawn(1, obj_capsule, 230);
            add_enemy_spawn(2, obj_gem, 230);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 120);
            add_enemy_spawn(1, obj_flub, 230);
            add_enemy_spawn(1, obj_capsule, 230);
            add_enemy_spawn(1, obj_flub, 230);
            add_enemy_spawn(2, obj_slinky, 230);
            add_enemy_spawn(2, obj_snake, 230);
            global.enemy_popcorn_limit = 13;
            global.enemy_standard_limit = 6;
            ds_map_set(global.enemy_specific_limit, obj_slinky, 4);
            ds_map_set(global.enemy_specific_limit, obj_snake, 4);
            global.background_object = obj_bg_luna;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_1;
            break;
        
        case "s_infinitefear":
            global.floors_fruit_percent = [15, 25];
            global.floors_required_percent = 85;
            
            repeat (3)
            {
                add_enemy_spawn(2, obj_capsule, 240);
                add_enemy_spawn(1, obj_stopper, 240);
                add_enemy_spawn(2, obj_slinky, 240);
                add_enemy_spawn(1, obj_seeker, 240);
                add_enemy_spawn(1, obj_stopper, 240);
            }
            
            add_enemy_spawn(1, obj_powerup_dash, 100);
            global.enemy_popcorn_limit = 16;
            global.enemy_standard_limit = 8;
            ds_map_set(global.enemy_specific_limit, obj_seeker, 2);
            ds_map_set(global.enemy_specific_limit, obj_slinky, 5);
            global.background_object = obj_bg_luna;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_1;
            else
                global.floors_method = UnknownEnum.Value_3;
            
            break;
        
        case "s_montezuma":
            global.floors_fruit_percent = [20, 45];
            global.floors_required_percent = 75;
            add_enemy_spawn(1, obj_snake, 100);
            add_enemy_spawn(2, obj_slinky, 100);
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(1, obj_powerup_stamphammer, 200);
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(2, obj_flub, 100);
            add_enemy_spawn(1, obj_snake, 100);
            add_enemy_spawn(2, obj_slinky, 100);
            global.enemy_popcorn_limit = 14;
            global.enemy_standard_limit = 7;
            global.enemy_speed_scalar = 0.95;
            ds_map_set(global.enemy_specific_limit, obj_slinky, 4);
            ds_map_set(global.enemy_specific_limit, obj_snake, 3);
            global.background_object = obj_bg_luna;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_1;
            
            break;
        
        case "s_vania":
            global.floors_fruit_percent = [30, 50];
            global.floors_required_percent = 95;
            add_enemy_spawn(2, obj_capsule, 230);
            add_enemy_spawn(1, obj_seeker, 230);
            add_enemy_spawn(1, obj_snake, 230);
            add_enemy_spawn(2, obj_capsule, 230);
            add_enemy_spawn(2, obj_gem, 230);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 120);
            add_enemy_spawn(3, obj_blob, 230);
            add_enemy_spawn(2, obj_slinky, 230);
            add_enemy_spawn(2, obj_snake, 230);
            add_enemy_spawn(2, obj_seeker, 230);
            global.enemy_popcorn_limit = 16;
            global.enemy_standard_limit = 8;
            ds_map_set(global.enemy_specific_limit, obj_slinky, 2);
            ds_map_set(global.enemy_specific_limit, obj_snake, 3);
            ds_map_set(global.enemy_specific_limit, obj_seeker, 3);
            global.background_object = obj_bg_luna;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_1;
            
            break;
        
        case "s_discovery":
            global.floors_fruit_percent = [10, 40];
            global.floors_required_percent = 85;
            add_enemy_spawn(1, obj_blob, 100);
            add_enemy_spawn(1, obj_gem, 100);
            add_enemy_spawn(1, obj_capsule, 100);
            add_enemy_spawn(1, obj_gem, 100);
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(1, obj_spectre, 230);
            add_enemy_spawn(1, obj_snake, 230);
            add_enemy_spawn(2, obj_crescent, 230);
            add_enemy_spawn(2, obj_gem, 230);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(3, obj_crescent, 230);
            add_enemy_spawn(2, obj_spectre, 230);
            add_enemy_spawn(2, obj_snake, 230);
            add_enemy_spawn(2, obj_blub, 230);
            global.enemy_popcorn_limit = 16;
            global.enemy_speed_scalar = 1.1;
            global.enemy_standard_limit = 8;
            ds_map_set(global.enemy_specific_limit, obj_spectre, 2);
            ds_map_set(global.enemy_specific_limit, obj_snake, 3);
            global.background_object = obj_bg_luna;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_titanic":
            global.floors_fruit_percent = [20, 40];
            global.floors_required_percent = 85;
            add_enemy_spawn(1, obj_spectre, 100);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 100);
            add_enemy_spawn(1, obj_crescent, 100);
            add_enemy_spawn(1, obj_spectre, 100);
            add_enemy_spawn(1, obj_crescent, 100);
            add_enemy_spawn(1, obj_spectre, 100);
            add_enemy_spawn(1, obj_stopper, 100);
            add_enemy_spawn(1, obj_seeker, 100);
            add_enemy_spawn(1, obj_powerup_instant_bomb, 100);
            add_enemy_spawn(6, obj_crescent, 100);
            global.enemy_popcorn_limit = 11;
            global.enemy_standard_limit = 6;
            ds_map_set(global.enemy_specific_limit, obj_spectre, 4);
            global.background_object = obj_bg_luna;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_curvesheet":
            global.floors_fruit_percent = [10, 60];
            global.floors_required_percent = 90;
            add_enemy_spawn(2, obj_blob, 230);
            add_enemy_spawn(1, obj_powerup_bomb, 120);
            add_enemy_spawn(8, obj_blob, 200);
            add_enemy_spawn(1, obj_powerup_bomb, 120);
            add_enemy_spawn(8, obj_blob, 200);
            add_enemy_spawn(1, obj_powerup_stamphammer, 120);
            add_enemy_spawn(6, obj_blob, 200);
            global.enemy_popcorn_limit = 8;
            global.enemy_standard_limit = 3;
            global.background_object = obj_bg_fret;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_4;
            break;
        
        case "s_ancientroller":
            global.floors_fruit_percent = [15, 40];
            global.floors_required_percent = 90;
            add_enemy_spawn(2, obj_spectre, 150);
            add_enemy_spawn(1, obj_clover, 150);
            add_enemy_spawn(1, obj_wobbler, 150);
            add_enemy_spawn(1, obj_powerup_stamphammer, 150);
            add_enemy_spawn(1, obj_clover, 150);
            add_enemy_spawn(1, obj_crescent, 220);
            add_enemy_spawn(1, obj_spectre, 220);
            add_enemy_spawn(2, obj_spectre, 220);
            add_enemy_spawn(1, obj_powerup_stamphammer, 150);
            add_enemy_spawn(2, obj_crescent, 220);
            add_enemy_spawn(2, obj_clover, 220);
            add_enemy_spawn(1, obj_powerup_bomb, 150);
            add_enemy_spawn(1, obj_blob, 220);
            global.enemy_popcorn_limit = 13;
            global.enemy_standard_limit = 5;
            floor_scoring_absorb_color(spr_color_set, 0, 2);
            global.background_object = obj_bg_pulse;
            global.floors_method = UnknownEnum.Value_1;
            break;
        
        case "s_castlesiege":
            global.floors_fruit_percent = [10, 40];
            global.floors_required_percent = 75;
            add_enemy_spawn(3, obj_flub, 100);
            add_enemy_spawn(1, obj_spectre, 200);
            add_enemy_spawn(1, obj_seeker, 200);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 200);
            add_enemy_spawn(1, obj_snake, 100);
            add_enemy_spawn(3, obj_flub, 100);
            add_enemy_spawn(1, obj_spectre, 200);
            add_enemy_spawn(1, obj_seeker, 200);
            add_enemy_spawn(3, obj_flub, 100);
            global.enemy_popcorn_limit = 14;
            global.enemy_standard_limit = 6;
            global.enemy_speed_scalar = 0.95;
            ds_map_set(global.enemy_specific_limit, obj_seeker, 2);
            ds_map_set(global.enemy_specific_limit, obj_spectre, 2);
            ds_map_set(global.enemy_specific_limit, obj_snake, 2);
            global.background_object = obj_bg_luna;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_sweetnessfollows":
            global.floors_fruit_percent = [20, 50];
            global.floors_required_percent = 80;
            add_enemy_spawn(1, obj_spectre, 100);
            add_enemy_spawn(1, obj_blob, 100);
            add_enemy_spawn(1, obj_spectre, 100);
            add_enemy_spawn(1, obj_stopper, 100);
            add_enemy_spawn(1, obj_spectre, 100);
            add_enemy_spawn(1, obj_stopper, 100);
            add_enemy_spawn(1, obj_powerup_impact, 100);
            add_enemy_spawn(6, obj_blob, 100);
            global.enemy_popcorn_limit = 11;
            global.enemy_standard_limit = 6;
            ds_map_set(global.enemy_specific_limit, obj_spectre, 4);
            global.background_object = obj_bg_luna;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_heatingup":
            global.floors_fruit_percent = [30, 65];
            global.floors_required_percent = 95;
            add_enemy_spawn(3, obj_blob, 200);
            add_enemy_spawn(1, obj_giraffe, 200);
            add_enemy_spawn(1, obj_wobbler, 200);
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(3, obj_blob, 180);
            add_enemy_spawn(1, obj_powerup_stamphammer, 120);
            add_enemy_spawn(1, obj_giraffe, 120);
            add_enemy_spawn(3, obj_blob, 180);
            add_enemy_spawn(2, obj_flub, 180);
            add_enemy_spawn(2, obj_blob, 180);
            add_enemy_spawn(1, obj_powerup_bomb, 120);
            global.enemy_popcorn_limit = 12;
            global.enemy_standard_limit = 4;
            global.background_object = obj_bg_sweat;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_joystick":
            global.floors_fruit_percent = [20, 50];
            global.floors_required_percent = 80;
            add_enemy_spawn(2, obj_blob, 160);
            add_enemy_spawn(2, obj_mole, 160);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(1, obj_octi, 160);
            add_enemy_spawn(2, obj_blob, 160);
            add_enemy_spawn(2, obj_slinky, 160);
            add_enemy_spawn(2, obj_blob, 160);
            add_enemy_spawn(1, obj_octi, 200);
            add_enemy_spawn(6, obj_blob, 160);
            global.enemy_popcorn_limit = 15;
            ds_map_set(global.enemy_specific_limit, obj_blob, 8);
            ds_map_set(global.enemy_specific_limit, obj_octi, 4);
            ds_map_set(global.enemy_specific_limit, obj_slinky, 4);
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_glare;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_1;
            
            break;
        
        case "s_desertwarmup":
            global.floors_fruit_percent = [20, 50];
            global.floors_required_percent = 75;
            add_enemy_spawn(2, obj_blob, 160);
            add_enemy_spawn(1, obj_powerup_shield, 160);
            add_enemy_spawn(2, obj_snake, 160);
            add_enemy_spawn(3, obj_blob, 160);
            add_enemy_spawn(1, obj_snake, 160);
            add_enemy_spawn(1, obj_stopper, 160);
            add_enemy_spawn(2, obj_blob, 160);
            add_enemy_spawn(1, obj_powerup_paint_balloon, 160);
            add_enemy_spawn(2, obj_snake, 160);
            add_enemy_spawn(3, obj_blob, 160);
            add_enemy_spawn(1, obj_snake, 160);
            add_enemy_spawn(1, obj_stopper, 160);
            add_enemy_spawn(2, obj_blob, 160);
            global.enemy_popcorn_limit = 14;
            ds_map_set(global.enemy_specific_limit, obj_blob, 7);
            ds_map_set(global.enemy_specific_limit, obj_stopper, 4);
            ds_map_set(global.enemy_specific_limit, obj_snake, 4);
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_glare;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_sushi":
            global.floors_fruit_percent = [20, 50];
            global.floors_required_percent = 80;
            add_enemy_spawn(1, obj_blob, 300);
            add_enemy_spawn(2, obj_giraffe, 300);
            add_enemy_spawn(1, obj_sunsan, 300);
            add_enemy_spawn(1, obj_blob, 300);
            add_enemy_spawn(1, obj_powerup_paint_balloon, 300);
            add_enemy_spawn(1, obj_blub, 300);
            add_enemy_spawn(1, obj_flub, 300);
            add_enemy_spawn(1, obj_blob, 300);
            add_enemy_spawn(1, obj_mole, 300);
            add_enemy_spawn(1, obj_sunsan, 300);
            add_enemy_spawn(1, obj_gem, 300);
            add_enemy_spawn(2, obj_giraffe, 300);
            add_enemy_spawn(1, obj_powerup_bomb, 300);
            add_enemy_spawn(2, obj_flub, 300);
            add_enemy_spawn(1, obj_mole, 300);
            global.enemy_popcorn_limit = 13;
            global.enemy_standard_limit = 4;
            global.background_object = obj_bg_sweat;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_1;
            break;
        
        case "s_xcrate":
            global.floors_fruit_percent = [20, 50];
            global.floors_required_percent = 80;
            add_enemy_spawn(1, obj_blob, 210);
            add_enemy_spawn(1, obj_sunsan, 210);
            add_enemy_spawn(2, obj_giraffe, 170);
            add_enemy_spawn(2, obj_gem, 170);
            add_enemy_spawn(1, obj_powerup_stamphammer, 170);
            add_enemy_spawn(1, obj_strongman, 170);
            add_enemy_spawn(1, obj_blob, 220);
            add_enemy_spawn(1, obj_sunsan, 220);
            add_enemy_spawn(1, obj_strongman, 190);
            add_enemy_spawn(1, obj_sunsan, 190);
            add_enemy_spawn(2, obj_giraffe, 190);
            global.enemy_popcorn_limit = 12;
            ds_map_set(global.enemy_specific_limit, obj_gem, 4);
            ds_map_set(global.enemy_specific_limit, obj_giraffe, 3);
            ds_map_set(global.enemy_specific_limit, obj_strongman, 5);
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_mandel;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_1;
            
            break;
        
        case "s_bundleofjoy":
            global.floors_fruit_percent = [10, 40];
            global.floors_required_percent = 75;
            add_enemy_spawn(1, obj_blob, 160);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 160);
            add_enemy_spawn(2, obj_giraffe, 160);
            add_enemy_spawn(2, obj_flub, 160);
            add_enemy_spawn(1, obj_blub, 160);
            add_enemy_spawn(1, obj_powerup_paint_balloon, 160);
            add_enemy_spawn(3, obj_blob, 160);
            add_enemy_spawn(1, obj_wobbler, 160);
            add_enemy_spawn(2, obj_blob, 160);
            global.enemy_popcorn_limit = 14;
            ds_map_set(global.enemy_specific_limit, obj_blob, 7);
            ds_map_set(global.enemy_specific_limit, obj_flub, 5);
            ds_map_set(global.enemy_specific_limit, obj_wobbler, 3);
            ds_map_set(global.enemy_specific_limit, obj_blub, 5);
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_glare;
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_arctravel":
            global.floors_fruit_percent = [10, 60];
            global.floors_required_percent = 90;
            add_enemy_spawn(2, obj_strongman, 230);
            add_enemy_spawn(2, obj_blob, 230);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(3, obj_blob, 200);
            add_enemy_spawn(2, obj_giraffe, 200);
            add_enemy_spawn(1, obj_stopper, 200);
            add_enemy_spawn(1, obj_blob, 200);
            add_enemy_spawn(2, obj_blub, 200);
            add_enemy_spawn(1, obj_giraffe, 200);
            add_enemy_spawn(1, obj_powerup_bomb, 120);
            global.enemy_popcorn_limit = 14;
            global.enemy_standard_limit = 3;
            global.background_object = obj_bg_cozy;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_cork":
            global.floors_fruit_percent = [20, 50];
            global.floors_required_percent = 75;
            add_enemy_spawn(2, obj_slinky, 150);
            add_enemy_spawn(1, obj_powerup_stamphammer, 160);
            add_enemy_spawn(2, obj_giraffe, 160);
            add_enemy_spawn(1, obj_blob, 160);
            add_enemy_spawn(1, obj_octi, 160);
            add_enemy_spawn(1, obj_powerup_stamphammer, 160);
            add_enemy_spawn(2, obj_giraffe, 160);
            add_enemy_spawn(1, obj_flub, 160);
            add_enemy_spawn(2, obj_crescent, 160);
            add_enemy_spawn(2, obj_sunsan, 160);
            add_enemy_spawn(2, obj_blub, 160);
            add_enemy_spawn(1, obj_powerup_shield, 160);
            global.enemy_popcorn_limit = 14;
            global.enemy_standard_limit = 12;
            ds_map_set(global.enemy_specific_limit, obj_octi, 4);
            ds_map_set(global.enemy_specific_limit, obj_giraffe, 2);
            ds_map_set(global.enemy_specific_limit, obj_flub, 2);
            ds_map_set(global.enemy_specific_limit, obj_blub, 2);
            ds_map_set(global.enemy_specific_limit, obj_slinky, 2);
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_cock;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_1;
            else
                global.floors_method = UnknownEnum.Value_3;
            
            break;
        
        case "s_caramelcandy":
            global.floors_fruit_percent = [10, 40];
            global.floors_required_percent = 70;
            add_enemy_spawn(2, obj_giraffe, 160);
            add_enemy_spawn(2, obj_slinky, 160);
            add_enemy_spawn(1, obj_blob, 160);
            add_enemy_spawn(1, obj_powerup_paint_balloon, 160);
            add_enemy_spawn(3, obj_blob, 160);
            add_enemy_spawn(1, obj_gem, 160);
            add_enemy_spawn(2, obj_blob, 160);
            global.enemy_popcorn_limit = 14;
            ds_map_set(global.enemy_specific_limit, obj_blob, 7);
            ds_map_set(global.enemy_specific_limit, obj_giraffe, 3);
            ds_map_set(global.enemy_specific_limit, obj_slinky, 5);
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_sweat;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_1;
            
            break;
        
        case "s_manpac":
            global.floors_fruit_percent = [10, 40];
            global.floors_required_percent = 95;
            add_enemy_spawn(1, obj_seeker, 100);
            add_enemy_spawn(1, obj_spectre, 100);
            add_enemy_spawn(1, obj_capsule, 100);
            add_enemy_spawn(1, obj_snake, 100);
            global.enemy_popcorn_limit = 10;
            global.enemy_standard_limit = 5;
            global.enemy_speed_scalar = 1.2;
            ds_map_set(global.enemy_specific_limit, obj_seeker, 2);
            ds_map_set(global.enemy_specific_limit, obj_spectre, 2);
            ds_map_set(global.enemy_specific_limit, obj_snake, 3);
            global.background_object = obj_bg_luna;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_diagonaldiogenes":
            global.floors_fruit_percent = [25, 55];
            global.floors_required_percent = 85;
            add_enemy_spawn(3, obj_blob, 150);
            add_enemy_spawn(1, obj_powerup_stamphammer, 160);
            add_enemy_spawn(2, obj_giraffe, 160);
            add_enemy_spawn(1, obj_blob, 160);
            add_enemy_spawn(1, obj_spectre, 160);
            add_enemy_spawn(1, obj_powerup_impact, 160);
            add_enemy_spawn(2, obj_giraffe, 160);
            add_enemy_spawn(1, obj_wobbler, 160);
            add_enemy_spawn(2, obj_blob, 160);
            add_enemy_spawn(2, obj_blub, 160);
            global.enemy_popcorn_limit = 14;
            global.enemy_standard_limit = 12;
            ds_map_set(global.enemy_specific_limit, obj_spectre, 2);
            ds_map_set(global.enemy_specific_limit, obj_giraffe, 4);
            ds_map_set(global.enemy_specific_limit, obj_wobbler, 2);
            ds_map_set(global.enemy_specific_limit, obj_blub, 2);
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_pulse;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_1;
            else
                global.floors_method = UnknownEnum.Value_3;
            
            break;
        
        case "s_areallyfatxwing":
            global.floors_fruit_percent = [20, 50];
            global.floors_required_percent = 90;
            add_enemy_spawn(2, obj_giraffe, 120);
            add_enemy_spawn(2, obj_slinky, 120);
            add_enemy_spawn(2, obj_giraffe, 120);
            add_enemy_spawn(4, obj_blob, 220);
            add_enemy_spawn(1, obj_powerup_stamphammer, 150);
            add_enemy_spawn(2, obj_giraffe, 220);
            add_enemy_spawn(2, obj_slinky, 220);
            add_enemy_spawn(2, obj_giraffe, 220);
            add_enemy_spawn(2, obj_blob, 220);
            add_enemy_spawn(1, obj_powerup_bomb, 150);
            add_enemy_spawn(1, obj_blob, 220);
            global.enemy_popcorn_limit = 8;
            global.enemy_standard_limit = 6;
            floor_scoring_absorb_color(spr_color_set, 0, 2);
            global.background_object = obj_bg_cozy;
            global.floors_method = UnknownEnum.Value_2;
            break;
        
        case "s_L":
            global.floors_fruit_percent = [30, 60];
            global.floors_required_percent = 75;
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(2, obj_slinky, 200);
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(1, obj_powerup_paint_balloon, 120);
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(2, obj_slinky, 200);
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(1, obj_wobbler, 200);
            add_enemy_spawn(1, obj_powerup_bomb, 120);
            global.enemy_popcorn_limit = 12;
            global.background_object = obj_bg_pulse;
            floor_scoring_absorb_color(spr_color_set, 2, 3);
            global.floors_method = UnknownEnum.Value_2;
            break;
        
        case "s_chaosunfold":
            global.floors_fruit_percent = [30, 50];
            global.floors_required_percent = 90;
            add_enemy_spawn(2, obj_blob, 230);
            add_enemy_spawn(1, obj_snake, 230);
            add_enemy_spawn(2, obj_flub, 230);
            add_enemy_spawn(2, obj_gem, 230);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 120);
            add_enemy_spawn(3, obj_flub, 230);
            add_enemy_spawn(2, obj_slinky, 230);
            add_enemy_spawn(2, obj_snake, 230);
            global.enemy_popcorn_limit = 16;
            global.enemy_standard_limit = 4;
            ds_map_set(global.enemy_specific_limit, obj_slinky, 4);
            ds_map_set(global.enemy_specific_limit, obj_snake, 3);
            global.background_object = obj_bg_luna;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_goldenbeachpromenade":
            global.floors_fruit_percent = [55, 70];
            global.floors_required_percent = 85;
            add_enemy_spawn(1, obj_clover, 330);
            add_enemy_spawn(1, obj_sunsan, 230);
            add_enemy_spawn(1, obj_clover, 330);
            add_enemy_spawn(1, obj_giraffe, 230);
            add_enemy_spawn(2, obj_crescent, 230);
            add_enemy_spawn(1, obj_powerup_impact, 230);
            add_enemy_spawn(1, obj_clover, 330);
            add_enemy_spawn(1, obj_sunsan, 230);
            add_enemy_spawn(1, obj_clover, 330);
            add_enemy_spawn(1, obj_giraffe, 230);
            add_enemy_spawn(2, obj_crescent, 230);
            global.enemy_popcorn_limit = 13;
            global.enemy_standard_limit = 5;
            global.background_object = obj_bg_luna;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_coldopening":
            global.floors_fruit_percent = [30, 65];
            global.floors_required_percent = 95;
            add_enemy_spawn(3, obj_blob, 300);
            
            repeat (3)
            {
                add_enemy_spawn(1, obj_powerup_impact, 120);
                add_enemy_spawn(1, obj_blob, 120);
                add_enemy_spawn(1, obj_wobbler, 180);
                add_enemy_spawn(1, obj_crescent, 120);
                add_enemy_spawn(1, obj_dream, 120);
                add_enemy_spawn(1, obj_wobbler, 180);
                add_enemy_spawn(1, obj_powerup_instant_bomb, 120);
                add_enemy_spawn(2, obj_crescent, 200);
                add_enemy_spawn(1, obj_dream, 120);
            }
            
            global.enemy_popcorn_limit = 16;
            global.enemy_standard_limit = 5;
            global.background_object = obj_bg_calm;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_snowbonanza":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 85;
            add_enemy_spawn(1, obj_flub, 200);
            add_enemy_spawn(1, obj_crescent, 200);
            add_enemy_spawn(2, obj_blub, 200);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(1, obj_giraffe, 120);
            add_enemy_spawn(1, obj_stopper, 180);
            add_enemy_spawn(1, obj_flub, 120);
            add_enemy_spawn(1, obj_crescent, 120);
            add_enemy_spawn(1, obj_stopper, 180);
            add_enemy_spawn(1, obj_powerup_instant_bomb, 120);
            add_enemy_spawn(2, obj_blub, 200);
            add_enemy_spawn(1, obj_giraffe, 180);
            global.enemy_popcorn_limit = 14;
            global.enemy_standard_limit = 4;
            global.background_object = obj_bg_calm;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_2;
            break;
        
        case "s_roachflap":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 80;
            add_enemy_spawn(3, obj_flub, 220);
            add_enemy_spawn(2, obj_nooter, 220);
            add_enemy_spawn(1, obj_powerup_dash, 150);
            add_enemy_spawn(1, obj_capsule, 220);
            add_enemy_spawn(4, obj_stopper, 220);
            add_enemy_spawn(3, obj_flub, 220);
            add_enemy_spawn(1, obj_powerup_bomb, 150);
            add_enemy_spawn(1, obj_stopper, 220);
            add_enemy_spawn(1, obj_seeker, 220);
            add_enemy_spawn(1, obj_capsule, 220);
            add_enemy_spawn(1, obj_giraffe, 220);
            add_enemy_spawn(1, obj_mole, 220);
            add_enemy_spawn(1, obj_crescent, 220);
            global.enemy_popcorn_limit = 18;
            global.enemy_standard_limit = 8;
            global.enemy_speed_scalar = 1.1;
            floor_scoring_absorb_color(spr_color_set, 0, 2);
            global.background_object = obj_bg_deep;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_1;
            
            break;
        
        case "s_walkoflife":
            global.floors_fruit_percent = [10, 40];
            global.floors_required_percent = 70;
            add_enemy_spawn(3, obj_blob, 64);
            add_enemy_spawn(1, obj_powerup_stamphammer, 120);
            add_enemy_spawn(2, obj_nooter, 80);
            add_enemy_spawn(2, obj_slinky, 64);
            add_enemy_spawn(2, obj_blob, 144);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(1, obj_slinky, 64);
            add_enemy_spawn(1, obj_blub, 144);
            add_enemy_spawn(1, obj_blob, 150);
            add_enemy_spawn(1, obj_nooter, 80);
            add_enemy_spawn(1, obj_gem, 150);
            add_enemy_spawn(1, obj_nooter, 80);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(2, obj_slinky, 64);
            add_enemy_spawn(3, obj_blob, 64);
            add_enemy_spawn(2, obj_nooter, 80);
            add_enemy_spawn(2, obj_blob, 144);
            add_enemy_spawn(3, obj_gem, 150);
            global.enemy_popcorn_limit = 10;
            global.enemy_standard_limit = 5;
            floor_scoring_absorb_color(spr_color_set, 0, 8);
            global.background_object = obj_bg_prime;
            break;
        
        case "s_superjumpintro":
            global.floors_fruit_percent = [55, 65];
            global.floors_required_percent = 85;
            add_enemy_spawn(4, obj_blob, 350);
            add_enemy_spawn(2, obj_gem, 350);
            add_enemy_spawn(2, obj_marble, 350);
            add_enemy_spawn(1, obj_blob, 350);
            add_enemy_spawn(1, obj_gem, 350);
            add_enemy_spawn(1, obj_marble, 350);
            add_enemy_spawn(2, obj_blob, 350);
            add_enemy_spawn(1, obj_gem, 350);
            add_enemy_spawn(1, obj_marble, 350);
            add_enemy_spawn(1, obj_mole, 350);
            global.enemy_popcorn_limit = 12;
            global.background_object = obj_bg_bond;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_geom":
            global.floors_fruit_percent = [30, 60];
            global.floors_required_percent = 80;
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(1, obj_remover, 200);
            add_enemy_spawn(1, obj_powerup_paint_balloon, 120);
            add_enemy_spawn(1, obj_blob, 120);
            add_enemy_spawn(1, obj_strongman, 120);
            add_enemy_spawn(1, obj_wobbler, 180);
            add_enemy_spawn(1, obj_snake, 120);
            add_enemy_spawn(1, obj_wobbler, 180);
            add_enemy_spawn(1, obj_powerup_instant_bomb, 120);
            add_enemy_spawn(1, obj_remover, 200);
            add_enemy_spawn(2, obj_snake, 200);
            add_enemy_spawn(2, obj_blob, 200);
            global.enemy_popcorn_limit = 12;
            global.enemy_standard_limit = 4;
            global.enemy_speed_scalar = 1.2;
            global.background_object = obj_bg_millennium;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_2;
            break;
        
        case "s_cliffcorner":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 80;
            add_enemy_spawn(3, obj_blob, 220);
            add_enemy_spawn(3, obj_leaper, 220);
            add_enemy_spawn(1, obj_powerup_dash, 150);
            add_enemy_spawn(3, obj_blob, 220);
            add_enemy_spawn(1, obj_mole, 220);
            add_enemy_spawn(3, obj_leaper, 220);
            add_enemy_spawn(3, obj_blob, 220);
            add_enemy_spawn(2, obj_marble, 220);
            add_enemy_spawn(1, obj_powerup_bomb, 150);
            add_enemy_spawn(1, obj_blob, 220);
            add_enemy_spawn(1, obj_remover, 220);
            add_enemy_spawn(1, obj_mole, 220);
            add_enemy_spawn(2, obj_marble, 220);
            global.enemy_popcorn_limit = 13;
            global.enemy_standard_limit = 5;
            floor_scoring_absorb_color(spr_color_set, 0, 2);
            global.background_object = obj_bg_ao;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_1;
            
            break;
        
        case "s_funkystairs":
            global.floors_fruit_percent = [20, 40];
            global.floors_required_percent = 85;
            add_enemy_spawn(4, obj_blob, 200);
            add_enemy_spawn(2, obj_gem, 200);
            add_enemy_spawn(1, obj_powerup_stamphammer, 120);
            add_enemy_spawn(1, obj_blub, 200);
            add_enemy_spawn(2, obj_blob, 180);
            add_enemy_spawn(1, obj_stopper, 180);
            add_enemy_spawn(2, obj_gem, 180);
            
            if (!(global.stage_difficulty == UnknownEnum.Value_0))
                add_enemy_spawn(1, obj_remover, 220);
            else
                add_enemy_spawn(1, obj_wobbler, 220);
            
            add_enemy_spawn(1, obj_powerup_bomb, 120);
            global.enemy_popcorn_limit = 12;
            global.background_object = obj_bg_fresh;
            global.enemy_speed_scalar = 1.2;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_3;
            else
                global.floors_method = UnknownEnum.Value_4;
            
            break;
        
        case "s_frozenwindmill":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 90;
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(2, obj_octi, 200);
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(1, obj_blob, 120);
            add_enemy_spawn(1, obj_octi, 180);
            add_enemy_spawn(1, obj_blob, 120);
            add_enemy_spawn(1, obj_wobbler, 180);
            add_enemy_spawn(1, obj_nooter, 180);
            add_enemy_spawn(2, obj_marble, 150);
            add_enemy_spawn(1, obj_powerup_instant_bomb, 120);
            add_enemy_spawn(2, obj_blob, 200);
            global.enemy_popcorn_limit = 14;
            global.enemy_standard_limit = 6;
            global.background_object = obj_bg_apex;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_squashedspider":
            global.floors_fruit_percent = [30, 65];
            global.floors_required_percent = 95;
            add_enemy_spawn(1, obj_blob, 270);
            add_enemy_spawn(1, obj_marble, 270);
            add_enemy_spawn(2, obj_snake, 270);
            add_enemy_spawn(3, obj_flub, 240);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(2, obj_marble, 170);
            add_enemy_spawn(3, obj_flub, 220);
            add_enemy_spawn(2, obj_marble, 220);
            add_enemy_spawn(1, obj_remover, 220);
            add_enemy_spawn(2, obj_snake, 220);
            add_enemy_spawn(1, obj_powerup_instant_bomb, 120);
            global.enemy_popcorn_limit = 11;
            global.enemy_standard_limit = 5;
            global.background_object = obj_bg_calm;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_1;
            else
                global.floors_method = UnknownEnum.Value_3;
            
            break;
        
        case "s_auntiesporch":
            global.floors_fruit_percent = [10, 60];
            global.floors_required_percent = 90;
            add_enemy_spawn(4, obj_blob, 230);
            add_enemy_spawn(1, obj_wobbler, 230);
            add_enemy_spawn(1, obj_giraffe, 230);
            add_enemy_spawn(2, obj_strongman, 230);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 120);
            add_enemy_spawn(4, obj_blob, 200);
            add_enemy_spawn(2, obj_strongman, 200);
            add_enemy_spawn(1, obj_powerup_bomb, 120);
            add_enemy_spawn(1, obj_wobbler, 200);
            add_enemy_spawn(1, obj_giraffe, 230);
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(3, obj_blob, 200);
            global.enemy_popcorn_limit = 16;
            global.enemy_standard_limit = 6;
            global.background_object = obj_bg_melody;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_crownpants":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 75;
            
            repeat (2)
            {
                add_enemy_spawn(1, obj_blob, 200);
                add_enemy_spawn(1, obj_nooter, 200);
                add_enemy_spawn(1, obj_blob, 200);
                add_enemy_spawn(1, obj_nooter, 200);
                add_enemy_spawn(2, obj_blob, 200);
                add_enemy_spawn(1, obj_nooter, 200);
            }
            
            add_enemy_spawn(1, obj_powerup_shield, 200);
            global.enemy_popcorn_limit = 12;
            global.background_object = obj_bg_fresh;
            floor_scoring_absorb_color(spr_color_set, 2, 1);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_2;
            else
                global.floors_method = UnknownEnum.Value_4;
            
            break;
        
        case "s_backnforth":
            global.floors_fruit_percent = [30, 50];
            global.floors_required_percent = 75;
            add_enemy_spawn(2, obj_nooter, 30);
            add_enemy_spawn(1, obj_octi, 120);
            add_enemy_spawn(2, obj_blub, 230);
            add_enemy_spawn(2, obj_blob, 230);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(3, obj_nooter, 230);
            add_enemy_spawn(2, obj_octi, 230);
            add_enemy_spawn(1, obj_snake, 230);
            add_enemy_spawn(2, obj_blob, 230);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 120);
            global.enemy_popcorn_limit = 18;
            global.enemy_standard_limit = 10;
            ds_map_set(global.enemy_specific_limit, obj_nooter, 6);
            ds_map_set(global.enemy_specific_limit, obj_octi, 4);
            global.background_object = obj_bg_millennium;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_1;
            break;
        
        case "s_shoe":
            global.floors_fruit_percent = [30, 60];
            global.floors_required_percent = 80;
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(1, obj_leaper, 200);
            add_enemy_spawn(1, obj_powerup_paint_balloon, 120);
            add_enemy_spawn(1, obj_blob, 120);
            add_enemy_spawn(1, obj_strongman, 120);
            add_enemy_spawn(1, obj_wobbler, 180);
            add_enemy_spawn(1, obj_snake, 120);
            add_enemy_spawn(1, obj_wobbler, 180);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 120);
            add_enemy_spawn(1, obj_remover, 200);
            add_enemy_spawn(2, obj_snake, 200);
            add_enemy_spawn(2, obj_blob, 200);
            global.enemy_popcorn_limit = 17;
            global.enemy_standard_limit = 6;
            global.enemy_speed_scalar = 1.2;
            global.background_object = obj_bg_bond;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_1;
            
            break;
        
        case "s_bigslinky":
            global.floors_fruit_percent = [30, 60];
            global.floors_required_percent = 80;
            add_enemy_spawn(2, obj_slinky, 200);
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(1, obj_slinky, 120);
            add_enemy_spawn(2, obj_gem, 180);
            add_enemy_spawn(1, obj_mole, 180);
            add_enemy_spawn(1, obj_slinky, 180);
            add_enemy_spawn(1, obj_blob, 180);
            add_enemy_spawn(1, obj_powerup_instant_bomb, 120);
            add_enemy_spawn(1, obj_slinky, 200);
            add_enemy_spawn(4, obj_blob, 200);
            global.enemy_popcorn_limit = 12;
            global.enemy_standard_limit = 8;
            global.enemy_speed_scalar = 1.2;
            ds_map_set(global.enemy_specific_limit, obj_slinky, 5);
            ds_map_set(global.enemy_specific_limit, obj_mole, 3);
            global.background_object = obj_bg_bond;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_1;
            
            break;
        
        case "s_innerbox":
            global.floors_fruit_percent = [30, 65];
            global.floors_required_percent = 90;
            add_enemy_spawn(3, obj_blob, 200);
            add_enemy_spawn(1, obj_flub, 200);
            add_enemy_spawn(1, obj_powerup_shield, 120);
            add_enemy_spawn(1, obj_strongman, 200);
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(1, obj_octi, 200);
            add_enemy_spawn(1, obj_remover, 200);
            add_enemy_spawn(1, obj_flub, 200);
            add_enemy_spawn(2, obj_octi, 200);
            add_enemy_spawn(3, obj_strongman, 180);
            add_enemy_spawn(1, obj_remover, 200);
            add_enemy_spawn(1, obj_powerup_instant_bomb, 120);
            global.enemy_popcorn_limit = 14;
            global.enemy_standard_limit = 4;
            global.background_object = obj_bg_glide;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_wingcard":
            global.floors_fruit_percent = [20, 45];
            global.floors_required_percent = 75;
            add_enemy_spawn(2, obj_blob, 120);
            add_enemy_spawn(1, obj_sparkun, 110);
            add_enemy_spawn(1, obj_leaper, 120);
            add_enemy_spawn(1, obj_stopper, 120);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(1, obj_giraffe, 120);
            add_enemy_spawn(1, obj_leaper, 120);
            add_enemy_spawn(1, obj_giraffe, 120);
            add_enemy_spawn(2, obj_blob, 110);
            add_enemy_spawn(1, obj_sparkun, 110);
            global.enemy_popcorn_limit = 12;
            global.background_object = obj_bg_ao;
            floor_scoring_absorb_color(spr_color_set, 1, 2);
            global.floors_method = UnknownEnum.Value_1;
            break;
        
        case "s_superjumpcolumn":
            global.floors_fruit_percent = [10, 20];
            global.floors_required_percent = 65;
            add_enemy_spawn(3, obj_blob, 350);
            add_enemy_spawn(1, obj_sunsan, 350);
            add_enemy_spawn(1, obj_clover, 350);
            add_enemy_spawn(2, obj_molemage, 250);
            add_enemy_spawn(2, obj_leaper, 250);
            add_enemy_spawn(2, obj_wobbler, 250);
            add_enemy_spawn(1, obj_clover, 250);
            add_enemy_spawn(2, obj_molemage, 250);
            global.enemy_popcorn_limit = 16;
            global.enemy_standard_limit = 8;
            ds_map_set(global.enemy_specific_limit, obj_seeker, 2);
            ds_map_set(global.enemy_specific_limit, obj_wobbler, 3);
            ds_map_set(global.enemy_specific_limit, obj_leaper, 2);
            global.background_object = obj_bg_bond;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_dorby":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 80;
            add_enemy_spawn(2, obj_slinky, 230);
            add_enemy_spawn(2, obj_blob, 230);
            add_enemy_spawn(1, obj_wobbler, 230);
            add_enemy_spawn(1, obj_leaper, 230);
            add_enemy_spawn(1, obj_blob, 230);
            add_enemy_spawn(1, obj_powerup_paint_balloon, 120);
            add_enemy_spawn(4, obj_blob, 200);
            add_enemy_spawn(2, obj_blub, 200);
            global.enemy_popcorn_limit = 13;
            global.enemy_standard_limit = 4;
            global.background_object = obj_bg_glide;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_drill":
            global.floors_fruit_percent = [30, 50];
            global.floors_required_percent = 90;
            add_enemy_spawn(1, obj_slinky, 200);
            add_enemy_spawn(1, obj_arachnid, 200);
            add_enemy_spawn(1, obj_slinky, 200);
            add_enemy_spawn(1, obj_arachnid, 200);
            add_enemy_spawn(2, obj_crescent, 200);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 150);
            add_enemy_spawn(1, obj_slinky, 200);
            add_enemy_spawn(2, obj_capsule, 200);
            add_enemy_spawn(2, obj_wobbler, 200);
            add_enemy_spawn(2, obj_blob, 200);
            global.enemy_popcorn_limit = 9;
            global.enemy_standard_limit = 8;
            floor_scoring_absorb_color(spr_color_set, 0, 1);
            global.background_object = obj_bg_veridisquo;
            break;
        
        case "s_coastalruins":
            global.floors_fruit_percent = [25, 40];
            global.floors_required_percent = 80;
            add_enemy_spawn(2, obj_dream, 250);
            add_enemy_spawn(1, obj_gero, 250);
            add_enemy_spawn(1, obj_powerup_stamphammer, 120);
            add_enemy_spawn(2, obj_gero, 250);
            add_enemy_spawn(2, obj_marble, 250);
            add_enemy_spawn(1, obj_dream, 250);
            add_enemy_spawn(1, obj_nooter, 250);
            add_enemy_spawn(2, obj_gero, 250);
            add_enemy_spawn(2, obj_dream, 180);
            add_enemy_spawn(1, obj_sparkun, 180);
            add_enemy_spawn(1, obj_clover, 250);
            add_enemy_spawn(1, obj_marble, 250);
            add_enemy_spawn(1, obj_powerup_bomb, 120);
            add_enemy_spawn(1, obj_dream, 200);
            global.enemy_popcorn_limit = 16;
            global.enemy_standard_limit = 6;
            global.background_object = obj_bg_glory;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_tank":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 75;
            add_enemy_spawn(2, obj_ace, 200);
            add_enemy_spawn(1, obj_gem, 200);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(2, obj_gero, 200);
            add_enemy_spawn(2, obj_ace, 200);
            add_enemy_spawn(1, obj_gem, 200);
            add_enemy_spawn(1, obj_nooter, 200);
            add_enemy_spawn(2, obj_octi, 200);
            add_enemy_spawn(3, obj_strongman, 180);
            add_enemy_spawn(1, obj_gero, 200);
            add_enemy_spawn(1, obj_leaper, 200);
            add_enemy_spawn(1, obj_powerup_bomb, 120);
            add_enemy_spawn(1, obj_gem, 200);
            global.enemy_popcorn_limit = 15;
            global.enemy_standard_limit = 5;
            global.background_object = obj_bg_glory;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_d":
            global.floors_fruit_percent = [50, 55];
            global.floors_required_percent = 85;
            add_enemy_spawn(1, obj_dream, 250);
            add_enemy_spawn(1, obj_clover, 250);
            add_enemy_spawn(1, obj_dream, 250);
            add_enemy_spawn(1, obj_clover, 250);
            add_enemy_spawn(1, obj_sparkun, 250);
            add_enemy_spawn(1, obj_powerup_dash, 120);
            add_enemy_spawn(1, obj_clover, 250);
            add_enemy_spawn(1, obj_arachnid, 250);
            add_enemy_spawn(1, obj_dream, 250);
            add_enemy_spawn(1, obj_flub, 250);
            add_enemy_spawn(2, obj_clover, 250);
            add_enemy_spawn(2, obj_sparkun, 180);
            add_enemy_spawn(1, obj_leaper, 180);
            add_enemy_spawn(1, obj_arachnid, 250);
            add_enemy_spawn(1, obj_clover, 250);
            add_enemy_spawn(1, obj_powerup_bomb, 120);
            add_enemy_spawn(1, obj_dream, 200);
            global.enemy_popcorn_limit = 16;
            global.enemy_standard_limit = 6;
            global.enemy_speed_scalar = 0.85;
            global.background_object = obj_bg_glory;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_return":
            global.floors_fruit_percent = [30, 50];
            global.floors_required_percent = 90;
            add_enemy_spawn(1, obj_powerup_wrap_paper, 120);
            add_enemy_spawn(2, obj_blob, 230);
            add_enemy_spawn(1, obj_blub, 230);
            add_enemy_spawn(2, obj_snake, 230);
            add_enemy_spawn(2, obj_stopper, 230);
            add_enemy_spawn(3, obj_flub, 230);
            add_enemy_spawn(2, obj_blob, 230);
            add_enemy_spawn(2, obj_blub, 230);
            add_enemy_spawn(1, obj_star, 230);
            global.enemy_popcorn_limit = 13;
            global.enemy_standard_limit = 6;
            ds_map_set(global.enemy_specific_limit, obj_snake, 3);
            global.background_object = obj_bg_ao;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_sled":
            global.floors_fruit_percent = [10, 30];
            global.floors_required_percent = 75;
            add_enemy_spawn(2, obj_snake, 180);
            add_enemy_spawn(1, obj_octi, 180);
            add_enemy_spawn(1, obj_star, 180);
            add_enemy_spawn(1, obj_arachnid, 180);
            add_enemy_spawn(3, obj_flub, 180);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(2, obj_snake, 180);
            add_enemy_spawn(3, obj_blob, 180);
            add_enemy_spawn(2, obj_gem, 180);
            add_enemy_spawn(1, obj_octi, 180);
            add_enemy_spawn(1, obj_star, 180);
            add_enemy_spawn(1, obj_arachnid, 180);
            add_enemy_spawn(3, obj_flub, 180);
            add_enemy_spawn(2, obj_snake, 180);
            global.enemy_popcorn_limit = 14;
            global.enemy_standard_limit = 5;
            ds_map_set(global.enemy_specific_limit, obj_blob, 8);
            ds_map_set(global.enemy_specific_limit, obj_arachnid, 2);
            ds_map_set(global.enemy_specific_limit, obj_snake, 3);
            ds_map_set(global.enemy_specific_limit, obj_octi, 3);
            ds_map_set(global.enemy_specific_limit, obj_gem, 2);
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_citrus;
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_cigar":
            global.floors_fruit_percent = [20, 50];
            global.floors_required_percent = 70;
            add_enemy_spawn(1, obj_blob, 140);
            add_enemy_spawn(1, obj_star, 140);
            add_enemy_spawn(2, obj_leaper, 140);
            add_enemy_spawn(2, obj_flub, 140);
            add_enemy_spawn(1, obj_blob, 140);
            add_enemy_spawn(1, obj_powerup_instant_bomb, 120);
            add_enemy_spawn(2, obj_blob, 130);
            add_enemy_spawn(1, obj_star, 140);
            add_enemy_spawn(1, obj_flub, 130);
            add_enemy_spawn(2, obj_blob, 130);
            add_enemy_spawn(1, obj_wobbler, 130);
            global.enemy_popcorn_limit = 10;
            global.background_object = obj_bg_melody;
            floor_scoring_absorb_color(spr_color_set, 1, 0);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_bonkers":
            global.floors_fruit_percent = [20, 40];
            global.floors_required_percent = 80;
            add_enemy_spawn(1, obj_wobbler, 80);
            add_enemy_spawn(5, obj_gem, 180);
            add_enemy_spawn(2, obj_gero, 180);
            add_enemy_spawn(1, obj_powerup_paint_balloon, 150);
            add_enemy_spawn(3, obj_gem, 150);
            add_enemy_spawn(1, obj_wobbler, 150);
            add_enemy_spawn(1, obj_powerup_instant_bomb, 150);
            add_enemy_spawn(3, obj_gem, 150);
            add_enemy_spawn(2, obj_gero, 180);
            add_enemy_spawn(2, obj_blub, 150);
            global.enemy_popcorn_limit = 14;
            ds_map_set(global.enemy_specific_limit, obj_wobbler, 3);
            ds_map_set(global.enemy_specific_limit, obj_gem, 7);
            ds_map_set(global.enemy_specific_limit, obj_blub, 4);
            floor_scoring_absorb_color(spr_color_set, 0, 2);
            global.background_object = obj_bg_breathe;
            global.floors_method = UnknownEnum.Value_2;
            break;
        
        case "s_producecube":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 75;
            add_enemy_spawn(1, obj_marble, 120);
            add_enemy_spawn(1, obj_powerup_stamphammer, 120);
            add_enemy_spawn(1, obj_arachnid, 120);
            add_enemy_spawn(2, obj_gem, 120);
            add_enemy_spawn(3, obj_capsule, 120);
            add_enemy_spawn(2, obj_molemage, 120);
            add_enemy_spawn(1, obj_gem, 120);
            add_enemy_spawn(1, obj_capsule, 120);
            add_enemy_spawn(1, obj_mole, 120);
            add_enemy_spawn(1, obj_marble, 120);
            add_enemy_spawn(1, obj_leaper, 120);
            add_enemy_spawn(1, obj_arachnid, 120);
            add_enemy_spawn(1, obj_powerup_dash, 120);
            add_enemy_spawn(3, obj_gem, 120);
            add_enemy_spawn(3, obj_marble, 120);
            add_enemy_spawn(2, obj_molemage, 120);
            add_enemy_spawn(1, obj_gem, 120);
            add_enemy_spawn(1, obj_marble, 120);
            add_enemy_spawn(1, obj_remover, 120);
            add_enemy_spawn(1, obj_arachnid, 120);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(5, obj_gem, 110);
            add_enemy_spawn(1, obj_mole, 110);
            global.enemy_popcorn_limit = 16;
            global.enemy_standard_limit = 3;
            ds_map_set(global.enemy_specific_limit, obj_arachnid, 3);
            floor_scoring_absorb_color(spr_color_set, 0, 7);
            global.background_object = obj_bg_melody;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_1;
            else
                global.floors_method = UnknownEnum.Value_3;
            
            break;
        
        case "s_abandonedpost":
            global.floors_fruit_percent = [25, 55];
            global.floors_required_percent = 80;
            add_enemy_spawn(3, obj_blob, 150);
            add_enemy_spawn(1, obj_gero, 150);
            add_enemy_spawn(1, obj_mole, 150);
            add_enemy_spawn(1, obj_stopper, 150);
            add_enemy_spawn(1, obj_gero, 150);
            add_enemy_spawn(1, obj_mole, 150);
            add_enemy_spawn(2, obj_blob, 150);
            add_enemy_spawn(1, obj_gero, 150);
            add_enemy_spawn(1, obj_blub, 150);
            add_enemy_spawn(1, obj_mole, 150);
            add_enemy_spawn(2, obj_gero, 150);
            add_enemy_spawn(2, obj_blob, 150);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            global.enemy_popcorn_limit = 20;
            global.enemy_standard_limit = 4;
            global.background_object = obj_bg_glory;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_bandage":
            global.floors_fruit_percent = [30, 65];
            global.floors_required_percent = 90;
            add_enemy_spawn(3, obj_blob, 200);
            add_enemy_spawn(1, obj_flub, 200);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(1, obj_strongman, 200);
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(1, obj_octi, 200);
            add_enemy_spawn(1, obj_flub, 200);
            add_enemy_spawn(2, obj_octi, 200);
            add_enemy_spawn(3, obj_strongman, 180);
            add_enemy_spawn(1, obj_powerup_instant_bomb, 120);
            global.enemy_popcorn_limit = 14;
            global.enemy_standard_limit = 4;
            global.background_object = obj_bg_glory;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_2;
            break;
        
        case "s_roswell":
            global.floors_fruit_percent = [20, 50];
            global.floors_required_percent = 80;
            add_enemy_spawn(2, obj_ufo, 170);
            add_enemy_spawn(1, obj_blob, 170);
            add_enemy_spawn(2, obj_gem, 170);
            add_enemy_spawn(1, obj_powerup_stamphammer, 170);
            add_enemy_spawn(1, obj_blob, 170);
            add_enemy_spawn(2, obj_ufo, 200);
            add_enemy_spawn(1, obj_mole, 170);
            add_enemy_spawn(1, obj_gem, 170);
            add_enemy_spawn(1, obj_blob, 170);
            add_enemy_spawn(1, obj_remover, 170);
            add_enemy_spawn(1, obj_ufo, 170);
            add_enemy_spawn(1, obj_powerup_instant_bomb, 170);
            global.enemy_popcorn_limit = 14;
            ds_map_set(global.enemy_specific_limit, obj_ufo, 4);
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_mandel;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_1;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_truckingon":
            global.floors_fruit_percent = [20, 50];
            global.floors_required_percent = 75;
            add_enemy_spawn(1, obj_gem, 170);
            add_enemy_spawn(2, obj_blob, 170);
            add_enemy_spawn(1, obj_ufo, 170);
            add_enemy_spawn(2, obj_gem, 170);
            add_enemy_spawn(1, obj_powerup_stamphammer, 170);
            add_enemy_spawn(1, obj_blob, 170);
            add_enemy_spawn(2, obj_blub, 200);
            add_enemy_spawn(1, obj_fuse, 200);
            add_enemy_spawn(1, obj_gem, 170);
            add_enemy_spawn(2, obj_gero, 170);
            global.enemy_popcorn_limit = 14;
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_mandel;
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_bulbmania":
            global.floors_fruit_percent = [10, 30];
            global.floors_required_percent = 85;
            add_enemy_spawn(2, obj_ufo, 140);
            add_enemy_spawn(2, obj_stopper, 140);
            add_enemy_spawn(2, obj_ufo, 140);
            add_enemy_spawn(2, obj_stopper, 140);
            add_enemy_spawn(2, obj_ufo, 140);
            add_enemy_spawn(2, obj_stopper, 140);
            add_enemy_spawn(1, obj_leaper, 140);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            global.enemy_popcorn_limit = 10;
            global.enemy_standard_limit = 8;
            ds_map_set(global.enemy_specific_limit, obj_ufo, 5);
            ds_map_set(global.enemy_specific_limit, obj_snake, 5);
            ds_map_set(global.enemy_specific_limit, obj_leaper, 1);
            global.background_object = obj_bg_platinum;
            floor_scoring_absorb_color(spr_color_set, 1, 0);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_1;
            else
                global.floors_method = UnknownEnum.Value_3;
            
            break;
        
        case "s_segtube":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 85;
            add_enemy_spawn(1, obj_slinky, 170);
            add_enemy_spawn(2, obj_stopper, 170);
            add_enemy_spawn(1, obj_powerup_shield, 170);
            add_enemy_spawn(1, obj_seeker, 270);
            add_enemy_spawn(1, obj_clover, 270);
            add_enemy_spawn(1, obj_slinky, 270);
            add_enemy_spawn(1, obj_seeker, 270);
            add_enemy_spawn(1, obj_slinky, 270);
            add_enemy_spawn(2, obj_stopper, 170);
            add_enemy_spawn(1, obj_gero, 170);
            add_enemy_spawn(1, obj_powerup_impact, 270);
            add_enemy_spawn(2, obj_slinky, 210);
            add_enemy_spawn(2, obj_stopper, 210);
            add_enemy_spawn(1, obj_clover, 170);
            add_enemy_spawn(1, obj_gero, 170);
            global.enemy_popcorn_limit = 17;
            global.enemy_standard_limit = 8;
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_mandel;
            global.floors_method = UnknownEnum.Value_1;
            break;
        
        case "s_tonight":
            global.floors_fruit_percent = [20, 35];
            global.floors_required_percent = 75;
            add_enemy_spawn(2, obj_ufo, 140);
            add_enemy_spawn(1, obj_wobbler, 140);
            add_enemy_spawn(1, obj_giraffe, 140);
            add_enemy_spawn(2, obj_blob, 140);
            add_enemy_spawn(2, obj_ufo, 140);
            add_enemy_spawn(1, obj_powerup_bomb, 140);
            add_enemy_spawn(1, obj_flub, 140);
            add_enemy_spawn(1, obj_parrot, 140);
            add_enemy_spawn(1, obj_flub, 140);
            add_enemy_spawn(2, obj_gem, 140);
            add_enemy_spawn(1, obj_wobbler, 140);
            add_enemy_spawn(1, obj_giraffe, 140);
            add_enemy_spawn(1, obj_powerup_stamphammer, 120);
            global.enemy_popcorn_limit = 10;
            global.enemy_standard_limit = 8;
            ds_map_set(global.enemy_specific_limit, obj_ufo, 4);
            ds_map_set(global.enemy_specific_limit, obj_snake, 5);
            ds_map_set(global.enemy_specific_limit, obj_giraffe, 3);
            global.background_object = obj_bg_platinum;
            floor_scoring_absorb_color(spr_color_set, 1, 0);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_1;
            
            break;
        
        case "s_kowloon":
            global.floors_fruit_percent = [20, 40];
            global.floors_required_percent = 80;
            add_enemy_spawn(4, obj_mole, 370);
            add_enemy_spawn(1, obj_molemage, 370);
            add_enemy_spawn(1, obj_powerup_stamphammer, 170);
            add_enemy_spawn(2, obj_strongman, 370);
            global.enemy_popcorn_limit = 12;
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_mandel;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_2;
            else
                global.floors_method = UnknownEnum.Value_4;
            
            break;
        
        case "s_mistercomputer":
            global.floors_fruit_percent = [10, 40];
            global.floors_required_percent = 90;
            add_enemy_spawn(1, obj_clover, 200);
            add_enemy_spawn(1, obj_powerup_shield, 230);
            add_enemy_spawn(1, obj_clover, 200);
            add_enemy_spawn(1, obj_wobbler, 200);
            add_enemy_spawn(1, obj_molemage, 230);
            add_enemy_spawn(1, obj_arachnid, 230);
            add_enemy_spawn(1, obj_flub, 230);
            add_enemy_spawn(1, obj_ufo, 230);
            add_enemy_spawn(1, obj_powerup_dash, 230);
            add_enemy_spawn(1, obj_flub, 230);
            add_enemy_spawn(1, obj_molemage, 230);
            add_enemy_spawn(1, obj_wobbler, 200);
            add_enemy_spawn(1, obj_arachnid, 230);
            add_enemy_spawn(1, obj_molemage, 230);
            add_enemy_spawn(2, obj_clover, 230);
            add_enemy_spawn(2, obj_flub, 330);
            add_enemy_spawn(1, obj_capsule, 230);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(1, obj_capsule, 230);
            add_enemy_spawn(1, obj_arachnid, 230);
            add_enemy_spawn(1, obj_snake, 230);
            add_enemy_spawn(1, obj_ufo, 230);
            add_enemy_spawn(2, obj_molemage, 230);
            add_enemy_spawn(2, obj_clover, 330);
            global.enemy_speed_scalar = (global.stage_difficulty == UnknownEnum.Value_0) ? 0.8 : 0.85;
            global.enemy_popcorn_limit = 14;
            global.enemy_standard_limit = 9;
            ds_map_set(global.enemy_specific_limit, obj_molemage, (global.stage_difficulty == UnknownEnum.Value_0) ? 1 : 2);
            ds_map_set(global.enemy_specific_limit, obj_clover, (global.stage_difficulty == UnknownEnum.Value_0) ? 3 : 5);
            ds_map_set(global.enemy_specific_limit, obj_arachnid, 3);
            ds_map_set(global.enemy_specific_limit, obj_ufo, 3);
            ds_map_set(global.enemy_specific_limit, obj_wobbler, 3);
            global.background_object = obj_bg_luna;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_excavation":
            global.floors_fruit_percent = [60, 65];
            global.floors_required_percent = 80;
            add_enemy_spawn(2, obj_ace, 170);
            add_enemy_spawn(1, obj_flub, 170);
            add_enemy_spawn(1, obj_stopper, 170);
            add_enemy_spawn(1, obj_gem, 170);
            add_enemy_spawn(1, obj_giraffe, 170);
            add_enemy_spawn(1, obj_ace, 220);
            add_enemy_spawn(2, obj_ufo, 220);
            add_enemy_spawn(2, obj_molemage, 220);
            add_enemy_spawn(1, obj_powerup_stamphammer, 170);
            add_enemy_spawn(2, obj_strongman, 270);
            global.enemy_popcorn_limit = 14;
            ds_map_set(global.enemy_specific_limit, obj_giraffe, 2);
            ds_map_set(global.enemy_specific_limit, obj_ufo, 2);
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_mandel;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_1;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_sssoftS":
            global.floors_fruit_percent = [30, 65];
            global.floors_required_percent = 95;
            add_enemy_spawn(1, obj_snake, 200);
            add_enemy_spawn(1, obj_crescent, 200);
            add_enemy_spawn(1, obj_molemage, 200);
            add_enemy_spawn(1, obj_leaper, 200);
            add_enemy_spawn(1, obj_snake, 150);
            add_enemy_spawn(1, obj_blob, 150);
            add_enemy_spawn(1, obj_leaper, 150);
            add_enemy_spawn(1, obj_ufo, 150);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 150);
            add_enemy_spawn(1, obj_snake, 150);
            add_enemy_spawn(1, obj_blob, 150);
            add_enemy_spawn(1, obj_leaper, 150);
            add_enemy_spawn(1, obj_molemage, 200);
            add_enemy_spawn(1, obj_snake, 100);
            add_enemy_spawn(1, obj_ufo, 150);
            add_enemy_spawn(1, obj_blob, 100);
            add_enemy_spawn(1, obj_parrot, 180);
            add_enemy_spawn(1, obj_leaper, 100);
            global.enemy_popcorn_limit = 7;
            global.enemy_standard_limit = 10;
            global.enemy_speed_scalar = 1.2;
            ds_map_set(global.enemy_specific_limit, obj_leaper, 3);
            ds_map_set(global.enemy_specific_limit, obj_snake, 3);
            ds_map_set(global.enemy_specific_limit, obj_ufo, 3);
            global.background_object = obj_bg_reflex;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_1;
            break;
        
        case "s_gridjogger":
            global.floors_fruit_percent = [5, 40];
            global.floors_required_percent = 95;
            add_enemy_spawn(2, obj_sparkun, 330);
            add_enemy_spawn(1, obj_giraffe, 230);
            add_enemy_spawn(1, obj_snake, 230);
            add_enemy_spawn(1, obj_seeker, 230);
            add_enemy_spawn(1, obj_molemage, 230);
            add_enemy_spawn(1, obj_giraffe, 230);
            add_enemy_spawn(1, obj_snake, 230);
            add_enemy_spawn(1, obj_seeker, 230);
            add_enemy_spawn(2, obj_mole, 230);
            add_enemy_spawn(2, obj_sparkun, 330);
            add_enemy_spawn(1, obj_capsule, 230);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(1, obj_capsule, 230);
            add_enemy_spawn(1, obj_giraffe, 230);
            add_enemy_spawn(1, obj_snake, 230);
            add_enemy_spawn(1, obj_seeker, 230);
            add_enemy_spawn(2, obj_mole, 230);
            add_enemy_spawn(2, obj_sparkun, 330);
            global.enemy_popcorn_limit = 19;
            global.enemy_standard_limit = 9;
            ds_map_set(global.enemy_specific_limit, obj_giraffe, 3);
            ds_map_set(global.enemy_specific_limit, obj_snake, 3);
            ds_map_set(global.enemy_specific_limit, obj_seeker, 3);
            global.background_object = obj_bg_luna;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_2;
            break;
        
        case "s_hollowcube":
            global.floors_fruit_percent = [20, 50];
            global.floors_required_percent = 70;
            add_enemy_spawn(2, obj_ufo, 140);
            add_enemy_spawn(2, obj_star, 140);
            add_enemy_spawn(2, obj_ufo, 140);
            add_enemy_spawn(1, obj_powerup_stamphammer, 120);
            add_enemy_spawn(2, obj_flub, 130);
            add_enemy_spawn(1, obj_fuse, 130);
            add_enemy_spawn(1, obj_star, 130);
            add_enemy_spawn(2, obj_ufo, 130);
            add_enemy_spawn(2, obj_molemage, 130);
            add_enemy_spawn(1, obj_star, 130);
            add_enemy_spawn(1, obj_parrot, 130);
            add_enemy_spawn(1, obj_remover, 130);
            add_enemy_spawn(2, obj_ufo, 140);
            add_enemy_spawn(2, obj_star, 140);
            add_enemy_spawn(2, obj_ufo, 140);
            add_enemy_spawn(1, obj_powerup_stamphammer, 120);
            add_enemy_spawn(2, obj_flub, 130);
            add_enemy_spawn(1, obj_fuse, 130);
            add_enemy_spawn(1, obj_star, 130);
            add_enemy_spawn(2, obj_ufo, 130);
            add_enemy_spawn(2, obj_molemage, 130);
            add_enemy_spawn(1, obj_star, 130);
            add_enemy_spawn(1, obj_parrot, 130);
            global.enemy_popcorn_limit = 10;
            global.enemy_standard_limit = 10;
            global.background_object = obj_bg_platinum;
            floor_scoring_absorb_color(spr_color_set, 1, 0);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_1;
            else
                global.floors_method = UnknownEnum.Value_3;
            
            break;
        
        case "s_piston":
            global.floors_fruit_percent = [20, 50];
            global.floors_required_percent = 70;
            add_enemy_spawn(2, obj_kuso, 140);
            add_enemy_spawn(1, obj_parrot, 140);
            add_enemy_spawn(2, obj_strongman, 240);
            add_enemy_spawn(1, obj_powerup_paint_balloon, 120);
            add_enemy_spawn(2, obj_strongman, 140);
            add_enemy_spawn(1, obj_gem, 140);
            add_enemy_spawn(2, obj_nooter, 130);
            add_enemy_spawn(2, obj_kuso, 140);
            add_enemy_spawn(1, obj_parrot, 140);
            add_enemy_spawn(2, obj_strongman, 240);
            add_enemy_spawn(2, obj_strongman, 140);
            add_enemy_spawn(1, obj_gem, 140);
            add_enemy_spawn(1, obj_leaper, 130);
            add_enemy_spawn(1, obj_nooter, 130);
            global.enemy_popcorn_limit = 12;
            global.enemy_standard_limit = 6;
            ds_map_set(global.enemy_specific_limit, obj_leaper, 2);
            ds_map_set(global.enemy_specific_limit, obj_nooter, 3);
            global.background_object = obj_bg_cogito;
            floor_scoring_absorb_color(spr_color_set, 1, 0);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_minefield":
            global.floors_fruit_percent = [15, 30];
            global.floors_required_percent = 90;
            add_enemy_spawn(2, obj_capsule, 170);
            add_enemy_spawn(2, obj_flub, 170);
            add_enemy_spawn(2, obj_ace, 170);
            add_enemy_spawn(2, obj_leaper, 170);
            add_enemy_spawn(1, obj_powerup_stamphammer, 170);
            add_enemy_spawn(2, obj_ace, 170);
            add_enemy_spawn(2, obj_flub, 170);
            add_enemy_spawn(2, obj_ace, 170);
            add_enemy_spawn(2, obj_snake, 170);
            add_enemy_spawn(2, obj_mole, 170);
            add_enemy_spawn(1, obj_slinky, 170);
            
            if (global.stage_difficulty == UnknownEnum.Value_1)
                add_enemy_spawn(1, obj_remover, 170);
            
            global.enemy_popcorn_limit = 20;
            global.enemy_standard_limit = 10;
            ds_map_set(global.enemy_specific_limit, obj_leaper, 2);
            ds_map_set(global.enemy_specific_limit, obj_snake, 4);
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_mandel;
            global.enemy_speed_scalar = 1.6;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_clasp":
            global.floors_fruit_percent = [20, 40];
            global.floors_required_percent = 80;
            add_enemy_spawn(2, obj_kuso, 200);
            add_enemy_spawn(1, obj_remover, 200);
            add_enemy_spawn(1, obj_giraffe, 180);
            add_enemy_spawn(1, obj_ufo, 180);
            add_enemy_spawn(2, obj_flub, 200);
            add_enemy_spawn(2, obj_ace, 180);
            add_enemy_spawn(1, obj_powerup_stamphammer, 120);
            add_enemy_spawn(1, obj_giraffe, 180);
            add_enemy_spawn(1, obj_ufo, 180);
            add_enemy_spawn(1, obj_parrot, 180);
            add_enemy_spawn(2, obj_stopper, 180);
            global.enemy_speed_scalar = 1.2;
            global.enemy_popcorn_limit = 14;
            global.enemy_standard_limit = 4;
            global.background_object = obj_bg_cogito;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_1;
            else
                global.floors_method = UnknownEnum.Value_4;
            
            break;
        
        case "s_superjumprevolve":
            global.floors_fruit_percent = [30, 45];
            global.floors_required_percent = 85;
            add_enemy_spawn(4, obj_blob, 350);
            add_enemy_spawn(2, obj_gem, 350);
            add_enemy_spawn(2, obj_star, 350);
            add_enemy_spawn(2, obj_blob, 350);
            add_enemy_spawn(1, obj_kuso, 350);
            add_enemy_spawn(1, obj_blob, 350);
            add_enemy_spawn(2, obj_gem, 350);
            add_enemy_spawn(2, obj_star, 350);
            add_enemy_spawn(4, obj_blob, 350);
            add_enemy_spawn(2, obj_gem, 350);
            add_enemy_spawn(2, obj_marble, 350);
            add_enemy_spawn(1, obj_mole, 350);
            global.enemy_popcorn_limit = 12;
            global.background_object = obj_bg_bond;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_shattercube":
            global.floors_fruit_percent = [25, 55];
            global.floors_required_percent = 85;
            add_enemy_spawn(2, obj_blob, 150);
            add_enemy_spawn(1, obj_draco, 150);
            add_enemy_spawn(1, obj_powerup_shield, 160);
            add_enemy_spawn(2, obj_blob, 160);
            add_enemy_spawn(1, obj_draco, 160);
            add_enemy_spawn(1, obj_ace, 160);
            add_enemy_spawn(1, obj_blob, 160);
            add_enemy_spawn(1, obj_powerup_impact, 160);
            add_enemy_spawn(1, obj_draco, 160);
            add_enemy_spawn(2, obj_flub, 160);
            add_enemy_spawn(1, obj_leaper, 160);
            add_enemy_spawn(2, obj_blob, 160);
            add_enemy_spawn(2, obj_flub, 160);
            global.enemy_popcorn_limit = 14;
            global.enemy_standard_limit = 12;
            ds_map_set(global.enemy_specific_limit, obj_leaper, 2);
            ds_map_set(global.enemy_specific_limit, obj_draco, 2);
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_vastness;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_3;
            
            break;
        
        case "s_poutine":
            global.floors_fruit_percent = [20, 60];
            global.floors_required_percent = 90;
            
            repeat (2)
            {
                add_enemy_spawn(2, obj_blob, 150);
                add_enemy_spawn(2, obj_giraffe, 150);
                add_enemy_spawn(1, obj_powerup_impact, 160);
                add_enemy_spawn(1, obj_viruse, 150);
                add_enemy_spawn(1, obj_blob, 160);
                add_enemy_spawn(1, obj_strongman, 160);
                add_enemy_spawn(1, obj_blob, 160);
                add_enemy_spawn(2, obj_giraffe, 150);
                add_enemy_spawn(1, obj_blob, 150);
                add_enemy_spawn(1, obj_stopper, 150);
                add_enemy_spawn(1, obj_blob, 150);
            }
            
            add_enemy_spawn(1, obj_remover, 150);
            global.enemy_popcorn_limit = 14;
            global.enemy_standard_limit = 4;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_1;
            else
                global.floors_method = UnknownEnum.Value_4;
            
            break;
        
        case "s_loopgalaxy":
            global.floors_fruit_percent = [20, 40];
            global.floors_required_percent = 80;
            add_enemy_spawn(3, obj_blob, 300);
            add_enemy_spawn(2, obj_leaper, 300);
            add_enemy_spawn(2, obj_clover, 300);
            add_enemy_spawn(1, obj_powerup_paint_balloon, 300);
            add_enemy_spawn(3, obj_blob, 300);
            add_enemy_spawn(2, obj_leaper, 300);
            add_enemy_spawn(2, obj_sparkun, 300);
            add_enemy_spawn(3, obj_blob, 300);
            add_enemy_spawn(2, obj_leaper, 300);
            add_enemy_spawn(2, obj_clover, 300);
            add_enemy_spawn(1, obj_powerup_superjump, 300);
            add_enemy_spawn(3, obj_blob, 300);
            add_enemy_spawn(2, obj_leaper, 300);
            add_enemy_spawn(2, obj_sparkun, 300);
            global.enemy_popcorn_limit = 8;
            global.enemy_standard_limit = 4;
            global.background_object = obj_bg_nebula;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_2;
            break;
        
        case "s_hellscocoon":
            global.floors_fruit_percent = [50, 55];
            global.floors_required_percent = 95;
            add_enemy_spawn(1, obj_gero, 150);
            add_enemy_spawn(1, obj_flub, 150);
            add_enemy_spawn(1, obj_gero, 150);
            add_enemy_spawn(1, obj_sunsan, 150);
            add_enemy_spawn(1, obj_wobbler, 150);
            add_enemy_spawn(1, obj_remover, 150);
            add_enemy_spawn(1, obj_powerup_stamphammer, 150);
            add_enemy_spawn(1, obj_gero, 150);
            add_enemy_spawn(2, obj_fuse, 220);
            add_enemy_spawn(1, obj_gero, 150);
            add_enemy_spawn(1, obj_flub, 150);
            add_enemy_spawn(1, obj_sunsan, 150);
            add_enemy_spawn(1, obj_wobbler, 150);
            add_enemy_spawn(2, obj_blob, 220);
            add_enemy_spawn(1, obj_clover, 150);
            add_enemy_spawn(1, obj_viruse, 150);
            global.enemy_popcorn_limit = 14;
            global.enemy_standard_limit = 4;
            global.floors_method = UnknownEnum.Value_2;
            break;
        
        case "s_helipad":
            global.floors_fruit_percent = [5, 30];
            global.floors_required_percent = 75;
            add_enemy_spawn(1, obj_blob, 150);
            add_enemy_spawn(1, obj_fuse, 150);
            add_enemy_spawn(1, obj_clover, 150);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 150);
            add_enemy_spawn(2, obj_gem, 150);
            add_enemy_spawn(1, obj_fuse, 150);
            add_enemy_spawn(1, obj_clover, 150);
            add_enemy_spawn(1, obj_snake, 150);
            add_enemy_spawn(1, obj_blob, 150);
            add_enemy_spawn(1, obj_fuse, 150);
            add_enemy_spawn(1, obj_draco, 150);
            add_enemy_spawn(1, obj_wobbler, 150);
            add_enemy_spawn(1, obj_blob, 150);
            global.enemy_popcorn_limit = 14;
            global.enemy_standard_limit = 8;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_1;
            
            break;
        
        case "s_interstellarfaucet":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 75;
            add_enemy_spawn(1, obj_draco, 150);
            add_enemy_spawn(1, obj_nooter, 150);
            add_enemy_spawn(1, obj_molemage, 150);
            add_enemy_spawn(1, obj_powerup_dash, 150);
            add_enemy_spawn(1, obj_molemage, 150);
            add_enemy_spawn(1, obj_draco, 150);
            add_enemy_spawn(1, obj_boobytrap_dash, 150);
            add_enemy_spawn(2, obj_ace, 150);
            add_enemy_spawn(1, obj_draco, 150);
            add_enemy_spawn(1, obj_nooter, 150);
            add_enemy_spawn(1, obj_molemage, 150);
            add_enemy_spawn(1, obj_powerup_dash, 150);
            add_enemy_spawn(1, obj_nooter, 150);
            add_enemy_spawn(2, obj_ace, 150);
            add_enemy_spawn(1, obj_boobytrap_dash, 150);
            global.enemy_popcorn_limit = 14;
            global.enemy_standard_limit = 6;
            global.enemy_speed_scalar = 0.9;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_1;
            
            break;
        
        case "s_brainparasite":
            global.floors_fruit_percent = [30, 55];
            global.floors_required_percent = 75;
            add_enemy_spawn(1, obj_blob, 150);
            add_enemy_spawn(1, obj_wobbler, 150);
            add_enemy_spawn(2, obj_blob, 180);
            add_enemy_spawn(1, obj_draco, 150);
            add_enemy_spawn(1, obj_powerup_impact, 150);
            add_enemy_spawn(1, obj_giraffe, 150);
            add_enemy_spawn(1, obj_blob, 150);
            add_enemy_spawn(1, obj_wobbler, 150);
            add_enemy_spawn(2, obj_blob, 180);
            add_enemy_spawn(1, obj_draco, 150);
            add_enemy_spawn(3, obj_blob, 150);
            add_enemy_spawn(1, obj_blob, 150);
            add_enemy_spawn(1, obj_wobbler, 150);
            add_enemy_spawn(2, obj_blob, 180);
            add_enemy_spawn(1, obj_draco, 150);
            add_enemy_spawn(1, obj_remover, 150);
            add_enemy_spawn(1, obj_powerup_impact, 150);
            add_enemy_spawn(1, obj_giraffe, 150);
            add_enemy_spawn(1, obj_blob, 150);
            add_enemy_spawn(1, obj_wobbler, 150);
            add_enemy_spawn(2, obj_blob, 180);
            add_enemy_spawn(1, obj_draco, 150);
            add_enemy_spawn(3, obj_blob, 150);
            global.enemy_popcorn_limit = 10;
            global.enemy_standard_limit = 4;
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_cosmicoilrig":
            global.floors_fruit_percent = [30, 55];
            global.floors_required_percent = 90;
            add_enemy_spawn(1, obj_dream, 150);
            add_enemy_spawn(1, obj_flub, 150);
            add_enemy_spawn(2, obj_clover, 180);
            add_enemy_spawn(1, obj_wobbler, 150);
            add_enemy_spawn(1, obj_ufo, 150);
            add_enemy_spawn(1, obj_powerup_stamphammer, 150);
            add_enemy_spawn(1, obj_blub, 150);
            add_enemy_spawn(1, obj_crescent, 150);
            add_enemy_spawn(1, obj_wobbler, 150);
            add_enemy_spawn(2, obj_clover, 180);
            add_enemy_spawn(1, obj_ace, 150);
            add_enemy_spawn(3, obj_ufo, 150);
            add_enemy_spawn(1, obj_powerup_paint_balloon, 150);
            global.enemy_popcorn_limit = 16;
            global.enemy_standard_limit = 6;
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_nexus2060":
            global.floors_fruit_percent = [30, 40];
            global.floors_required_percent = 95;
            
            for (var i = 0; i < 3; i++)
            {
                add_enemy_spawn(4, obj_star, 100);
                add_enemy_spawn(1, obj_hypermole, 160);
                add_enemy_spawn(1, obj_leaper, 160);
                add_enemy_spawn(1, obj_stopper, 160);
                add_enemy_spawn(1, obj_slinky, 160);
                add_enemy_spawn(1, obj_gem, 160);
                
                if (i == 1)
                    add_enemy_spawn(1, obj_viruse, 160);
                
                add_enemy_spawn(1, obj_powerup_impact, 160);
                add_enemy_spawn(2, obj_star, 160);
                add_enemy_spawn(1, obj_hypermole, 160);
                add_enemy_spawn(1, obj_leaper, 160);
                add_enemy_spawn(2, obj_gem, 160);
                add_enemy_spawn(1, obj_slinky, 160);
                add_enemy_spawn(1, obj_powerup_wrap_paper, 160);
                add_enemy_spawn(2, obj_ufo, 150);
            }
            
            global.enemy_popcorn_limit = 16;
            global.enemy_standard_limit = 6;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_wiremaze":
            global.floors_fruit_percent = [30, 60];
            global.floors_required_percent = 90;
            add_enemy_spawn(1, obj_seeker, 180);
            add_enemy_spawn(1, obj_snake, 180);
            add_enemy_spawn(1, obj_seeker, 180);
            add_enemy_spawn(1, obj_snake, 180);
            add_enemy_spawn(3, obj_molemage, 180);
            add_enemy_spawn(3, obj_blub, 180);
            add_enemy_spawn(1, obj_powerup_stamphammer, 150);
            add_enemy_spawn(1, obj_seeker, 180);
            add_enemy_spawn(1, obj_snake, 180);
            add_enemy_spawn(3, obj_molemage, 180);
            add_enemy_spawn(3, obj_blub, 180);
            add_enemy_spawn(1, obj_powerup_dash, 150);
            global.enemy_popcorn_limit = 11;
            global.enemy_standard_limit = 7;
            floor_scoring_absorb_color(spr_color_set, 0, 2);
            global.background_object = obj_bg_millennium;
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_neptune":
            global.floors_fruit_percent = [30, 55];
            global.floors_required_percent = 95;
            add_enemy_spawn(1, obj_ufo, 150);
            add_enemy_spawn(1, obj_nooter, 150);
            add_enemy_spawn(1, obj_ufo, 150);
            add_enemy_spawn(2, obj_flub, 150);
            add_enemy_spawn(2, obj_nooter, 150);
            add_enemy_spawn(1, obj_sunsan, 150);
            add_enemy_spawn(1, obj_powerup_stamphammer, 150);
            add_enemy_spawn(2, obj_flub, 150);
            add_enemy_spawn(2, obj_nooter, 150);
            add_enemy_spawn(1, obj_ufo, 150);
            add_enemy_spawn(1, obj_boobytrap_paint_balloon, 150);
            add_enemy_spawn(1, obj_flub, 150);
            add_enemy_spawn(1, obj_ace, 150);
            add_enemy_spawn(1, obj_flub, 150);
            add_enemy_spawn(1, obj_powerup_paint_balloon, 150);
            global.enemy_popcorn_limit = 16;
            global.enemy_standard_limit = 4;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_bingo":
            global.floors_fruit_percent = [50, 75];
            global.floors_required_percent = 85;
            add_enemy_spawn(1, obj_nooter, 150);
            add_enemy_spawn(1, obj_fuse, 150);
            add_enemy_spawn(2, obj_draco, 180);
            add_enemy_spawn(1, obj_ace, 150);
            add_enemy_spawn(1, obj_hypermole, 150);
            add_enemy_spawn(1, obj_powerup_stamphammer, 150);
            add_enemy_spawn(1, obj_nooter, 150);
            add_enemy_spawn(1, obj_arachnid, 150);
            add_enemy_spawn(1, obj_fuse, 150);
            add_enemy_spawn(1, obj_draco, 150);
            add_enemy_spawn(1, obj_powerup_shield, 150);
            add_enemy_spawn(2, obj_ace, 180);
            add_enemy_spawn(1, obj_fuse, 150);
            add_enemy_spawn(1, obj_viruse, 150);
            add_enemy_spawn(1, obj_powerup_superjump, 150);
            add_enemy_spawn(1, obj_hypermole, 150);
            add_enemy_spawn(3, obj_blob, 150);
            add_enemy_spawn(1, obj_powerup_dash, 150);
            add_enemy_spawn(1, obj_arachnid, 150);
            global.enemy_popcorn_limit = 16;
            global.enemy_standard_limit = 6;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_1;
            else
                global.floors_method = UnknownEnum.Value_3;
            
            break;
        
        case "s_pencil":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 75;
            add_enemy_spawn(2, obj_ufo, 140);
            add_enemy_spawn(2, obj_stopper, 140);
            add_enemy_spawn(2, obj_ufo, 140);
            add_enemy_spawn(1, obj_powerup_stamphammer, 120);
            add_enemy_spawn(2, obj_flub, 130);
            add_enemy_spawn(1, obj_stopper, 130);
            add_enemy_spawn(1, obj_parrot, 130);
            add_enemy_spawn(2, obj_ufo, 130);
            add_enemy_spawn(1, obj_giraffe, 130);
            add_enemy_spawn(1, obj_leaper, 130);
            add_enemy_spawn(1, obj_giraffe, 130);
            add_enemy_spawn(1, obj_leaper, 130);
            add_enemy_spawn(1, obj_star, 130);
            add_enemy_spawn(1, obj_clover, 130);
            add_enemy_spawn(1, obj_powerup_paint_balloon, 120);
            global.enemy_popcorn_limit = 16;
            global.enemy_standard_limit = 8;
            ds_map_set(global.enemy_specific_limit, obj_ufo, 4);
            ds_map_set(global.enemy_specific_limit, obj_leaper, 3);
            ds_map_set(global.enemy_specific_limit, obj_giraffe, 3);
            global.background_object = obj_bg_platinum;
            floor_scoring_absorb_color(spr_color_set, 1, 0);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_1;
            else
                global.floors_method = UnknownEnum.Value_3;
            
            break;
        
        case "s_bolt":
            global.floors_fruit_percent = [10, 40];
            global.floors_required_percent = 90;
            add_enemy_spawn(1, obj_capsule, 160);
            add_enemy_spawn(1, obj_snake, 160);
            add_enemy_spawn(1, obj_slinky, 160);
            add_enemy_spawn(1, obj_molemage, 160);
            add_enemy_spawn(1, obj_powerup_dash, 200);
            add_enemy_spawn(1, obj_capsule, 200);
            add_enemy_spawn(1, obj_fuse, 200);
            add_enemy_spawn(1, obj_wobbler, 200);
            add_enemy_spawn(1, obj_capsule, 200);
            add_enemy_spawn(1, obj_snake, 200);
            add_enemy_spawn(1, obj_molemage, 160);
            add_enemy_spawn(2, obj_slinky, 160);
            add_enemy_spawn(1, obj_powerup_dash, 200);
            add_enemy_spawn(1, obj_capsule, 200);
            add_enemy_spawn(1, obj_flub, 200);
            add_enemy_spawn(1, obj_molemage, 160);
            add_enemy_spawn(2, obj_snake, 200);
            global.enemy_speed_scalar = (global.stage_difficulty == UnknownEnum.Value_0) ? 1.25 : 1;
            global.enemy_popcorn_limit = 18;
            global.enemy_standard_limit = 8;
            ds_map_set(global.enemy_specific_limit, obj_snake, 4);
            ds_map_set(global.enemy_specific_limit, obj_slinky, 4);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_1;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_blackout":
            global.floors_fruit_percent = [25, 45];
            global.floors_required_percent = 85;
            add_enemy_spawn(1, obj_draco, 150);
            add_enemy_spawn(1, obj_ufo, 150);
            add_enemy_spawn(1, obj_sparkun, 150);
            add_enemy_spawn(1, obj_hypermole, 150);
            add_enemy_spawn(2, obj_gem, 150);
            add_enemy_spawn(2, obj_flub, 150);
            add_enemy_spawn(1, obj_powerup_stamphammer, 150);
            add_enemy_spawn(2, obj_gem, 150);
            add_enemy_spawn(2, obj_flub, 150);
            add_enemy_spawn(1, obj_sparkun, 150);
            add_enemy_spawn(1, obj_draco, 150);
            add_enemy_spawn(1, obj_ufo, 150);
            add_enemy_spawn(1, obj_arachnid, 150);
            add_enemy_spawn(1, obj_gem, 150);
            add_enemy_spawn(1, obj_molemage, 150);
            global.enemy_popcorn_limit = 16;
            global.enemy_standard_limit = 4;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_1;
            else
                global.floors_method = UnknownEnum.Value_3;
            
            break;
        
        case "s_drone":
            global.floors_fruit_percent = [20, 50];
            global.floors_required_percent = 100;
            add_enemy_spawn(2, obj_crescent, 200);
            add_enemy_spawn(1, obj_draco, 200);
            add_enemy_spawn(1, obj_powerup_dash, 120);
            add_enemy_spawn(1, obj_gem, 200);
            add_enemy_spawn(3, obj_kuso, 200);
            add_enemy_spawn(1, obj_draco, 200);
            add_enemy_spawn(1, obj_crescent, 200);
            add_enemy_spawn(1, obj_draco, 200);
            add_enemy_spawn(1, obj_octi, 200);
            add_enemy_spawn(2, obj_gero, 200);
            add_enemy_spawn(3, obj_gem, 180);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 120);
            global.enemy_popcorn_limit = 14;
            global.enemy_standard_limit = 4;
            global.enemy_speed_scalar = 1.4;
            global.background_object = obj_bg_rapture_sec1;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_snakesandladders":
            global.floors_fruit_percent = [10, 30];
            global.floors_required_percent = 100;
            add_enemy_spawn(2, obj_clover, 200);
            add_enemy_spawn(1, obj_leaper, 200);
            add_enemy_spawn(1, obj_viruse, 200);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 120);
            add_enemy_spawn(1, obj_clover, 200);
            add_enemy_spawn(1, obj_sparkun, 200);
            add_enemy_spawn(2, obj_hypermole, 200);
            add_enemy_spawn(2, obj_leaper, 200);
            add_enemy_spawn(1, obj_clover, 200);
            add_enemy_spawn(1, obj_strongman, 200);
            add_enemy_spawn(1, obj_molemage, 200);
            add_enemy_spawn(2, obj_leaper, 200);
            add_enemy_spawn(3, obj_clover, 180);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 120);
            global.enemy_popcorn_limit = 18;
            global.enemy_standard_limit = 5;
            global.enemy_speed_scalar = 1.4;
            global.background_object = obj_bg_rapture_sec2;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_skewystreet":
            global.floors_fruit_percent = [30, 65];
            global.floors_required_percent = 100;
            add_enemy_spawn(2, obj_blob, 200);
            add_enemy_spawn(1, obj_giraffe, 200);
            add_enemy_spawn(1, obj_powerup_shield, 120);
            add_enemy_spawn(1, obj_gem, 200);
            add_enemy_spawn(1, obj_blob, 200);
            add_enemy_spawn(1, obj_crescent, 200);
            add_enemy_spawn(1, obj_marble, 200);
            add_enemy_spawn(1, obj_gem, 200);
            add_enemy_spawn(1, obj_flub, 200);
            add_enemy_spawn(1, obj_viruse, 200);
            add_enemy_spawn(2, obj_giraffe, 200);
            add_enemy_spawn(3, obj_marble, 180);
            add_enemy_spawn(1, obj_powerup_stamphammer, 120);
            global.enemy_popcorn_limit = 14;
            global.enemy_standard_limit = 4;
            global.background_object = obj_bg_rapture_sec3;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_boomshakalaka":
            global.floors_fruit_percent = [10, 30];
            global.floors_required_percent = 100;
            add_enemy_spawn(2, obj_clover, 200);
            add_enemy_spawn(1, obj_spectre, 200);
            add_enemy_spawn(1, obj_powerup_impact, 120);
            add_enemy_spawn(1, obj_clover, 200);
            add_enemy_spawn(2, obj_molemage, 200);
            add_enemy_spawn(2, obj_nooter, 200);
            add_enemy_spawn(1, obj_kuso, 200);
            add_enemy_spawn(1, obj_arachnid, 200);
            add_enemy_spawn(1, obj_viruse, 200);
            add_enemy_spawn(1, obj_powerup_shield, 120);
            add_enemy_spawn(1, obj_strongman, 200);
            add_enemy_spawn(1, obj_molemage, 200);
            add_enemy_spawn(2, obj_spectre, 200);
            add_enemy_spawn(3, obj_clover, 180);
            add_enemy_spawn(1, obj_viruse, 200);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 120);
            global.enemy_popcorn_limit = 20;
            global.enemy_standard_limit = 6;
            global.enemy_speed_scalar = 1.4;
            global.background_object = obj_bg_rapture_sec4;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_galaxy2":
            global.floors_fruit_percent = [20, 50];
            global.floors_required_percent = 100;
            add_enemy_spawn(1, obj_crescent, 200);
            add_enemy_spawn(1, obj_ufo, 200);
            add_enemy_spawn(1, obj_draco, 200);
            add_enemy_spawn(1, obj_powerup_dash, 120);
            add_enemy_spawn(1, obj_kuso, 200);
            add_enemy_spawn(1, obj_clover, 200);
            add_enemy_spawn(1, obj_kuso, 200);
            add_enemy_spawn(1, obj_ufo, 200);
            add_enemy_spawn(1, obj_draco, 200);
            add_enemy_spawn(1, obj_crescent, 200);
            add_enemy_spawn(1, obj_draco, 200);
            add_enemy_spawn(2, obj_ufo, 200);
            add_enemy_spawn(3, obj_crescent, 180);
            add_enemy_spawn(1, obj_powerup_stamphammer, 120);
            global.enemy_popcorn_limit = 16;
            global.enemy_standard_limit = 4;
            global.enemy_speed_scalar = 1.4;
            global.background_object = obj_bg_rapture_sec1;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_collapsecube":
            global.floors_fruit_percent = [30, 40];
            global.floors_required_percent = 100;
            add_enemy_spawn(2, obj_capsule, 200);
            add_enemy_spawn(1, obj_blib, 200);
            add_enemy_spawn(1, obj_clover, 200);
            add_enemy_spawn(1, obj_sunsan, 200);
            add_enemy_spawn(1, obj_powerup_stamphammer, 120);
            add_enemy_spawn(2, obj_capsule, 200);
            add_enemy_spawn(1, obj_blib, 200);
            add_enemy_spawn(1, obj_ace, 200);
            add_enemy_spawn(1, obj_stopper, 200);
            add_enemy_spawn(2, obj_blub, 200);
            add_enemy_spawn(1, obj_seeker, 200);
            add_enemy_spawn(1, obj_leaper, 200);
            global.enemy_popcorn_limit = 14;
            global.enemy_standard_limit = 3;
            global.enemy_speed_scalar = 1.5;
            global.background_object = obj_bg_rapture_sec2;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_love":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 100;
            add_enemy_spawn(2, obj_arachnid, 260);
            add_enemy_spawn(1, obj_powerup_shield, 260);
            add_enemy_spawn(1, obj_draco, 260);
            add_enemy_spawn(1, obj_molemage, 260);
            add_enemy_spawn(1, obj_powerup_stamphammer, 260);
            add_enemy_spawn(1, obj_viruse, 260);
            add_enemy_spawn(2, obj_capsule, 260);
            add_enemy_spawn(2, obj_dream, 260);
            add_enemy_spawn(1, obj_powerup_paint_balloon, 260);
            add_enemy_spawn(2, obj_leaper, 260);
            add_enemy_spawn(1, obj_blob, 260);
            add_enemy_spawn(1, obj_powerup_shield, 260);
            add_enemy_spawn(1, obj_gem, 260);
            add_enemy_spawn(1, obj_powerup_impact, 260);
            add_enemy_spawn(2, obj_arachnid, 260);
            add_enemy_spawn(1, obj_draco, 260);
            add_enemy_spawn(1, obj_powerup_shield, 260);
            add_enemy_spawn(1, obj_molemage, 260);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 260);
            add_enemy_spawn(1, obj_viruse, 260);
            add_enemy_spawn(2, obj_star, 260);
            add_enemy_spawn(2, obj_dream, 260);
            add_enemy_spawn(1, obj_powerup_shield, 260);
            add_enemy_spawn(2, obj_wobbler, 260);
            add_enemy_spawn(1, obj_blob, 260);
            add_enemy_spawn(1, obj_gem, 260);
            add_enemy_spawn(1, obj_powerup_stamphammer, 260);
            global.enemy_popcorn_limit = 6;
            global.enemy_standard_limit = 6;
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_rapture_sec3;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_1;
            else
                global.floors_method = UnknownEnum.Value_4;
            
            break;
        
        case "s_loophandkerchief":
            global.floors_fruit_percent = [25, 50];
            global.floors_required_percent = 75;
            add_enemy_spawn(2, obj_nooter, 100);
            add_enemy_spawn(1, obj_seeker, 100);
            add_enemy_spawn(1, obj_sparkun, 100);
            add_enemy_spawn(1, obj_parrot, 100);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 150);
            add_enemy_spawn(3, obj_funbag, 50);
            add_enemy_spawn(1, obj_blib, 150);
            add_enemy_spawn(2, obj_nooter, 100);
            add_enemy_spawn(1, obj_seeker, 100);
            add_enemy_spawn(1, obj_parrot, 100);
            add_enemy_spawn(3, obj_funbag, 50);
            add_enemy_spawn(1, obj_sparkun, 150);
            add_enemy_spawn(1, obj_clover, 150);
            add_enemy_spawn(1, obj_blib, 150);
            add_enemy_spawn(1, obj_seeker, 150);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 150);
            add_enemy_spawn(1, obj_seeker, 100);
            add_enemy_spawn(1, obj_parrot, 100);
            add_enemy_spawn(2, obj_nooter, 100);
            global.enemy_speed_scalar = 2;
            global.enemy_popcorn_limit = 22;
            global.enemy_standard_limit = 10;
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_dice":
            global.floors_fruit_percent = [25, 55];
            global.floors_required_percent = 95;
            add_enemy_spawn(1, obj_ufo, 150);
            add_enemy_spawn(1, obj_funbag, 180);
            add_enemy_spawn(1, obj_capsule, 180);
            add_enemy_spawn(1, obj_powerup_superjump, 150);
            add_enemy_spawn(1, obj_leaper, 150);
            add_enemy_spawn(1, obj_hypermole, 150);
            add_enemy_spawn(2, obj_draco, 180);
            add_enemy_spawn(1, obj_powerup_stamphammer, 150);
            add_enemy_spawn(1, obj_ufo, 150);
            add_enemy_spawn(1, obj_hypermole, 150);
            add_enemy_spawn(1, obj_powerup_dash, 150);
            add_enemy_spawn(1, obj_ufo, 150);
            add_enemy_spawn(1, obj_arachnid, 150);
            add_enemy_spawn(1, obj_leaper, 150);
            add_enemy_spawn(1, obj_draco, 150);
            add_enemy_spawn(1, obj_powerup_shield, 150);
            add_enemy_spawn(2, obj_funbag, 180);
            add_enemy_spawn(1, obj_capsule, 180);
            add_enemy_spawn(1, obj_fuse, 150);
            add_enemy_spawn(1, obj_powerup_superjump, 150);
            add_enemy_spawn(1, obj_hypermole, 150);
            add_enemy_spawn(3, obj_capsule, 150);
            add_enemy_spawn(1, obj_powerup_wrap_paper, 150);
            add_enemy_spawn(1, obj_arachnid, 150);
            global.enemy_speed_scalar = 1.5;
            global.enemy_popcorn_limit = 22;
            global.enemy_standard_limit = 12;
            ds_map_set(global.enemy_specific_limit, obj_leaper, 3);
            ds_map_set(global.enemy_specific_limit, obj_draco, 3);
            ds_map_set(global.enemy_specific_limit, obj_arachnid, 3);
            ds_map_set(global.enemy_specific_limit, obj_ufo, 3);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_pripyat":
            global.floors_fruit_percent = [20, 50];
            global.floors_required_percent = 90;
            add_enemy_spawn(2, obj_giraffe, 120);
            add_enemy_spawn(1, obj_slinky, 120);
            add_enemy_spawn(1, obj_kuso, 120);
            add_enemy_spawn(2, obj_giraffe, 120);
            add_enemy_spawn(1, obj_parrot, 220);
            add_enemy_spawn(1, obj_sparkun, 220);
            add_enemy_spawn(1, obj_blib, 220);
            add_enemy_spawn(1, obj_sparkun, 220);
            add_enemy_spawn(1, obj_powerup_stamphammer, 150);
            add_enemy_spawn(1, obj_giraffe, 220);
            add_enemy_spawn(1, obj_kuso, 120);
            add_enemy_spawn(2, obj_slinky, 220);
            add_enemy_spawn(2, obj_giraffe, 220);
            add_enemy_spawn(1, obj_remover, 220);
            add_enemy_spawn(1, obj_sparkun, 220);
            add_enemy_spawn(1, obj_powerup_bomb, 150);
            add_enemy_spawn(1, obj_blib, 220);
            global.enemy_popcorn_limit = 14;
            global.enemy_standard_limit = 8;
            ds_map_set(global.enemy_specific_limit, obj_giraffe, 4);
            ds_map_set(global.enemy_specific_limit, obj_slinky, 4);
            floor_scoring_absorb_color(spr_color_set, 0, 2);
            global.background_object = obj_bg_cozy;
            global.floors_method = UnknownEnum.Value_2;
            break;
        
        case "s_fxairline":
            global.floors_fruit_percent = [10, 30];
            global.floors_required_percent = 90;
            add_enemy_spawn(2, obj_ufo, 150);
            add_enemy_spawn(1, obj_powerup_shield, 150);
            add_enemy_spawn(2, obj_leaper, 150);
            add_enemy_spawn(2, obj_giraffe, 150);
            add_enemy_spawn(1, obj_funbag, 180);
            add_enemy_spawn(1, obj_dream, 180);
            add_enemy_spawn(1, obj_funbag, 180);
            add_enemy_spawn(1, obj_clover, 180);
            add_enemy_spawn(1, obj_dream, 180);
            add_enemy_spawn(1, obj_powerup_stamphammer, 150);
            add_enemy_spawn(2, obj_leaper, 150);
            add_enemy_spawn(1, obj_clover, 180);
            add_enemy_spawn(2, obj_giraffe, 150);
            add_enemy_spawn(1, obj_dream, 180);
            add_enemy_spawn(2, obj_ufo, 150);
            add_enemy_spawn(1, obj_powerup_dash, 150);
            add_enemy_spawn(2, obj_leaper, 150);
            add_enemy_spawn(2, obj_giraffe, 150);
            add_enemy_spawn(1, obj_funbag, 180);
            add_enemy_spawn(1, obj_dream, 180);
            add_enemy_spawn(1, obj_funbag, 180);
            add_enemy_spawn(1, obj_clover, 180);
            add_enemy_spawn(1, obj_dream, 180);
            add_enemy_spawn(1, obj_powerup_stamphammer, 150);
            add_enemy_spawn(2, obj_leaper, 150);
            add_enemy_spawn(1, obj_clover, 180);
            add_enemy_spawn(2, obj_giraffe, 150);
            add_enemy_spawn(1, obj_dream, 180);
            global.enemy_speed_scalar = 1.75;
            global.enemy_popcorn_limit = 22;
            global.enemy_standard_limit = 12;
            ds_map_set(global.enemy_specific_limit, obj_ufo, 2);
            ds_map_set(global.enemy_specific_limit, obj_leaper, 5);
            ds_map_set(global.enemy_specific_limit, obj_giraffe, 3);
            ds_map_set(global.enemy_specific_limit, obj_arachnid, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_anelevatorcity":
            global.floors_fruit_percent = [5, 40];
            global.floors_required_percent = 75;
            
            for (var ii = 0; ii <= 2; ii++)
            {
                add_enemy_spawn(1, obj_clover, 330);
                add_enemy_spawn(1, obj_sparkun, 330);
                add_enemy_spawn(2, obj_leaper, 230);
                add_enemy_spawn(2, obj_clover, 230);
                add_enemy_spawn(2, obj_hypermole, 230);
                add_enemy_spawn(2, obj_leaper, 230);
                add_enemy_spawn(2, obj_hypermole, 230);
                
                if (ii == 0)
                {
                    add_enemy_spawn(1, obj_powerup_impact, 120);
                    add_enemy_spawn(1, obj_viruse, 330);
                }
                else
                {
                    add_enemy_spawn(1, obj_powerup_superjump, 120);
                    add_enemy_spawn(1, obj_remover, 330);
                }
            }
            
            global.enemy_speed_scalar = 1.75;
            global.enemy_popcorn_limit = 22;
            global.enemy_standard_limit = 6;
            ds_map_set(global.enemy_specific_limit, obj_leaper, 4);
            global.background_object = obj_bg_luna;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_circuitbreakers":
            global.floors_fruit_percent = [10, 20];
            global.floors_required_percent = 90;
            add_enemy_spawn(1, obj_blob, 300);
            global.enemy_popcorn_limit = 12;
            floor_scoring_absorb_color(spr_color_set, 0, 0);
            global.background_object = obj_bg_mandel;
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_superjumpcubes":
            global.floors_fruit_percent = [25, 35];
            global.floors_required_percent = 90;
            add_enemy_spawn(3, obj_clover, 330);
            add_enemy_spawn(2, obj_mole, 330);
            add_enemy_spawn(1, obj_leaper, 330);
            add_enemy_spawn(3, obj_clover, 330);
            add_enemy_spawn(1, obj_mole, 330);
            add_enemy_spawn(1, obj_molemage, 330);
            add_enemy_spawn(1, obj_leaper, 330);
            global.enemy_speed_scalar = 0.8;
            global.enemy_popcorn_limit = 15;
            global.enemy_standard_limit = 3;
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "s_hourglass":
            global.floors_fruit_percent = [40, 65];
            global.floors_required_percent = 85;
            add_enemy_spawn(1, obj_draco, 190);
            add_enemy_spawn(1, obj_parrot, 190);
            add_enemy_spawn(1, obj_draco, 180);
            add_enemy_spawn(1, obj_capsule, 180);
            add_enemy_spawn(1, obj_powerup_dash, 150);
            add_enemy_spawn(1, obj_blib, 150);
            add_enemy_spawn(1, obj_draco, 150);
            add_enemy_spawn(2, obj_gem, 180);
            add_enemy_spawn(1, obj_powerup_stamphammer, 150);
            add_enemy_spawn(1, obj_ufo, 150);
            add_enemy_spawn(1, obj_capsule, 150);
            add_enemy_spawn(1, obj_powerup_impact, 150);
            add_enemy_spawn(1, obj_dream, 150);
            add_enemy_spawn(1, obj_strongman, 150);
            add_enemy_spawn(1, obj_capsule, 150);
            add_enemy_spawn(1, obj_draco, 150);
            add_enemy_spawn(1, obj_powerup_shield, 150);
            add_enemy_spawn(2, obj_strongman, 180);
            add_enemy_spawn(1, obj_capsule, 180);
            add_enemy_spawn(1, obj_blib, 180);
            add_enemy_spawn(1, obj_parrot, 150);
            add_enemy_spawn(1, obj_powerup_impact, 150);
            add_enemy_spawn(1, obj_parrot, 150);
            add_enemy_spawn(1, obj_draco, 150);
            add_enemy_spawn(3, obj_strongman, 150);
            add_enemy_spawn(1, obj_powerup_dash, 150);
            add_enemy_spawn(1, obj_ufo, 150);
            global.enemy_speed_scalar = 1.5;
            global.enemy_popcorn_limit = 22;
            global.enemy_standard_limit = 10;
            ds_map_set(global.enemy_specific_limit, obj_draco, (global.stage_difficulty == UnknownEnum.Value_0) ? 2 : 4);
            ds_map_set(global.enemy_specific_limit, obj_ufo, (global.stage_difficulty == UnknownEnum.Value_0) ? 3 : 4);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_1;
            else
                global.floors_method = UnknownEnum.Value_4;
            
            break;
        
        case "s_harddiamond":
            global.floors_fruit_percent = [25, 40];
            global.floors_required_percent = 95;
            add_enemy_spawn(3, obj_gem, 190);
            add_enemy_spawn(1, obj_ufo, 190);
            add_enemy_spawn(1, obj_gem, 190);
            add_enemy_spawn(3, obj_marble, 190);
            add_enemy_spawn(1, obj_powerup_impact, 190);
            add_enemy_spawn(2, obj_gem, 190);
            add_enemy_spawn(1, obj_prodigy, 190);
            add_enemy_spawn(1, obj_ufo, 190);
            add_enemy_spawn(1, obj_gem, 190);
            add_enemy_spawn(3, obj_marble, 190);
            global.enemy_speed_scalar = 2;
            global.enemy_popcorn_limit = 22;
            global.enemy_standard_limit = 8;
            ds_map_set(global.enemy_specific_limit, obj_ufo, 4);
            global.floors_method = UnknownEnum.Value_2;
            break;
        
        case "s_beneath":
            global.floors_fruit_percent = [15, 45];
            global.floors_required_percent = 95;
            add_enemy_spawn(1, obj_fuse, 190);
            add_enemy_spawn(1, obj_snake, 190);
            add_enemy_spawn(1, obj_funbag, 190);
            add_enemy_spawn(1, obj_fuse, 190);
            add_enemy_spawn(3, obj_gem, 190);
            add_enemy_spawn(1, obj_powerup_paint_balloon, 190);
            add_enemy_spawn(1, obj_blob, 190);
            add_enemy_spawn(1, obj_snake, 190);
            add_enemy_spawn(1, obj_gero, 190);
            add_enemy_spawn(1, obj_gem, 190);
            add_enemy_spawn(1, obj_funbag, 190);
            add_enemy_spawn(2, obj_blob, 190);
            add_enemy_spawn(1, obj_snake, 190);
            global.enemy_speed_scalar = 1.5;
            global.enemy_popcorn_limit = 22;
            global.enemy_standard_limit = 8;
            ds_map_set(global.enemy_specific_limit, obj_snake, 4);
            ds_map_set(global.enemy_specific_limit, obj_gero, 4);
            global.floors_method = UnknownEnum.Value_2;
            break;
        
        case "s_phoenix":
            global.floors_fruit_percent = [30, 50];
            global.floors_required_percent = 95;
            add_enemy_spawn(2, obj_crescent, 190);
            add_enemy_spawn(1, obj_marble, 190);
            add_enemy_spawn(1, obj_snake, 190);
            add_enemy_spawn(1, obj_molemage, 190);
            add_enemy_spawn(3, obj_crescent, 190);
            add_enemy_spawn(1, obj_powerup_paint_balloon, 190);
            add_enemy_spawn(1, obj_capsule, 190);
            add_enemy_spawn(2, obj_snake, 190);
            add_enemy_spawn(1, obj_molemage, 190);
            add_enemy_spawn(1, obj_marble, 190);
            add_enemy_spawn(1, obj_gem, 190);
            add_enemy_spawn(1, obj_vlad, 190);
            add_enemy_spawn(2, obj_crescent, 190);
            add_enemy_spawn(1, obj_marble, 190);
            add_enemy_spawn(1, obj_snake, 190);
            global.enemy_speed_scalar = 1.2;
            global.enemy_popcorn_limit = 24;
            global.enemy_standard_limit = 12;
            ds_map_set(global.enemy_specific_limit, obj_snake, 6);
            ds_map_set(global.enemy_specific_limit, obj_marble, 4);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_battleshipusagi":
            global.floors_fruit_percent = [10, 40];
            global.floors_required_percent = 75;
            add_enemy_spawn(1, obj_mole, 150);
            add_enemy_spawn(1, obj_hypermole, 150);
            add_enemy_spawn(1, obj_fuse, 150);
            add_enemy_spawn(1, obj_draco, 180);
            add_enemy_spawn(1, obj_molemage, 150);
            add_enemy_spawn(1, obj_powerup_stamphammer, 150);
            add_enemy_spawn(1, obj_mole, 150);
            add_enemy_spawn(1, obj_fuse, 150);
            add_enemy_spawn(1, obj_draco, 150);
            add_enemy_spawn(2, obj_ufo, 180);
            add_enemy_spawn(1, obj_fuse, 150);
            add_enemy_spawn(1, obj_hypermole, 150);
            add_enemy_spawn(3, obj_ace, 150);
            add_enemy_spawn(1, obj_powerup_dash, 150);
            add_enemy_spawn(1, obj_viruse, 150);
            global.enemy_popcorn_limit = 16;
            global.enemy_standard_limit = 6;
            ds_map_set(global.enemy_specific_limit, obj_draco, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_superjumpuniverse":
            global.floors_fruit_percent = [35, 55];
            global.floors_required_percent = 90;
            add_enemy_spawn(1, obj_ufo, 180);
            add_enemy_spawn(1, obj_powerup_shield, 180);
            add_enemy_spawn(1, obj_leaper, 180);
            add_enemy_spawn(1, obj_molemage, 280);
            add_enemy_spawn(1, obj_blob, 280);
            add_enemy_spawn(1, obj_mole, 280);
            add_enemy_spawn(1, obj_blob, 280);
            add_enemy_spawn(1, obj_boobytrap_impact, 280);
            add_enemy_spawn(1, obj_molemage, 280);
            add_enemy_spawn(1, obj_powerup_impact, 280);
            add_enemy_spawn(2, obj_gem, 280);
            add_enemy_spawn(1, obj_ufo, 280);
            add_enemy_spawn(1, obj_leaper, 280);
            add_enemy_spawn(1, obj_molemage, 280);
            add_enemy_spawn(1, obj_powerup_superjump, 180);
            add_enemy_spawn(1, obj_ufo, 280);
            add_enemy_spawn(2, obj_blob, 280);
            global.enemy_popcorn_limit = 18;
            global.enemy_standard_limit = 7;
            global.enemy_speed_scalar = 0.9;
            ds_map_set(global.enemy_specific_limit, obj_leaper, 1);
            ds_map_set(global.enemy_specific_limit, obj_molemage, 1);
            ds_map_set(global.enemy_specific_limit, obj_mole, 2);
            
            if (global.stage_difficulty == UnknownEnum.Value_0)
                global.floors_method = UnknownEnum.Value_0;
            else
                global.floors_method = UnknownEnum.Value_2;
            
            break;
        
        case "s_fortboyard":
            global.floors_fruit_percent = [45, 65];
            global.floors_required_percent = 95;
            add_enemy_spawn(1, obj_hypermole, 190);
            add_enemy_spawn(1, obj_vlad, 190);
            add_enemy_spawn(1, obj_powerup_stamphammer, 190);
            add_enemy_spawn(3, obj_capsule, 190);
            add_enemy_spawn(1, obj_crescent, 190);
            add_enemy_spawn(1, obj_wobbler, 190);
            add_enemy_spawn(3, obj_gem, 190);
            add_enemy_spawn(1, obj_vlad, 190);
            add_enemy_spawn(1, obj_hypermole, 190);
            add_enemy_spawn(1, obj_powerup_bomb, 190);
            add_enemy_spawn(1, obj_gero, 190);
            add_enemy_spawn(1, obj_gem, 190);
            add_enemy_spawn(2, obj_capsule, 190);
            add_enemy_spawn(1, obj_crescent, 190);
            global.enemy_speed_scalar = 1.2;
            global.enemy_popcorn_limit = 22;
            global.enemy_standard_limit = 4;
            ds_map_set(global.enemy_specific_limit, obj_snake, 4);
            ds_map_set(global.enemy_specific_limit, obj_gero, 4);
            global.floors_method = UnknownEnum.Value_2;
            break;
        
        case "s_hopscotch":
            global.floors_fruit_percent = [10, 20];
            global.floors_required_percent = 95;
            
            repeat (4)
            {
                add_enemy_spawn(2, obj_blob, 220);
                add_enemy_spawn(1, obj_kuso, 220);
                add_enemy_spawn(1, obj_blub, 220);
                add_enemy_spawn(1, obj_blob, 220);
            }
            
            add_enemy_spawn(1, obj_viruse, 220);
            global.enemy_speed_scalar = (global.stage_difficulty == UnknownEnum.Value_0) ? 0.8 : 1;
            global.enemy_popcorn_limit = (global.stage_difficulty == UnknownEnum.Value_0) ? 14 : 20;
            global.enemy_standard_limit = 4;
            global.floors_method = UnknownEnum.Value_2;
            break;
        
        case "5-2":
            global.floors_fruit_percent = [20, 40];
            global.floors_required_percent = 70;
            global.enemy_spawn_order = [obj_blob, obj_blub, obj_blob, obj_blob, obj_blob];
            global.enemy_popcorn_limit = 25;
            global.enemy_spawn_delay_after = [44, 44, 44, 44, 100];
            global.floors_palette[0] = 10246224;
            global.floors_palette[1] = 9723064;
            global.floors_palette[2] = 8426568;
            break;
        
        case "5-3":
            global.floors_fruit_percent = [30, 50];
            global.floors_required_percent = 70;
            global.enemy_spawn_order = [obj_blob, obj_wobbler, obj_blob, obj_blob, obj_gem, obj_wobbler, obj_blob, obj_gem, obj_wobbler];
            global.enemy_popcorn_limit = 18;
            global.enemy_spawn_delay_after = [44, 44, 114, 114, 120, 44, 44, 124, 144];
            global.floors_palette[0] = 5274196;
            global.floors_palette[1] = 9723064;
            global.floors_palette[2] = 14719048;
            break;
        
        case "5-5":
            global.floors_fruit_percent = [30, 50];
            global.floors_required_percent = 70;
            global.enemy_spawn_order = [obj_blob, obj_star, obj_blob, obj_blob, obj_gem, obj_star, obj_blob, obj_gem, obj_star];
            global.enemy_popcorn_limit = 18;
            global.enemy_spawn_delay_after = [44, 44, 114, 114, 120, 44, 44, 124, 144];
            break;
        
        case "sketch3":
            global.floors_fruit_percent = [20, 50];
            global.floors_required_percent = 80;
            global.enemy_spawn_order = [obj_blob, obj_blob, obj_blob, obj_blob, obj_blob, obj_star];
            global.enemy_popcorn_limit = 8;
            global.enemy_spawn_delay_after = 140;
            break;
        
        case "sketch5":
        case "sketch6":
            global.floors_fruit_percent = [20, 50];
            global.floors_required_percent = 80;
            global.enemy_spawn_order = [obj_wobbler, obj_blob, obj_blob, obj_blub];
            global.enemy_popcorn_limit = 8;
            global.enemy_spawn_delay_after = 150;
            global.floors_palette[2] = 10246224;
            global.floors_palette[1] = 9723064;
            global.floors_palette[0] = 8426568;
            break;
        
        case "sketch9":
            global.floors_fruit_percent = [20, 50];
            global.floors_required_percent = 80;
            global.enemy_spawn_order = [obj_blob, obj_blob, obj_blob, obj_gem];
            global.enemy_popcorn_limit = 16;
            global.enemy_spawn_delay_after = 150;
            global.floors_palette[0] = 6903894;
            global.floors_palette[1] = 9723064;
            global.floors_palette[2] = 3054726;
            break;
        
        case "sketch31":
            global.enemy_spawn_order = [obj_blob];
            global.background_object = obj_bg_glory;
            break;
        
        case "sketch32":
            global.enemy_spawn_order = [obj_blob];
            global.background_object = obj_bg_ao;
            break;
        
        case "test14":
            global.enemy_spawn_order = [obj_blob];
            global.background_object = obj_bg_buzz;
            break;
        
        case "snake":
            global.floors_fruit_percent = [40, 60];
            global.floors_required_percent = 95;
            add_enemy_spawn(1, obj_snake, 230);
            global.enemy_popcorn_limit = 1;
            global.enemy_standard_limit = 1;
            global.background_object = obj_bg_glory;
            floor_scoring_absorb_color(spr_color_set, 2, 2);
            global.floors_method = UnknownEnum.Value_0;
            break;
        
        case "xmas":
            global.floors_fruit_percent = [20, 50];
            global.floors_required_percent = 75;
            add_enemy_spawn(3, obj_star, 40);
            add_enemy_spawn(1, obj_blob, 40);
            add_enemy_spawn(1, obj_blib, 40);
            add_enemy_spawn(1, obj_powerup_dash, 120);
            add_enemy_spawn(1, obj_wobbler, 40);
            add_enemy_spawn(1, obj_star, 120);
            global.enemy_popcorn_limit = 30;
            global.enemy_spawn_delay_after = 120;
            floor_scoring_absorb_color(spr_color_set, 3, 0);
            global.background_object = obj_bg_fresh;
            break;
        
        default:
            global.enemy_spawn_order = [obj_blob];
            global.background_object = obj_bg_glide;
            break;
    }
    
    var p1 = game_get_current_stage();
    var p2 = game_get_current_substage();
    
    if (!is_string(p1))
    {
        if ((p1 >= 1 && p1 <= 9) || p1 == 11)
            bg_adapt_to_current_stage();
    }
    
    // ARCHIPELAGO: nerf finale if enabled
    if (game_is_in_final_level() && !(AP_is_multiworld_active() && global.AP_nerfed_finale))
        global.floors_required_percent = 100;
    
    stage_load_properties2();
    
    if (global.stage_difficulty == UnknownEnum.Value_0)
    {
        if (!easy_hand_adjusted)
        {
            if (!instance_exists(obj_debug_stage_prop_dump))
                global.enemy_speed_scalar = max(min(global.enemy_speed_scalar, 0.8), global.enemy_speed_scalar * 0.8);
            
            global.enemy_popcorn_limit = max(min(global.enemy_popcorn_limit, 5), ceil(global.enemy_popcorn_limit * 0.64));
            global.enemy_standard_limit = max(min(global.enemy_standard_limit, 4), ceil(global.enemy_standard_limit * 0.8));
            
            if (ds_map_exists(global.enemy_specific_limit, obj_draco))
                ds_map_set(global.enemy_specific_limit, obj_draco, max(min(ds_map_find_value(global.enemy_specific_limit, obj_draco), 3), ceil(ds_map_find_value(global.enemy_specific_limit, obj_draco) * 0.6)));
            else
                ds_map_set(global.enemy_specific_limit, obj_draco, 3);
            
            if (ds_map_exists(global.enemy_specific_limit, obj_ufo))
                ds_map_set(global.enemy_specific_limit, obj_ufo, max(min(ds_map_find_value(global.enemy_specific_limit, obj_ufo), 3), ceil(ds_map_find_value(global.enemy_specific_limit, obj_ufo) * 0.6)));
            else
                ds_map_set(global.enemy_specific_limit, obj_ufo, 3);
            
            if (ds_map_exists(global.enemy_specific_limit, obj_arachnid))
                ds_map_set(global.enemy_specific_limit, obj_arachnid, max(min(ds_map_find_value(global.enemy_specific_limit, obj_arachnid), 3), ceil(ds_map_find_value(global.enemy_specific_limit, obj_arachnid) * 0.6)));
            else
                ds_map_set(global.enemy_specific_limit, obj_arachnid, 3);
        }
        
        show_debug_msg("------ difficulty easy");
    }
    else
    {
        show_debug_msg("------ difficulty hard");
    }
}

function stage_load_properties2()
{
    if (ds_map_exists(global.bg_object_to_palette, global.background_object))
    {
        floor_scoring_absorb_color(spr_color_set, 0, ds_map_find_value(global.bg_object_to_palette, global.background_object));
        
        for (var i = 0; i < 6; i++)
            global.floors_base_palette[i] = global.floors_palette[i];
        
        floor_scoring_absorb_color_highcontrast(spr_color_set, 0, ds_map_find_value(global.bg_object_to_palette, global.background_object));
        
        for (var i = 0; i < 6; i++)
            global.floors_base_palette[i + 6] = global.floors_palette[i];
    }
    else
    {
        floor_scoring_absorb_color(spr_color_set, 0, 0);
        
        for (var i = 0; i < 6; i++)
        {
            global.floors_base_palette[i] = global.floors_palette[i];
            global.floors_base_palette[i + 6] = -1;
        }
    }
    
    if (ds_map_exists(global.bg_object_to_cubetex, global.background_object))
        global.cubetex_current = ds_map_find_value(global.bg_object_to_cubetex, global.background_object);
    else
        global.cubetex_current = spr_cube_basic_tex;
    
    floor_update_required();
    floor_update_palette();
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4
}
