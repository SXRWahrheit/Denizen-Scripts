UnlockShadowStunQuestDeliveryHandler:
    type: task
    debug: false
    script:
    - define stage:1
    - define quest_internalname:UnlockShadowStun
    - choose <player.item_in_hand.material.name>:
        - case redstone:
            - define objective:1
        - case ender_pearl:
            - define objective:2
        - case fermented_spider_eye:
            - define objective:3
        - case string:
            - define objective:4
        - case gold_ingot:
            - define objective:5
        - default:
            - narrate format:MagnificentMageFormat "Whenever you've got the items I'm looking for, just hand them over."
            - run QuestProgressHandler def:UnlockShadowStun
            - stop
    - inject QuestItemDeliveryHandler
    - if <[InProgress]>:
        - narrate format:MagnificentMageFormat <proc[ItemDescriptionHandler_Spells].context[<[delivery_item]>]>

UnlockShadowStunQuestExperienceDeliveryHandler:
    type: task
    debug: false
    script:
    - define stage:2
    - define quest_internalname:UnlockShadowStun
    - if <player.item_in_hand.scriptname||null> == crystallizedexperiencebillet:
        - define objective:1
        - inject QuestItemDeliveryHandler
    - else:
        - narrate format:MagnificentMageFormat "You can get a Billet of Crystallized Experience from the Arch Artificer. When you've got one, bring it over."
        
UnlockShadowStunCompletion:
    type: task
    debug: false
    script:
    - execute as_server "cast teach <player.name> ShadowStun"