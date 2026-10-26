rank_table_surf = -1;
rank_table_display = false;
rank_table_y2 = 0;
timer = 0;
main_alpha = 1;
second_alpha = 0;
screen = 0;
go_to_atrium = false;

// ARCHIPELAGO: Don't go to title after credits
if (global.previous_room == rm_level_clear || AP_is_multiworld_active(false))
    go_to_atrium = true;

text_press_start = lang_press_start();
game_time_in_seconds = floor(global.game_time / 1000);
game_hours = min(999, floor(game_time_in_seconds / 3600));
game_minutes = floor(game_time_in_seconds / 60) % 60;
game_seconds = game_time_in_seconds % 60;
text = [lang("cong_goodjob"), lang("cong_ranks"), lang("cong_time"), string_replace_all(string_format(game_hours, 2, 0), " ", "0") + ":" + string_replace_all(string_format(game_minutes, 2, 0), " ", "0") + ":" + string_replace_all(string_format(game_seconds, 2, 0), " ", "0")];
text_n = array_length(text);
arrow_l_textex = new TEXTEX("[[[LEFT]]]", global.fnt_hud, 0);
arrow_r_textex = new TEXTEX("[[[RIGHT]]]", global.fnt_hud, 0);

for (var i = 0; i < text_n; i++)
{
    text_start[i] = 10 + (i * 100);
    text_unroll[i] = unroll_text_create_adapting(text[i], global.fnt_info, 0.4, 0.4, 0, true);
}

text_start[0] = 50;
text_start[3] = text_start[2] + 20;
text_x[0] = 640;
text_x[1] = 640;
text_x[2] = 448 + (text_unroll[2].max_width * 0.5);
text_x[3] = 832 - (text_unroll[3].max_width * 0.5);
text_y[0] = 64;
text_y[1] = 128;
text_y[2] = 580;
text_y[3] = text_y[2];
lay_set(4);
start_show = false;
start_timer = 0;
rank_got_non_v = false;
rank_got_non_s = false;
rank_bucket = ds_map_create();

rank_add_to_bucket = function(arg0)
{
    if (arg0 != "P")
        rank_got_non_v = true;
    
    if (arg0 != "P" && arg0 != "S" && arg0 != "S+")
        rank_got_non_s = true;
    
    if (is_undefined(ds_map_find_value(rank_bucket, arg0)))
        ds_map_set(rank_bucket, arg0, 1);
    else
        ds_map_set(rank_bucket, arg0, ds_map_find_value(rank_bucket, arg0) + 1);
};

for (var i = 0; i < 9; i++)
{
    for (var j = 0; j < 15; j++)
    {
        var r = ds_map_find_value(global.saved_rank, global.stage_order[i][j]);
        
        if (!is_undefined(r))
            rank_add_to_bucket(r);
    }
}

if (ds_map_exists(global.saved_rank, "finale"))
    rank_add_to_bucket(ds_map_find_value(global.saved_rank, "finale"));

var n = array_length(global.stage_order);

for (var i = 10; i < n; i++)
{
    for (var j = 0; j < 15; j++)
    {
        var r = ds_map_find_value(global.saved_rank, global.stage_order[i][j]);
        
        if (!is_undefined(r))
            rank_add_to_bucket(r);
    }
}

rank_list_str = ["V", "S+", "S", "A+", "A", "B+", "B", "C+", "C", "D+", "D", "E"];
rank_list_key = ["P", "S+", "S", "A+", "A", "B+", "B", "C+", "C", "D+", "D", "E"];
var vranks = ds_map_exists(rank_bucket, "P") ? ds_map_find_value(rank_bucket, "P") : 0;
var sranks = vranks + (ds_map_exists(rank_bucket, "S") ? ds_map_find_value(rank_bucket, "S") : 0) + (ds_map_exists(rank_bucket, "S+") ? ds_map_find_value(rank_bucket, "S+") : 0);
extra_mode = 0;

if (vranks >= 151)
    extra_mode = 2;
else if (sranks >= 151)
    extra_mode = 1;

second_message = "-";
second_timer = 0;

switch (extra_mode)
{
    case 0:
        bc1 = merge_color(c_black, c_red, 0.1);
        bc2 = merge_color(c_black, c_blue, 0.1);
        bc3 = merge_color(c_black, c_lime, 0.1);
        bc4 = merge_color(c_black, c_yellow, 0.1);
        ccc = merge_color(c_olive, c_dkgray, 0.5);
        base_tint_background_color = 16776960;
        instance_create_lay(0, 0, 1, obj_bg_youdidyourbest);
        second_message = "The end?";
        break;
    
    case 1:
        bc1 = merge_color(c_black, c_red, 0.1);
        bc2 = merge_color(c_black, c_blue, 0.1);
        bc3 = merge_color(c_black, c_lime, 0.1);
        bc4 = merge_color(c_black, c_yellow, 0.1);
        ccc = 0;
        base_tint_background_color = merge_color(c_black, c_olive, 0.5);
        instance_create_lay(0, 0, 1, obj_bg_youdidyourbest);
        second_message = "You have S-ranked all stages!\nCongratulations!\n\nThanks for playing VIVIDLOPE!";
        break;
    
    case 2:
        bc1 = merge_color(c_black, c_red, 0.1);
        bc2 = merge_color(c_black, c_blue, 0.1);
        bc3 = merge_color(c_black, c_lime, 0.1);
        bc4 = merge_color(c_black, c_yellow, 0.1);
        ccc = 0;
        base_tint_background_color = merge_color(c_black, c_fuchsia, 0.5);
        instance_create_lay(0, 0, 1, obj_bg_idealnight);
        second_message = "Wow, you have V-ranked all stages!\nYou're really good at this.\n\nThank you for playing VIVIDLOPE!";
        break;
}

bgm_play(snd_jingle_game_clear, false);
firework_dir = choose(-1, 1);
firework_countdown = 240;
ach_new_check_and_exec_stage_achievements();
