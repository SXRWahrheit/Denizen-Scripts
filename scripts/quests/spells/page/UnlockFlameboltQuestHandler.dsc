UnlockFlameboltQuestDeliveryHandler:
    type: task
    debug: false
    script:
    - define stage:1
    - define quest_internalname:UnlockFlamebolt
    - choose <player.item_in_hand.material.name>:
        - case redstone:
            - define objective:1
        - case blaze_rod:
            - define objective:2
        - case fireball:
            - define objective:3
        - case gold_ingot:
            - define objective:4
        - default:
            - narrate format:StoicSageFormat "Whenever you've got the items I'm looking for, just hand them over."
            - run QuestProgressHandler def:UnlockFlamebolt
            - stop
    - inject QuestItemDeliveryHandler
    - if <[InProgress]>:
        - narrate format:StoicSageFormat <proc[ItemDescriptionHandler_Spells].context[<[delivery_item]>]>

UnlockFlameboltQuestExperienceDeliveryHandler:
    type: task
    debug: false
    script:
    - define stage:2
    - define quest_internalname:UnlockFlamebolt
    - if <player.item_in_hand.scriptname||null> == crystallizedexperiencechunk:
        - define objective:1
        - inject QuestItemDeliveryHandler
    - else:
        - narrate format:StoicSageFormat "You can get a Chunk of Crystallized Experience from the Arch Artificer. When you've got one, bring it over."
        
UnlockFlameboltCompletion:
    type: task
    debug: false
    script:
    - execute as_server "cast teach <player.name> Flamebolt"