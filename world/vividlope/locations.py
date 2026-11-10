from __future__ import annotations
from typing import TYPE_CHECKING
from BaseClasses import Entrance, Region, Location
from rule_builder.field_resolvers import FromOption
from rule_builder.options import OptionFilter
from rule_builder.rules import Has, HasAll, Rule
from .items import VividlopeItem
from .names import level_names, stage_prefixes, LocationSuffix, ItemNames
from .data import stage_data, level_clear_count, Stage
from .options import GoalUnlock

if TYPE_CHECKING:
    from .world import VividlopeWorld

class VividlopeLocation(Location):
    game = "VIVIDLOPE"

def get_location_names_with_ids(location_names: list[str]) -> dict[str, int | None]:
    table = generate_location_table()
    return {location_name: table[location_name] for location_name in location_names}

def generate_location_table() -> dict[str, int]:
    location_table = {}
    for level in range (0,11):
        # Level clear location IDs range from 200000-200010 depending on the level.
        # They are 200000+ to not clash with Stage IDs.
        location_table[f"{level_names[level]} Clear"] = 200000 + level

        for stage in range(1,16):
            # Stage location IDs take up this form: XXYYZZ
            # Where X depends on the location type:
            # 0 for generic Completion checks
            # 1-11 for D-V Ranks
            # YY is the level number: 1-9 -> 1-9, Finale -> 10, X -> 11
            # and ZZ is the stage number minus 1, 0-14.
            stage_id = (level + 1) * 100 + (stage - 1)
            location_table[f"{stage_prefixes[level]}{stage} {LocationSuffix.stage_clear}"] = stage_id
            location_table[f"{stage_prefixes[level]}{stage} {LocationSuffix.stage_d}"] = stage_id + 10000
            location_table[f"{stage_prefixes[level]}{stage} {LocationSuffix.stage_dp}"] = stage_id + 20000
            location_table[f"{stage_prefixes[level]}{stage} {LocationSuffix.stage_c}"] = stage_id + 30000
            location_table[f"{stage_prefixes[level]}{stage} {LocationSuffix.stage_cp}"] = stage_id + 40000
            location_table[f"{stage_prefixes[level]}{stage} {LocationSuffix.stage_b}"] = stage_id + 50000
            location_table[f"{stage_prefixes[level]}{stage} {LocationSuffix.stage_bp}"] = stage_id + 60000
            location_table[f"{stage_prefixes[level]}{stage} {LocationSuffix.stage_a}"] = stage_id + 70000
            location_table[f"{stage_prefixes[level]}{stage} {LocationSuffix.stage_ap}"] = stage_id + 80000
            location_table[f"{stage_prefixes[level]}{stage} {LocationSuffix.stage_s}"] = stage_id + 90000
            location_table[f"{stage_prefixes[level]}{stage} {LocationSuffix.stage_sp}"] = stage_id + 100000
            location_table[f"{stage_prefixes[level]}{stage} {LocationSuffix.stage_v}"] = stage_id + 110000

    for shop in range(0,25):
        # Shop ids are in the range 150000-150024
        location_table[f"Shop Purchase {shop + 1}"] = 150000 + shop

    return location_table

