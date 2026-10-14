from dataclasses import dataclass

from Options import Choice, OptionGroup, PerGameCommonOptions, Range, Toggle

class GoalCondition(Choice):
    """
    The win/victory condition for this world.
    finale: Goal when the Finale is cleared.
    level_x: Goal when Level X is fully cleared.
    """
    display_name = "Goal Condition"

    finale = 0
    level_x = 1

    default = finale

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
    Splits Stage Completion checks into several checks, one for each rank (excluding E-Rank).
    You earn them by completing a level and reaching that rank or above.
    none: No rank checks, only one check for clearing the stage.
    partial: Split checks into D-S ranks, and only 1 check for a perfect rank (S+/V).
    full: Split checks into D-V ranks. S+ and V ranks are separate checks.
    """
    display_name = "Rank Checks"

    none = 0
    partial = 1
    full = 2

    default = none

@dataclass
class VividlopeOptions(PerGameCommonOptions):
    goal_condition: GoalCondition
    goal_unlock: GoalUnlock
    stage_shuffle: StageShuffle
    rank_checks: RankChecks