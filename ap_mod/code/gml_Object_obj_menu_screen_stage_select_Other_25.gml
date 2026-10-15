spreview_reset_positioning();
m_proj = matrix_build_projection_perspective_fov(30, 1.7777777777777777, 32, 9000);
m_view = matrix_build_lookat(0, -112, -320, 0, 0, 0, 0, 1, 0);
m_transfer = matrix_multiply(m_proj, m_view);
spinner_rx = 128;
spinner_ry = 32;
menu_screen_stage_select_draw_setup(0, -320, -320, 0, 0, 0, 0, 1, 0, 224, -128);
animacc = 0;
color = obj_menu_controller.color;
stage_order_n = array_length(stage_order);
var i = stage_order_n - 1;

while (i >= 0)
{
    var stg = -1;
    
    if (instance_exists(obj_custom_level_holder))
        stg = obj_custom_level_holder.struc.stage[real(stage_order[i])];
    
    stage_order_prefix[i] = "";
    stage_order_name[i] = string(i + 1);
    
    if (instance_exists(obj_custom_level_holder))
    {
        var bs = stg.select_name;
        var pp = string_pos("-", bs);
        
        if (pp > 0 && pp <= 3)
        {
            stage_order_prefix[i] = string_delete(bs, pp + 1, string_length(bs));
            
            if (pp == 2)
                string_insert(" ", stage_order_prefix[i], 2);
            else if (pp == 3 && string_char_at(bs, 1) == "1")
                string_insert(" ", stage_order_prefix[i], 3);
            
            stage_order_name[i] = string_delete(bs, 1, pp);
        }
        else
        {
            stage_order_name[i] = bs;
        }
    }
    
    if (room == rm_mainmenu)
        stage_order_rank[i] = choose("", "", "", "P", "S", "A+", "A", "B+", "C", "C+", "D", "D+", "E");
    else
        stage_order_rank[i] = ds_map_find_value(global.saved_rank, @@array_get@@(stage_order, i));
    
    if (is_undefined(stage_order_rank[i]))
        stage_order_rank[i] = "";
    
    stage_order_rank_color[i] = rank_string_to_color(stage_order_rank[i]);
    
    switch (stage_order_rank[i])
    {
        case "D":
            stage_order_rank_ball[i] = 1;
            break;
        
        case "D+":
            stage_order_rank_ball[i] = 2;
            break;
        
        case "C":
            stage_order_rank_ball[i] = 3;
            break;
        
        case "C+":
            stage_order_rank_ball[i] = 4;
            break;
        
        case "B":
            stage_order_rank_ball[i] = 5;
            break;
        
        case "B+":
            stage_order_rank_ball[i] = 6;
            break;
        
        case "A":
            stage_order_rank_ball[i] = 7;
            break;
        
        case "A+":
            stage_order_rank_ball[i] = 8;
            break;
        
        case "S":
            stage_order_rank_ball[i] = 9;
            break;
        
        case "S+":
            stage_order_rank_ball[i] = 10;
            break;
        
        case "P":
            stage_order_rank_ball[i] = 11;
            break;
        
        default:
            stage_order_rank_ball[i] = 0;
            break;
    }
    
    stage_order_completed[i] = (stage_order_rank[i] != "") ? 1 : 0;
    stage_order_color[i] = 16777215;
    stage_order_back_color[i] = merge_color(c_white, stage_color, 0.6);
    stage_order_tick[i] = false;
    
    if (stage_order_rank[i] != "")
    {
        stage_order_back_color[i] = stage_color;
        stage_order_tick[i] = true;
    }
    
    spreview_load(stage_order[i]);
    i--;
}

stage_order_chosen = 0;

for (i = 0; i < stage_order_n; i++)
{
    if (stage_order[i] == global.current_stage)
    {
        stage_order_chosen = i;
        break;
    }
}