# Creates the regions that deal with the map portion of the world.
# This is the menu region, level regions, and "X-Y Entrance" Regions.
def create_map_regions(world: VividlopeWorld):
    multiworld = world.multiworld
    player = world.player

    # Overworld region
    overworld = Region("Overworld", player, multiworld)
    multiworld.regions.append(overworld)

    # Level regions
    for level in range(0, 11):
        # Create the level region
        level_region = Region(level_names[level], player, multiworld)
        multiworld.regions.append(level_region)

        # Stage entrance regions in that level
        for stage in range(0, 15):
            if level == 10 and stage >= 7:
                break # Finale only has 7 parts, so this prevents it from adding more

            # Keep in mind these are only containers for stage randomization.
            # We will connect a (random) stage region with locations in another function
            stage_region = Region(f"{stage_prefixes[level]}{stage} Entrance", player, multiworld)
            multiworld.regions.append(stage_region)
            level_region.connect(stage_region)

        # Level region rules:
        overworld_to_level = overworld.connect(level_region)
        clear_location_name = f"{level_names[level]} {LocationSuffix.level_clear}"

        # If this world is a goal, we need to make a lot of things different to account for it
        if (level == 10 and world.options.goal_condition == 0) or ( # Finale
            level == 9 and world.options.goal_condition == 1): # Level X
            world.set_rule(overworld_to_level, Has(ItemNames.level_clear_event, count=FromOption(GoalUnlock)))

            level_region.add_event(f"{clear_location_name} Goal Event", "Victory", location_type=VividlopeLocation, item_type=VividlopeItem)
            world.set_completion_rule(Has("Victory"))
        else:
            # Players can only enter the level if they have the unlock
            world.set_rule(overworld_to_level, Has(f"{level_names[level]} Unlock"))

            # Add a level clear event and event item pair for the goal
            level_region.add_event(f"{level_names[level]} {LocationSuffix.level_clear_event}", ItemNames.level_clear_event, location_type=VividlopeLocation, item_type=VividlopeItem)

            # Add the level clear location to the newly created region
            clear_location = VividlopeLocation(player, clear_location_name, world.location_name_to_id[clear_location_name], level_region)
            level_region.locations.append(clear_location)
            clear_item_name = f"{level_names[level]} {LocationSuffix.stage_clear_event} Item"
            world.set_rule(clear_location, Has(clear_item_name, count=level_clear_count[level]))

    # Shop regions
    shop_check_number = 1
    for shop in range(0, 5):
        # There are 5 shop regions which are all unlocked by having more shop upgrades.
        shop_region = Region(f"Shop Upgrade {shop}", player, multiworld)
        multiworld.regions.append(shop_region)
        overworld_to_shop = overworld.connect(shop_region)
        world.set_rule(overworld_to_shop, Has(ItemNames.shop_upgrade, count=(shop + 1)))

        # Add locations to shops
        for _ in range(0, 5):
            location_name = f"Shop Purchase {shop_check_number}"
            shop_location = VividlopeLocation(player, location_name, world.location_name_to_id[location_name], shop_region)
            shop_region.locations.append(shop_location)
            shop_check_number += 1

def attach_shuffled_levels(world: VividlopeWorld):
    multiworld = world.multiworld
    player = world.player
    # table = generate_location_table()
    stages: list[Stage] = stage_data.copy()

    # The levels only get shuffled if the option to shuffle them is on.
    # But the comments from here on out will act like they are always shuffled.
    if world.options.stage_shuffle:
        if len(world.stage_shuffle_order) != 0:
            # NOTE: This only works because all levels except Finale have 15 stages
            stages: list[Stage] = [stage_data[(stage_id // 100 - 1) * 15 + stage_id % 100] for stage_id in world.stage_shuffle_order]
        else:
            world.random.shuffle(stages)
            world.stage_shuffle_order = [stage.location_id() for stage in stages]

    stage_index = 0
    for level in range(0, 11):
        # level_region = world.get_region(level_names[level])

        for stage in range(0, 15):
            if level == 10 and stage >= 7:
                break # Finale only has 7 parts, so this prevents it from checking for extra
            entrance_region = world.get_region(f"{stage_prefixes[level]}{stage} Entrance")
            random_stage = stages[stage_index]

            # Create region from the randomly selected level
            stage_region = Region(f"{stage_prefixes[random_stage.level-1]}{random_stage.stage}", player, multiworld)
            multiworld.regions.append(stage_region)
            connection = entrance_region.connect(stage_region)

            # Assign rules
            if random_stage.req_items != None:
                world.set_rule(connection, random_stage.req_items)

            # Create an event item so we can keep track of mow many stages are beat in a level
            # for proper logic for the level clear checks.
            clear_item_name = f"{level_names[level]} {LocationSuffix.stage_clear_event} Item"
            stage_region.add_event(f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_clear_event}", clear_item_name, location_type=VividlopeLocation, item_type=VividlopeItem)

            location_names = []
            if world.options.rank_checks != 2:
                location_names.append(f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_clear}")
            if world.options.rank_checks != 0:
                all_location_names = [
                    f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_d}",
                    f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_dp}",
                    f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_c}",
                    f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_cp}",
                    f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_b}",
                    f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_bp}",
                    f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_a}",
                    f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_ap}",
                    f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_s}",
                    f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_sp}",
                    f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_v}",
                ]
                if world.options.rank_checks == 1:
                    location_name = all_location_names[world.options.max_rank_check]
                    location_names.append(location_name)
                else:
                    for n in range(0, world.options.max_rank_check+1):
                        location_name = all_location_names[n]
                        location_names.append(location_name)
            location_ids = get_location_names_with_ids(location_names)
            stage_region.add_locations(location_ids, VividlopeLocation)

            # Require items for ranks B and higher
            if random_stage.req_items_rank != None and world.options.rank_checks != 0 and world.options.max_rank_check >= 4:
                if world.options.rank_checks == 1:
                    world.set_rule(world.get_location(location_names[1]), random_stage.req_items_rank)
                else:
                    for n in range(4, world.options.max_rank_check+1):
                        location_name = location_names[n]
                        world.set_rule(world.get_location(location_name), random_stage.req_items_rank)

            stage_index += 1