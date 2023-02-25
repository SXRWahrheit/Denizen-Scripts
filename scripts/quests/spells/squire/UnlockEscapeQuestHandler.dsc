UnlockEscapeQuestDeliveryHandler:
    type: task
    debug: false
    script:
    - define stage:1
    - define quest_internalname:UnlockEscape
    - choose <player.item_in_hand.material.name>:
        - case redstone:
            - define objective:1
        - case ender_pearl:
            - define objective:2
        - case diamond:
            - define objective:3
        - case gold_ingot:
            - define objective:4
        - default:
            - narrate format:SkilledSorcererFormat "Whenever you've got the items I'm looking for, just hand them over."
            - run QuestProgressHandler def:UnlockEscape
            - stop
    - inject QuestItemDeliveryHandler
    - if <[InProgress]>:
        - narrate format:SkilledSorcererFormat <proc[ItemDescriptionHandler_Spells].context[<[delivery_item]>]>

UnlockEscapeQuestExperienceDeliveryHandler:
    type: task
    debug: false
    script:
    - define stage:2
    - define quest_internalname:UnlockEscape
    - if <player.item_in_hand.scriptname.if_null[null]> == crystallizedexperiencebillet:
        - define objective:1
        - inject QuestItemDeliveryHandler
    - else:
        - narrate format:SkilledSorcererFormat "You can get a Billet of Crystallized Experience from the Arch Artificer. When you've got one, bring it over."
        
UnlockEscapeCompletion:
    type: task
    debug: false
    script:
    - execute as_server "cast teach <player.name> Escape"