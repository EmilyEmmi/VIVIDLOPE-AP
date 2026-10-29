/// IMPORT
persistent = 1;
wss = 7;
ws = 6;

global.AP_ENUM_CONNECTION_STATE = {
    ERROR_TIMEOUT: -3,
    ERROR_CONNECTION_REFUSED: -2,
    ERROR_CREATING_SOCKET: -1,
    DISCONNECTED: 0,
    TRYING_TO_CONNECT: 1,
    AWAITING_ARCHIPELAGO_RESPONSE: 2,
    GOT_ROOMINFO : 3,
    CONNECTED: 4,
    WAITING_FOR_SCOUTING: 5,
    GOT_SCOUTING: 6,
    GOT_DATA_PACKAGE: 7,
    READY: 8
}

global.AP_version = get_version();
global.AP_connection_state = global.AP_ENUM_CONNECTION_STATE.DISCONNECTED;
global.AP_heartbeat_timer = 10 * 30;
global.AP_socket = -1;
global.AP_name = "Player";
global.AP_slot = 0;
global.AP_team = 0;
global.AP_player_names = ["Archipelago"];
global.AP_slotinfo = ["Archipelago"];
global.AP_scouting_raw = undefined;
global.AP_data_package_raw = undefined;
global.AP_id_to_itemname = undefined;
global.AP_server = "127.0.0.1";
global.AP_port = 38281;
global.AP_password = "";
global.AP_secure = false;
global.AP_connect_deadline = 10 * 30;
global.AP_item_from_server = [];
global.AP_item_in_save = [];
global.AP_is_receiving_items = false;
global.AP_is_first_sync = true;
global.AP_locations_during_disconnect = [];
global.AP_deathlink = false;
global.AP_deathlink_protected = false;
global.AP_deathlink_infos = {source: undefined, cause: undefined, time: undefined, uuid: undefined};
global.AP_deathlink_group = ""
global.AP_deathlink_amnesty = 5;
global.AP_deathlink_current_deaths = 0;
global.AP_damagelink = false;
global.AP_damagelink_protected = false;
global.AP_damagelink_infos = {source: undefined, uuid: undefined, damage_points: undefined, time: undefined};
global.AP_damagelink_group = ""
global.AP_multiworld = 0;
global.AP_all_locations_ids = [];
global.AP_remaining_locations = [];
global.AP_connection_errors = undefined;
global.AP_sync = true;
global.AP_sync_output_done = false;
global.AP_received_datapackage = 0;
global.AP_requested_datapackage = 0;
global.AP_resquest_list = [];
global.AP_last_datapackage_requested = "";
/*global.AP_colors = 
{
    filler: "00FFFF",
    progression: "800080",
    useful: "0000FF",
    trap: "FF0000",
    useful_progression: "FFFF00"
};*/
global.AP_item_offset =
{
    levelunlock: 0,
    powerupunlock: 20,
    shopupgrade: 40,
    inventoryitem: 50,
    attire: 70,
    elementunlock: 100,
    enemytrap: 110,
};
// Game specific
global.AP_unlocked_levels = [false, false, false, false, false,false, false, false, false, false, false];
global.AP_shop_upgrades = 0;
global.AP_unlocked_items = ["bonus_fruit", "1up"];
global.AP_unlocked_elements = [];
global.AP_enemy_trap_queue = [];
global.AP_stored_enemy_trap_queue = [];
global.AP_stage_shuffle_order = [];
global.AP_goal_condition = 0;
global.AP_goal_unlock = 0;
global.AP_nerfed_finale = true;
global.AP_override_level_x_reveal = false;
global.AP_received_filler = ds_map_create();
global.AP_processed_filler = ds_map_create();

global.AP_other_games = []

global.AP_POWERUP_OBJ_MAP = {
    "impact": obj_powerup_impact,
    "dash": obj_powerup_dash,
    "stamphammer": obj_powerup_stamphammer,
    "wrap_paper": obj_powerup_wrap_paper,
    "paint_balloon": obj_powerup_paint_balloon,
    "paint_burst": obj_powerup_paint_burst,
    "bomb": obj_powerup_bomb,
    "instant_bomb": obj_powerup_instant_bomb,
    "superjump": obj_powerup_superjump,
    "shield": obj_powerup_shield,
    "bonus_fruit": obj_powerup_cherry,
    "1up": obj_powerup_extra_life,
};

global.AP_UNLOCKABLE_ELEMENTS = [
    1, // Flower
    2, // Roller
    9, // Bucket
    16, // Bubble
    21, // Snowman
];

