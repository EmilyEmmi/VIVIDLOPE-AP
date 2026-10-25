global.enemy_close_spawn = ds_map_create();
ds_map_set(global.enemy_close_spawn, obj_par_powerup, true);
ds_map_set(global.enemy_close_spawn, obj_wobbler, true);
ds_map_set(global.enemy_close_spawn, obj_clover, true);
ds_map_set(global.enemy_close_spawn, obj_viruse, true);
ds_map_set(global.enemy_close_spawn, obj_parrot, true);
ds_map_set(global.enemy_close_spawn, obj_marble, true);
ds_map_set(global.enemy_close_spawn, obj_remover, true);
global.enemy_used_map = ds_map_create();
global.enemy_specific_limit = ds_map_create();

function enemy_spawn_init()
{
    global.enemy_spawn_cycle = 1;
    global.enemy_spawn_wait = 20;
    global.enemy_spawn_dir = [0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3];
    global.enemy_spawn_order = [obj_blob, obj_blob, obj_gem, obj_blob, obj_blib];
    global.enemy_spawn_delay_after = [30, 30, 30, 40, 120];
    global.enemy_spawn_delay_after_override = -1;
    global.enemy_spawn_order_iterator = 0;
    global.enemy_spawn_retry = -1;
    global.enemy_spawn_retry_target = -4;
    global.enemy_spawn_retry_object = -4;
    global.enemy_spawn_tx = 0;
    global.enemy_spawn_ty = 0;
    global.enemy_spawn_fruit_override = 0;
    global.enemy_popcorn_limit = 19;
    global.enemy_standard_limit = 5;
    global.enemy_big_limit = 1;
    global.enemy_speed_scalar = 1;
}

function enemy_spawn_reset()
{
    global.enemy_spawn_cycle = 1;
    global.enemy_spawn_wait = 20;
    global.enemy_spawn_delay_after_override = -1;
    global.enemy_spawn_order_iterator = 0;
    global.enemy_spawn_retry = -1;
    global.enemy_spawn_retry_target = -4;
    global.enemy_spawn_retry_object = -4;
    global.enemy_spawn_tx = 0;
    global.enemy_spawn_ty = 0;
    global.enemy_spawn_dir = [0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3];
    global.enemy_spawn_fruit_override = 0;
    global.enemy_just_fruited = false;
}

function enemy_spawn_step()
{
    if (global.enemy_spawn_retry > 0)
    {
        global.enemy_spawn_retry -= global.fdelta;
        
        if (global.enemy_spawn_retry <= 0)
        {
            with (global.enemy_spawn_retry_target)
                enemy_spawn(true);
        }
        
        exit;
    }
    
    if (global.enemy_spawn_fruit_override > 0)
    {
        enemy_trigger_spawn();
        exit;
    }
    
    var pace = lerp(1, 0.6, global.nanny_var);
    
    if (global.stage_difficulty == UnknownEnum.Value_0)
        pace = lerp(0.5, 0.4, global.nanny_var);
    
    global.enemy_spawn_wait -= (pace * global.fdelta);
    
    if (global.enemy_spawn_wait <= 0)
    {
        if (global.enemy_spawn_delay_after_override > 0)
        {
            global.enemy_spawn_wait = global.enemy_spawn_delay_after_override;
            global.enemy_spawn_delay_after_override = -1;
        }
        else if (!is_array(global.enemy_spawn_delay_after))
        {
            global.enemy_spawn_wait = global.enemy_spawn_delay_after;
        }
        else
        {
            global.enemy_spawn_wait = global.enemy_spawn_delay_after[global.enemy_spawn_order_iterator];
        }
        
        enemy_trigger_spawn();
    }
}

function enemy_get_spawn_nearest_to_player(arg0)
{
    var stage_grid = global.stage_grid;
    var w = ds_grid_width(stage_grid) - 1;
    var h = ds_grid_height(stage_grid) - 1;
    var grid_mindis = 9999;
    var grid_minobj = -4;
    var mindis = 9999;
    var minobj = arg0;
    
    for (var xx = 1; xx < w; xx++)
    {
        for (var yy = 1; yy < h; yy++)
        {
            var s = ds_grid_get(stage_grid, xx, yy);
            
            if (is_struct(s))
            {
                if (s.type == UnknownEnum.Value_3)
                {
                    var dist = vividext_pathfind_get(s.gx, s.gy);
                    
                    if (dist < mindis)
                    {
                        mindis = dist;
                        minobj = instance_position((xx * 32) + 16, (yy * 32) + 16, obj_enemy_spawner);
                    }
                }
            }
        }
    }
    
    if (mindis < 9999)
    {
        grid_mindis = mindis;
        grid_minobj = minobj;
    }
    
    if (!instance_exists(obj_player))
    {
        if (grid_mindis < 9999)
            return grid_minobj;
        
        return arg0;
    }
    
    var plx = obj_player.display_x;
    var ply = obj_player.display_y;
    var plz = obj_player.display_z;
    mindis = 9999;
    
    with (obj_enemy_spawner)
    {
        var p = stage_get_middle_position(floor(x / 32), floor(y / 32));
        var dis = point_distance_3d(plx, ply, plz, p[0], p[1], p[2]);
        
        if (dis < mindis)
        {
            mindis = dis;
            minobj = self.id;
        }
    }
    
    if (mindis < 144)
        return minobj;
    
    if (grid_mindis < 10)
        return grid_minobj;
    
    if (mindis < 9999)
        return minobj;
    
    return arg0;
}

