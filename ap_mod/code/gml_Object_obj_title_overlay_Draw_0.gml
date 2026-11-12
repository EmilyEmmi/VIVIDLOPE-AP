if (instance_exists(obj_title_logo_intro))
    exit;

cam_set_2d();
bg_draw_blurred_surface_16_9_border();
var xx = 502;
var yy = 680;
var n = array_length(delta);
var lx = max(global.window_x1, 0);
var rx = min(global.window_x2, 1280);
var mx = 32;
var my = 22;
mx = 0;
my = 0;
var fns = 0.4;
draw_set_font(fnt_hud_compatible);
fns *= global.fnt_hud_compatible_scale;
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_set_color(c_white);
xx = 16;
draw_text_transformed(lx + 16 + mx, 704 - my, string(version_code) + " ", fns, fns, 0);
xx += (string_width(version_code + " ") * fns);
draw_text_transformed(lx + xx + mx, 690 - my, "20", fns, fns, 0);
draw_text_transformed(lx + xx + 1 + mx, 718 - my, "24", fns, fns, 0);
xx += (string_width("20 ") * fns);
draw_text_transformed(lx + xx + mx, 704 - my, "Jaklub", fns, fns, 0);
// Draw AP marker
xx += (string_width("Jaklub ") * fns);
draw_text_transformed(lx + xx + mx, 704 - my, "AP v1.0.0", fns, fns, 0);
draw_set_halign(fa_right);

if (trange(press_start_flash, press_start_flash, 0, 0.7))
{
    draw_set_alpha(lengthdir_y(-1, global.timer_slider * 180));
    draw_text_transformed(rx - 16 - mx, 704 - my, press_enter_str, fns, fns, 0);
    draw_set_alpha(1);
}

mx = 27;
my = 27;
mx = 0;
my = 0;

if (post_intro_mode)
{
    var t = min(timer / 120, 1);
    var t2 = min(timer / 60, 1);
    var s2 = 0.33;
    var ss = ease_inout_sine(1, 0.33, t) + ease_out_sine(0.3, 0, t2);
    xx = ease_inout_sine(640, min(global.window_x2, 1280) - (640 * s2) - mx, t) + ease_out_sine(-336, 0, t2);
    yy = ease_inout_sine(360, (360 * s2) + my, t);
    var aa = ease_inout_sine(1, 0.4, t);
    draw_sprite_ext(spr_title_logo, 0, xx, yy, ss, ss, 0, c_white, aa);
}
else
{
    var t = min(timer / 120, 1);
    var s2 = 0.33;
    var ss = ease_out_sine(1, 0.33, t);
    xx = ease_out_sine(640, min(global.window_x2, 1280) - (640 * s2) - mx, t);
    yy = ease_out_sine(360, (360 * s2) + my, t);
    var aa = ease_out_sine(1, 0.4, t);
    draw_sprite_ext(spr_title_logo, 0, xx, yy, ss, ss, 0, c_white, aa);
}
