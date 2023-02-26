CarrotCarlAssignment:
    type: assignment
    interact scripts:
    - CarrotCarlInteract
    actions:
        on assignment:
        - teleport npc location:<npc.anchor[CarrotCarl]>
        - trigger name:proximity state:true
        - trigger name:chat state:true

CarrotCarlFormat:
    type: format
    format: <gray>Carrot Carl<white><&co> <[text]>

CarrotCarlInteract:
    type: interact
    steps:
        CarrotQuestOffer*:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyGathering_Carrots]>:
                        - narrate format:CarrotCarlFormat "Hey <player.name>, got some carrots for me?"
                        - zap CarrotQuestDelivery
                    - else if <yaml[<[data]>].contains[quests.active.DailyGathering_Carrots].not> && <proc[QuestAvailabilityHandler].context[DailyGathering_Carrots]>:
                        - narrate format:CarrotCarlFormat "Hey <player.name>, we need some carrots to feed the people of Dawn's Landing. Can you help out?"
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                - if <yaml[<[data]>].contains[quests.active.DailyGathering_Carrots].not> && <proc[QuestAvailabilityHandler].context[DailyGathering_Carrots]>:
                    - run QuestAcceptHandler def:DailyGathering_Carrots
                - else if <yaml[<[data]>].contains[quests.active.DailyGathering_Carrots]>:
                    - inject DailyGathering_CarrotsQuestDeliveryHandler
            chat trigger:
                DailyGathering_CarrotsAccept:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyGathering_Carrots].not> && <proc[QuestAvailabilityHandler].context[DailyGathering_Carrots]>:
                        - run QuestAcceptHandler def:DailyGathering_Carrots

        CarrotQuestDelivery:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyGathering_Carrots]>:
                        - narrate format:CarrotCarlFormat "Hey <player.name>, got those carrots for me?"
                    - else:
                        - zap CarrotQuestOffer
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                - if <yaml[<[data]>].contains[quests.active.DailyGathering_Carrots]>:
                    - inject DailyGathering_CarrotsQuestDeliveryHandler

DailyGathering_CarrotsQuestDeliveryHandler:
    type: task
    debug: false
    script:
    - define stage 1
    - define quest_internalname DailyGathering_Carrots
    - if <player.item_in_hand.material.name> == carrot:
        - define objective 1
        - inject QuestItemDeliveryHandler
        - if <[InProgress]>:
            - narrate format:CarrotCarlFormat <proc[ItemDescriptionHandler_Gathering].context[<[delivery_item]>]>