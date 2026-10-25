/// IMPORT

function AP_write_settings_file()
{
    AP_updateTags();
    
    ap_settings = 
    {
        server: global.AP_server,
        port: global.AP_port,
        name: global.AP_name,
        password: global.AP_password,
        /*settings: 
        {
            colors: global.AP_colors
        },*/
        uuid: global.AP_uuid
    };
    ap_setting_json = json_stringify(ap_settings);
    var file = file_text_open_write("ap_settings.json");
    file_text_write_string(file, ap_setting_json);
    file_text_close(file);
    // deathlink
    settings = 
    {
        deathLink: global.AP_deathlink,
        deathLinkAmnesty: global.AP_deathlink_amnesty
    }
    setting_json = json_stringify(settings);
    var file = file_text_open_write(AP_get_save_folder_prefix() +  "settings.json");
    file_text_write_string(file, setting_json);
    file_text_close(file);
}

function AP_read_settings_file()
{
    var file = file_text_open_read("ap_settings.json");
    var content = file_text_read_string(file);
    file_text_close(file);
    ap_settings_struct = -1;
    
    if (content != -1)
        ap_settings_struct = json_parse(content);
    
    return ap_settings_struct;
}

function AP_connect(isSecure = true)
{
    AP_disconnect(false);
    
    global.AP_secure = isSecure;
    global.AP_connection_state = global.AP_ENUM_CONNECTION_STATE.TRYING_TO_CONNECT;

    if (global.AP_server == "localhost")
        global.AP_secure = false;

    if (global.AP_secure)
        global.AP_socket = network_create_socket(wss);
    else
        global.AP_socket = network_create_socket(ws);

    isConnected = network_connect_raw_async(global.AP_socket, global.AP_server, global.AP_port);

    if (isConnected < 0)
    {
        global.AP_connection_state = global.AP_ENUM_CONNECTION_STATE.ERROR_CREATING_SOCKET;
        if (global.AP_secure)
        {
            AP_connect(false)
        }
        else {
            menu_set_top_caption("Connection failed")
        }
    }
    else
    {
        global.AP_connection_state = global.AP_ENUM_CONNECTION_STATE.AWAITING_ARCHIPELAGO_RESPONSE;
    }
}

function AP_sendConnectionInfo()
{
    var APgame = "VIVIDLOPE";
    var tags = AP_getTags();

    var _contents = 
    {
        cmd: "Connect",
        password: global.AP_password,
        game: APgame,
        name: global.AP_name,
        uuid: global.AP_uuid,
        items_handling: UnknownEnum.Value_7,
        tags: tags,
        version: 
        {
            class: "Version",
            major: int64(global.AP_version[0]),
            minor: int64(global.AP_version[1]),
            build: int64(global.AP_version[2])
        }
    };

    AP_internal_send_packet(_contents);
}

function AP_disconnect(showMessage = true, updateMenu = false)
{
    if (global.AP_socket != -1)
    {
        global.AP_connection_state = global.AP_ENUM_CONNECTION_STATE.DISCONNECTED;
        network_destroy(global.AP_socket);
        
        global.AP_socket = -1;
        global.AP_received_datapackage = 0;
        global.AP_requested_datapackage = 0;
        global.AP_resquest_list = [];
        global.AP_last_datapackage_requested = "";
        global.AP_is_first_sync = true;
        
        if (showMessage)
            AP_create_notification("You were disconnected from the Multiworld.");
        if (room = rm_mainmenu && instance_exists(obj_menu_screen_archipelago) && updateMenu)
            menu_set_top_caption("Connection failed");
    }
}

function AP_isAuthenticated()
{
    return global.AP_connection_state == global.AP_ENUM_CONNECTION_STATE.READY;
}

function AP_isDisconnected()
{
    return global.AP_connection_state <= global.AP_ENUM_CONNECTION_STATE.DISCONNECTED;
}

