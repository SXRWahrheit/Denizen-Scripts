WoodToolsCompletion:
    type: task
    debug: false
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.active.SetHome].not> && <yaml[<[data]>].contains[quests.completed.SetHome].not>:
        - zap FirstQuestsActive QuestMasterInteract
    - else if <yaml[<[data]>].contains[quests.active.WoodTools]>:
        - zap WoodToolsActiveOnly QuestMasterInteract
    - else if <yaml[<[data]>].contains[quests.completed.WoodTools]>:
        - zap StoneToolsOffer QuestMasterInteract

WoodToolsQuestCraftingHandler:
    type: world
    debug: false
    events:
        on player crafts wooden_*:
        - define data <player.uuid>_quest_data
        - define quest_internalname:WoodTools
        - if <yaml[<[data]>].contains[quests.active.WoodTools].not>:
            - stop
        - define stage:1
        - choose <context.item.material.name>:
            - case wooden_axe:
                - define objective:1
                - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress]> == 0:
                    - narrate "<green>You crafted a wooden axe!"
                    - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:1
                    - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]> instantly
            - case wooden_pickaxe:
                - define objective:2
                - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress]> == 0:
                    - narrate "<green>You crafted a wooden pickaxe!"
                    - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:1
                    - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]> instantly
            - case wooden_shovel:
                - define objective:3
                - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress]> == 0:
                    - narrate "<green>You crafted a wooden shovel!"
                    - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:1
                    - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]> instantly
            - case wooden_sword:
                - define objective:4
                - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress]> == 0:
                    - narrate "<green>You crafted a wooden sword!"
                    - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:1
                    - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]> instantly
            - case wooden_hoe:
                - define objective:5
                - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress]> == 0:
                    - narrate "<green>You crafted a wooden hoe!"
                    - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:1
                    - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]> instantly

WoodToolsQuestDeliveryHandler:
    type: task
    debug: false
    definitions: data
    script:
    - define quest_internalname:WoodTools
    - define stage:2
    - if <player.item_in_hand.durability> > 0:
        - narrate format:QuestMasterFormat "Are you trying to stiff me with a used tool? Craft me a new one!"
        - stop
    - choose <player.item_in_hand.material.name>:
        - case wooden_axe:
            - define objective:1
            - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress]> == 0:
                - take material:wooden_axe
                - narrate format:QuestMasterFormat "A wooden axe! Axes make it easier to chop down trees."
                - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:1
                - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]> instantly
        - case wooden_pickaxe:
            - define objective:2
            - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress]> == 0:
                - take material:wooden_pickaxe
                - narrate format:QuestMasterFormat "A wooden pickaxe! You use one of these to mine stone."
                - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:1
                - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]> instantly
        - case wooden_shovel:
            - define objective:3
            - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress]> == 0:
                - take material:wooden_shovel
                - narrate format:QuestMasterFormat "A wooden shovel! This will make it easier for you to dig up dirt, grass, gravel, and sand."
                - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:1
                - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]> instantly
        - case wooden_sword:
            - define objective:4
            - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress]> == 0:
                - take material:wooden_sword
                - narrate format:QuestMasterFormat "A wooden sword! It's a bit better than just punching monsters with your hands."
                - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:1
                - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]> instantly
        - case wooden_hoe:
            - define objective:5
            - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress]> == 0:
                - take material:wooden_hoe
                - narrate format:QuestMasterFormat "A wooden hoe! Farming is a great way to build a life for yourself out there."
                - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:1
                - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]> instantly
        - default:
            - narrate format:QuestMasterFormat "Still waiting on that set of wood tools! You crafted them, didn't you?"