function player_chain_get_rank_limit()
{
    return floor(global.floors_total * 0.2);
}

function rank_get()
{
    var rank = 0;
    var map = ds_map_create();
    ds_map_set(map, "type", "standard");
    ds_map_set(map, "cap_tile", 10);
    
    if (global.floors_percent >= 100)
    {
        rank += 10;
        ds_map_set(map, "score_tile", 10);
        ds_map_set(map, "tile", 1);
    }
    else if (global.floors_percent >= lerp(global.floors_required_percent, 100, 0.5))
    {
        rank += 5;
        ds_map_set(map, "score_tile", 5);
        ds_map_set(map, "tile", 0.5);
    }
    else
    {
        ds_map_set(map, "score_tile", 0);
        ds_map_set(map, "tile", 0);
    }
    
    ds_map_set(map, "cap_fruit", 20);
    
    if (global.player_any_fruit)
    {
        if (global.player_fruits >= 2)
        {
            rank += 20;
            ds_map_set(map, "score_fruit", 20);
            ds_map_set(map, "fruit", 1);
        }
        else if (global.player_fruits >= 1)
        {
            rank += 15;
            ds_map_set(map, "score_fruit", 15);
            ds_map_set(map, "fruit", 0.75);
        }
        else
        {
            rank += 10;
            ds_map_set(map, "score_fruit", 10);
            ds_map_set(map, "fruit", 0.5);
        }
    }
    else
    {
        ds_map_set(map, "score_fruit", 0);
        ds_map_set(map, "fruit", 0);
    }
    
    ds_map_set(map, "power1", global.player_power_at_clear);
    ds_map_set(map, "power2", global.player_power);
    ds_map_set(map, "cap_power", 20);
    var pp = max(global.player_power_at_clear, global.player_power);
    
    if (pp >= global.__player_power_speed_2)
    {
        rank += 20;
        ds_map_set(map, "score_power", 20);
        ds_map_set(map, "power", 1);
    }
    else if (pp >= lerp(global.__player_power_speed_2, global.__player_power_speed_1, 0.66))
    {
        rank += 15;
        ds_map_set(map, "score_power", 15);
        ds_map_set(map, "power", 0.75);
    }
    else if (pp >= lerp(global.__player_power_speed_2, global.__player_power_speed_1, 0.33))
    {
        rank += 10;
        ds_map_set(map, "score_power", 10);
        ds_map_set(map, "power", 0.5);
    }
    else if (pp >= global.__player_power_speed_1)
    {
        rank += 5;
        ds_map_set(map, "score_power", 5);
        ds_map_set(map, "power", 0.25);
    }
    else
    {
        ds_map_set(map, "score_power", 0);
        ds_map_set(map, "power", 0);
    }
    
    ds_map_set(map, "cap_chain", 20);
    
    if (global.player_stage_chain >= floor(global.floors_total * 0.2))
    {
        rank += 20;
        ds_map_set(map, "score_chain", 20);
        ds_map_set(map, "chain", 1);
    }
    else if (global.player_stage_chain >= floor(global.floors_total * 0.15))
    {
        rank += 15;
        ds_map_set(map, "score_chain", 15);
        ds_map_set(map, "chain", 0.75);
    }
    else if (global.player_stage_chain >= floor(global.floors_total * 0.1))
    {
        rank += 10;
        ds_map_set(map, "score_chain", 10);
        ds_map_set(map, "chain", 0.5);
    }
    else if (global.player_stage_chain >= floor(global.floors_total * 0.05))
    {
        rank += 5;
        ds_map_set(map, "score_chain", 5);
        ds_map_set(map, "chain", 0.25);
    }
    else
    {
        ds_map_set(map, "score_chain", 0);
        ds_map_set(map, "chain", 0);
    }
    
    ds_map_set(map, "cap_miss", 30);
    
    if (global.player_stage_kos == 0)
    {
        rank += 30;
        ds_map_set(map, "score_miss", 30);
        ds_map_set(map, "miss", 1);
    }
    else if (global.player_stage_kos <= 1)
    {
        rank += 20;
        ds_map_set(map, "score_miss", 20);
        ds_map_set(map, "miss", 0.66);
    }
    else if (global.player_stage_kos <= 2)
    {
        rank += 10;
        ds_map_set(map, "score_miss", 10);
        ds_map_set(map, "miss", 0.33);
    }
    else if (global.player_stage_kos >= 7)
    {
        rank -= 20;
        ds_map_set(map, "score_miss", -20);
        ds_map_set(map, "miss", 0);
    }
    else if (global.player_stage_kos >= 6)
    {
        rank -= 10;
        ds_map_set(map, "score_miss", -10);
        ds_map_set(map, "miss", 0);
    }
    else
    {
        ds_map_set(map, "score_miss", 0);
        ds_map_set(map, "miss", 0);
    }
    
    ds_map_set(map, "score", rank);
    ds_map_set(map, "symbol", rank_get_string(rank, global.rank_cap));
    return map;
}