function AP_sendLocation(ids)
{
    if (!AP_isAuthenticated())
    {
        if(is_array(ids))
        {
            for (var i = 0; i < array_length(ids); i++)
            {
                array_push(global.AP_locations_during_disconnect, ids[i]);
                location_data = AP_get_location_reward_data(ids[i]);
                //array_push(obj_archipelago_toast_notificator.current_notification, new AP_toast_notification(location_data.itemName, AP_item_flag_to_color(location_data.flags), location_data.playerName, true));
                AP_create_notification(string("Sent {1} to {0}", location_data.playerName, location_data.itemName));
            }
        }
        else
        {
            array_push(global.AP_locations_during_disconnect, ids);
            location_data = AP_get_location_reward_data(ids);
            //array_push(obj_archipelago_toast_notificator.current_notification, new AP_toast_notification(location_data.itemName, AP_item_flag_to_color(location_data.flags), location_data.playerName, true));
            AP_create_notification(string("Sent {1} to {0}", location_data.playerName, location_data.itemName));
        }
    }

    var validLocations = AP_internal_verify_remaining_location_id(ids);

    if (array_length(validLocations) == 0)
        exit;

    for (var i = 0; i < array_length(validLocations); i++)
    {
        location_data = AP_get_location_reward_data(validLocations[i]);
        if (location_data.playerName != "Yourself")
        {
            //array_push(obj_archipelago_toast_notificator.current_notification, new AP_toast_notification(location_data.itemName, AP_item_flag_to_color(location_data.flags), location_data.playerName, true));
            AP_create_notification(string("Sent {1} to {0}", location_data.playerName, location_data.itemName));
        }

        for (var j = 0; j < array_length(global.AP_remaining_locations); j++)
        {
            if (global.AP_remaining_locations[j] == validLocations[i])
            {
                array_delete(global.AP_remaining_locations, j, 1)
                break;
            }
        }
    }
    
    var _contents = 
    {
        cmd: "LocationChecks",
        locations: validLocations
    };
    
    for (var i = 0; i < array_length(_contents.locations); i++)
    {
        _contents.locations[i] = int64(_contents.locations[i]);
    }

    AP_internal_send_packet(_contents);
}

/*function AP_completeChapter(chapter_number)
{
    chapter = {}

    if ((chapter_number == 2 || chapter_number == 5) && global.AP_current_route == global.AP_ENUM_CHOSEN_ROUTE.WEIRD_ROUTE)
    {
        chapter_number = string(chapter_number) + "-wr"
    }

    variable_struct_set(chapter, chapter_number, true)
    AP_setDataStorage("completed_chapters", chapter, "update", true)
}*/

function AP_getDatastoragePrefix()
{
    return string(global.AP_slot) + "_" + string(global.AP_team) + "_";
}

function AP_getDataStorage(keys, without_prefix = false)
{
    if (!AP_isAuthenticated())
        exit;

    prefixed_keys = []

    if (without_prefix)
    {
        prefixed_keys = keys
    }
    else
    {
        if (is_array(keys))
        {
            for (var i = 0; i < array_length(keys); i++)
            {
                array_push(prefixed_keys, AP_getDatastoragePrefix() + keys[i])
            }
        }
        else
        {
            array_push(prefixed_keys, AP_getDatastoragePrefix() + keys)
        }
    }

    var _contents = 
    {
        cmd: "Get",
        keys: prefixed_keys
    };

    AP_internal_send_packet(_contents);
}

function AP_setDataStorage(key, value, operation = "replace", want_reply = false, default_value = 0, without_prefix = false)
{
    if (!AP_isAuthenticated())
        exit;

    prefixed_key = without_prefix ? key : AP_getDatastoragePrefix() + key

    var _contents =
    {
        cmd: "Set",
        key: prefixed_key,
        "default": default_value,
        want_reply: want_reply,
        operations: [{operation: operation, value: value}]
    }

    AP_internal_send_packet(_contents);
}

