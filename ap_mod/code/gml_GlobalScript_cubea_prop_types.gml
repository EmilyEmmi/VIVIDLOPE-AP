global.prop_spawn_script = ds_map_create();
global.prop_ko_respawn = ds_map_create();
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_1, function(arg0, arg1, arg2, arg3, arg4)
{
    instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj_flower);
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_1, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_2, function(arg0, arg1, arg2, arg3, arg4)
{
    var o = instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj_roller);
    
    with (o)
    {
        self.dir = arg3;
        stage_object_face_direction(-90 + (arg3 * 90), arg0, arg1);
    }
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_2, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_3, function(arg0, arg1, arg2, arg3, arg4)
{
    var o = instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj_squatrol);
    
    with (o)
    {
        self.dir = arg3;
        self.next_dir = arg3;
    }
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_3, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_4, function(arg0, arg1, arg2, arg3, arg4)
{
    var o = instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj_maria);
    
    with (o)
    {
        self.angle = arg2;
        self.grid_distance = 2;
        
        if (arg2 >= 360)
            self.angle_scalar *= -1;
    }
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_4, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_5, function(arg0, arg1, arg2, arg3, arg4)
{
    var o = instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj_lunger);
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_5, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_6, function(arg0, arg1, arg2, arg3, arg4)
{
    var o = instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj_dropper);
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_6, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_7, function(arg0, arg1, arg2, arg3, arg4)
{
    var o = instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj_key);
    o.param = arg2;
    var c = ds_map_find_value(global.locked_colors, arg2);
    
    if (is_undefined(c))
        c = 65535;
    
    o.color = merge_color(c, merge_color(c_yellow, c_white, 0.8), 0.56);
    o.color2 = c;
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_7, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_8, function(arg0, arg1, arg2, arg3, arg4)
{
    instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj_weed);
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_8, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_9, function(arg0, arg1, arg2, arg3, arg4)
{
    var o = instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj_bucket);
    
    if (arg2 == 1)
    {
        with (o)
        {
            positive = false;
            sprite.plus_frame = 1;
            color = process_color(global.floors_palette[0]);
        }
    }
    else
    {
        with (o)
        {
            positive = true;
            sprite.plus_frame = 0;
            color = process_color(global.floors_palette[2]);
        }
    }
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_9, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_10, function(arg0, arg1, arg2, arg3, arg4)
{
    var o = instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj_teleport);
    var pp = arg2;
    o.param = pp;
    var c = ds_map_find_value(global.locked_colors, pp);
    
    if (is_undefined(c))
        c = 16777215;
    
    o.color = merge_color(c, merge_color(c_aqua, c_white, 0.8), 0.56);
    o.color2 = c;
    o.warp_color = ds_map_find_value(global.warp_colors, pp);
    
    with (o)
        event_user(15);
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_10, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_11, function(arg0, arg1, arg2, arg3, arg4)
{
    var angle_delta = clamp(360 / clamp(arg2 % 1000, 1, 100), 15, 180);
    var fast = clamp(floor(arg2 / 1000), 0, 2);
    var range = 1;
    var p = [arg0, arg1, (arg3 + 2) % 4];
    
    repeat (16)
    {
        var p2 = stage_grid_step_not_too_steep(p, p[2]);
        
        if (p2[0] < 0 || p2[2] < 0)
            break;
        
        p = p2;
    }
    
    var tx = p[0];
    var ty = p[1];
    p[2] = (p[2] + 2) % 4;
    var td = p[2];
    
    repeat (24)
    {
        var p2 = stage_grid_step_not_too_steep(p, p[2]);
        
        if (p2[0] < 0 || p2[2] < 0)
            break;
        
        p = p2;
        range++;
    }
    
    var o = ringu_create(tx, ty, td, range, angle_delta);
    
    switch (fast)
    {
        case 0:
            o.rotation_speed = 0.7 * max(0.1, 1 - ((range - 1) * 0.1));
            break;
        
        case 1:
            o.rotation_speed = 1.4 * max(0.1, 1 - ((range - 1) * 0.1));
            break;
        
        case 2:
            o.rotation_speed = 2.1 * max(0.1, 1 - ((range - 1) * 0.1));
            break;
    }
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_11, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_12, function(arg0, arg1, arg2, arg3, arg4)
{
    var o = instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj_zone_switch);
    o.param = arg2;
    var c = ds_map_find_value(global.locked_colors, arg2);
    
    if (is_undefined(c))
        c = 65535;
    
    o.color = merge_color(c, merge_color(c_yellow, c_white, 0.8), 0.56);
    o.color2 = c;
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_12, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_13, function(arg0, arg1, arg2, arg3, arg4)
{
    if (!instance_exists(obj_beatdancers))
        instance_create_lay(0, 0, 303, obj_beatdancers);
    
    obj_beatdancers.hurt[arg0][arg1] = 1 + arg2;
    array_set(obj_beatdancers.zone_used, ds_grid_get(global.stage_grid, arg0, arg1).zone, true);
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_13, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_14, function(arg0, arg1, arg2, arg3, arg4)
{
    if (!instance_exists(obj_beartraps))
        instance_create_lay(0, 0, 303, obj_beartraps);
    
    obj_beartraps.hurt[arg0][arg1] = 1;
    ds_list_add(@@array_get@@(obj_beartraps.zone_bears, ds_grid_get(global.stage_grid, arg0, arg1).zone), [arg0, arg1]);
    array_set(obj_beartraps.zone_used, ds_grid_get(global.stage_grid, arg0, arg1).zone, true);
    var surroundings = stage_get_3x3_neighbors(arg0, arg1);
    obj_beartraps.surround_list[arg0][arg1] = surroundings;
    var i = array_length(surroundings) - 1;
    
    while (i >= 0)
    {
        obj_beartraps.surround_check[surroundings[i][0]][surroundings[i][1]] = 1;
        i--;
    }
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_14, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_15, function(arg0, arg1, arg2, arg3, arg4)
{
    var o = instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj_dropper_ex);
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_15, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_16, function(arg0, arg1, arg2, arg3, arg4)
{
    var o = instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj_bubble);
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_16, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_17, function(arg0, arg1, arg2, arg3, arg4)
{
    var o = instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj_landmine);
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_17, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_18, function(arg0, arg1, arg2, arg3, arg4)
{
    var o = instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj_viruse);
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_18, true);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_19, function(arg0, arg1, arg2, arg3, arg4)
{
    var o = instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj_lightbulb);
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_19, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_20, function(arg0, arg1, arg2, arg3, arg4)
{
    var o = instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj_falling_star_trigger);
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_20, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_21, function(arg0, arg1, arg2, arg3, arg4)
{
    var o = instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj_snowman);
    o.height = arg2;
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_21, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_22, function(arg0, arg1, arg2, arg3, arg4)
{
    var o = instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj_spitter);
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_22, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_23, function(arg0, arg1, arg2, arg3, arg4)
{
    var o = instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj_baywatch);
    
    with (o)
    {
        self.dir = arg3;
        self.next_dir = arg3;
    }
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_23, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_24, function(arg0, arg1, arg2, arg3, arg4)
{
    var o = instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj_qix);
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_24, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_25, function(arg0, arg1, arg2, arg3, arg4)
{
    spark_dope_create(arg0, arg1);
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_25, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_26, function(arg0, arg1, arg2, arg3, arg4)
{
    var o = instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj_infinite_item_giver);
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_26, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_100, function(arg0, arg1, arg2, arg3, arg4)
{
    var o = instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj_npc);
    
    with (o)
    {
        stage_object_face_direction(-90 + (arg3 * 90), arg0, arg1);
        start_dir_angle = -90 + (arg3 * 90);
        npc_initialize(arg2);
    }
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_100, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_101, function(arg0, arg1, arg2, arg3, arg4)
{
    instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj_overworld_vividcore_visage);
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_101, false);
ds_map_set(global.prop_spawn_script, UnknownEnum.Value_102, function(arg0, arg1, arg2, arg3, arg4)
{
    instance_create_lay((arg0 * 32) + 16, (arg1 * 32) + 16, 300, obj_level_requirement_switcher);
});
ds_map_set(global.prop_ko_respawn, UnknownEnum.Value_102, false);

function cubea_get_prop_types()
{
    var dirname = ["Down", "Right", "Up", "Left"];
    var typea = [];
    array_push(typea, 
    {
        name: "Blank",
        type: UnknownEnum.Value_0,
        param: 0
    });
    array_push(typea, 
    {
        name: "Flower",
        type: UnknownEnum.Value_1,
        param: 0
    });
    array_push(typea, 
    {
        name: "Roller",
        type: UnknownEnum.Value_2,
        param: 0
    });
    array_push(typea, 
    {
        name: "Squatrol",
        type: UnknownEnum.Value_3,
        param: 0
    });
    array_push(typea, 
    {
        name: "Maria",
        type: UnknownEnum.Value_4,
        param: 0
    });
    array_push(typea, 
    {
        name: "Lunger",
        type: UnknownEnum.Value_5,
        param: 0
    });
    array_push(typea, 
    {
        name: "Dropper",
        type: UnknownEnum.Value_6,
        param: 0
    });
    array_push(typea, 
    {
        name: "Dropper EX",
        type: UnknownEnum.Value_15,
        param: 0
    });
    
    for (var i = 0; i < 6; i++)
    {
        array_push(typea, 
        {
            name: "Key " + string(global.locked_colors_characters[i]),
            type: UnknownEnum.Value_7,
            param: i
        });
    }
    
    array_push(typea, 
    {
        name: "Weed",
        type: UnknownEnum.Value_8,
        param: 0
    });
    array_push(typea, 
    {
        name: "Bucket",
        type: UnknownEnum.Value_9,
        param: 0
    });
    array_push(typea, 
    {
        name: "Bucket Neg.",
        type: UnknownEnum.Value_9,
        param: 1
    });
    
    for (var i = 0; i < 6; i++)
    {
        array_push(typea, 
        {
            name: "Teleport " + string(global.locked_colors_characters[i]),
            type: UnknownEnum.Value_10,
            param: i
        });
    }
    
    array_push(typea, 
    {
        name: "Ringu 4 Slow",
        type: UnknownEnum.Value_11,
        param: 4
    });
    array_push(typea, 
    {
        name: "Ringu 6 Slow",
        type: UnknownEnum.Value_11,
        param: 6
    });
    array_push(typea, 
    {
        name: "Ringu 8 Slow",
        type: UnknownEnum.Value_11,
        param: 8
    });
    array_push(typea, 
    {
        name: "Ringu 12 Slow",
        type: UnknownEnum.Value_11,
        param: 12
    });
    array_push(typea, 
    {
        name: "Ringu 4 Fast",
        type: UnknownEnum.Value_11,
        param: 1004
    });
    array_push(typea, 
    {
        name: "Ringu 6 Fast",
        type: UnknownEnum.Value_11,
        param: 1006
    });
    array_push(typea, 
    {
        name: "Ringu 8 Fast",
        type: UnknownEnum.Value_11,
        param: 1008
    });
    array_push(typea, 
    {
        name: "Ringu 12 Fast",
        type: UnknownEnum.Value_11,
        param: 1012
    });
    array_push(typea, 
    {
        name: "Ringu 4 Turbo",
        type: UnknownEnum.Value_11,
        param: 2004
    });
    array_push(typea, 
    {
        name: "Ringu 6 Turbo",
        type: UnknownEnum.Value_11,
        param: 2006
    });
    array_push(typea, 
    {
        name: "Ringu 8 Turbo",
        type: UnknownEnum.Value_11,
        param: 2008
    });
    array_push(typea, 
    {
        name: "Ringu 12 Turbo",
        type: UnknownEnum.Value_11,
        param: 2012
    });
    
    for (var i = 0; i < 6; i++)
    {
        array_push(typea, 
        {
            name: "Zone Switch " + string(global.locked_colors_characters[i]),
            type: UnknownEnum.Value_12,
            param: i
        });
    }
    
    array_push(typea, 
    {
        name: "Beatdancer c. 0",
        type: UnknownEnum.Value_13,
        param: 0
    });
    array_push(typea, 
    {
        name: "Beatdancer c. 1",
        type: UnknownEnum.Value_13,
        param: 1
    });
    array_push(typea, 
    {
        name: "Naval mine",
        type: UnknownEnum.Value_14,
        param: 0
    });
    array_push(typea, 
    {
        name: "Bubble",
        type: UnknownEnum.Value_16,
        param: 0
    });
    array_push(typea, 
    {
        name: "Landmine",
        type: UnknownEnum.Value_17,
        param: 0
    });
    array_push(typea, 
    {
        name: "Green Man",
        type: UnknownEnum.Value_18,
        param: 0
    });
    array_push(typea, 
    {
        name: "Lightbulb",
        type: UnknownEnum.Value_19,
        param: 0
    });
    array_push(typea, 
    {
        name: "Falling Star",
        type: UnknownEnum.Value_20,
        param: 0
    });
    array_push(typea, 
    {
        name: "Snowman 1 tall",
        type: UnknownEnum.Value_21,
        param: 1
    });
    array_push(typea, 
    {
        name: "Snowman 2 tall",
        type: UnknownEnum.Value_21,
        param: 2
    });
    array_push(typea, 
    {
        name: "Snowman 3 tall",
        type: UnknownEnum.Value_21,
        param: 3
    });
    array_push(typea, 
    {
        name: "Snowman 4 tall",
        type: UnknownEnum.Value_21,
        param: 4
    });
    array_push(typea, 
    {
        name: "Snowman 5 tall",
        type: UnknownEnum.Value_21,
        param: 5
    });
    array_push(typea, 
    {
        name: "Spitter",
        type: UnknownEnum.Value_22,
        param: 0
    });
    array_push(typea, 
    {
        name: "Baywatch",
        type: UnknownEnum.Value_23,
        param: 0
    });
    array_push(typea, 
    {
        name: "Qix",
        type: UnknownEnum.Value_24,
        param: 0
    });
    array_push(typea, 
    {
        name: "Spark Dope",
        type: UnknownEnum.Value_25,
        param: 0
    });
    array_push(typea, 
    {
        name: "Inf. Superjump",
        type: UnknownEnum.Value_26,
        param: 0
    });
    
    if (global.consumer_mode)
        return typea;
    
    array_push(typea, 
    {
        name: "NPC",
        type: UnknownEnum.Value_100,
        param: -1
    });
    array_push(typea, 
    {
        name: "VVCoreVis",
        type: UnknownEnum.Value_101,
        param: 0
    });
    array_push(typea, 
    {
        name: "LvClSw",
        type: UnknownEnum.Value_102,
        param: 0
    });
    return typea;
}

function cubea_spawn_props(arg0, arg1)
{
    var w = ds_grid_width(arg0);
    var h = ds_grid_height(arg0);
    
    for (var xx = 1; xx < w; xx++)
    {
        for (var yy = 1; yy < h; yy++)
        {
            var f = ds_grid_get(arg0, xx, yy);
            
            if (is_struct(f) && f.prop != UnknownEnum.Value_0)
            {
                with (f)
                {
                    // ARCHIPELAGO: Handle locked level elements
                    if ((arg1 || ds_map_find_value(global.prop_ko_respawn, prop)) && AP_element_is_unlocked(prop))
                        ds_map_find_value(global.prop_spawn_script, prop)(xx, yy, prop_param, prop_dir, arg1);
                }
            }
        }
    }
    
    if (global.current_stage == "overworld")
    {
        var b;
        
        with (obj_player)
            b = stage_get_middle_position(gx, gy);
        
        var distance_map = ds_map_create();
        var npc_iterate = 0;
        
        with (obj_npc)
        {
            var a = stage_get_middle_position(gx, gy);
            initial_dist = point_distance_3d(a[0], a[1], a[2], b[0], b[1], b[2]) + (npc_iterate * 0.01);
            npc_iterate++;
            
            if (!ds_map_exists(distance_map, original_param))
                ds_map_set(distance_map, original_param, initial_dist);
            else if (ds_map_find_value(distance_map, original_param) > initial_dist)
                ds_map_set(distance_map, original_param, initial_dist);
        }
        
        with (obj_npc)
        {
            if (ds_map_find_value(distance_map, original_param) != initial_dist)
                instance_destroy();
        }
        
        ds_map_destroy(distance_map);
    }
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
    Value_7,
    Value_8,
    Value_9,
    Value_10,
    Value_11,
    Value_12,
    Value_13,
    Value_14,
    Value_15,
    Value_16,
    Value_17,
    Value_18,
    Value_19,
    Value_20,
    Value_21,
    Value_22,
    Value_23,
    Value_24,
    Value_25,
    Value_26,
    Value_100 = 100,
    Value_101,
    Value_102
}
