LichHuntCompletion:
    type: task
    debug: false
    script:
    - zap EliteHuntOffer WarmasterReinwaldInteract

LichHuntHandler:
    type: world
    debug: false
    events:
        on player kills entity:
        - define data <player.uuid>_quest_data
        - define quest_internalname LichHunt
        - define objective 1
        - if <yaml[<[data]>].contains[quests.active.LichHunt].not>:
            - stop
        - if <context.entity.mythicmob.internal_name.if_null[null]> == Lich:
            - inject QuestObjectiveProgressHandler instantly