/*function AP_initializeChapterCompletion()
{
    if (!AP_isAuthenticated())
        exit;

    completed_chapters = {};

    for (var chapter = 1; chapter <= global.AP_max_chapter; chapter++)
    {
        if (global.AP_include_chapters[chapter - 1])
        {
            if (chapter == 2 || chapter == 5)
            {
                if (global.AP_route_from_settings == global.AP_ENUM_CHOSEN_ROUTE.WEIRD_ROUTE)
                {
                    variable_struct_set(completed_chapters, string(chapter) + "-wr", false);
                }
                else if (global.AP_route_from_settings == global.AP_ENUM_CHOSEN_ROUTE.BOTH_ROUTES)
                {
                    variable_struct_set(completed_chapters, chapter, false);
                    variable_struct_set(completed_chapters, string(chapter) + "-wr", false);
                }
                else
                {
                    variable_struct_set(completed_chapters, chapter, false);
                }
            }
            else
            {
                variable_struct_set(completed_chapters, chapter, false);
            }
        }
    }

    AP_setDataStorage("completed_chapters",,"default", true, completed_chapters)
}*/

function AP_initializeCurrentLocation()
{
    if (!AP_isAuthenticated())
        exit;

    AP_setDataStorage("current_location",,"default",, {current_chapter: -1, current_room: "unknown"})
}

function AP_goal()
{
    if (!AP_isAuthenticated())
        exit;

    var _contents = 
    {
        cmd: "StatusUpdate",
        status: int64(AP_client_status.CLIENT_GOAL)
    };

    AP_internal_send_packet(_contents);
}

function AP_sendHint(ids)
{
    if (!AP_isAuthenticated())
        exit;

    var validLocations = AP_internal_verify_location_id(ids);

    if (array_length(validLocations) == 0)
        exit;

    var _contents =
    {
        cmd: "CreateHints",
        locations: validLocations
    };

    for (var i = 0; i < array_length(_contents.locations); i++)
    {
        _contents.locations[i] = int64(_contents.locations[i]);
    }

    AP_internal_send_packet(_contents);
}

function AP_sendDeathlink(text)
{
    if (!global.AP_deathlink || global.AP_deathlink_protected)
        exit;
    
    if (!AP_isAuthenticated())
        exit;
    
    
    if (global.AP_deathlink_amnesty > 1)
    {
        global.AP_deathlink_current_deaths += 1;
        AP_create_notification("KOs: " + string(global.AP_deathlink_current_deaths) + "/" + string(global.AP_deathlink_amnesty), true);
        if (global.AP_deathlink_amnesty > global.AP_deathlink_current_deaths)
        {
            AP_setDataStorage("current_deaths", global.AP_deathlink_current_deaths);
            exit;
        }
        global.AP_deathlink_current_deaths = 0;
        AP_setDataStorage("current_deaths", global.AP_deathlink_current_deaths);
    } else {
        global.AP_deathlink_current_deaths = 0;
    }

    var _contents =
    {
        cmd: "Bounce",
        tags: [("DeathLink" + global.AP_deathlink_group)],
        data:
        {
            time: int64(current_time),
            source: global.AP_name,
            uuid: global.AP_uuid,
            cause: text
        }
    };

    AP_internal_send_packet(_contents);
}

function AP_sendDamagelink(amount)
{
    if (!AP_isAuthenticated())
        exit;

    if (!global.AP_damagelink || global.AP_damagelink_protected)
        exit;

    if (amount <= 0)
        exit;

    if(global.chapter > 1 && instance_exists(obj_cutscene_master))
        exit;

    var _contents = 
    {
        cmd: "Bounce",
        tags: [("SharedDamage" + global.AP_damagelink_group)],
        data:
        {
            time: int64(current_time),
            source: global.AP_name,
            uuid: global.AP_uuid,
            damage_points: amount
        }
    }

    AP_internal_send_packet(_contents);
}

