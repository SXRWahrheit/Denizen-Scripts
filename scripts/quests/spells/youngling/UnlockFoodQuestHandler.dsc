UnlockFoodQuestDeliveryHandler:
    type: task
    debug: false
    script:
    - define stage:1
    - define quest_internalname:UnlockFood
    - choose <player.item_in_hand.material.name>:
        - case redstone:
            - define objective:1
        - case carrot:
            - define objective:2
        - case potato:
            - define objective:3
        - case melon_slice:
            - define objective:4
        - case wheat:
            - define objective:5
        - case pumpkin:
            - define objective:6
        - case cocoa:
            - define objective:7
        - case gold_ingot:
            - define objective:8
        - default:
            - narrate format:WiseWizardFormat "Whenever you've got the items I'm looking for, just hand them over."
            - run QuestProgressHandler def:UnlockFood
    - inject QuestItemDeliveryHandler
    - if <[InProgress]>:
        - choose <[delivery_item]>:
            - case redstone:
                - narrate format:WiseWizardFormat "Thanks for the redstone! As I'm sure you know, it's quite important for magical endeavors."
            - case carrot:
                - narrate format:WiseWizardFormat "I love a crunchy carrot. Just don't eat too many or you'll start turning orange!"
            - case potato:
                - narrate format:WiseWizardFormat "You sure can make quite a lot of different dishes with potatoes! But a baked potato is a classic."
            - case melon_slice:
                - narrate format:WiseWizardFormat "Isn't farming melons fun? Plant 'em once and they'll keep making you delicious fruit over and over."
            - case wheat:
                - narrate format:WiseWizardFormat "Wheat is the backbone of our food supply! Bread is a staple at every meal."
            - case pumpkin:
                - narrate format:WiseWizardFormat "Have you ever tried making a pumpkin pie? I love all the spices!"
            - case cocoa_beans:
                - narrate format:WiseWizardFormat "Cocoa is important for making sweet treats. Wheat and cocoa can be used to make great cookies!"
            - case gold_ingot:
                - narrate format:WiseWizardFormat "Gold ingots help concentrate magical power. You can mine gold from the ground, of course, or scavenge bits of gold from the corpses of zombie pigmen in the Nether."

UnlockFoodQuestExperienceDeliveryHandler:
    type: task
    debug: false
    script:
    - define stage:2
    - define quest_internalname:UnlockFood
    - if <player.item_in_hand.script.name.if_null[null]> == crystallizedexperiencesliver:
        - define objective:1
        - inject QuestItemDeliveryHandler
    - else:
        - narrate format:WiseWizardFormat "You can get a Sliver of Crystallized Experience from the Arch Artificer. When you've got one, bring it over."

UnlockFoodCompletion:
    type: task
    debug: false
    script:
    - execute as_server "cast teach <player.name> Food"