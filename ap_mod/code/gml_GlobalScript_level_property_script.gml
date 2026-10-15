function level_get_from_stage(arg0)
{
    if (global.gmode == UnknownEnum.Value_2)
        return 3;
    
    var i = array_length(global.stage_order) - 1;
    
    while (i >= 0)
    {
        var j = array_length(global.stage_order[i]) - 1;
        
        while (j >= 0)
        {
            if (global.stage_order[i][j] == arg0)
                return i + 1;
            
            j--;
        }
        
        i--;
    }
    
    return 1;
}

function level_is_short_mode()
{
    return global.level_clear_requirement <= 6;
}

function level_get_requirement(arg0, arg1 = -1)
{
    if (arg1 < 0)
    {
        if (level_is_short_mode())
            arg1 = 1;
        else
            arg1 = 0;
    }
    
    if (global.gmode == UnknownEnum.Value_13 || global.gmode == UnknownEnum.Value_14 || global.gmode == UnknownEnum.Value_15)
    {
        var stage_order = custom_level_get_stage_order();
        var stage_required = array_length(stage_order);
        return stage_required;
    }
    
    switch (arg0)
    {
        case 1:
            return arg1 ? 5 : 8;
        
        case 2:
            return arg1 ? 5 : 10;
        
        case 3:
            return arg1 ? 5 : 9;
        
        case 4:
            return arg1 ? 5 : 8;
        
        case 5:
            return arg1 ? 5 : 8;
        
        case 6:
            return arg1 ? 5 : 9;
        
        case 7:
            return arg1 ? 5 : 8;
        
        case 8:
            return arg1 ? 5 : 10;
        
        case 9:
            return arg1 ? 5 : 8;
        
        case 11:
            return 15;
    }
    
    return arg1 ? 5 : 12;
}

function level_is_accessed(arg0)
{
    return ds_map_exists(global.accessed_levels, arg0);
}

function level_is_cleared(arg0)
{
    if (global.gmode == UnknownEnum.Value_2)
        return false;
    
    if (arg0 == 10)
    {
        if (ds_map_exists(global.saved_rank, "finale"))
            return true;
        
        return false;
    }
    
    var cleared = 0;
    var stages = global.stage_order[clamp(round(arg0 - 1), 0, array_length(global.stage_order) - 1)];
    var i = array_length(stages) - 1;
    
    while (i >= 0)
    {
        if (ds_map_exists(global.saved_rank, stages[i]))
            cleared++;
        
        i--;
    }
    
    if (arg0 == 11)
        return cleared >= array_length(stages);
    
    return cleared >= level_get_requirement(arg0);
}

function level_is_complete(arg0)
{
    if (global.gmode == UnknownEnum.Value_2)
        return false;
    
    if (arg0 == 10)
    {
        if (ds_map_exists(global.saved_rank, "finale"))
            return true;
        
        return false;
    }
    
    var cleared = 0;
    var stages = global.stage_order[clamp(round(arg0 - 1), 0, array_length(global.stage_order) - 1)];
    var i = array_length(stages) - 1;
    
    while (i >= 0)
    {
        if (ds_map_exists(global.saved_rank, stages[i]))
            cleared++;
        
        i--;
    }
    
    return cleared >= array_length(stages);
}

function level_is_superb(arg0)
{
    if (global.gmode == UnknownEnum.Value_2)
        return false;
    
    if (arg0 == 10)
    {
        if (ds_map_exists(global.saved_rank, "finale") && (ds_map_find_value(global.saved_rank, "finale") == "P" || ds_map_find_value(global.saved_rank, "finale") == "S+" || ds_map_find_value(global.saved_rank, "finale") == "S"))
            return true;
        
        return false;
    }
    
    var cleared = 0;
    var stages = global.stage_order[clamp(round(arg0 - 1), 0, array_length(global.stage_order) - 1)];
    var i = array_length(stages) - 1;
    
    while (i >= 0)
    {
        if (ds_map_exists(global.saved_rank, stages[i]) && (ds_map_find_value(global.saved_rank, @@array_get@@(stages, i)) == "P" || ds_map_find_value(global.saved_rank, @@array_get@@(stages, i)) == "S+" || ds_map_find_value(global.saved_rank, @@array_get@@(stages, i)) == "S"))
            cleared++;
        
        i--;
    }
    
    return cleared >= array_length(stages);
}

function level_is_perfect(arg0)
{
    if (global.gmode == UnknownEnum.Value_2)
        return false;
    
    if (arg0 == 10)
    {
        if (ds_map_exists(global.saved_rank, "finale") && ds_map_find_value(global.saved_rank, "finale") == "P")
            return true;
        
        return false;
    }
    
    var cleared = 0;
    var stages = global.stage_order[clamp(round(arg0 - 1), 0, array_length(global.stage_order) - 1)];
    var i = array_length(stages) - 1;
    
    while (i >= 0)
    {
        if (ds_map_exists(global.saved_rank, stages[i]) && ds_map_find_value(global.saved_rank, @@array_get@@(stages, i)) == "P")
            cleared++;
        
        i--;
    }
    
    return cleared >= array_length(stages);
}