if (room == rm_maingame)
{
    repeat (stage_order_n)
    {
        stage_order_chosen = (stage_order_chosen + 1) % stage_order_n;
        
        if (stage_order_rank[stage_order_chosen] == "")
            break;
    }
}

stage_order_angle_delta = 360 / stage_order_n;
stage_order_angle_tiltp = 0;
stage_order_angle_tilt = 0;
spinner_timer = 0;
spinner_shoot_timer = -1;
stage_order_draw_queue = ds_priority_create();

stage_order_draw = function(arg0, arg1, arg2, arg3, arg4)
{
    var height = 64 * arg4;
    var alpha = ring_alpha;
    var w = 192 * arg4;
    var shadow = 2 * arg4;
    var iconoffset = 1;
    var xx = (arg1 - (w * 0.5)) + (0 * arg4);
    var yy = arg2 - (height * 0.5);
    var xxs = 0.25 * arg4;
    var yys = 0.25 * arg4;
    
    if (stage_order_tick[arg0])
    {
        if (arg3)
        {
            draw_sprite_stretched_ext_baseline_scale(spr_menu_stage, 2, xx, yy, w, height, 16777215, alpha, xxs, yys);
            draw_sprite_stretched_ext_baseline_scale(spr_menu_stage, 2, xx, yy + shadow, w, height, 16777215, alpha, xxs, yys);
        }
        
        draw_sprite_stretched_ext_baseline_scale(spr_menu_stage, 0, xx, yy, w, height, stage_order_back_color[arg0], alpha, xxs, yys);
    }
    else
    {
        if (arg3)
        {
            draw_sprite_stretched_ext_baseline_scale(spr_menu_stage, 2, xx, yy, w, height, 16777215, alpha, xxs, yys);
            draw_sprite_stretched_ext_baseline_scale(spr_menu_stage, 2, xx, yy + shadow, w, height, 16777215, alpha, xxs, yys);
        }
        
        draw_sprite_stretched_ext_baseline_scale(spr_menu_stage, 1, xx, yy, w, height, stage_order_back_color[arg0], alpha, xxs, yys);
    }
    
    xx = arg1 - (w * 0.5);
    
    if (stage_order_completed[arg0])
    {
        draw_sprite_ext(spr_menu_stage_rankball, stage_order_rank_ball[arg0] + 2, xx + (height * 0.5), yy + (height * 0.5), arg4 * 0.25, arg4 * 0.25, 0, c_white, alpha);
        draw_set_font(global.fnt_title_card2);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text_transformed_color(xx + (height * 0.5), yy + (height * 0.5) + (global.fnt_title_card_yoffsetc * arg4 * 0.3), rank_parse_display_symbol(stage_order_rank[arg0]), arg4 * 0.3, arg4 * 0.3, 0, stage_order_rank_color[arg0], stage_order_rank_color[arg0], stage_order_rank_color[arg0], stage_order_rank_color[arg0], alpha);
    }
    else
    {
        var ss = 0.2 + lengthdir_y(0.03, (current_time / 1000) * 360);
        draw_sprite_ext(spr_menu_stage_rankball, 1, xx + (height * 0.5), yy + (height * 0.5), arg4 * 0.25, arg4 * 0.25, (current_time / 1000) * 280, c_white, alpha);
        draw_sprite_ext(spr_menu_stage_rankball, 0, xx + (height * 0.5), yy + (height * 0.5), arg4 * ss, arg4 * ss, 0, c_white, alpha);
    }
    
    draw_set_font(global.fnt_hud);
    draw_set_valign(fa_middle);
    var c = stage_order_color[arg0];
    
    if (instance_exists(obj_custom_level_holder))
    {
        if (stage_order_prefix[arg0] == "")
        {
            draw_set_halign(fa_center);
            draw_text_transformed_color(xx + (((w - (height * iconoffset)) * 0.5) + ((height - 4) * iconoffset)) + 1, yy + (height * 0.5) + (global.fnt_hud_yoffsetc * arg4) + (3 * arg4), stage_order_name[arg0], 0.35 * arg4, 0.35 * arg4, 0, c, c, c, c, alpha);
            draw_text_transformed_color(xx + (((w - (height * iconoffset)) * 0.5) + ((height - 4) * iconoffset)), (yy + (height * 0.5) + (global.fnt_hud_yoffsetc * arg4) + (3 * arg4)) - 1, stage_order_name[arg0], 0.35 * arg4, 0.35 * arg4, 0, c, c, c, c, alpha);
            draw_text_transformed_color((xx + (((w - (height * iconoffset)) * 0.5) + ((height - 4) * iconoffset))) - 1, yy + (height * 0.5) + (global.fnt_hud_yoffsetc * arg4) + (3 * arg4), stage_order_name[arg0], 0.35 * arg4, 0.35 * arg4, 0, c, c, c, c, alpha);
            draw_text_transformed_color(xx + (((w - (height * iconoffset)) * 0.5) + ((height - 4) * iconoffset)), yy + (height * 0.5) + (global.fnt_hud_yoffsetc * arg4) + (3 * arg4) + 1, stage_order_name[arg0], 0.35 * arg4, 0.35 * arg4, 0, c, c, c, c, alpha);
            draw_text_transformed_color(xx + (((w - (height * iconoffset)) * 0.5) + ((height - 4) * iconoffset)), yy + (height * 0.5) + (global.fnt_hud_yoffsetc * arg4) + (3 * arg4), stage_order_name[arg0], 0.35 * arg4, 0.35 * arg4, 0, c, c, c, c, alpha);
        }
        else
        {
            draw_set_halign(fa_right);
            draw_text_transformed_color(((xx + (((w - (height * iconoffset)) * 0.5) + ((height - 4) * iconoffset))) - (6 * arg4)) + 1, yy + (height * 0.5) + (global.fnt_hud_yoffsetc * arg4) + (3 * arg4), stage_order_prefix[arg0], 0.35 * arg4, 0.35 * arg4, 0, c, c, c, c, alpha);
            draw_text_transformed_color((xx + (((w - (height * iconoffset)) * 0.5) + ((height - 4) * iconoffset))) - (6 * arg4), (yy + (height * 0.5) + (global.fnt_hud_yoffsetc * arg4) + (3 * arg4)) - 1, stage_order_prefix[arg0], 0.35 * arg4, 0.35 * arg4, 0, c, c, c, c, alpha);
            draw_text_transformed_color((xx + (((w - (height * iconoffset)) * 0.5) + ((height - 4) * iconoffset))) - (6 * arg4) - 1, yy + (height * 0.5) + (global.fnt_hud_yoffsetc * arg4) + (3 * arg4), stage_order_prefix[arg0], 0.35 * arg4, 0.35 * arg4, 0, c, c, c, c, alpha);
            draw_text_transformed_color((xx + (((w - (height * iconoffset)) * 0.5) + ((height - 4) * iconoffset))) - (6 * arg4), yy + (height * 0.5) + (global.fnt_hud_yoffsetc * arg4) + (3 * arg4) + 1, stage_order_prefix[arg0], 0.35 * arg4, 0.35 * arg4, 0, c, c, c, c, alpha);
            draw_text_transformed_color((xx + (((w - (height * iconoffset)) * 0.5) + ((height - 4) * iconoffset))) - (6 * arg4), yy + (height * 0.5) + (global.fnt_hud_yoffsetc * arg4) + (3 * arg4), stage_order_prefix[arg0], 0.35 * arg4, 0.35 * arg4, 0, c, c, c, c, alpha);
            draw_set_halign(fa_left);
            draw_text_transformed_color(xx + (((w - (height * iconoffset)) * 0.5) + ((height - 4) * iconoffset)), yy + (height * 0.5) + (global.fnt_hud_yoffsetc * arg4), stage_order_name[arg0], 0.5 * arg4, 0.5 * arg4, 0, c, c, c, c, alpha);
        }
    }
    else
    {
        // ARCHIPELAGO: show actual stage
        var cur_stage_prefix = stage_prefix;
        var cur_stage_name = stage_order_name[arg0];
        if (ds_map_exists(global.stage_index_to_true_code, stage_order[arg0])) {
            var levelcode = stage_get_level_code(stage_order[arg0]);
            cur_stage_prefix = string(level_get_letter(levelcode[0])) + " -";
            cur_stage_name = string(levelcode[1]);
        }
        
        draw_set_halign(fa_right);
        draw_text_transformed_color(((xx + (((w - (height * iconoffset)) * 0.5) + ((height - 4) * iconoffset))) - (6 * arg4)) + 1, yy + (height * 0.5) + (global.fnt_hud_yoffsetc * arg4) + (3 * arg4), cur_stage_prefix, 0.35 * arg4, 0.35 * arg4, 0, c, c, c, c, alpha);
        draw_text_transformed_color((xx + (((w - (height * iconoffset)) * 0.5) + ((height - 4) * iconoffset))) - (6 * arg4), (yy + (height * 0.5) + (global.fnt_hud_yoffsetc * arg4) + (3 * arg4)) - 1, cur_stage_prefix, 0.35 * arg4, 0.35 * arg4, 0, c, c, c, c, alpha);
        draw_text_transformed_color((xx + (((w - (height * iconoffset)) * 0.5) + ((height - 4) * iconoffset))) - (6 * arg4) - 1, yy + (height * 0.5) + (global.fnt_hud_yoffsetc * arg4) + (3 * arg4), cur_stage_prefix, 0.35 * arg4, 0.35 * arg4, 0, c, c, c, c, alpha);
        draw_text_transformed_color((xx + (((w - (height * iconoffset)) * 0.5) + ((height - 4) * iconoffset))) - (6 * arg4), yy + (height * 0.5) + (global.fnt_hud_yoffsetc * arg4) + (3 * arg4) + 1, cur_stage_prefix, 0.35 * arg4, 0.35 * arg4, 0, c, c, c, c, alpha);
        draw_text_transformed_color((xx + (((w - (height * iconoffset)) * 0.5) + ((height - 4) * iconoffset))) - (6 * arg4), yy + (height * 0.5) + (global.fnt_hud_yoffsetc * arg4) + (3 * arg4), cur_stage_prefix, 0.35 * arg4, 0.35 * arg4, 0, c, c, c, c, alpha);
        draw_set_halign(fa_left);
        draw_text_transformed_color(xx + (((w - (height * iconoffset)) * 0.5) + ((height - 4) * iconoffset)), yy + (height * 0.5) + (global.fnt_hud_yoffsetc * arg4), cur_stage_name, 0.5 * arg4, 0.5 * arg4, 0, c, c, c, c, alpha);
    }
    
    if (arg3)
    {
        var al = global.menu_draw_alpha;
        global.menu_draw_alpha *= alpha;
        draw_menu_arrow(arg1, arg2 - (height * 0.5) - (9 * arg4), 90, arg4);
        draw_menu_arrow(arg1, arg2 + (height * 0.5) + (11 * arg4), -90, arg4);
        draw_menu_arrow(arg1 + (w * 0.5) + (8 * arg4), arg2, 0, arg4);
        draw_menu_arrow(arg1 - (w * 0.5) - (8 * arg4), arg2, 180, arg4);
        global.menu_draw_alpha = al;
    }
};

