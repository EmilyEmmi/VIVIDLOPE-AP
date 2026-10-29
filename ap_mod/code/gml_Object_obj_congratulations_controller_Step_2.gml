ptimer = timer;
timer += global.tdelta;

if (screen == 0)
{
    var n = array_length(rank_list_str);
    var uuu = 192;
    var deltu = 36;
    uuu = 188;
    deltu = 33;
    
    for (var i = 0; i < n; i++)
    {
        if (teqs(125 + (i * 5)))
        {
            var o = instance_create_lay(640, 192 + (deltu * i), 3, obj_congratulations_rank_slide);
            o.dir = (i % 2) ? -1 : 1;
            o.text_corner = rank_list_str[i];
            o.text_center = ds_map_exists(rank_bucket, rank_list_key[i]) ? string(ds_map_find_value(rank_bucket, @@array_get@@(rank_list_key, i))) : "0";
        }
    }
    
    if (teqs(300))
        start_show = true;
    
    if (start_show)
    {
        start_timer += global.tdelta;
        
        if (minput_pressed(3) || minput_pressed(1))
        {
            menu_play_sound_choose();
            surface_free_please(rank_table_surf);
            rank_table_surf = -1;
            rank_table_display = !rank_table_display;
            
            with (obj_congratulations_rank_slide)
                visible = !other.rank_table_display;
        }
        
        if (minput_pressed(4))
        {
            if (extra_mode > 0)
            {
                menu_play_sound_accept();
                screen = 1;
                start_show = false;
            }
            else
            {
                audi_play_simple(snd_menu_start);
                start_show = false;
                // ARCHIPELAGO: Go to atrium after beating the game
                if (go_to_atrium) {
                    global.current_stage = "overworld";
                    room_goto_transition_slow_fade(rm_maingame);
                } else {
                    room_goto_transition_slow_fade(rm_pretitle);
                }
                
                with (obj_fade_transition)
                {
                    time = 120;
                    go_point = 80;
                }
            }
        }
    }
}

if (screen == 1)
{
    var p = second_timer;
    second_timer += global.tdelta;
    var m = main_alpha;
    
    if (trange(second_timer, p, 0, 30))
        main_alpha = 1 - global.timer_slider;
    
    if (trange(second_timer, p, 30, 60))
    {
        main_alpha = 0;
        second_alpha = global.timer_slider;
    }
    
    if (m != main_alpha)
    {
        with (obj_congratulations_rank_slide)
            alpha = other.main_alpha;
    }
    
    if (teq(second_timer, p, 60))
    {
        second_alpha = 1;
        start_show = true;
        start_timer = 0;
    }
    
    if (start_show)
    {
        start_timer += global.tdelta;
        
        if (minput_pressed(4))
        {
            audi_play_simple(snd_menu_start);
            start_show = false;
            
            if (go_to_atrium)
            {
                global.current_stage = "overworld";
                room_goto_transition_slow_fade(rm_maingame);
            }
            else
            {
                room_goto_transition_slow_fade(rm_pretitle);
            }
            
            with (obj_fade_transition)
            {
                time = 120;
                go_point = 80;
            }
        }
    }
}

if (extra_mode == 0)
    exit;

firework_countdown -= global.tdelta;

if (firework_countdown <= 0)
{
    if (random(2) < 1.5)
        firework_dir = -firework_dir;
    
    firework_countdown = random_range(2, 36);
    var xx = 640 + (firework_dir * random(640));
    var yy = random_range(224, 480);
    var o = instance_create_depth(xx, yy, depth - 1, obj_new_lunar_year_firework_launch);
    o.frame = irandom_range(0, 3);
    o.scale = 0.5;
    o = instance_create_depth(xx, yy, depth - 1, obj_new_lunar_year_firework);
    o.timer = -50;
    o.frame = 2 + extra_mode;
    o.color[0] = color_change_hsv(9968838, random(255), -1, -1);
    o.color[1] = color_change_hsv(5172988, random(255), -1, -1);
}