function rank_get_finale()
{
    var rank = 0;
    var map = ds_map_create();
    ds_map_set(map, "type", "finale");
    ds_map_set(map, "cap_fruit", 20);
    
    if (global.compound_stat_fruit >= 14)
    {
        rank += 20;
        ds_map_set(map, "score_fruit", 20);
        ds_map_set(map, "fruit", 1);
    }
    else if (global.compound_stat_fruit >= 12)
    {
        rank += 15;
        ds_map_set(map, "score_fruit", 15);
        ds_map_set(map, "fruit", 0.75);
    }
    else if (global.compound_stat_fruit >= 8)
    {
        rank += 10;
        ds_map_set(map, "score_fruit", 10);
        ds_map_set(map, "fruit", 0.5);
    }
    else if (global.compound_stat_fruit >= 4)
    {
        rank += 5;
        ds_map_set(map, "score_fruit", 5);
        ds_map_set(map, "fruit", 0.25);
    }
    else
    {
        ds_map_set(map, "score_fruit", 0);
        ds_map_set(map, "fruit", 0);
    }
    
    ds_map_set(map, "cap_power", 30);
    var pp = global.compound_stat_end_percent_sum / global.compound_stat_stages;
    
    if (pp >= (global.__player_power_speed_2 / global.__player_power_max))
    {
        rank += 30;
        ds_map_set(map, "score_power", 30);
        ds_map_set(map, "power", 1);
    }
    else if (pp >= (lerp(global.__player_power_speed_2, global.__player_power_speed_1, 0.66) / global.__player_power_max))
    {
        rank += 20;
        ds_map_set(map, "score_power", 20);
        ds_map_set(map, "power", 0.66);
    }
    else if (pp >= (lerp(global.__player_power_speed_2, global.__player_power_speed_1, 0.33) / global.__player_power_max))
    {
        rank += 15;
        ds_map_set(map, "score_power", 15);
        ds_map_set(map, "power", 0.5);
    }
    else if (pp >= (global.__player_power_speed_1 / global.__player_power_max))
    {
        rank += 10;
        ds_map_set(map, "score_power", 10);
        ds_map_set(map, "power", 0.33);
    }
    else
    {
        ds_map_set(map, "score_power", 0);
        ds_map_set(map, "power", 0);
    }
    
    ds_map_set(map, "cap_chain", 20);
    pp = global.compound_stat_best_chain / global.compound_stat_stages;
    
    if (pp >= 0.2)
    {
        rank += 20;
        ds_map_set(map, "score_chain", 20);
        ds_map_set(map, "chain", 1);
    }
    else if (pp >= 0.15)
    {
        rank += 15;
        ds_map_set(map, "score_chain", 15);
        ds_map_set(map, "chain", 0.75);
    }
    else if (pp >= 0.1)
    {
        rank += 10;
        ds_map_set(map, "score_chain", 10);
        ds_map_set(map, "chain", 0.5);
    }
    else if (pp >= 0.05)
    {
        rank += 5;
        ds_map_set(map, "score_chain", 5);
        ds_map_set(map, "chain", 0.25);
    }
    else
    {
        ds_map_set(map, "score_chain", 0);
        ds_map_set(map, "chain", 0);
    }
    
    ds_map_set(map, "cap_miss", 30);
    
    if (global.compound_stat_kos <= 3)
    {
        rank += 30;
        ds_map_set(map, "score_miss", 30);
    }
    else if (global.compound_stat_kos <= 4)
    {
        rank += 25;
        ds_map_set(map, "score_miss", 25);
    }
    else if (global.compound_stat_kos <= 5)
    {
        rank += 20;
        ds_map_set(map, "score_miss", 20);
    }
    else if (global.compound_stat_kos <= 6)
    {
        rank += 10;
        ds_map_set(map, "score_miss", 10);
    }
    else
    {
        ds_map_set(map, "score_miss", 0);
    }
    
    ds_map_set(map, "miss", ds_map_find_value(map, "score_miss") / ds_map_find_value(map, "cap_miss"));
    ds_map_set(map, "score", rank);
    ds_map_set(map, "symbol", rank_get_string(rank, global.rank_cap));
    return map;
}

function rank_get_string(arg0, arg1)
{
    if (arg0 >= 100 && arg1 == "P")
    {
        if (global.stage_difficulty == UnknownEnum.Value_0)
            return "S+";
        
        return "P";
    }
    
    if (arg0 >= 90 && (arg1 == "P" || arg1 == "S"))
        return "S";
    
    if (arg0 >= 80)
        return "A+";
    
    if (arg0 >= 70)
        return "A";
    
    if (arg0 >= 60)
        return "B+";
    
    if (arg0 >= 50)
        return "B";
    
    if (arg0 >= 40)
        return "C+";
    
    if (arg0 >= 30)
        return "C";
    
    if (arg0 >= 20)
        return "D+";
    
    if (arg0 >= 10)
        return "D";
    
    return "E";
}

