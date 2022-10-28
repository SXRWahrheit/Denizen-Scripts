SkeletalRogueHuntCompletion:
    type: task
    debug: false
    script:
    - zap VeteranHuntOffer WarmasterReinwaldInteract

SkeletalRogueHuntHandler:
    type: world
    debug: false
    events:
        on player kills entity:
        - define data <player.uuid>_quest_data
        - define quest_internalname SkeletalRogueHunt
        - define objective 1
        - if <yaml[<[data]>].contains[quests.active.SkeletalRogueHunt].not>:
            - stop
        - if <context.entity.mythicmob.internal_name||null> == SkeletalRogue:
            - inject QuestObjectiveProgressHandler instantly