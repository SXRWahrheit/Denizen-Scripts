MelonMattAssignment:
    type: assignment
    interact scripts:
    - MelonMattInteract
    actions:
        on assignment:
        - teleport npc location:<npc.anchor[MelonMatt]>
        - trigger name:proximity state:true
        - trigger name:chat state:true

MelonMattFormat:
    type: format
    format: "<gray>Melon Matt<white><&co> <[text]>"

MelonMattInteract:
    type: interact
    steps:
        MelonQuestOffer*:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyGathering_Melons]>:
                        - narrate format:MelonMattFormat "Hey <player.name>, got some melons for me?"
                        - zap MelonQuestDelivery
                    - else if <yaml[<[data]>].contains[quests.active.DailyGathering_Melons].not> && <proc[QuestAvailabilityHandler].context[DailyGathering_Melons]>:
                        - narrate format:MelonMattFormat "Hey <player.name>, we need some melons to feed the people of Dawn's Landing. Can you help out?"
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                - if <yaml[<[data]>].contains[quests.active.DailyGathering_Melons].not> && <proc[QuestAvailabilityHandler].context[DailyGathering_Melons]>:
                    - run QuestAcceptHandler def:DailyGathering_Melons
                - else if <yaml[<[data]>].contains[quests.active.DailyGathering_Carrots]>:
                    - inject DailyGathering_CarrotsQuestDeliveryHandler
            chat trigger:
                DailyGathering_MelonsAccept:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyGathering_Melons].not> && <proc[QuestAvailabilityHandler].context[DailyGathering_Melons]>:
                        - run QuestAcceptHandler def:DailyGathering_Melons
        MelonQuestDelivery:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyGathering_Melons]>:
                        - narrate format:MelonMattFormat "Hey <player.name>, got those melons for me?"
                    - else:
                        - zap MelonQuestOffer
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                - if <yaml[<[data]>].contains[quests.active.DailyGathering_Carrots]>:
                    - inject DailyGathering_CarrotsQuestDeliveryHandler

DailyGathering_MelonsQuestDeliveryHandler:
    type: task
    debug: false
    script:
    - define stage 1
    - define quest_internalname DailyGathering_Melons
    - if <player.item_in_hand.material.name> == Melon:
        - define objective 1
        - inject QuestItemDeliveryHandler
        - if <[InProgress]>:
            - narrate format:MelonMattFormat <proc[ItemDescriptionHandler_Gathering].context[<[delivery_item]>]>