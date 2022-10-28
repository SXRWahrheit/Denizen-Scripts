FirstMobHuntingCompletion:
    type: task
    debug: false
    script:
    - zap SkeletalRogueHuntOffer WarmasterReinwaldInteract

FirstMobHuntingHandler:
    type: world
    debug: false
    events:
        on player kills entity:
        - define data <player.uuid>_quest_data
        - define quest_internalname FirstMobHunting
        - define stage:1
        - if <yaml[<[data]>].contains[quests.active.<[quest_internalname]>].not>:
            - stop
        - choose <context.entity.entity_type>:
            - case CREEPER:
                - define objective 1
                - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress]> == 0:
                    - narrate "<green>You killed a creeper!"
                    - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:1
                    - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]>
            - case SKELETON:
                - define objective 2
                - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress]> == 0:
                    - narrate "<green>You killed a skeleton!"
                    - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:1
                    - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]>
            - case SPIDER:
                - define objective 3
                - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress]> == 0:
                    - narrate "<green>You killed a spider!"
                    - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:1
                    - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]>
            - case ZOMBIE:
                - define objective 4
                - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress]> == 0:
                    - narrate "<green>You killed a zombie!"
                    - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:1
                    - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]>