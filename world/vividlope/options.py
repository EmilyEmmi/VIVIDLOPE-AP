from dataclasses import dataclass

from Options import Choice, OptionGroup, PerGameCommonOptions, Range, Toggle

class DeathLink(Toggle):
    """
    When you get KOed, all other players with Deathlink enabled receive a death, and vice versa.
    """
    display_name = "DeathLink"

class DeathLinkAmnesty(Range):
    """
    You won't send a DeathLink until you are KOed this many times.
    Since it is very easy to get KOed in this game, playing with this set to 1 is not recommended.
    """
    display_name = "DeathLink Amnesty"
    range_start = 1
    range_end = 50
    default = 5

class GoalCondition(Choice):
    """
    The win/victory condition for this world.
    finale: Goal when the Finale is cleared.
    level_x: Goal when Level X is fully cleared.
    """
    display_name = "Goal Condition"
    option_finale = 0
    option_level_x = 1
    default = 0

class GoalUnlock(Range):
    """
    The number of levels you need to clear to automatically unlock your goal.
    If your goal condition is Level X, Finale counts as clearing a level.
    """
    display_name = "Clears Until Unlock"

    range_start = 1
    range_end = 9
    default = 6

class StageShuffle(Toggle):
    """
    Whether stages are shuffled to be in a random order.
    """
    display_name = "Shuffle Stages"

class RankChecks(Choice):
    """
    Splits Stage Completion checks into multiple checks depending on rank.
    You earn them by completing a level and reaching that rank or above.
    none: No rank checks, only one check for clearing the stage.
    partial: One check for clearing the stage, one check for reaching the max rank (defined by max_rank_check below).
    full: One check for each rank, starting from D rank up to the max rank, excluding include plus ranks with the exception of S+. Note that this can SIGNIFICANTLY increase the number of locations, so use with caution!
    
    """
    display_name = "Rank Checks"
    option_none = 0
    option_partial = 1
    option_full = 2
    default = 0

class MaxRankCheck(Choice):
    """
    The max rank expected for rank checks. Earning a V rank requires playing in Hard.
    Plus ranks other than S+ (written as sp) are excluded.
    """
    display_name = "Rank Checks"
    option_d = 0
    option_c = 1
    option_b = 2
    option_a = 3
    option_s = 4
    option_sp = 5
    option_v = 6
    default = 4

@dataclass
class VividlopeOptions(PerGameCommonOptions):
    deathlink: DeathLink
    deathlink_amnesty: DeathLinkAmnesty
    goal_condition: GoalCondition
    goal_unlock: GoalUnlock
    stage_shuffle: StageShuffle
    rank_checks: RankChecks
    max_rank_check: MaxRankCheck