global.level_stage = "";
global.current_level = 0;

function level_get_current()
{
    if (global.gmode == UnknownEnum.Value_2)
        return 3;
    
    if (global.level_stage != global.current_stage)
    {
        global.current_level = level_get_from_stage(global.current_stage);
        global.level_stage = global.current_stage;
    }
    
    return global.current_level;
}

function level_get_letter(arg0 = -1)
{
    if (arg0 < 0)
        arg0 = level_get_current();
    
    // finale
    if (arg0 == 10)
        return "F";
    if (arg0 == 11)
        return "X";
    
    return string(arg0);
}

function level_get_menu_colors(arg0)
{
    var c1 = 8421504;
    var c3 = -1;
    
    switch (arg0)
    {
        case 1:
            c1 = 5948492;
            c3 = 9361540;
            break;
        
        case 2:
            c1 = 15751908;
            break;
        
        case 3:
            c1 = 3195104;
            c3 = 1372412;
            break;
        
        case 4:
            c1 = 13391496;
            break;
        
        case 5:
            c1 = 3686634;
            break;
        
        case 6:
            c1 = 14472294;
            break;
        
        case 7:
            c1 = 15630930;
            break;
        
        case 8:
            c1 = 11969700;
            break;
        
        case 9:
            c1 = 11945044;
            break;
        
        case 10:
            c1 = 4210752;
            break;
        
        case 11:
            c1 = 14734552;
            break;
    }
    
    var c2 = merge_color(c1, merge_color(c_dkgray, c_navy, 0.5), 0.2);
    c3 = (c3 < 0) ? c1 : c3;
    return 
    {
        color: c1,
        main_color: c1,
        border_color: c2,
        level_clear_color: c3
    };
}

function level_get_bg_anticipation_properties(arg0)
{
    var ss = spr_bg_anticipation_back_1;
    var cc = 16777215;
    var c2 = merge_color(c_ltgray, merge_color(c_gray, c_blue, 0.1), 0.5);
    
    switch (arg0)
    {
        case 1:
            ss = spr_bg_anticipation_back_1;
            cc = c2;
            break;
        
        case 2:
            ss = spr_bg_anticipation_back_2;
            break;
        
        case 3:
            ss = spr_bg_anticipation_back_3;
            cc = c2;
            break;
        
        case 4:
            ss = spr_bg_anticipation_back_4;
            cc = c2;
            break;
        
        case 5:
            ss = spr_bg_anticipation_back_5;
            break;
        
        case 6:
            ss = spr_bg_anticipation_back_6;
            cc = c2;
            break;
        
        case 7:
            ss = spr_bg_anticipation_back_7;
            break;
        
        case 8:
            ss = spr_bg_anticipation_back_8;
            break;
        
        case 9:
            ss = spr_bg_anticipation_back_9;
            break;
        
        case 10:
            ss = spr_bg_anticipation_back_9;
            cc = c2;
            break;
        
        case 11:
            ss = spr_bg_anticipation_back_Z;
            cc = merge_color(c_white, c2, 0.5);
            break;
    }
    
    return [ss, cc];
}

function level_get_bg_approach_properties(arg0)
{
    var ss = spr_bg_anticipation_back_1;
    var cc = 16777215;
    var c2 = merge_color(c_white, merge_color(c_gray, c_blue, 0.1), 0.5);
    var c3 = merge_color(c_dkgray, #9393B9, 0.4);
    
    switch (arg0)
    {
        case 1:
            ss = spr_bg_anticipation_back_1;
            cc = c2;
            break;
        
        case 2:
            ss = spr_bg_anticipation_back_2;
            break;
        
        case 3:
            ss = spr_bg_anticipation_back_3;
            cc = c2;
            break;
        
        case 4:
            ss = spr_bg_anticipation_back_4;
            cc = c2;
            break;
        
        case 5:
            ss = spr_bg_anticipation_back_5;
            break;
        
        case 6:
            ss = spr_bg_anticipation_back_6;
            cc = c2;
            break;
        
        case 7:
            ss = spr_bg_anticipation_back_7;
            break;
        
        case 8:
            ss = spr_bg_anticipation_back_8;
            cc = c2;
            break;
        
        case 9:
            ss = spr_bg_anticipation_back_9;
            c3 = merge_color(c_black, merge_color(c_aqua, c_blue, 0.5), 0.5);
            break;
        
        case 10:
            ss = spr_bg_anticipation_back_9;
            cc = c2;
            break;
        
        case 11:
            ss = spr_bg_anticipation_back_Z;
            cc = merge_color(c2, c_white, 0.25);
            break;
    }
    
    return [ss, cc, c3];
}

function level_get_bg_yume_platform_color(arg0)
{
    return level_get_menu_colors(arg0).main_color;
}

function level_get_dream_text(arg0)
{
    return lang("vision" + string(arg0));
}

enum UnknownEnum
{
    Value_2 = 2,
    Value_13 = 13,
    Value_14,
    Value_15
}
