global.stage_index = ds_map_create();
global.stage_index_key_list = ds_list_create();
global.stage_index_color_map = ds_map_create();
global.stage_index_to_level = ds_map_create();

function stage_index_add_stage(arg0, arg1)
{
    ds_map_set(global.stage_index, arg0, arg1);
    ds_list_add(global.stage_index_key_list, arg0);
    
    if (global.stage_world >= 1)
    {
        array_push(global.stage_order[global.stage_world - 1], arg0);
        var c = -1;
        
        switch (global.stage_world)
        {
            case 1:
                c = merge_color(c_lime, c_green, 0.5);
                break;
            
            case 2:
                c = 16711935;
                break;
            
            case 3:
                c = 65535;
                break;
            
            case 4:
                c = 8388736;
                break;
            
            case 5:
                c = 4235519;
                break;
            
            case 6:
                c = 16776960;
                break;
            
            case 7:
                c = merge_color(c_aqua, c_blue, 0.5);
                break;
            
            case 8:
                c = merge_color(c_blue, c_gray, 0.5);
                break;
            
            case 9:
                c = 16711680;
                break;
            
            case 10:
                c = 255;
                break;
            
            case 11:
                c = merge_color(c_fuchsia, c_aqua, 0.5);
                break;
        }
        
        if (c != -1)
            ds_map_set(global.stage_index_color_map, arg0, merge_color(c, c_white, 0.6));
        
        ds_map_set(global.stage_index_to_level, arg0, global.stage_world);
        show_debug_msg("*** world assignment - " + string(arg0) + " - " + string(global.stage_world));
    }
}

function stage_get_level_code(arg0)
{
    // get true values in level shuffle
    if (ds_map_exists(global.stage_index_to_true_code, arg0)) {
        return ds_map_find_value(global.stage_index_to_true_code, arg0);
    }

    var n1 = array_length(global.stage_order);
    
    for (var i = 0; i < n1; i++)
    {
        var n2 = array_length(global.stage_order[i]);
        
        for (var j = 0; j < n2; j++)
        {
            if (global.stage_order[i][j] == arg0)
                return [i + 1, j + 1];
        }
    }
    
    return [0, 0];
}

