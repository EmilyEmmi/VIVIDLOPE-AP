from collections.abc import Mapping
from typing import Any

# Imports of base Archipelago modules must be absolute.
from worlds.AutoWorld import World

# Imports of your world's files must be relative.
from . import locations, items
from . import options as vividlope_options  # rename due to a name conflict with World.options

class VIVIDLOPEWorld(World):
    """
    description
    """

    game = "VIVIDLOPE"

    options_dataclass = vividlope_options.VividlopeOptions
    options: vividlope_options.VividlopeOptions

    location_name_to_id = locations.generate_location_table()
    item_name_to_id = items.ITEM_NAME_TO_ID