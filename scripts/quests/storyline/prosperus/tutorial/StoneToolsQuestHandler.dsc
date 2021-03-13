StoneToolsCompletion:
    type: task
    debug: false
    script:
    - zap LeatherArmorOffer QuestMasterInteract

StoneToolsQuestCraftingHandler:
    type: world
    debug: false
    events:
        on player crafts stone_*:
        - define data <player.uuid>_quest_data
        - define quest_internalname:StoneTools
        - define stage:1
        - if <yaml[<[data]>].contains[quests.active.<[quest_internalname]>].not>:
            - stop
        - choose <context.item.material.name>:
            - case stone_axe:
                - define objective:1
                - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress]> == 0:
                    - narrate "<green>You crafted a Stone Axe!"
                    - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:1
                    - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]>
            - case stone_pickaxe:
                - define objective:2
                - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress]> == 0:
                    - narrate "<green>You crafted a Stone Pickaxe!"
                    - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:1
                    - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]>
            - case stone_shovel:
                - define objective:3
                - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress]> == 0:
                    - narrate "<green>You crafted a Stone Shovel!"
                    - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:1
                    - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]>
            - case stone_sword:
                - define objective:4
                - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress]> == 0:
                    - narrate "<green>You crafted a Stone Sword!"
                    - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:1
                    - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]>
            - case stone_hoe:
                - define objective:5
                - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress]> == 0:
                    - narrate "<green>You crafted a Stone Hoe!"
                    - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:1
                    - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]>

StoneToolsQuestDeliveryHandler:
    type: task
    debug: false
    definitions: data
    script:
    - define stage:2
    - define quest_internalname:StoneTools
    - if <player.item_in_hand.durability> > 0:
        - narrate format:QuestMasterFormat "Are you trying to stiff me with a used tool? Craft me a new one!"
        - stop
    - choose <player.item_in_hand.material.name>:
        - case stone_axe:
            - define objective:1
            - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress]> == 0:
                - take material:stone_axe
                - narrate format:QuestMasterFormat "A stone axe! Stone axes chop trees just a little bit faster than their wooden counterparts."
                - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:1
                - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]>
        - case stone_pickaxe:
            - define objective:2
            - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress]> == 0:
                - take material:stone_pickaxe
                - narrate format:QuestMasterFormat "A stone pickaxe! You're going to want to use this to mine some iron and coal."
                - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:1
                - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]>
        - case stone_shovel:
            - define objective:3
            - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress]> == 0:
                - take material:stone_shovel
                - narrate format:QuestMasterFormat "A stone shovel! If you dig up some sand, you can make glass out of it with a furnace."
                - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:1
                - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]>
        - case stone_sword:
            - define objective:4
            - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress]> == 0:
                - take material:stone_sword
                - narrate format:QuestMasterFormat "A stone sword! Now you'll be able to beat back those zombies pretty well."
                - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:1
                - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]>
        - case stone_hoe:
            - define objective:5
            - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress]> == 0:
                - take material:stone_hoe
                - narrate format:QuestMasterFormat "A stone hoe! This should last quite a bit longer than that wooden one."
                - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:1
                - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]>
        - default:
            - narrate format:QuestMasterFormat "Bring me those stone tools!"