function rank_get_string_from_normalized(arg0)
{
    if (arg0 >= 0.9)
        return "S";
    
    if (arg0 >= 0.8)
        return "A+";
    
    if (arg0 >= 0.7)
        return "A";
    
    if (arg0 >= 0.6)
        return "B+";
    
    if (arg0 >= 0.5)
        return "B";
    
    if (arg0 >= 0.4)
        return "C+";
    
    if (arg0 >= 0.3)
        return "C";
    
    if (arg0 >= 0.2)
        return "D+";
    
    if (arg0 >= 0.1)
        return "D";
    
    return "E";
}

function rank_get_gauntlet_stone_frame(arg0)
{
    switch (arg0)
    {
        case "E":
            return 14;
        
        case "D":
            return 15;
        
        case "D+":
            return 1;
        
        case "C":
            return 2;
        
        case "C+":
            return 3;
        
        case "B":
            return 5;
        
        case "B+":
            return 6;
        
        case "A":
            return 7;
        
        case "A+":
            return 8;
        
        case "S":
            return 9;
        
        case "S+":
            return 10;
        
        case "P":
            return 10;
    }
    
    return 0;
}

function rank_parse_display_symbol(arg0)
{
    if (arg0 == "P")
        return "V";
    
    return arg0;
}

global.rank_power = ds_map_create();
ds_map_set(global.rank_power, "E", 1);
ds_map_set(global.rank_power, "D", 2);
ds_map_set(global.rank_power, "D+", 3);
ds_map_set(global.rank_power, "C", 4);
ds_map_set(global.rank_power, "C+", 5);
ds_map_set(global.rank_power, "B", 6);
ds_map_set(global.rank_power, "B+", 7);
ds_map_set(global.rank_power, "A", 8);
ds_map_set(global.rank_power, "A+", 9);
ds_map_set(global.rank_power, "S", 10);
ds_map_set(global.rank_power, "S+", 11);
ds_map_set(global.rank_power, "P", 12);

function rank_get_stronger(arg0, arg1)
{
    var p1 = ds_map_exists(global.rank_power, arg0) ? ds_map_find_value(global.rank_power, arg0) : 0;
    var p2 = ds_map_exists(global.rank_power, arg1) ? ds_map_find_value(global.rank_power, arg1) : 0;
    return (p1 < p2) ? arg1 : arg0;
}

global.rank_to_color = ds_map_create();
ds_map_set(global.rank_to_color, "P", 16575666);
ds_map_set(global.rank_to_color, "S+", 16575666);
ds_map_set(global.rank_to_color, "S", 16575666);
ds_map_set(global.rank_to_color, "A+", 13958284);
ds_map_set(global.rank_to_color, "A", 13958284);
ds_map_set(global.rank_to_color, "B+", 9239704);
ds_map_set(global.rank_to_color, "B", 9239704);
ds_map_set(global.rank_to_color, "C+", 9237244);
ds_map_set(global.rank_to_color, "C", 9237244);
ds_map_set(global.rank_to_color, "D+", 9219324);
ds_map_set(global.rank_to_color, "D", 9219324);
ds_map_set(global.rank_to_color, "E", 13929724);
ds_map_set(global.rank_to_color, "Y", 12632256); // add entry for Y to prevent crash

function rank_string_to_color(arg0)
{
    if (!ds_map_exists(global.rank_to_color, arg0))
        return 12632256;
    
    return ds_map_find_value(global.rank_to_color, arg0);
}

global.rank_to_color_vibrant = ds_map_create();
ds_map_set(global.rank_to_color_vibrant, "P", 15250006);
ds_map_set(global.rank_to_color_vibrant, "S+", 15250006);
ds_map_set(global.rank_to_color_vibrant, "S", 15250006);
ds_map_set(global.rank_to_color_vibrant, "A+", 10934326);
ds_map_set(global.rank_to_color_vibrant, "A", 10934326);
ds_map_set(global.rank_to_color_vibrant, "B+", 4512886);
ds_map_set(global.rank_to_color_vibrant, "B", 4512886);
ds_map_set(global.rank_to_color_vibrant, "C+", 2150638);
ds_map_set(global.rank_to_color_vibrant, "C", 2150638);
ds_map_set(global.rank_to_color_vibrant, "D+", 3021048);
ds_map_set(global.rank_to_color_vibrant, "D", 3021048);
ds_map_set(global.rank_to_color_vibrant, "E", 12992764);
ds_map_set(global.rank_to_color_vibrant, "Y", 8421504); // add entry for Y to prevent crash

function rank_string_to_vibrant_color(arg0)
{
    if (!ds_map_exists(global.rank_to_color_vibrant, arg0))
        return 8421504;
    
    return ds_map_find_value(global.rank_to_color_vibrant, arg0);
}

enum UnknownEnum
{
    Value_0
}
