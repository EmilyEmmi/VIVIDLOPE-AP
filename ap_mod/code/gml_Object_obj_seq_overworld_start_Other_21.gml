with (obj_control)
{
}

with (obj_hud)
    palette_enabled = true;

if (timer >= 40)
{
    if (!game_overworld_clear_event_check("levelX_clear") && level_is_complete(11) && global.overworld_position == 11)
    {
        timer = 0;
        ptimer = 0;
        level_x_clear = true;
    }
    else if ((AP_is_multiworld_active() && global.AP_override_level_x_reveal) || (!game_overworld_clear_event_check("levelX_reveal") && level_is_complete(1) && level_is_complete(2) && level_is_complete(3) && level_is_complete(4) && level_is_complete(5) && level_is_complete(6) && level_is_complete(7) && level_is_complete(8) && level_is_complete(9) && level_is_complete(10)))
    {
        timer = 0;
        ptimer = 0;
        level_x_reveal = true;
        global.AP_override_level_x_reveal = false;
    }
    else if (global.overworld_just_cleared > 0 && global.overworld_just_cleared < 10)
    {
        timer = 0;
        ptimer = 0;
        new_level_reveal = true;
    }
    else
    {
        global.overworld_just_cleared = 0;
        global.gstate = UnknownEnum.Value_1;
        event_user(5);
        instance_destroy();
    }
}

enum UnknownEnum
{
    Value_1 = 1
}
