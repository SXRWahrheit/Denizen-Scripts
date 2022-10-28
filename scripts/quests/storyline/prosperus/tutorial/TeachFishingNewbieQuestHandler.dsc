TeachFishingNewbieFishHandler:
    type: world
    debug: false
    events:
        on player fishes while caught_fish:
        - define data <player.uuid>_quest_data
        - define quest_internalname TeachFishingNewbie
        - define objective 1
        - if <yaml[<[data]>].contains[quests.active.TeachFishingNewbie]>:
            - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.1.objectives.1.progress:++
            - if <yaml[<[data]>].read[quests.active.TeachFishingNewbie.stages.1.objectives.1.progress]> >= 16:
                - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]> instantly
            - else:
                - run QuestProgressHandler def:<[quest_internalname]>|<[objective]> instantly

TeachFishingNewbieCompletion:
    type: task
    debug: false
    script:
    - zap DailiesAvailableCheck FishingNewbieInteract