lay_set(2);
fade = 1.1;

if ((global.gmode == UnknownEnum.Value_3 || global.gmode == UnknownEnum.Value_4 || global.gmode == UnknownEnum.Value_1 || global.gmode == UnknownEnum.Value_2) || global.gmode == UnknownEnum.Value_5 || global.gmode == UnknownEnum.Value_6 || (global.gmode == UnknownEnum.Value_13 || global.gmode == UnknownEnum.Value_14 || global.gmode == UnknownEnum.Value_15))
{
    with (obj_control)
    {
        gcamera_mode = UnknownEnum.Value_2;
        gcamera_intro_length = 180 + global.in_transition_length;
    }
}

timer = -global.in_transition_length;
countdown_to_sound = 4;
hide = 0;
var s = lang("test_stage");
var level = game_get_current_stage();
var stage = game_get_current_substage();

if (game_is_current_stage_valid())
{
    var p1 = level;
    var p2 = stage;
    
    if (p1 == 11)
        s = "X - " + string(p2);
    else
        s = string(p1) + " - " + string(p2);
}

if (global.gmode == UnknownEnum.Value_0)
    s = lang("howto_stage");

if (global.gmode == UnknownEnum.Value_5)
    s = lang("endless_stage_" + string(global.endless_level) + string(global.endless_stage));

if (global.gmode == UnknownEnum.Value_2)
    s = "EX-" + string(array_find_index_legacy(global.demo_extended_stage_order, global.current_stage) + 1);

if (level == 10)
    s = lang("finale_stage");

var o = instance_create_lay(0, 0, 3, obj_title_card_stage_start);
o.str = s;

if (global.gmode == UnknownEnum.Value_5)
{
    o.str2_displayed = true;
    
    if (global.endless_loop > 1)
        o.str2 = lang3("endless_numbers_loop", string(global.endless_level), string(global.endless_stage), string(global.endless_loop));
    else
        o.str2 = lang2("endless_numbers", string(global.endless_level), string(global.endless_stage));
}

if (level == 10)
{
    o.str2_displayed = true;
    
    if (stage == 7)
        o.str2 = lang("finale_subtitle_f");
    else
        o.str2 = lang1("finale_subtitle", string(game_get_current_substage()));
}

if (global.gmode == UnknownEnum.Value_13 || global.gmode == UnknownEnum.Value_14 || global.gmode == UnknownEnum.Value_15)
{
    o.str = obj_custom_level_holder.struc.stage[obj_custom_level_holder.chosen_stage_index].name;
    o.str2 = obj_custom_level_holder.struc.stage[obj_custom_level_holder.chosen_stage_index].subtitle;
    
    if (string_count(" ", o.str2) != string_length(o.str2))
        o.str2_displayed = true;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_13 = 13,
    Value_14,
    Value_15
}
