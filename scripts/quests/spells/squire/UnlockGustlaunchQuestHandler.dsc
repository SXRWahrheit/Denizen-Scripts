UnlockGustlaunchQuestDeliveryHandler:
    type: task
    debug: false
    script:
    - define stage:1
    - define quest_internalname:UnlockGustlaunch
    - choose <player.item_in_hand.material.name>:
        - case redstone:
            - define objective:1
        - case feather:
            - define objective:2
        - case ender_pearl:
            - define objective:3
        - case diamond:
            - define objective:4
        - case gold_ingot:
            - define objective:5
        - default:
            - narrate format:SkilledSorcererFormat "Whenever you've got the items I'm looking for, just hand them over."
            - run QuestProgressHandler def:UnlockGustlaunch
            - stop
    - inject QuestItemDeliveryHandler
    - if <[InProgress]>:
        - narrate format:SkilledSorcererFormat <proc[ItemDescriptionHandler_Spells].context[<[delivery_item]>]>

UnlockGustlaunchQuestExperienceDeliveryHandler:
    type: task
    debug: false
    script:
    - define stage:2
    - define quest_internalname:UnlockGustlaunch
    - if <player.item_in_hand.script.name.if_null[null]> == crystallizedexperiencebillet:
        - define objective:1
        - inject QuestItemDeliveryHandler
    - else:
        - narrate format:SkilledSorcererFormat "You can get a Billet of Crystallized Experience from the Arch Artificer. When you've got one, bring it over."

UnlockGustlaunchCompletion:
    type: task
    debug: false
    script:
    - execute as_server "cast teach <player.name> Gustlaunch"