function popup_activate(arg0, arg1)
{
    var f = ds_grid_get(global.stage_grid, arg0, arg1);
    
    if (is_struct(f))
    {
        if (f.type == UnknownEnum.Value_21 || f.type == UnknownEnum.Value_22)
        {
            if (global.floors_percent >= global.floors_required_percent)
                exit;
            
            f.type = UnknownEnum.Value_1;
            f.special_look_x = 0;
            f.special_look_y = 0;
            cpart_create_popup_activation(arg0, arg1, 2);
            var m = stage_get_middle_position(arg0, arg1);
            container_play_position("cnt_popup", m[0], m[1], m[2]);
            var ou = stage_get_out_vector(arg0, arg1);
            var up = stage_get_up_vector(arg0, arg1);
            var ri = stage_get_right_vector(arg0, arg1);
            
            repeat (9)
            {
                var dx = random_range(-16, 16);
                var dy = random_range(-16, 16);
                var dz = 3;
                var xx = m[0] + (dx * ri[0]) + (dy * up[0]) + (ou[0] * dz);
                var yy = m[1] + (dx * ri[1]) + (dy * up[1]) + (ou[1] * dz);
                var zz = m[2] + (dx * ri[2]) + (dy * up[2]) + (ou[2] * dz);
                dz = random_range(4, 8);
                var xs = dz * ou[0];
                var ys = dz * ou[1];
                var zs = dz * ou[2];
                cpart_create_paint_drip(16777215, xx, yy, zz, xs, ys, zs, ou, irandom_range(20, 50), random_range(0.3, 0.6));
            }
            
            cubea_buffer_change(arg0, arg1, global.stage_model);
            var popup = ds_map_find_value(global.popup_type, f.type_param);
            
            if (!is_undefined(popup))
            {
                var obj = popup.object;
                
                // ARCHIPELAGO: Don't spawn powerups we don't have
                if (object_is_ancestor(obj, obj_par_powerup) && AP_is_powerup_obj_unlocked(obj)) {
                    var o = instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj);
                    o.state = powerup_state_popup;
                    o.visible = 0;
                }
                
                if (object_is_ancestor(obj, obj_par_popcorn_enemy) || object_is_ancestor(obj, obj_par_standard_enemy))
                {
                    var o = instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj);
                    o.state = ds_map_find_value(global.enemy_popup_state, obj);
                    
                    if (is_undefined(o.state))
                        o.state = ds_map_find_value(global.enemy_popup_state, object_get_parent(obj));
                    
                    if (is_undefined(o.state))
                        o.state = ds_map_find_value(global.enemy_popup_state, object_get_parent(object_get_parent(obj)));
                    
                    if (is_undefined(o.state))
                        o.state = enemy_blob_state_popup;
                    
                    o.visible = 0;
                }
            }
        }
        
        if (f.type == UnknownEnum.Value_36)
        {
            f.type = UnknownEnum.Value_1;
            f.special_look_x = 0;
            f.special_look_y = 0;
            cpart_create_popup_activation(arg0, arg1, 1);
            var m = stage_get_middle_position(arg0, arg1);
            audi_play_at(snd_popspread, m[0], m[1], m[2]);
            var ou = stage_get_out_vector(arg0, arg1);
            var up = stage_get_up_vector(arg0, arg1);
            var ri = stage_get_right_vector(arg0, arg1);
            
            repeat (9)
            {
                var dx = random_range(-16, 16);
                var dy = random_range(-16, 16);
                var dz = 3;
                var xx = m[0] + (dx * ri[0]) + (dy * up[0]) + (ou[0] * dz);
                var yy = m[1] + (dx * ri[1]) + (dy * up[1]) + (ou[1] * dz);
                var zz = m[2] + (dx * ri[2]) + (dy * up[2]) + (ou[2] * dz);
                dz = random_range(4, 8);
                var xs = dz * ou[0];
                var ys = dz * ou[1];
                var zs = dz * ou[2];
                cpart_create_paint_drip(16777215, xx, yy, zz, xs, ys, zs, ou, irandom_range(20, 50), random_range(0.3, 0.6));
            }
            
            cubea_buffer_change(arg0, arg1, global.stage_model);
            var taken_map = ds_map_create();
            ds_map_set(taken_map, arg0 + (arg1 * 1000), true);
            
            for (var i = 0; i < 4; i++)
            {
                var d = stage_grid_step([arg0, arg1], i);
                
                if (d[0] < 0 || d[2] < 0)
                    continue;
                
                if (!ds_map_exists(taken_map, d[0] + (d[1] * 1000)))
                {
                    popspread_affect(d[0], d[1]);
                    ds_map_set(taken_map, d[0] + (d[1] * 1000), true);
                }
                
                var d2 = stage_grid_step(d, (d[2] + 1) % 4);
                
                if (d2[0] >= 0 && d2[2] >= 0 && !ds_map_exists(taken_map, d2[0] + (d2[1] * 1000)))
                {
                    popspread_affect(d2[0], d2[1]);
                    ds_map_set(taken_map, d2[0] + (d2[1] * 1000), true);
                }
                
                d2 = stage_grid_step(d, (d[2] + 3) % 4);
                
                if (d2[0] >= 0 && d2[2] >= 0 && !ds_map_exists(taken_map, d2[0] + (d2[1] * 1000)))
                {
                    popspread_affect(d2[0], d2[1]);
                    ds_map_set(taken_map, d2[0] + (d2[1] * 1000), true);
                }
            }
            
            ds_map_destroy(taken_map);
            
            with (obj_player)
                prevent_negative_any += 2;
        }
    }
}

