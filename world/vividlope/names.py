from enum import StrEnum

level_names: dict[int, str] = {
    0: "Level 1",
    1: "Level 2",
    2: "Level 3",
    3: "Level 4",
    4: "Level 5",
    5: "Level 6",
    6: "Level 7",
    7: "Level 8",
    8: "Level 9",
    9: "Finale",
    10: "Level X",
}
stage_prefixes: dict[int, str] = {
    0: "1-",
    1: "2-",
    2: "3-",
    3: "4-",
    4: "5-",
    5: "6-",
    6: "7-",
    7: "8-",
    8: "9-",
    9: "Finale Part ",
    10: "X-",
}

class LocationSuffix(StrEnum):
    level_clear = "Clear"

    stage_clear =   "Completion"
    stage_perfect = "Perfect"
    stage_d =       "D Rank"
    stage_c =       "C Rank"
    stage_b =       "B Rank"
    stage_a =       "A Rank"
    stage_s =       "S Rank"
    stage_sp =      "S+ Rank"
    stage_v =       "V Rank"

    # Event items
    stage_clear_event = "Stage Clear Event"
    level_clear_event = "Level Clear Event"

class ItemNames(StrEnum):
    # Powerup Unlocks
    impact_unlock = "Impact Unlock"
    dash_unlock = "Dash Unlock"
    stamp_unlock = "Stamp Unlock"
    wrap_unlock = "Wrap Paper Unlock"
    balloon_unlock = "Paint Balloon Unlock"
    burst_unlock = "Paint Burst Unlock" # Shop exclusive
    bomb_unlock = "Bomb Unlock"
    insta_unlock = "Instabomb Unlock" # Level exclusive
    superjump_unlock = "Superjump Unlock" # Level exclusive

    # Filler unlocks
    impact_filler   = "[Filler]: Impact"
    dash_filler     = "[Filler]: Dash"
    stamp_filler    = "[Filler]: Stamp"
    wrap_filler     = "[Filler]: Wrap Paper"
    balloon_filler  = "[Filler]: Paint Balloon"
    burst_filler    = "[Filler]: Paint Burst"
    bomb_filler     = "[Filler]: Bomb"

    # Shop upgrades
    shop_upgrade = "Progressive Shop Upgrade"

    # Events
    level_clear_event = "Level Clear Event Item"

item_id_to_unlock: dict[int, str] = {
    0: ItemNames.impact_unlock,
    1: ItemNames.dash_unlock,
    2: ItemNames.stamp_unlock,
    3: ItemNames.wrap_unlock,
    4: ItemNames.balloon_unlock,
    5: ItemNames.burst_unlock,
    6: ItemNames.bomb_unlock,
    7: ItemNames.insta_unlock,
    8: ItemNames.superjump_unlock,
}