function AP_postScouting()
{
    global.AP_connection_state = global.AP_ENUM_CONNECTION_STATE.READY;
    
    AP_updateTags();
    //AP_initializeChapterCompletion();
    //AP_initializeCurrentLocation();
    AP_fill_id_to_itemname_struct();
    
    /*if (variable_global_exists("chapter"))
    {
        AP_game_start_post_connexion();
        AP_setDataStorage("current_location", {current_chapter: global.chapter, current_room: undefined}, "update")
    }
    else
    {
        AP_setDataStorage("current_location", {current_chapter: 0, current_room: undefined}, "update")
    }*/

}

function AP_fill_id_to_itemname_struct()
{
    if (array_length(global.AP_remaining_locations) == 0) exit;

    id_to_itemname_path = AP_get_save_folder_prefix() + "id_to_itemname.json"

    if (file_exists(id_to_itemname_path))
    {
        var file = file_text_open_read(id_to_itemname_path);
        var content = file_text_read_string(file);
        file_text_close(file);

        if (content != -1)
            global.AP_id_to_itemname = json_parse(content);
    }
    else
    {
        global.AP_id_to_itemname = {}
        
        if (global.AP_data_package_raw == undefined)
        {
            var file = file_text_open_read(AP_get_save_folder_prefix() + "datapackage.json");
            var content = file_text_read_string(file);
            file_text_close(file);

            if (content != -1)
                global.AP_data_package_raw = json_parse(content);
        }

        item_name_to_id = global.AP_data_package_raw.VIVIDLOPE.item_name_to_id;

        names = variable_struct_get_names(item_name_to_id);

        for (var i = 0; i < array_length(names); i++)
        {
            var name = names[i]
            var item_id = variable_struct_get(item_name_to_id, name)
            variable_struct_set(global.AP_id_to_itemname, string(item_id), name)
        }

        if (!file_exists(id_to_itemname_path))
        {
            package_json = json_stringify(global.AP_id_to_itemname);
            var file = file_text_open_write(id_to_itemname_path);
            file_text_write_string(file, package_json);
            file_text_close(file);
        }
    }

}

function AP_sendLocationScouts(ids)
{    
    var _contents =
    {
        cmd: "LocationScouts",
        locations: ids
    };

    for (var i = 0; i < array_length(_contents.locations); i++)
    {
        _contents.locations[i] = int64(_contents.locations[i]);
    }

    AP_internal_send_packet(_contents);
}

function AP_getDataPackage(games)
{
    var _contents =
    {
        cmd: "GetDataPackage",
        games: games
    };

    AP_internal_send_packet(_contents);
}

function AP_getTags()
{
    var tags = ["AP", "NoText"]

    if global.AP_deathlink
        array_push(tags, "DeathLink")

    if global.AP_damagelink
        array_push(tags, "SharedDamage" + global.AP_damagelink_group)
    
    return tags
}

function AP_updateTags()
{
    if (!AP_isAuthenticated())
        exit;

    var tags = AP_getTags();

    var _contents = 
    {
        cmd: "ConnectUpdate",
        items_handling: 7,
        tags: tags
    };
    AP_internal_send_packet(_contents);
}

function AP_internal_send_packet(content)
{
    var arr = [content];
    data = json_stringify(arr);
    var buffer = buffer_create(string_byte_length(data), buffer_fixed, 1);
    buffer_seek(buffer, buffer_seek_start, 0);
    buffer_write(buffer, buffer_text, data);

    show_debug_message("Sending package to server")
    show_debug_message(content)
    show_debug_message(content.cmd)

    var size_send = network_send_raw(global.AP_socket, buffer, buffer_tell(buffer), 2);

    // var compressed_buffer = buffer_compress(buffer, 0, buffer_tell(buffer));
    // var size_send = network_send_raw(global.AP_socket, compressed_buffer, buffer_tell(compressed_buffer), 2);

    if (AP_isAuthenticated() && size_send < 0)
    {
        AP_heartbeat();
    }

    buffer_delete(buffer)
    // buffer_delete(compressed_buffer);
}

