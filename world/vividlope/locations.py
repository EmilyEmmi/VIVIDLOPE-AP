from __future__ import annotations
from typing import TYPE_CHECKING
from BaseClasses import Entrance, Region, Location
from rule_builder.options import OptionFilter
from rule_builder.rules import Has, HasAll, Rule
from . import items
from .names import level_names, stage_prefixes, LocationSuffix, ItemNames, item_id_to_unlock
from .data import stage_data, Stage

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
        # Level clear location IDs range from 90000-90010 depending on the level.
        # They are 9000+ to not clash with Stage IDs.
        location_table[f"{level_names[level]} Clear"] = 90000 + level

        for stage in range(1,16):
            # Stage location IDs take up this form: XYYZZ
            # Where X depends on the location type:
            # 0 for generic Completion checks
            # 1 for Perfect checks (combination S+/V rank if that option is set)
            # 2-8 for D-V Ranks
            # YY is the level number: 1-9 -> 0-8, X -> 9, Finale -> 10
            # and ZZ is the stage number minus 1, 0-14.
            stage_id = level * 100 + (stage - 1)
            location_table[f"{stage_prefixes[level]}{stage} {LocationSuffix.stage_clear}"] = stage_id
            location_table[f"{stage_prefixes[level]}{stage} {LocationSuffix.stage_perfect}"] = stage_id + 10000
            location_table[f"{stage_prefixes[level]}{stage} {LocationSuffix.stage_d}"] = stage_id + 20000
            location_table[f"{stage_prefixes[level]}{stage} {LocationSuffix.stage_c}"] = stage_id + 30000
            location_table[f"{stage_prefixes[level]}{stage} {LocationSuffix.stage_b}"] = stage_id + 40000
            location_table[f"{stage_prefixes[level]}{stage} {LocationSuffix.stage_a}"] = stage_id + 50000
            location_table[f"{stage_prefixes[level]}{stage} {LocationSuffix.stage_s}"] = stage_id + 60000
            location_table[f"{stage_prefixes[level]}{stage} {LocationSuffix.stage_sp}"] = stage_id + 70000
            location_table[f"{stage_prefixes[level]}{stage} {LocationSuffix.stage_v}"] = stage_id + 80000

    return location_table

# Creates the regions that deal with the map portion of the world.
# This is the menu region, level regions, and "X-Y Entrance" Regions.
def create_map_regions(world: VividlopeWorld):
    table = generate_location_table()
    multiworld = world.multiworld
    player = world.player

    overworld = Region("Overworld", player, multiworld)
    multiworld.regions.append(overworld)

    # Level regions
    for level in range(0, 11):
        level_region = Region(level_names[level], player, multiworld)
        multiworld.regions.append(level_region)

        # Players can only enter the level if they have the unlock
        overworld_to_level = overworld.connect(level_region)
        world.set_rule(overworld_to_level, Has(f"{level_names[level]} Unlock"))

        # Stage entrance regions in that level
        for stage in range(0, 15):
            if level == 9 and stage >= 7:
                break # Finale only has 7 parts, so this prevents it from adding more

            # Keep in mind these are only containers for stage randomization.
            # We will connect a (random) stage region with locations in another function
            stage_region = Region(f"{stage_prefixes[level]}{stage} Entrance", player, multiworld)
            multiworld.regions.append(stage_region)
            overworld.connect(stage_region)

    # Shop regions
    shop_regions = []
    for upgrade in range(0, 15):
        # I picked 15 shop upgrades completely arbitrarily.
        # You can change this, or maybe you'll want to make it an option instead
        upgrade_region = Region(f"Shop Upgrade {upgrade}", player, multiworld)
        shop_regions.append(upgrade_region)
        if upgrade > 0:
            shop_regions[upgrade - 1].connect(upgrade_region)
        else:
            overworld.connect(upgrade_region)

def attach_shuffled_levels(world: VividlopeWorld):
    multiworld = world.multiworld
    player = world.player
    table = generate_location_table()
    stages: list[Stage] = stage_data

    # The levels only get shuffled if the option to shuffle them is on.
    # But the comments from here on out will act like they are always shuffled.
    if world.options.stage_shuffle:
        world.random.shuffle(stages)

    stage_index = 0
    for level in range(0, 11):
        level_region = world.get_region(level_names[level])

        # Create an event item so we can keep track of mow many stages are beat in a level
        # for proper logic for the level clear checks.
        clear_location_name = f"{level_names[level]} {LocationSuffix.level_clear}"
        clear_location = VividlopeLocation(player, clear_location_name, world.location_name_to_id[clear_location_name], level_region)

        level_region.locations.append(clear_location)
        clear_item_name = f"{level_names[level]} Clear Event Item"
        if level == 9: # Finale
            world.set_rule(clear_location, Has(clear_item_name, count=7))
        else: # Others
            world.set_rule(clear_location, Has(clear_item_name, count=15))

        for stage in range(0, 15):
            if level == 9 and stage >= 7:
                break # Finale only has 7 parts, so this prevents it from checking for extra
            entrance_region = world.get_region(f"{stage_prefixes[level]}{stage} Entrance")
            random_stage = stages[stage_index]

            # Create region from the randomly selected level
            stage_region = Region(f"{stage_prefixes[random_stage.level-1]}{random_stage.stage}", player, multiworld)
            multiworld.regions.append(stage_region)
            connection = entrance_region.connect(stage_region)

            # Assign rules
            if len(random_stage.req_items) != 0:
                all_items = list[str]
                for item in random_stage.req_items:
                    all_items.append(item_id_to_unlock[item])
                world.set_rule(connection, HasAll(all_items))

            # Create and attach locations to the newly created region
            stage_region.add_event(f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} Clear Event", clear_item_name, location_type=VividlopeLocation, item_type=items.VividlopeItem)

            location_names = []
            if world.options.rank_checks == 0:
                location_names = get_location_names_with_ids(f"{stage_prefixes[random_stage.level]}{random_stage.stage} {LocationSuffix.stage_clear}")
            elif world.options.rank_checks == 1:
                location_names = get_location_names_with_ids([
                    f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_d}",
                    f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_c}",
                    f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_b}",
                    f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_a}",
                    f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_s}",
                    f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_perfect}",
                ])
            else:
                location_names = get_location_names_with_ids([
                    f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_d}",
                    f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_c}",
                    f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_b}",
                    f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_a}",
                    f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_s}",
                    f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_sp}",
                    f"{stage_prefixes[random_stage.level-1]}{random_stage.stage} {LocationSuffix.stage_v}",
                ])
            stage_region.add_locations(location_names, VividlopeLocation)

            stage_index += 1