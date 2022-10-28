WilWheatonAssignment:
    type: assignment
    interact scripts:
    - WilWheatonInteract
    actions:
        on assignment:
        - teleport npc location:<npc.anchor[WilWheaton]>
        - trigger name:proximity state:true
        - trigger name:chat state:true

WilWheatonFormat:
    type: format
    format: "<gray>Wil Wheaton<white><&co> <[text]>"

WilWheatonInteract:
    type: interact
    steps:
        WheatQuestOffer*:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyGathering_Wheat]>:
                        - narrate format:WilWheatonFormat "Hey <player.name>, got some wheat for me?"
                        - zap WheatQuestDelivery
                    - else if <yaml[<[data]>].contains[quests.active.DailyGathering_Wheat].not> && <proc[QuestAvailabilityHandler].context[DailyGathering_Wheat]>:
                        - narrate format:WilWheatonFormat "Hey <player.name>, we need some wheat to feed the people of Dawn's Landing. Can you help out?"
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                - if <yaml[<[data]>].contains[quests.active.DailyGathering_Wheat].not> && <proc[QuestAvailabilityHandler].context[DailyGathering_Wheat]>:
                    - run QuestAcceptHandler def:DailyGathering_Wheat
                - else if <yaml[<[data]>].contains[quests.active.DailyGathering_Carrots]>:
                    - inject DailyGathering_CarrotsQuestDeliveryHandler
            chat trigger:
                DailyGathering_WheatAccept:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyGathering_Wheat].not> && <proc[QuestAvailabilityHandler].context[DailyGathering_Wheat]>:
                        - run QuestAcceptHandler def:DailyGathering_Wheat
        WheatQuestDelivery:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyGathering_Wheat]>:
                        - narrate format:WilWheatonFormat "Hey <player.name>, got that wheat for me?"
                    - else:
                        - zap WheatQuestOffer
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                - if <yaml[<[data]>].contains[quests.active.DailyGathering_Carrots]>:
                    - inject DailyGathering_CarrotsQuestDeliveryHandler

DailyGathering_WheatQuestDeliveryHandler:
    type: task
    debug: false
    script:
    - define stage 1
    - define quest_internalname DailyGathering_Wheat
    - if <player.item_in_hand.material.name> == Wheat:
        - define objective 1
        - inject QuestItemDeliveryHandler
        - if <[InProgress]>:
            - narrate format:WilWheatonFormat <proc[ItemDescriptionHandler_Gathering].context[<[delivery_item]>]>