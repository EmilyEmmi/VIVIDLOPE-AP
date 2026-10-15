/// IMPORT

function AP_get_save_folder_prefix(version = -1)
{
    return "Archipelago/" + string(global.AP_multiworld) + "_" + string(global.AP_team) + "_" + string(global.AP_slot) + "/";
}