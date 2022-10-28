UnlockBlinkQuestDeliveryHandler:
    type: task
    debug: true
    speed: 0
    script:
    - define stage 1
    - define quest_internalname UnlockBlink
    - choose <player.item_in_hand.material.name>:
        - case redstone:
            - define objective 1
        - case ender_pearl:
            - define objective 2
        - case gold_ingot:
            - define objective 3
        - default:
            - narrate format:WiseWizardFormat "Whenever you've got the items I'm looking for, just hand them over."
            - run QuestProgressHandler def:UnlockBlink instantly
            - stop
    - inject QuestItemDeliveryHandler
    - if <[Delivery_Success]>:
        - narrate format:WiseWizardFormat <proc[ItemDescriptionHandler_Spells].context[<[delivery_item]>]>
    - if <[Enough_items]> && <[current_stage]> == 1:
        - narrate format:WiseWizardFormat "One reagent down! Bring me the rest of the items when you're ready."

UnlockBlinkQuestExperienceDeliveryHandler:
    type: task
    debug: false
    speed: 0
    script:
    - define stage:2
    - define quest_internalname:UnlockBlink
    - if <player.item_in_hand.script.name.if_null[null]> == crystallizedexperiencesliver:
        - define objective 1
        - inject QuestItemDeliveryHandler
    - else:
        - narrate format:WiseWizardFormat "You can get a Sliver of Crystallized Experience from the Arch Artificer. When you've got one, bring it over."

UnlockBlinkCompletion:
    type: task
    debug: false
    script:
    - zap BlinkUnlocked WiseWizardInteract
    - execute as_server "cast teach <player.name> Blink"