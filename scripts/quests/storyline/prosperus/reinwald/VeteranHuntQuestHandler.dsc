VeteranHuntCompletion:
    type: task
    debug: false
    script:
    - zap LichHuntOffer WarmasterReinwaldInteract

VeteranHuntHandler:
    type: world
    debug: false
    events:
        on player kills entity:
        - define data <player.uuid>_quest_data
        - define quest_internalname VeteranHunt
        - define objective 1
        - if <yaml[<[data]>].contains[quests.active.<[quest_internalname]>].not>:
            - stop
        - if <context.entity.name.starts_with[<&9>]>:
            - inject QuestObjectiveProgressHandler instantly