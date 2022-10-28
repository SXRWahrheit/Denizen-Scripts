EliteHuntCompletion:
    type: task
    debug: false
    script:
    - zap EliteHuntComplete WarmasterReinwaldInteract

EliteHuntHandler:
    type: world
    debug: false
    events:
        on player kills entity:
        - define data <player.uuid>_quest_data
        - define quest_internalname EliteHunt
        - define objective 1
        - if <yaml[<[data]>].contains[quests.active.<[quest_internalname]>].not>:
            - stop
        - if <context.entity.name.starts_with[<&d>]>:
            - inject QuestObjectiveProgressHandler instantly