function AP_heartbeat()
{    
    var _contents =
    {
        cmd: "Bounce",
        tags: [""],
        data: {
        }
    };

    var arr = [_contents];
    data = json_stringify(arr);
    var buffer = buffer_create(string_byte_length(data), buffer_fixed, 1);
    buffer_seek(buffer, buffer_seek_start, 0);
    buffer_write(buffer, buffer_text, data);
    var size_send = network_send_raw(global.AP_socket, buffer, buffer_tell(buffer), 2);

    // var compressed_buffer = buffer_compress(buffer, 0, buffer_tell(buffer));
    // var size_send = network_send_raw(global.AP_socket, compressed_buffer, buffer_tell(compressed_buffer), 2);

    buffer_delete(buffer)
    // buffer_delete(compressed_buffer);

    if (size_send < 0)
    {
        show_debug_message("Failed to heartbeat, connection is probably disconnected");
        AP_disconnect();
        global.AP_connection_state = global.AP_ENUM_CONNECTION_STATE.ERROR_TIMEOUT;
    }
}

function AP_internal_verify_location_id(ids)
{
    var validLocations = [];

    if (is_array(ids))
    {
        for (var i = 0; i < array_length(ids); i++)
        {
            for (var ii = 0; ii < array_length(global.AP_all_locations_ids); ii++)
            {
                if (ids[i] == global.AP_all_locations_ids[ii])
                {
                    array_push(validLocations, ids[i]);
                    break;
                }
            }
        }
    }
    else
    {
        for (var i = 0; i < array_length(global.AP_all_locations_ids); i++)
        {
            if (ids == global.AP_all_locations_ids[i])
            {
                array_push(validLocations, ids);
            }
        }
    }

    return validLocations;
}

function AP_internal_verify_remaining_location_id(ids)
{
    var validLocations = [];

    if (is_array(ids))
    {
        for (var i = 0; i < array_length(ids); i++)
        {
            for (var ii = 0; ii < array_length(global.AP_remaining_locations); ii++)
            {
                if (ids[i] == global.AP_remaining_locations[ii])
                {
                    array_push(validLocations, ids[i]);
                    break;
                }
            }
        }
    }
    else
    {
        for (var i = 0; i < array_length(global.AP_remaining_locations); i++)
        {
            if (ids == global.AP_remaining_locations[i])
            {
                array_push(validLocations, ids);
            }
        }
    }

    return validLocations;
}

function AP_add_new_datapackage(data)
{
    if (global.AP_data_package_raw == undefined)
    {
        global.AP_data_package_raw = {}
    }

    game_names = variable_struct_get_names(variable_struct_get(data, "games"))
    game_name = game_names[0]

    variable_struct_set(global.AP_data_package_raw, game_name, variable_struct_get(variable_struct_get(data, "games"), game_name))
}

function AP_create_notification(str, priority = false) {
    var o = instance_create_lay(0, 0, 2, obj_ap_notification_scheduler);
    with (o)
        text = str;
        if (priority) {
            timer = 3;
        }
}

function AP_handle_received_items(forceLoad = false) {
    // Must be in-game
    if (!forceLoad && (room == rm_mainmenu || !(global.gmode == 3 || global.gmode == 4 || global.gmode == 1 || global.gmode == 2))) {
        exit;
    }
    
    server_size = array_length(global.AP_item_from_server)
    save_size = array_length(global.AP_item_in_save)

    item_to_sync = server_size - save_size

    for (var i = save_size; i < server_size; i++)
    {
        global.AP_item_in_save[i] = global.AP_item_from_server[i];

        if (global.AP_item_from_server[i] > 0)
            AP_handle_receive_item(global.AP_item_from_server[i]);
    }

    if (global.AP_is_first_sync && server_size != 0)
    {
        global.AP_is_first_sync = false;
    }
}

