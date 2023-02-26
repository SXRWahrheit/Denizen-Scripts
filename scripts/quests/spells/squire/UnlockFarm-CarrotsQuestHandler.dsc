UnlockFarm_CarrotsQuestDeliveryHandler:
    type: task
    debug: false
    script:
    - define stage:1
    - define quest_internalname:UnlockFarm_Carrots
    - choose <player.item_in_hand.material.name>:
        - case redstone:
            - define objective:1
        - case carrot:
            - define objective:2
        - case glowstone:
            - define objective:3
        - case gold_ingot:
            - define objective:4
        - default:
            - narrate format:SkilledSorcererFormat "Whenever you've got the items I'm looking for, just hand them over."
            - run QuestProgressHandler def:UnlockFarm_Carrots
            - stop
    - inject QuestItemDeliveryHandler
    - if <[InProgress]>:
        - narrate format:SkilledSorcererFormat <proc[ItemDescriptionHandler_Spells].context[<[delivery_item]>]>

UnlockFarm_CarrotsQuestExperienceDeliveryHandler:
    type: task
    debug: false
    script:
    - define stage:2
    - define quest_internalname:UnlockFarm-Carrots
    - if <player.item_in_hand.script.name.if_null[null]> == crystallizedexperiencebillet:
        - define objective:1
        - inject QuestItemDeliveryHandler
    - else:
        - narrate format:SkilledSorcererFormat "You can get a Billet of Crystallized Experience from the Arch Artificer. When you've got one, bring it over."

UnlockFarm_CarrotsCompletion:
    type: task
    debug: false
    script:
    - execute as_server "cast teach <player.name> Farm-Carrots"