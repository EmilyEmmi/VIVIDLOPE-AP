function story_progression_has_normal_atrium()
{
    // ARCHIPELAGO: Use normal music after clearing any level
    if (AP_is_multiworld_active()) {
        for (var i = 1; i <= 11; i++) {
            if (story_progression_has_passed_level(i)) {
                return true;
            }
        }
        return false;
    }
    return story_progression_has_passed_level(1);
}

function story_progression_has_passed_level(arg0)
{
    if (ds_map_find_value(global.cleared_levels, arg0))
        return true;
    
    return false;
}

function is_rank_superb(arg0)
{
    return arg0 == "S" || arg0 == "P" || arg0 == "S+";
}

function story_progression_has_perfect_everything()
{
    if (!ds_map_exists(global.saved_rank, "finale") || ds_map_find_value(global.saved_rank, "finale") != "P")
        return false;
    
    for (var i = 0; i < 11; i++)
    {
        if (i == 9)
            continue;
        
        for (var j = 0; j < 15; j++)
        {
            if (ds_map_exists(global.saved_rank, global.stage_order[i][j]) && ds_map_find_value(global.saved_rank, global.stage_order[i][j]) != "P")
                return false;
            
            if (!ds_map_exists(global.saved_rank, global.stage_order[i][j]))
                return false;
        }
    }
    
    return true;
}

function story_progression_has_superb_everything()
{
    if (!ds_map_exists(global.saved_rank, "finale") || !is_rank_superb(ds_map_find_value(global.saved_rank, "finale")))
        return false;
    
    for (var i = 0; i < 11; i++)
    {
        if (i == 9)
            continue;
        
        for (var j = 0; j < 15; j++)
        {
            if (ds_map_exists(global.saved_rank, global.stage_order[i][j]) && !is_rank_superb(ds_map_find_value(global.saved_rank, global.stage_order[i][j])))
                return false;
            
            if (!ds_map_exists(global.saved_rank, global.stage_order[i][j]))
                return false;
        }
    }
    
    return true;
}

function level_is_cleared_save_agnostic(arg0)
{
    var saved_rank = ds_map_create();
    
    with (global.shared_savedata)
    {
        i = 0;
        var n = array_length(ranks);
        
        while (i < n)
        {
            ds_map_set(saved_rank, @@array_get@@(@@array_get@@(ranks, i), 0), ranks[i][1]);
            i++;
        }
    }
    
    if (arg0 == 10)
    {
        if (ds_map_exists(saved_rank, "finale"))
        {
            ds_map_destroy(saved_rank);
            return true;
        }
        
        ds_map_destroy(saved_rank);
        return false;
    }
    
    var cleared = 0;
    var stages = global.stage_order[clamp(round(arg0 - 1), 0, array_length(global.stage_order) - 1)];
    var i = array_length(stages) - 1;
    
    while (i >= 0)
    {
        if (ds_map_exists(saved_rank, stages[i]))
            cleared++;
        
        i--;
    }
    
    if (arg0 == 11)
    {
        ds_map_destroy(saved_rank);
        return cleared >= array_length(stages);
    }
    
    ds_map_destroy(saved_rank);
    return cleared >= level_get_requirement(arg0);
}
