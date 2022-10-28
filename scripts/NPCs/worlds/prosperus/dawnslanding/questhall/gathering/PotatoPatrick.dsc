PotatoPatrickAssignment:
    type: assignment
    interact scripts:
    - PotatoPatrickInteract
    actions:
        on assignment:
        - teleport npc location:<npc.anchor[PotatoPatrick]>
        - trigger name:proximity state:true
        - trigger name:chat state:true

PotatoPatrickFormat:
    type: format
    format: "<gray>Potato Patrick<white><&co> <[text]>"

PotatoPatrickInteract:
    type: interact
    steps:
        PotatoQuestOffer*:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyGathering_Potatoes]>:
                        - narrate format:PotatoPatrickFormat "Hey <player.name>, got some potatoes for me?"
                        - zap PotatoQuestDeliver
                    - else if <yaml[<[data]>].contains[quests.active.DailyGathering_Potatoes].not> && <proc[QuestAvailabilityHandler].context[DailyGathering_Potatoes]>:
                        - narrate format:PotatoPatrickFormat "Hey <player.name>, we need some potatoes to feed the people of Dawn's Landing. Can you help out?"
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                - if <yaml[<[data]>].contains[quests.active.DailyGathering_Potatoes].not> && <proc[QuestAvailabilityHandler].context[DailyGathering_Potatoes]>:
                    - run QuestAcceptHandler def:DailyGathering_Potatoes
                - else if <yaml[<[data]>].contains[quests.active.DailyGathering_Carrots]>:
                    - inject DailyGathering_CarrotsQuestDeliveryHandler
            chat trigger:
                DailyGathering_PotatoesAccept:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyGathering_Potatoes].not> && <proc[QuestAvailabilityHandler].context[DailyGathering_Potatoes]>:
                        - run QuestAcceptHandler def:DailyGathering_Potatoes
        PotatoQuestDelivery:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyGathering_Potatoes]>:
                        - narrate format:PotatoPatrickFormat "Hey <player.name>, got those potatoes for me?"
                    - else:
                        - zap PotatoQuestOffer
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                - if <yaml[<[data]>].contains[quests.active.DailyGathering_Carrots]>:
                    - inject DailyGathering_CarrotsQuestDeliveryHandler

DailyGathering_PotatoesQuestDeliveryHandler:
    type: task
    debug: false
    script:
    - define stage 1
    - define quest_internalname DailyGathering_Potatoes
    - if <player.item_in_hand.material.name> == Potato:
        - define objective 1
        - inject QuestItemDeliveryHandler
        - if <[InProgress]>:
            - narrate format:PotatoPatrickFormat <proc[ItemDescriptionHandler_Gathering].context[<[delivery_item]>]>