function AP_handle_receive_item(item_id) {
    if (item_id >= global.AP_item_offset.elementunlock) {
        // Level elements (Buckets, etc.)
        var prop = global.AP_UNLOCKABLE_ELEMENTS[item_id - global.AP_item_offset.elementunlock];
        if (!array_contains(global.AP_unlocked_elements, prop))
            array_push(global.AP_unlocked_elements, prop);
    } else if (item_id >= global.AP_item_offset.attire) {
        if (array_length(ATTIRE_LIST) <= item_id - global.AP_item_offset.attire) {
            show_message("Got invalid attire: " + string(item_id - global.AP_item_offset.attire) + "\nPlease report this!");
            exit;
        }
        
        var clothesSet = ATTIRE_LIST[item_id - global.AP_item_offset.attire];
        for (var i = 0; i < array_length(clothesSet); i++) {
            if (string_length(clothesSet[i]) != 0) {
                shared_savedata_unlock_clothes(clothesSet[i]);
            }
        }
    } else if (item_id >= global.AP_item_offset.inventoryitem) {
        // Filler item
        var relative_id = item_id - global.AP_item_offset.inventoryitem;
        
        // This is how many items we've processed from the server
        var processedFiller = 0;
        if (!is_undefined(ds_map_find_value(global.AP_processed_filler, relative_id)))
            processedFiller = ds_map_find_value(global.AP_processed_filler, relative_id);
        processedFiller++;
        ds_map_set(global.AP_processed_filler, relative_id, processedFiller);
        
        // This is how many items were saved to the save file
        var receivedFiller = 0;
        if (!is_undefined(ds_map_find_value(global.AP_received_filler, relative_id)))
            receivedFiller = ds_map_find_value(global.AP_received_filler, relative_id);
        
        if (array_length(FILLER_LIST) <= relative_id) {
            show_message("Got invalid filler item: " + relative_id + "\nPlease report this!");
            exit;
        }
        
        // If we've processed more items than on the save file, save the new items
        if (processedFiller > receivedFiller) {
            equip_item_add(FILLER_LIST[relative_id], processedFiller - receivedFiller);
            ds_map_set(global.AP_received_filler, relative_id, processedFiller);
        }
    } else if (item_id >= global.AP_item_offset.shopupgrade) {
        // Shop upgrade
        global.AP_shop_upgrades++;
    } else if (item_id >= global.AP_item_offset.powerupunlock) {
        // Powerup
        var powerup_name = POWERUP_UNLOCK_LIST[item_id - global.AP_item_offset.powerupunlock];
        if (!array_contains(global.AP_unlocked_items, powerup_name))
            array_push(global.AP_unlocked_items, powerup_name);
    } else if (item_id >= global.AP_item_offset.levelunlock) {
        // Level unlock
        global.AP_unlocked_levels[item_id - global.AP_item_offset.levelunlock - 1] = true;
    }
}

function AP_reset_items() {
    global.AP_item_from_server = [];
    global.AP_item_in_save = [];
    global.AP_unlocked_levels = [false, false, false, false, false, false, false, false, false, false, false];
    global.AP_unlocked_items = ["bonus_fruit"];
    global.AP_unlocked_elements = [];
    global.AP_shop_upgrades = 0;
    ds_map_clear(global.AP_processed_filler);
    global.shared_savedata.unlocked_clothes = [];
}

enum UnknownEnum
{
    Value_7 = 7,
    Value_999999 = 999999
}

enum AP_client_status
{
    CLIENT_UNKNOWN = 0,
    CLIENT_CONNECTED = 5,
    CLIENT_READY = 10,
    CLIENT_PLAYING = 20,
    CLIENT_GOAL = 30
}