var s = lang("stasel_caption_upbeat");

if (room == rm_level_intro)
    s = lang("stasel_caption");

if (room == rm_game_over)
    s = lang("stasel_caption");

if (room == rm_stage_select)
    s = lang("stasel_caption");

show_text_top = showoff_text(640, 104, 3, s, (global.fnt_using_compatible == true) ? fnt_title_card_compatible : global.fnt_title_card2, (global.fnt_using_compatible == true) ? (0.43 * global.fnt_title_card_compatible_scale) : 0.43, 0, 38, 0, 2, function(arg0, arg1, arg2, arg3)
{
    var yys = 1;
    
    if (trange(arg3, arg3, 0, 20))
        yys = ease_out_sine(0, 2, global.timer_slider);
    else if (trange(arg3, arg3, 20, 36))
        yys = ease_inout_sine(2, 0.5, global.timer_slider);
    else if (trange(arg3, arg3, 36, 46))
        yys = ease_inout_sine(0.5, 1, global.timer_slider);
    
    draw_text_transformed_color(arg0, arg1, arg2, font_xscale, font_yscale * yys, 0, c_white, c_white, c_white, c_white, alpha);
});
show_text_top.visible = 0;
showoff_text_setup_frame(show_text_top, 48, 64, -10, function(arg0, arg1, arg2, arg3, arg4)
{
    var yy = lerp(arg1, arg3, 0.5);
    var h = ease_out_sine(16, arg3 - arg1, min(1, arg4 / 16));
    var a = min(1, arg4 / 10);
    draw_sprite_stretched_ext_baseline_scale(spr_stageclear_frame, global._frame_frame, arg0, yy - (h * 0.5), arg2 - arg0, h, global._frame_color, a, 0.5, 0.5);
});

