if ((current_level > 0 && current_level <= 9) || current_level == 11)
{
    var stages = global.stage_order[current_level - 1];
    
    if (ds_map_find_value(global.accessed_levels, current_level))
    {
        if (ds_map_find_value(global.cleared_levels, current_level))
        {
            current_level_status = UnknownEnum.Value_4;
            
            for (var i = 0; i < array_length(stages); i++)
            {
                if (!ds_map_exists(global.saved_rank, stages[i]))
                {
                    current_level_status = UnknownEnum.Value_2;
                    break;
                }
                
                if (ds_map_find_value(global.saved_rank, @@array_get@@(stages, i)) != "P")
                    current_level_status = UnknownEnum.Value_3;
            }
        }
        else
        {
            current_level_status = UnknownEnum.Value_1;
        }
    }
    else
    {
        current_level_status = UnknownEnum.Value_0;
    }
    
    var prefix;
    
    if (current_level == 11)
    {
        current_level_name = lang("level_introZ");
        prefix = "X";
    }
    else if (current_level == 10)
    {
        current_level_name = lang("level_introX");
        prefix = "X";
    }
    else
    {
        current_level_name = lang("level_intro" + string(current_level));
        prefix = string(current_level);
    }
    
    rank_stages = min(15, array_length(stages));
    
    for (var i = 0; i < rank_stages; i++)
    {
        if (ds_map_exists(global.saved_rank, stages[i]))
            rank[i] = ds_map_find_value(global.saved_rank, @@array_get@@(stages, i));
        else
            rank[i] = "-";
        
        // ARCHIPELAGO: get actual level code
        var letter = prefix;
        var stage = string(i + 1)
        if (ds_map_exists(global.stage_index_to_true_code, stages[i])) {
            var levelcode = stage_get_level_code(stages[i]);
            letter = string(level_get_letter(levelcode[0]))
            stage = string(levelcode[1]);
        }
        
        rank_stage[i] = letter + "-" + stage;
    }
    
    for (var i = rank_stages; i < 15; i++)
    {
        rank[i] = "-";
        rank_stage[i] = prefix + "-" + string(i + 1);
    }
    
    rank_stages = 15;
}
else if (current_level == 10)
{
    if (ds_map_find_value(global.accessed_levels, current_level))
    {
        current_level_name = lang("level_introX");
        rank_stages = 1;
        rank_stage[0] = "FIN";
        rank[0] = ds_map_exists(global.saved_rank, "finale") ? ds_map_find_value(global.saved_rank, "finale") : "-";
        current_level_status = UnknownEnum.Value_1;
        
        if (ds_map_find_value(global.saved_rank, "finale") == "P")
            current_level_status = UnknownEnum.Value_4;
        
        if (rank[0] != "-")
            current_level_status = UnknownEnum.Value_3;
    }
    else
    {
        current_level_name = "";
        rank_stages = 0;
        current_level_status = UnknownEnum.Value_0;
    }
}
else
{
    current_level_name = "UNKNOWN REALM";
    rank_stages = 0;
}

container_play("cnt_overworld_warp_step");

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4
}