global.AP_ENEMY_TRAP_LIST = [
    obj_blib,
    obj_draco,
    obj_fuse,
    obj_gero,
    obj_viruse,
    obj_parrot,
    obj_prodigy,
    obj_remover,
    obj_ufo,
    obj_vlad,
];

POWERUP_UNLOCK_LIST = [
    "impact",
    "dash",
    "stamphammer",
    "wrap_paper",
    "paint_balloon",
    "paint_burst",
    "bomb",
    "instant_bomb",
    "superjump",
    "max_power",
    "good_shoes",
    "shield",
];

FILLER_LIST = [
    "impact",
    "dash",
    "stamphammer",
    "wrap_paper",
    "paint_balloon",
    "paint_burst",
    "bomb",
    "max_power",
    "good_shoes",
    "1up",
];

ATTIRE_LIST = [
    ["cerise_hat_blue",         "ecru_hat_white",       "missnoir_hat_azure"],
    ["cerise_hat_green",        "ecru_hat_red",         "missnoir_hat_spearmint"],
    ["cerise_hat_pink",         "ecru_hat_green",       "missnoir_hat_lavender"],
    ["cerise_hat_orange",       "ecru_hat_yellow",      "missnoir_hat_chocolate"],
    ["cerise_hat_purple",       "ecru_hat_blue",        "missnoir_hat_amber"],
    ["cerise_hat_beige",        "ecru_hat_gift",        "missnoir_hat_silk"],
    ["cerise_hat_denim",        "",                     "missnoir_hat_denim"],
    ["cerise_hat_tracksuit",    "",                     "missnoir_hat_amaranth"],
    ["cerise_hat_wood",         "ecru_hat_wood",        "missnoir_hat_mahogany"],
    ["cerise_hat_zigzag",       "ecru_hat_zigzag",      "missnoir_hat_zigzag"],
    ["cerise_hat_buoy",         "ecru_hat_wet",         "missnoir_hat_salmon"],
    ["cerise_hat_contrast",     "ecru_hat_camo",        "missnoir_hat_contrast"],
    ["cerise_hat_sunshine",     "ecru_hat_charcoal",    "missnoir_hat_fiery"],
    ["cerise_hat_icey",         "ecru_hat_ice",         "missnoir_hat_aurora"],
    ["cerise_hat_scottish",     "ecru_hat_polka",       "missnoir_hat_scottish"],
    ["cerise_hat_elegant",      "ecru_hat_tinfoil",     "missnoir_hat_slate"],
    ["cerise_hat_arcade",       "ecru_hat_arcade",      "missnoir_hat_moonlight"],
    ["cerise_hat_lollipop",     "ecru_hat_twist",       "missnoir_hat_crimson"],
    ["cerise_hat_pastel",       "ecru_hat_chicken",     "missnoir_hat_pop"],
    ["cerise_hat_angel",        "ecru_hat_angel",       "missnoir_hat_angel"],
    ["cerise_hat_hat",          "ecru_hat_banana",      "missnoir_hat_cursed"],
    ["",                        "",                     "missnoir_hat_noise"],
    ["cerise_hat_fuzzy",        "ecru_hat_gaudy",       "missnoir_hat_fuzzy"],
    ["cerise_hat_recycle",      "ecru_hat_vintage",     "missnoir_hat_time"],
    ["cerise_hat_black",        "ecru_hat_gold",        "missnoir_hat_red"],
]

step = 0;

randomise();

event_user(0);

if (!file_exists("ap_settings.json"))
{
    ap_settings_struct = 
    {
        server: "archipelago.gg",
        port: "38281",
        name: "Player",
        password: "",
        /*settings: 
        {
            colors: global.AP_colors
        },*/
        uuid: generate_uuidv4()
    };
    ap_setting_json = json_stringify(ap_settings_struct);
    var file = file_text_open_write("ap_settings.json");
    file_text_write_string(file, ap_setting_json);
    file_text_close(file);
}

ap_settings = AP_read_settings_file();
global.AP_server = ap_settings.server;
global.AP_port = ap_settings.port;
global.AP_name = ap_settings.name;
global.AP_password = ap_settings.password;
//global.AP_colors = ap_settings.settings.colors;

if (variable_struct_exists(ap_settings, "uuid") && ap_settings.uuid != "EC0EE80E-B5CB-4148-BA5F-0FB2177F0707")
{
    global.AP_uuid = ap_settings.uuid;
}
else
{
    global.AP_uuid = generate_uuidv4()
}