from __future__ import annotations
from typing import TYPE_CHECKING
from BaseClasses import Item, ItemClassification
from .names import ItemNames, level_names
if TYPE_CHECKING:
    from .world import VividlopeWorld

# There's so few items in this game I just decided to give them all IDs by hand
ITEM_NAME_TO_ID = {
    "Level 1 Unlock": 0,
    "Level 2 Unlock": 1,
    "Level 3 Unlock": 2,
    "Level 4 Unlock": 3,
    "Level 5 Unlock": 4,
    "Level 6 Unlock": 5,
    "Level 7 Unlock": 6,
    "Level 8 Unlock": 7,
    "Level 9 Unlock": 8,
    "Finale Unlock": 9,
    "Level X Unlock": 10,

    ItemNames.impact_unlock.value:    20,
    ItemNames.dash_unlock.value:      21,
    ItemNames.stamp_unlock.value:     22,
    ItemNames.wrap_unlock.value:      23,
    ItemNames.balloon_unlock.value:   24,
    ItemNames.burst_unlock.value:     25,
    ItemNames.bomb_unlock.value:      26,
    ItemNames.insta_unlock.value:     27,
    ItemNames.superjump_unlock.value: 28,

    ItemNames.shop_upgrade.value: 30,

    ItemNames.impact_filler.value:    40,
    ItemNames.dash_filler.value:      41,
    ItemNames.stamp_filler.value:     42,
    ItemNames.wrap_filler.value:      43,
    ItemNames.balloon_filler.value:   44,
    ItemNames.burst_filler.value:     45,
    ItemNames.bomb_filler.value:      46
}

DEFAULT_ITEM_CLASSIFICATIONS = {
    "Level 1 Unlock": ItemClassification.progression,
    "Level 2 Unlock": ItemClassification.progression,
    "Level 3 Unlock": ItemClassification.progression,
    "Level 4 Unlock": ItemClassification.progression,
    "Level 5 Unlock": ItemClassification.progression,
    "Level 6 Unlock": ItemClassification.progression,
    "Level 7 Unlock": ItemClassification.progression,
    "Level 8 Unlock": ItemClassification.progression,
    "Level 9 Unlock": ItemClassification.progression,
    "Level X Unlock": ItemClassification.progression,
    "Finale Unlock": ItemClassification.progression,

    ItemNames.impact_unlock:    ItemClassification.progression,
    ItemNames.dash_unlock:      ItemClassification.progression,
    ItemNames.stamp_unlock:     ItemClassification.progression,
    ItemNames.wrap_unlock:      ItemClassification.progression,
    ItemNames.balloon_unlock:   ItemClassification.progression,
    ItemNames.burst_unlock:     ItemClassification.progression,
    ItemNames.bomb_unlock:      ItemClassification.progression,
    ItemNames.insta_unlock:     ItemClassification.progression,
    ItemNames.superjump_unlock: ItemClassification.progression,

    ItemNames.shop_upgrade: ItemClassification.progression,

    ItemNames.impact_filler:     ItemClassification.filler,
    ItemNames.dash_filler:       ItemClassification.filler,
    ItemNames.stamp_filler:      ItemClassification.filler,
    ItemNames.wrap_filler:       ItemClassification.filler,
    ItemNames.balloon_filler:    ItemClassification.filler,
    ItemNames.burst_filler:      ItemClassification.filler,
    ItemNames.bomb_filler:       ItemClassification.filler
}

class VividlopeItem(Item):
    game = "VIVIDLOPE"

def get_random_filler_item_name(world: VividlopeWorld) -> str:
    random = world.random.randint(0, 6)
    filler = [
        ItemNames.impact_filler,
        ItemNames.dash_filler,
        ItemNames.stamp_filler,
        ItemNames.wrap_filler,
        ItemNames.balloon_filler,
        ItemNames.burst_filler,
        ItemNames.bomb_filler
    ]
    return filler[random]

def create_item_with_correct_classification(world: VividlopeWorld, name: str) -> VividlopeItem:
    classification = DEFAULT_ITEM_CLASSIFICATIONS[name]
    return VividlopeItem(name, classification, ITEM_NAME_TO_ID[name], world.player)

def create_all_items(world: VividlopeWorld) -> None:
    itempool: list[Item] = [
        world.create_item(ItemNames.impact_unlock),
        world.create_item(ItemNames.dash_unlock),
        world.create_item(ItemNames.stamp_unlock),
        world.create_item(ItemNames.wrap_unlock),
        world.create_item(ItemNames.balloon_unlock),
        world.create_item(ItemNames.burst_unlock),
        world.create_item(ItemNames.bomb_unlock),
        world.create_item(ItemNames.insta_unlock),
        world.create_item(ItemNames.superjump_unlock),
        world.create_item(ItemNames.shop_upgrade),
        world.create_item(ItemNames.impact_filler),
        world.create_item(ItemNames.dash_filler),
        world.create_item(ItemNames.stamp_filler),
        world.create_item(ItemNames.wrap_filler),
        world.create_item(ItemNames.balloon_filler),
        world.create_item(ItemNames.burst_filler),
        world.create_item(ItemNames.bomb_filler)
    ]

    # Give the player a random level to start so they don't have 0 checks at the start of their game
    random_starting_level = world.random.randint(0, 11)
    for i in range(0, 11):
        unlock_item = world.create_item(f"{level_names[i]} Unlock")
        if i == random_starting_level:
            world.push_precollected(unlock_item)
        else:
            itempool.append(unlock_item)

    number_of_items = len(itempool)
    number_of_unfilled_locations = len(world.multiworld.get_unfilled_locations(world.player))
    needed_number_of_filler_items = number_of_unfilled_locations - number_of_items
    itempool += [world.create_filler() for _ in range(needed_number_of_filler_items)]

    world.multiworld.itempool += itempool