function enemy_spawn_should_be_blocked(arg0, arg1)
{
    if (position_meeting(arg0, arg1, obj_target_mark))
        return true;
    
    return false;
}

function enemy_adapt_limit_to_nanny(arg0)
{
    return ceil(lerp(arg0, arg0 * 0.6, global.nanny_var));
}

function enemy_spawn(arg0)
{
    var obj_to_spawn = -4;
    var queue_update = -1;
    var tx = (floor(x / 32) * 32) + 16;
    var ty = (floor(y / 32) * 32) + 16;
    
    if (global.enemy_spawn_fruit_override > 0)
    {
        obj_to_spawn = obj_powerup_cherry;
    }
    else
    {
        obj_to_spawn = global.enemy_spawn_order[global.enemy_spawn_order_iterator];
        
        if (obj_to_spawn != -4)
        {
            if (object_is_ancestor(obj_to_spawn, obj_par_popcorn_enemy) && instance_number(obj_par_popcorn_enemy) >= enemy_adapt_limit_to_nanny(global.enemy_popcorn_limit))
                obj_to_spawn = -4;
        }
        
        if (obj_to_spawn != -4)
        {
            if (object_is_ancestor(obj_to_spawn, obj_par_standard_enemy) && instance_number(obj_par_standard_enemy) >= enemy_adapt_limit_to_nanny(global.enemy_standard_limit))
                obj_to_spawn = -4;
        }
        
        if (obj_to_spawn != -4)
        {
            if (object_is_ancestor(obj_to_spawn, obj_par_powerup) && instance_number(obj_par_powerup) >= 8)
                obj_to_spawn = -4;
        }
        
        // ARCHIPELAGO: Prevent locked powerups from spawning
        if (obj_to_spawn != -4 && AP_is_multiworld_active() && object_is_ancestor(obj_to_spawn, obj_par_powerup) && !AP_is_powerup_obj_unlocked(obj_to_spawn)) {
            obj_to_spawn = -4;
        }
        
        if (obj_to_spawn != -4)
        {
            if (ds_map_exists(global.enemy_specific_limit, obj_to_spawn) && instance_number(obj_to_spawn) >= enemy_adapt_limit_to_nanny(ds_map_find_value(global.enemy_specific_limit, obj_to_spawn)))
                obj_to_spawn = -4;
        }
    }
    
    if (obj_to_spawn == -4)
        queue_update = 1;
    
    if (obj_to_spawn != -4)
    {
        if (obj_to_spawn == obj_powerup_cherry || ds_map_exists(global.enemy_close_spawn, obj_to_spawn) || ds_map_exists(global.enemy_close_spawn, object_get_parent(obj_to_spawn)))
        {
            var spo = enemy_get_spawn_nearest_to_player(self.id);
            
            if (instance_exists(spo))
            {
                tx = (floor(spo.x / 32) * 32) + 16;
                ty = (floor(spo.y / 32) * 32) + 16;
            }
        }
        
        if (enemy_spawn_should_be_blocked(tx, ty))
        {
            global.enemy_spawn_retry = 6;
            exit;
        }
    }
    
    if (obj_to_spawn != -4)
    {
        var o2 = instance_create_lay(tx, ty, 300, obj_to_spawn);
        o2.dir = global.enemy_spawn_dir[number - 1];
        o2.next_dir = o2.dir;
        o2.timer = -80;
        var o3 = instance_create_layer(o2.x, o2.y, layer, obj_target_mark);
        o3.friend = o2;
        
        if (obj_to_spawn == obj_remover || object_is_ancestor(obj_to_spawn, obj_par_powerup))
            o3.safe = 1;
        
        if (obj_to_spawn != obj_powerup_cherry)
            queue_update = 0;
        else
            global.enemy_spawn_fruit_override--;
    }
    
    if (queue_update != -1)
    {
        global.enemy_spawn_order_iterator = (global.enemy_spawn_order_iterator + 1) % array_length(global.enemy_spawn_order);
        hud_enemy_queue_command_pop(queue_update);
        
        if (queue_update == 1)
            global.enemy_spawn_wait = min(global.enemy_spawn_wait, 60);
    }
}

function enemy_trigger_spawn()
{
    var o = -4;
    
    repeat (24)
    {
        with (obj_enemy_spawner)
        {
            if (number == global.enemy_spawn_cycle)
            {
                o = self.id;
                break;
            }
        }
        
        global.enemy_spawn_cycle++;
        
        if (global.enemy_spawn_cycle >= 24)
            global.enemy_spawn_cycle = 1;
        
        if (o != -4)
            break;
    }
    
    if (o != -4)
    {
        with (o)
            enemy_spawn(false);
    }
}

enum UnknownEnum
{
    Value_0,
    Value_3 = 3
}