function stage_index_setup()
{
    ds_map_clear(global.stage_index);
    ds_list_clear(global.stage_index_key_list);
    ds_map_clear(global.stage_index_color_map);
    ds_map_clear(global.stage_index_to_level);
    global.stage_order = [[], [], [], [], [], [], [], [], [], [], []];
    global.stage_world = 0;
    stage_index_add_stage("howto", "howto");
    stage_index_add_stage("overworld", "overworld");
    
    for (var i = 1; i <= 14; i++)
        stage_index_add_stage("test" + string(i), "test" + string(i));
    
    stage_index_add_stage("gem", "gem");
    stage_index_add_stage("elevation", "elevation");
    stage_index_add_stage("revolve", "revolve");
    stage_index_add_stage("xmas", "xmas");
    stage_index_add_stage("snake", "snake");
    stage_index_add_stage("bgtester", "bgtester");
    stage_index_add_stage("playground", "playground");
    stage_index_add_stage("c_5x5x5cube", "c");
    stage_index_add_stage("c_wobblertower", "c");
    stage_index_add_stage("c_halfpipe", "c");
    stage_index_add_stage("c_capsule1", "c");
    stage_index_add_stage("c_capsule2", "c");
    stage_index_add_stage("ac_cube5x5x5", "ac");
    stage_index_add_stage("ac_cube7x7x7", "ac");
    stage_index_add_stage("ac_cube9x9x9", "ac");
    stage_index_add_stage("ac_block5x5x9", "ac");
    stage_index_add_stage("ac_block7x7x11", "ac");
    stage_index_add_stage("ac_block3x3x15", "ac");
    stage_index_add_stage("ac_block5x5x15", "ac");
    stage_index_add_stage("ac_hcyllinder32x5", "ac");
    stage_index_add_stage("ac_hcyllinder32x7", "ac");
    stage_index_add_stage("ac_hcyllinder36x9", "ac");
    stage_index_add_stage("ac_hcyllinder40x11", "ac");
    stage_index_add_stage("ac_vcyllinder32x5", "ac");
    stage_index_add_stage("ac_vcyllinder32x7", "ac");
    stage_index_add_stage("ac_vcyllinder36x9", "ac");
    stage_index_add_stage("ac_vcyllinder40x11", "ac");
    stage_index_add_stage("ac_mostlyflat17x13", "ac");
    stage_index_add_stage("ac_mostlyflat19x15", "ac");
    stage_index_add_stage("ac_mostlyflat19x15ringu1", "ac");
    stage_index_add_stage("ac_mostlyflat19x15ringu2", "ac");
    stage_index_add_stage("ac_mostlyflat19x15ringu3", "ac");
    stage_index_add_stage("ac_flat19x15qix1", "ac");
    stage_index_add_stage("ac_flat19x15qix2", "ac");
    stage_index_add_stage("ac_flat19x15qix3", "ac");
    stage_index_add_stage("ac_mostlyflat21x13", "ac");
    stage_index_add_stage("ac_mostlyflat23x11", "ac");
    global.stage_world = 1;
    stage_index_add_stage("s_simple", "s");
    stage_index_add_stage("s_cyllinder", "s");
    stage_index_add_stage("s_S", "s");
    stage_index_add_stage("s_toilet", "s");
    stage_index_add_stage("s_firstdiamond", "s");
    stage_index_add_stage("s_clockflower", "s");
    stage_index_add_stage("s_dropthedrop", "s");
    stage_index_add_stage("s_crossbullet", "s");
    stage_index_add_stage("s_doublebendplane", "s");
    stage_index_add_stage("s_keyhammer", "s");
    stage_index_add_stage("s_jumpdown", "s");
    stage_index_add_stage("s_racetrack", "s");
    stage_index_add_stage("s_firststair", "s");
    stage_index_add_stage("s_invader", "s");
    stage_index_add_stage("s_thefoxbox", "s");
    global.stage_world = 2;
    stage_index_add_stage("s_springstripe", "s");
    stage_index_add_stage("s_ticktockgrid", "s");
    stage_index_add_stage("s_switchtable", "s");
    stage_index_add_stage("s_shuricube", "s");
    stage_index_add_stage("s_PARTY", "s");
    stage_index_add_stage("s_lungertrail", "s");
    stage_index_add_stage("s_summit", "s");
    stage_index_add_stage("s_crosstokeytosix", "s");
    stage_index_add_stage("s_bouncepark", "s");
    stage_index_add_stage("s_bronx", "s");
    stage_index_add_stage("s_simplerevert", "s");
    stage_index_add_stage("s_stairshift", "s");
    stage_index_add_stage("s_hingedbackloop", "s");
    stage_index_add_stage("s_bop", "s");
    stage_index_add_stage("s_castleibiza", "s");
    global.stage_world = 3;
    stage_index_add_stage("s_beachcube", "s");
    stage_index_add_stage("s_lanecapsule", "s");
    stage_index_add_stage("s_slider", "s");
    stage_index_add_stage("s_mobius", "s");
    stage_index_add_stage("s_handkerchief", "s");
    stage_index_add_stage("s_tumorbone", "s");
    stage_index_add_stage("s_opposites", "s");
    stage_index_add_stage("s_droppertriangle", "s");
    stage_index_add_stage("s_starfish", "s");
    stage_index_add_stage("s_curvedH", "s");
    stage_index_add_stage("s_oceanman", "s");
    stage_index_add_stage("s_upupspringstairs", "s");
    stage_index_add_stage("s_binarystair", "s");
    stage_index_add_stage("s_keyfisher", "s");
    stage_index_add_stage("s_pill", "s");
    global.stage_world = 4;
    stage_index_add_stage("s_spookhouse", "s");
    stage_index_add_stage("s_tick", "s");
    stage_index_add_stage("s_shieldface", "s");
    stage_index_add_stage("s_invadertable", "s");
    stage_index_add_stage("s_bearcourse", "s");
    stage_index_add_stage("s_humanloop", "s");
    stage_index_add_stage("s_infinitefear", "s");
    stage_index_add_stage("s_montezuma", "s");
    stage_index_add_stage("s_vania", "s");
    stage_index_add_stage("s_discovery", "s");
    stage_index_add_stage("s_titanic", "s");
    stage_index_add_stage("s_curvesheet", "s");
    stage_index_add_stage("s_ancientroller", "s");
    stage_index_add_stage("s_castlesiege", "s");
    stage_index_add_stage("s_sweetnessfollows", "s");
    global.stage_world = 5;
    stage_index_add_stage("s_heatingup", "s");
    stage_index_add_stage("s_joystick", "s");
    stage_index_add_stage("s_desertwarmup", "s");
    stage_index_add_stage("s_sushi", "s");
    stage_index_add_stage("s_xcrate", "s");
    stage_index_add_stage("s_bundleofjoy", "s");
    stage_index_add_stage("s_arctravel", "s");
    stage_index_add_stage("s_cork", "s");
    stage_index_add_stage("s_caramelcandy", "s");
    stage_index_add_stage("s_manpac", "s");
    stage_index_add_stage("s_diagonaldiogenes", "s");
    stage_index_add_stage("s_areallyfatxwing", "s");
    stage_index_add_stage("s_L", "s");
    stage_index_add_stage("s_chaosunfold", "s");
    stage_index_add_stage("s_goldenbeachpromenade", "s");
    global.stage_world = 6;
    stage_index_add_stage("s_coldopening", "s");
    stage_index_add_stage("s_snowbonanza", "s");
    stage_index_add_stage("s_roachflap", "s");
    stage_index_add_stage("s_walkoflife", "s");
    stage_index_add_stage("s_superjumpintro", "s");
    stage_index_add_stage("s_geom", "s");
    stage_index_add_stage("s_cliffcorner", "s");
    stage_index_add_stage("s_funkystairs", "s");
    stage_index_add_stage("s_frozenwindmill", "s");
    stage_index_add_stage("s_squashedspider", "s");
    stage_index_add_stage("s_auntiesporch", "s");
    stage_index_add_stage("s_crownpants", "s");
    stage_index_add_stage("s_backnforth", "s");
    stage_index_add_stage("s_shoe", "s");
    stage_index_add_stage("s_bigslinky", "s");
    global.stage_world = 7;
    stage_index_add_stage("s_innerbox", "s");
    stage_index_add_stage("s_wingcard", "s");
    stage_index_add_stage("s_superjumpcolumn", "s");
    stage_index_add_stage("s_dorby", "s");
    stage_index_add_stage("s_drill", "s");
    stage_index_add_stage("s_coastalruins", "s");
    stage_index_add_stage("s_tank", "s");
    stage_index_add_stage("s_d", "s");
    stage_index_add_stage("s_return", "s");
    stage_index_add_stage("s_sled", "s");
    stage_index_add_stage("s_cigar", "s");
    stage_index_add_stage("s_bonkers", "s");
    stage_index_add_stage("s_producecube", "s");
    stage_index_add_stage("s_abandonedpost", "s");
    stage_index_add_stage("s_bandage", "s");
    global.stage_world = 8;
    stage_index_add_stage("s_roswell", "s");
    stage_index_add_stage("s_truckingon", "s");
    stage_index_add_stage("s_bulbmania", "s");
    stage_index_add_stage("s_segtube", "s");
    stage_index_add_stage("s_tonight", "s");
    stage_index_add_stage("s_kowloon", "s");
    stage_index_add_stage("s_mistercomputer", "s");
    stage_index_add_stage("s_excavation", "s");
    stage_index_add_stage("s_sssoftS", "s");
    stage_index_add_stage("s_gridjogger", "s");
    stage_index_add_stage("s_hollowcube", "s");
    stage_index_add_stage("s_piston", "s");
    stage_index_add_stage("s_minefield", "s");
    stage_index_add_stage("s_clasp", "s");
    stage_index_add_stage("s_superjumprevolve", "s");
    global.stage_world = 9;
    stage_index_add_stage("s_shattercube", "s");
    stage_index_add_stage("s_poutine", "s");
    stage_index_add_stage("s_loopgalaxy", "s");
    stage_index_add_stage("s_hellscocoon", "s");
    stage_index_add_stage("s_helipad", "s");
    stage_index_add_stage("s_interstellarfaucet", "s");
    stage_index_add_stage("s_brainparasite", "s");
    stage_index_add_stage("s_cosmicoilrig", "s");
    stage_index_add_stage("s_nexus2060", "s");
    stage_index_add_stage("s_wiremaze", "s");
    stage_index_add_stage("s_neptune", "s");
    stage_index_add_stage("s_bingo", "s");
    stage_index_add_stage("s_pencil", "s");
    stage_index_add_stage("s_bolt", "s");
    stage_index_add_stage("s_blackout", "s");
    global.stage_world = 10;
    stage_index_add_stage("s_drone", "s");
    stage_index_add_stage("s_snakesandladders", "s");
    stage_index_add_stage("s_skewystreet", "s");
    stage_index_add_stage("s_boomshakalaka", "s");
    stage_index_add_stage("s_galaxy2", "s");
    stage_index_add_stage("s_collapsecube", "s");
    stage_index_add_stage("s_love", "s");
    global.stage_world = 11;
    stage_index_add_stage("s_phoenix", "s");
    stage_index_add_stage("s_dice", "s");
    stage_index_add_stage("s_hourglass", "s");
    stage_index_add_stage("s_hopscotch", "s");
    stage_index_add_stage("s_anelevatorcity", "s");
    stage_index_add_stage("s_circuitbreakers", "s");
    stage_index_add_stage("s_superjumpcubes", "s");
    stage_index_add_stage("s_pripyat", "s");
    stage_index_add_stage("s_harddiamond", "s");
    stage_index_add_stage("s_beneath", "s");
    stage_index_add_stage("s_loophandkerchief", "s");
    stage_index_add_stage("s_battleshipusagi", "s");
    stage_index_add_stage("s_superjumpuniverse", "s");
    stage_index_add_stage("s_fortboyard", "s");
    stage_index_add_stage("s_fxairline", "s");
    global.stage_world = 0;
    stage_index_add_stage("s_X", "s");
    global.stage_world = 0;
    stage_index_add_stage("s_mayansurfer", "s");
    stage_index_add_stage("s_sponge", "s");
    stage_index_add_stage("s_tophat", "s");
    stage_index_add_stage("s_voomloop", "s");
    stage_index_add_stage("s_barragebox", "s");
    stage_index_add_stage("s_galaxy", "s");
    stage_index_add_stage("s_doublebottle", "s");
    stage_index_add_stage("s_spintipcross", "s");
    stage_index_add_stage("s_sidetanks", "s");
    stage_index_add_stage("s_newtipcross", "s");
    stage_index_add_stage("s_theOG", "s");
    stage_index_add_stage("s_slidesheet", "s");
    stage_index_add_stage("s_linkedtubes", "s");
    stage_index_add_stage("s_secretcube", "s");
    stage_index_add_stage("s_sausageparty", "s");
    stage_index_add_stage("s_softcube", "s");
    stage_index_add_stage("s_leaploop", "s");
    stage_index_add_stage("s_wiremaze0", "s");
    stage_index_add_stage("s_wirecage", "s");
    stage_index_add_stage("s_stormcube", "s");
    stage_index_add_stage("s_agdg", "s");
    stage_index_add_stage("s_slinkytube", "s");
    stage_index_add_stage("s_makethejump", "s");
    stage_index_add_stage("s_bendyflower", "s");
    stage_index_add_stage("s_assemblecapsule", "s");
    stage_index_add_stage("s_mackymoose", "s");
    stage_index_add_stage("s_cube", "s");
    stage_index_add_stage("s_squarecircle", "s");
    stage_index_add_stage("s_holeflowercube", "s");
    stage_index_add_stage("s_nostradamus", "s");
    stage_index_add_stage("s_fourclimb", "s");
    stage_index_add_stage("s_keyedcross", "s");
    stage_index_add_stage("s_lemonlink", "s");
    stage_index_add_stage("s_ringlocker", "s");
    stage_index_add_stage("s_theawakening", "s");
    stage_index_add_stage("s_doublepyramid", "s");
    stage_index_add_stage("s_flipbone", "s");
    stage_index_add_stage("s_bisidedX", "s");
    stage_index_add_stage("s_d2", "s");
    stage_index_add_stage("s_bulgedS", "s");
    stage_index_add_stage("s_aztecjumper", "s");
    stage_index_add_stage("s_vividlope", "s");
    stage_index_add_stage("finale", "s");
    
    // CUSTOM: STAGE SHUFFLE
    global.stage_index_to_true_code = ds_map_create();
    level_order = [];
    if (AP_is_multiworld_active()) {
        var stage_shuffle_order = global.AP_stage_shuffle_order
        if (array_length(stage_shuffle_order) != 0) {
            // go backwards so we pop in the correct  order
            for (var i = array_length(stage_shuffle_order) - 1; i >= 0; i--)
            {
                var location_id = stage_shuffle_order[i];
                var l = floor(location_id / 100) - 1;
                var s = location_id % 100;
                /*if (array_length(level_order) >= 15 && array_length(level_order) < 30) {
                    show_message(string("Stage shuffle: 2-{0} to {1}-{2} ({3})", (array_length(level_order)-14), l+1, s+1, location_id));
                }*/
                if (array_length(global.stage_order) <= l || array_length(global.stage_order[l]) <= s) {
                    show_message(string("Error: Stage shuffle: couldn't find {0}-{1}", l+1, s+1));
                } else {
                    array_push(level_order, global.stage_order[l][s]);
                    ds_map_set(global.stage_index_to_true_code, global.stage_order[l][s], [l + 1, s + 1]);
                }
            }
        }
    } else {
        // manual stage shuffle
        /*for (var l = 0; l < 11; l++)
        {
            for (var s = 0; s < ((l == 9) ? 7 : 15); s++)
            {
                array_push(level_order, global.stage_order[l][s]);
                ds_map_set(global.stage_index_to_true_code, global.stage_order[l][s], [l + 1, s + 1]);
            }
        }
        randomize();
        random_set_seed(12345, true);
        array_shuffle_ext(level_order);*/
    }
    
    if (array_length(level_order) != 0) {
        for (var l = 0; l < 11; l++)
        {
            for (var s = 0; s < ((l == 9) ? 7 : 15); s++)
            {
                var stage = array_pop(level_order);
                global.stage_order[l][s] = stage;
                ds_map_set(global.stage_index_to_level, stage, l + 1);
            }
        }
    }
    
    for (var w = 1; w <= 32; w++)
        stage_index_add_stage("sketch" + string(w), "sketch" + string(w));
    
    for (var w = 1; w <= 18; w++)
        stage_index_add_stage("can" + string(w), "can" + string(w));
    
    global.demo_stage_order = ["s_firstdiamond", "s_leaploop", "s_producecube", "s_walkoflife", "s_summit", "s_galaxy", "s_lanecapsule", "s_simplerevert", "s_funkystairs", "s_L"];
    global.demo_extended_stage_order = ["s_simplerevert", "s_bronx", "s_lanecapsule", "s_starfish", "s_opposites", "s_upupspringstairs", "s_pill"];
}
