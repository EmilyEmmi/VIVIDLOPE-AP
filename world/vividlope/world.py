from collections.abc import Mapping
from typing import Any

# Imports of base Archipelago modules must be absolute.
from worlds.AutoWorld import World

# Imports of your world's files must be relative.
from . import locations, items
from . import options as vividlope_options  # rename due to a name conflict with World.options

UT_SLOT_DATA_OPTION_NAMES = (
    "deathlink",
    "deathlink_amnesty",
    "goal_condition",
    "goal_unlock",
    "stage_shuffle",
    "rank_checks",
    "max_rank_check",
    "start_with_shield",
)

class VividlopeWorld(World):
    """
    description
    """

    game = "VIVIDLOPE"

    options_dataclass = vividlope_options.VividlopeOptions
    options: vividlope_options.VividlopeOptions

    location_name_to_id = locations.generate_location_table()
    item_name_to_id = items.ITEM_NAME_TO_ID

    origin_region_name = "Overworld"
    
    def pre_fill(self):
        return items.create_all_items

    def create_regions(self) -> None:
        locations.create_map_regions(self)
        locations.attach_shuffled_levels(self)

    """def set_rules(self) -> None:
        rules.set_all_rules(self)"""

    def create_items(self) -> None:
        items.create_all_items(self)

    def create_item(self, name: str) -> items.VividlopeItem:
        return items.create_item_with_correct_classification(self, name)

    def get_filler_item_name(self) -> str:
        return items.get_random_filler_item_name(self)

    def fill_slot_data(self) -> Mapping[str, Any]:
        slot_data = {
            "options": self.options.as_dict(*UT_SLOT_DATA_OPTION_NAMES),
        }
        # Add stage shuffle order to slot data
        if (self.options.stage_shuffle):
            slot_data["stage_shuffle_order"] = self.stage_shuffle_order
        return slot_data