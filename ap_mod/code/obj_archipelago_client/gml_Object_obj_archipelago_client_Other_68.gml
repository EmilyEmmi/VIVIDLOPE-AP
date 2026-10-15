/// IMPORT
if (ds_map_exists(async_load, "buffer"))
{
    var buff = ds_map_find_value(async_load, "buffer");
    buffer_seek(buff, buffer_seek_start, 0);
    var response = buffer_read(buff, buffer_string);
    var data = json_parse(response);
    
    for (var i = 0; i < array_length(data); i++)
    {
        show_debug_message("Receiving package from server")
        if (variable_struct_exists(data[i], "cmd"))
        {
            
            show_debug_message(data[i].cmd)
            if(data[i].cmd != "DataPackage")
            {
                show_debug_message(data[i])
            }
            // get archipelago multiworld
            if(global.AP_multiworld == 0)
			    global.AP_multiworld = data[0].seed_name;

            switch (data[i].cmd)
            {
                case "RoomInfo":
                    global.AP_connection_state = global.AP_ENUM_CONNECTION_STATE.GOT_ROOMINFO;
                    if (variable_struct_exists(data[i], "games"))
                    {
                        var ownGame = false;
                        for (var ii = 0; ii < array_length(data[i].games); ii++)
                        {
                            if (data[i].games[ii] == "Archipelago") continue;

                            if (data[i].games[ii] == "VIVIDLOPE")
                            {
                                if (!ownGame)
                                {
                                    ownGame = true;
                                    continue;
                                }
                            }

                            if (!array_contains(global.AP_other_games, data[i].games[ii]))
                            {
                                array_push(global.AP_other_games, data[i].games[ii])
                            }
                        }
                    }

                    AP_sendConnectionInfo();
                    break;
                case "Connected":

                    global.AP_slot = data[i].slot;
                    global.AP_team = data[i].team;
                    global.AP_connection_state = global.AP_ENUM_CONNECTION_STATE.CONNECTED;
                    global.AP_connection_errors = undefined;
                    stage_index_setup();
                    show_debug_message("Login successful!");
                    menu_set_top_caption("Connected!")
                    
                    with (obj_ap_notification_scheduler)
                        instance_destroy();

                    global.AP_all_locations_ids = array_concat(data[i].missing_locations, data[i].checked_locations);
                    global.AP_remaining_locations = data[i].missing_locations;

                    for (var ii = 0; ii < array_length(data[i].players); ii++)
                    {
                        var slot_info = variable_struct_get(data[i].slot_info, ii + 1);
                        var player = data[i].players[ii];
                        global.AP_player_names[ii + 1] = player.name;
                        global.AP_slotinfo[ii + 1] = slot_info.game;
                    }


                    global.AP_slot = data[i].slot;

                    // Settings here
                    if (variable_struct_exists(data[i].slot_data.options, "deathlink"))
                        global.AP_deathlink = data[i].slot_data.options.deathlink;
                    if (variable_struct_exists(data[i].slot_data.options, "deathlink_amnesty"))
                        global.AP_deathlink_amnesty = data[i].slot_data.options.deathlink_amnesty;
                    //if (variable_struct_exists(data[i].slot_data.options, "include_unused_items"))
                        //global.AP_include_unused_items = data[i].slot_data.options.include_unused_items;
                    
                    // get current deaths from the server
                    if global.AP_deathlink and global.AP_deathlink_amnesty > 1
                        AP_getDataStorage("current_deaths");

                    var path_settings = AP_get_save_folder_prefix()  + "settings.json"

                    if (file_exists(path_settings))
                    {
                        var file = file_text_open_read(path_settings);
                        var content = file_text_read_string(file);
                        file_text_close(file);

                        if (content != -1)
                            settings_struct = json_parse(content);

                        global.AP_deathlink = settings_struct.deathLink;
                        global.AP_deathlink_amnesty = settings_struct.deathLinkAmnesty;
                    }

                    AP_write_settings_file();
                    
                    var path_scouting = AP_get_save_folder_prefix() + "scouting.json"

                    var is_scouting_in_cache = file_exists(path_scouting)

                    if (!is_scouting_in_cache)
                    {
                        var missing_locations = data[i].missing_locations;
                        global.AP_connection_state = global.AP_ENUM_CONNECTION_STATE.WAITING_FOR_SCOUTING;
                        AP_sendLocationScouts(missing_locations);
                    }
                    else
                    {
                        var file = file_text_open_read(path_scouting);
                        var content = file_text_read_string(file);
                        file_text_close(file);

                        if (content != -1)
                            scouting_struct = json_parse(content);

                        global.AP_location_item = scouting_struct;
                        AP_postScouting();
                    }
                    
                    break;
                
                case "ConnectionRefused":
                    global.AP_connection_state = global.AP_ENUM_CONNECTION_STATE.ERROR_CONNECTION_REFUSED;
                    if (variable_struct_exists(data[i], "errors"))
                    {
                        global.AP_connection_errors = data[i].errors
                    }
                    show_debug_message("Login failed");
                    menu_set_top_caption("Connection failed")
                    break;
                
                case "ReceivedItems":
                    if (variable_struct_exists(data[i], "items"))
                    {
                        if (true)
                        {
                            global.AP_is_receiving_items = true
                            starting_index = data[i].index;

                            for (var ii = 0; ii < array_length(data[i].items); ii++)
                            {
                                global.AP_item_from_server[starting_index + ii] = data[i].items[ii].item;

                                // if starting index is not 0 then it's not the first connection packet
                                if (starting_index != 0)
                                {
                                    item_data = data[i].items[ii]

                                    playerName = global.AP_player_names[item_data.player]
                                    itemName = variable_struct_get(global.AP_id_to_itemname, string(item_data.item))

                                    AP_create_notification(string("Received {1} from {0}", playerName, itemName));
                                    //array_push(obj_archipelago_toast_notificator.current_notification, new AP_toast_notification(itemName, AP_item_flag_to_color(item_data.flags), playerName, false));
                                }
                            }

                            // idk
                            //AP_sync_item_from_server();
                            global.AP_is_receiving_items = false;
                        }
                    }
                    break;
                case "Bounced":
                    if (variable_struct_exists(data[i], "tags"))
                    {
                        for (var ii = 0; ii < array_length(data[i].tags); ii++)
                        {
                            if (data[i].tags[ii] == ("DeathLink" + global.AP_deathlink_group) && !global.AP_deathlink_protected)
                            {
                                if (global.current_stage != "overworld" && room == rm_maingame)
                                {
                                    var time;
                                    if (variable_struct_exists(data[i].data, "time"))
                                        time = data[i].data.time;
                                    else
                                        time = undefined;
                                    
                                    var source;
                                    if (variable_struct_exists(data[i].data, "source"))
                                        source = data[i].data.source;
                                    else
                                        source = undefined;

                                    var cause;
                                    if (variable_struct_exists(data[i].data, "cause"))
                                        cause = data[i].data.cause;
                                    else
                                        cause = undefined;

                                    var uuid;
                                    if (variable_struct_exists(data[i].data, "uuid"))
                                        uuid = data[i].data.uuid;
                                    else
                                        uuid = undefined;

                                    if (uuid != undefined && uuid == global.AP_uuid)
                                    {
                                        exit;
                                    }
                                    else if (source != undefined && source == global.AP_name)
                                    {
                                        exit;
                                    }

                                    global.AP_deathlink_infos = {source: source, cause: cause, time: time, uuid: uuid};
                                    global.AP_deathlink_protected = true;
                                    if (cause != undefined) {
                                        AP_create_notification(cause, true);
                                    }
                                    gstate_activate_player_ko(5); // KO player
                                    global.AP_deathlink_protected = false;
                                }
                            }
                            else if (data[i].tags[ii] == ("SharedDamage" + global.AP_damagelink_group) && data[i].data.uuid != global.AP_uuid && !global.AP_damagelink_protected)
                            {
                                if (variable_global_exists("chapter"))
                                {
                                    var time;
                                    if (variable_struct_exists(data[i].data, "time"))
                                        time = data[i].data.time;
                                    else
                                        time = undefined;
                                    
                                    var source;
                                    if (variable_struct_exists(data[i].data, "source"))
                                        source = data[i].data.source;
                                    else
                                        source = undefined;

                                    var uuid;
                                    if (variable_struct_exists(data[i].data, "uuid"))
                                        uuid = data[i].data.uuid;
                                    else
                                        uuid = undefined;

                                    var damage_points;
                                    if (variable_struct_exists(data[i].data, "damage_points"))
                                        damage_points = data[i].data.damage_points;
                                    else
                                        damage_points = 0;

                                    global.AP_damagelink_infos = {source: source, time: time, uuid: uuid, damage_points: damage_points}
                                    //AP_handle_Damagelink(); // TODO

                                }
                            }
                        }
                    }
                    break;
                case "LocationInfo":
                    if (variable_struct_exists(data[i], "locations"))
                    {
                        global.AP_connection_state = global.AP_ENUM_CONNECTION_STATE.GOT_SCOUTING;
                        global.AP_scouting_raw = data[i].locations;
                        var player_ids = [];
                        for (var ii = 0; ii < array_length(data[i].locations); ii++)
                        {
                            array_push(player_ids, data[i].locations[ii].player);
                        }

                        var player_ids_unique = array_unique(player_ids);
                        var games = ["VIVIDLOPE"];

                        for (var ii = 0; ii < array_length(player_ids_unique); ii++)
                        {
                            array_push(games, global.AP_slotinfo[player_ids_unique[ii]]);
                        }

                        var games_unique = array_unique(games);

                        global.AP_requested_datapackage = array_length(games_unique);
                        global.AP_resquest_list = games_unique;
                        global.AP_last_datapackage_requested = global.AP_resquest_list[0];
                        AP_getDataPackage([global.AP_resquest_list[0]]);
                    }
                    break;
                case "DataPackage":
                    if (variable_struct_exists(data[i], "data"))
                    {
                        global.AP_received_datapackage++;
                        AP_add_new_datapackage(data[i].data)

                        if (global.AP_received_datapackage != global.AP_requested_datapackage)
                        {
                            global.AP_last_datapackage_requested = global.AP_resquest_list[global.AP_received_datapackage]
                            AP_getDataPackage([global.AP_resquest_list[global.AP_received_datapackage]]);
                            exit;
                        }

                        global.AP_connection_state = global.AP_ENUM_CONNECTION_STATE.GOT_DATA_PACKAGE;

                        if (!file_exists(AP_get_save_folder_prefix() +  "datapackage.json"))
                        {
                            var package = global.AP_data_package_raw;
                            package_json = json_stringify(package);
                            var file = file_text_open_write(AP_get_save_folder_prefix() +  "datapackage.json");
                            file_text_write_string(file, package_json);
                            file_text_close(file);
                        }

                        if (!file_exists(AP_get_save_folder_prefix() +  "scouting.json"))
                        {
                            var scouting = {};

                            for (var ii = 0; ii < array_length(global.AP_scouting_raw); ii++)
                            {
                                var playerName; var itemName; var flags;

                                if (global.AP_scouting_raw[ii].player == global.AP_slot)
                                    playerName = "<yourself>";
                                else
                                    playerName = AP_sanitizeString(global.AP_player_names[global.AP_scouting_raw[ii].player]);

                                var gamePlayed = global.AP_slotinfo[global.AP_scouting_raw[ii].player];

                                var game_data = variable_struct_get(global.AP_data_package_raw, gamePlayed);

                                itemName = AP_sanitizeString(struct_find_key_by_value(game_data.item_name_to_id, global.AP_scouting_raw[ii].item));
                                flags = global.AP_scouting_raw[ii].flags;

                                variable_struct_set(scouting, global.AP_scouting_raw[ii].location, {playerName: playerName, itemName: itemName, flags: flags});
                            }

                            global.AP_location_item = scouting;

                            scouting_json = json_stringify(scouting);
                            var file = file_text_open_write(AP_get_save_folder_prefix() +  "scouting.json");
                            file_text_write_string(file, scouting_json);
                            file_text_close(file);
                        }
                    }

                    AP_postScouting();
                    break;
                case "Retrieved":
                    if (variable_struct_exists(data[i], "keys"))
                    {
                        var keys = variable_struct_get_names(data[i].keys);

                        if (variable_struct_exists(keys, AP_getDatastoragePrefix() + "current_deaths"))
                        {
                            global.AP_deathlink_current_deaths = variable_struct_get(keys, AP_getDatastoragePrefix() + "current_deaths")
                        }
                    }
                    break;
                /*case "SetReply":
                    if (data[i].key == AP_getDatastoragePrefix() + "completed_chapters")
                        AP_handle_retreived_completed_chapters(data[i].value)
                    break;*/

                case "ProxyDisconnect":
                    AP_disconnect();
                    break;
            }
        }
    }
}

function array_unique(array)
{
    if array_length(array) == 0 return [];
    
    var result = [array[0]];

    for (var i = 1; i < array_length(array); i++)
    {
        var unique = true;
        for (var j = 0; j < array_length(result); j++)
        {
            if (result[j] == array[i])
            {
                unique = false;
                break;
            }
        }

        if (unique)
        {
            array_push(result, array[i]);
        }
    }
    return result;
}

function array_contains(array, value)
{
    for (var i = 0; i < array_length(array); i++)
    {
        if (array[i] == value)
            return true;
    }
    return false;
}

function array_concat(array1, array2)
{
    var res = [];

    for (var i = 0; i < array_length(array1); i++)
    {
        array_push(res, array1[i]);
    }

    for (var i = 0; i < array_length(array2); i++)
    {
        array_push(res, array2[i]);
    }

    return res;
}

function struct_find_key_by_value(_struct, _value)
{
    var _keys = variable_struct_get_names(_struct);
    for (var i = 0; i < array_length(_keys); i++)
    {
        if (variable_struct_get(_struct, _keys[i]) == _value)
            return _keys[i];
    }
    return undefined;
}