if (stage_completed < stage_required && global.gmode != UnknownEnum.Value_2)
{
    s = "";
    
    if (room == rm_level_intro && (stage_required - stage_completed) > 1)
        s = lang1((level_get_current() == 11) ? "stasel_left_multi_enter_x" : "stasel_left_multi_enter", string(stage_required - stage_completed));
    else if (stage_completed >= (stage_required - 1))
        s = lang((level_get_current() == 11) ? "stasel_left_one_x" : "stasel_left_one");
    else
        s = lang1((level_get_current() == 11) ? "stasel_left_multi_x" : "stasel_left_multi", string(stage_required - stage_completed));
    
    show_text_bottom = showoff_text(640, 572 - ((show_difficulty_select == true) * 18), 3, s, (global.fnt_using_compatible == true) ? fnt_hud_compatible : global.fnt_hud, ((global.fnt_using_compatible == true) ? global.fnt_hud_compatible_scale : 1) * global.fnt_hud_scale, global.fnt_hud_yoffset, (global.fnt_using_compatible == true) ? 24 : 18, 
    {
        margin: (global.fnt_using_compatible == true) ? 0 : -9,
        space_boost: 10
    }, 1.2, function(arg0, arg1, arg2, arg3)
    {
        var yys = 1;
        
        if (trange(arg3, arg3, 0, 20))
            yys = ease_out_sine(0, 1, global.timer_slider);
        else
            yys = 1 + lengthdir_y(0.15, (arg3 - 20) * 7);
        
        draw_text_transformed_color(arg0, arg1, arg2, font_xscale * 0.8, font_yscale * yys, 0, c_white, c_white, c_white, c_white, alpha);
    });
    show_text_bottom.timer = -54;
    show_text_bottom.visible = 0;
    showoff_text_setup_frame(show_text_bottom, 32, 58, -10, function(arg0, arg1, arg2, arg3, arg4)
    {
        var yy = lerp(arg1, arg3, 0.5);
        var h = ease_out_sine(16, arg3 - arg1, min(1, arg4 / 16));
        var a = min(1, arg4 / 10);
        draw_sprite_stretched_ext_baseline_scale(spr_stageclear_frame, global._frame_frame, arg0, yy - (h * 0.5), arg2 - arg0, h, global._frame_color, a, 0.5, 0.5);
    });
}
else
{
    show_text_bottom = -4;
}

enum UnknownEnum
{
    Value_2 = 2
}