function popspread_affect(arg0, arg1)
{
    floor_scoring_mark(arg0, arg1, false, false, true);
    var o = instance_create_lay((gx * 32) + 16, (gy * 32) + 16, 302, obj_supermark_floor_effect);
}

global.popup_type = ds_map_create();
ds_map_add(global.popup_type, 0, 
{
    name: "dud",
    object: noone
});
ds_map_add(global.popup_type, 9, 
{
    name: "powerup_extra_life",
    object: obj_powerup_extra_life
});
ds_map_add(global.popup_type, 10, 
{
    name: "powerup_bomb",
    object: obj_powerup_bomb
});
ds_map_add(global.popup_type, 11, 
{
    name: "powerup_impact",
    object: obj_powerup_impact
});
ds_map_add(global.popup_type, 12, 
{
    name: "powerup_paint_burst",
    object: obj_powerup_paint_burst
});
ds_map_add(global.popup_type, 13, 
{
    name: "powerup_dash",
    object: obj_powerup_dash
});
ds_map_add(global.popup_type, 14, 
{
    name: "powerup_stamphammer",
    object: obj_powerup_stamphammer
});
ds_map_add(global.popup_type, 15, 
{
    name: "powerup_breadcrumb",
    object: obj_powerup_breadcrumb
});
ds_map_add(global.popup_type, 16, 
{
    name: "powerup_dodge",
    object: obj_powerup_dodge
});
ds_map_add(global.popup_type, 17, 
{
    name: "powerup_paint_balloon",
    object: obj_powerup_paint_balloon
});
ds_map_add(global.popup_type, 18, 
{
    name: "powerup_wrap_paper",
    object: obj_powerup_wrap_paper
});
ds_map_add(global.popup_type, 19, 
{
    name: "powerup_superjump",
    object: obj_powerup_superjump
});
ds_map_add(global.popup_type, 20, 
{
    name: "powerup_instant_bomb",
    object: obj_powerup_instant_bomb
});
ds_map_add(global.popup_type, 21, 
{
    name: "powerup_hotstep",
    object: obj_powerup_hotstep
});
ds_map_add(global.popup_type, 22, 
{
    name: "powerup_shield",
    object: obj_powerup_shield
});
ds_map_add(global.popup_type, 40, 
{
    name: "enemy_blob",
    object: obj_blob
});
ds_map_add(global.popup_type, 41, 
{
    name: "enemy_blib",
    object: obj_blib
});
ds_map_add(global.popup_type, 42, 
{
    name: "enemy_blub",
    object: obj_blub
});
ds_map_add(global.popup_type, 43, 
{
    name: "enemy_gem",
    object: obj_gem
});
ds_map_add(global.popup_type, 44, 
{
    name: "enemy_star",
    object: obj_star
});
ds_map_add(global.popup_type, 45, 
{
    name: "enemy_wobbler",
    object: obj_wobbler
});
ds_map_add(global.popup_type, 46, 
{
    name: "enemy_giraffe",
    object: obj_giraffe
});
ds_map_add(global.popup_type, 47, 
{
    name: "enemy_flub",
    object: obj_flub
});
ds_map_add(global.popup_type, 48, 
{
    name: "enemy_stopper",
    object: obj_stopper
});
ds_map_add(global.popup_type, 49, 
{
    name: "enemy_slinky",
    object: obj_slinky
});
ds_map_add(global.popup_type, 50, 
{
    name: "enemy_leaper",
    object: obj_leaper
});
ds_map_add(global.popup_type, 51, 
{
    name: "enemy_strongman",
    object: obj_strongman
});
ds_map_add(global.popup_type, 52, 
{
    name: "enemy_ace",
    object: obj_ace
});
ds_map_add(global.popup_type, 53, 
{
    name: "enemy_fuse",
    object: obj_fuse
});
ds_map_add(global.popup_type, 54, 
{
    name: "enemy_prodigy",
    object: obj_prodigy
});
ds_map_add(global.popup_type, 55, 
{
    name: "enemy_octi",
    object: obj_octi
});
ds_map_add(global.popup_type, 56, 
{
    name: "enemy_spectre",
    object: obj_spectre
});
ds_map_add(global.popup_type, 57, 
{
    name: "enemy_sunsan",
    object: obj_sunsan
});
ds_map_add(global.popup_type, 58, 
{
    name: "enemy_mole",
    object: obj_mole
});
ds_map_add(global.popup_type, 59, 
{
    name: "enemy_molemage",
    object: obj_molemage
});
ds_map_add(global.popup_type, 60, 
{
    name: "enemy_hypermole",
    object: obj_hypermole
});
ds_map_add(global.popup_type, 61, 
{
    name: "enemy_dream",
    object: obj_dream
});
ds_map_add(global.popup_type, 62, 
{
    name: "enemy_clover",
    object: obj_clover
});
ds_map_add(global.popup_type, 63, 
{
    name: "enemy_kuso",
    object: obj_kuso
});
ds_map_add(global.popup_type, 64, 
{
    name: "enemy_remover",
    object: obj_remover
});
ds_map_add(global.popup_type, 65, 
{
    name: "enemy_marble",
    object: obj_marble
});
ds_map_add(global.popup_type, 66, 
{
    name: "enemy_crescent",
    object: obj_crescent
});
ds_map_add(global.popup_type, 67, 
{
    name: "enemy_arachnid",
    object: obj_arachnid
});

enum UnknownEnum
{
    Value_1 = 1,
    Value_21 = 21,
    Value_22,
    Value_36 = 36
}
