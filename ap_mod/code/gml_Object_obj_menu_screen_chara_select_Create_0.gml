menu_screen_init("charaselect");
global._squeue_ear_detail = 0.05;
character_anim = 0;
character_life_icon = [];

for (var i = 0; i < UnknownEnum.Value_5; i++)
{
    if (i == UnknownEnum.Value_2)
        continue;
    
    if (i == UnknownEnum.Value_3)
        continue;
    
    var m = menu_screen_add_option(new MENU_OPTION("csel" + string(i), spr_menu_icon_none, 0, chara_get_name(i), function()
    {
    }, -1, chara_get_description(i)));
    m.character_assigned = i;
    array_push(character_life_icon, chara_get_life_icon_index(i));
}

back_action = function()
{
    // ARCHIPELAGO: go back to AP menu in character select menu
    if (AP_is_multiworld_active()) {
        menu_flow_goto_menu_screen(obj_menu_screen_archipelago, true);
    } else {
        menu_flow_goto_menu_screen(obj_menu_screen_file_select, true);
    }
};

menu_screen_post_init();
menu_set_top_caption(lang("mc_character"));
menu_set_bottom_caption(lang("mb_select"), lang("mb_back"));
char_camera = camera_create();
camera_set_proj_mat(char_camera, matrix_build_projection_perspective_fov(60, global.window_w / global.window_h, 32, 9000));
camera_set_view_mat(char_camera, matrix_build_lookat(1284, 368, -640, 640, 360, 0, 0, 1, 0));
skeletons_are_destroyed = false;
skeletons = [ani3d_get_skeleton("heroine"), ani3d_get_skeleton("friend"), ani3d_get_skeleton("wench")];
ani3d_skeleton_play_animation_next(skeletons[0], "charasel_cerise", 1);
ani3d_skeleton_play_animation_next(skeletons[1], "charasel_ecru", 1);
ani3d_skeleton_play_animation_next(skeletons[2], "charasel_missnoir", 1);
char_rotz[0] = [120, 104];
char_rotz[1] = [120, 104];
char_rotz[2] = [115, 104];
ani3d_tail_activate(skeletons[2]);
smug_factor = 0;
smug_active = false;
smug_activate = false;
smug_countdown = 270;
chosen = 0;

enum UnknownEnum
{
    Value_2 = 2,
    Value_3,
    Value_5 = 5
}
