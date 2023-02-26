# Youngling guy

WiseWizardAssignment:
    type: assignment
    debug: false
    interact scripts:
    - WiseWizardInteract
    actions:
        on assignment:
        - trigger name:proximity state:true
        - trigger name:chat state:true

WiseWizardFormat:
    type: format
    debug: false
    format: <dark_green>Wise Wizard<white><&co> <[text]>

WiseWizardInteract:
    type: interact
    debug: true
    speed: 0
    steps:
        Greeting*:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.completed.UnlockBlink]>:
                        - narrate format:WiseWizardFormat "Greetings, <player.name>."
                        - zap BlinkUnlocked
                    - else if <proc[QuestRequirementsHandler].context[UnlockBlink]>:
                        - narrate format:WiseWizardFormat "Greetings, <player.name>. Have you come to begin your journey of mastering the magical arts? The first spell I can teach you is Blink, and it allows you to teleport short distances."
                        - zap UnlockBlinkOffer
                    - else:
                        - narrate format:WiseWizardFormat "Greetings, <player.name>. You are not yet ready to learn what I have to teach."
                        - if !<yaml[<[data]>].contains[quests.completed.IronTools]>:
                            - wait 0.7s
                            - narrate format:WiseWizardFormat "Be sure to visit the Quest Master and complete the quests he has to offer."
                        - zap CheckQuestProgress
        CheckQuestProgress:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <proc[QuestRequirementsHandler].context[UnlockBlink]>:
                        - narrate format:WiseWizardFormat "Greetings, <player.name>. Have you come to begin your journey of mastering the magical arts? The first spell I can teach you is Blink, and it allows you to teleport short distances."
                        - zap UnlockBlinkOffer
                    - else:
                        - narrate format:WiseWizardFormat "Greetings, <player.name>. You are not yet ready to learn what I have to teach."
                        - if !<yaml[<[data]>].contains[quests.completed.IronTools]>:
                            - wait 0.7s
                            - narrate format:WiseWizardFormat "Be sure to visit the Quest Master and complete the quests he has to offer."
        UnlockBlinkOffer:
            proximity trigger:
                entry:
                    script:
                    - narrate format:WiseWizardFormat "Greetings, <player.name>. Have you come to begin your journey of mastering the magical arts? The first spell I can teach you is Blink, and it allows you to teleport short distances."
            click trigger:
                script:
                - narrate format:PlayerChatFormat "Magic? Sounds awesome, I'm in!"
                - run QuestAcceptHandler def:UnlockBlink
                - zap UnlockBlinkActive
            chat trigger:
                UnlockBlinkAcceptance:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - narrate format:PlayerChatFormat "Magic? Sounds awesome, I'm in!"
                    - run QuestAcceptHandler def:UnlockBlink
                    - zap UnlockBlinkActive
        UnlockBlinkActive:
            proximity trigger:
                entry:
                    script:
                    - narrate format:WiseWizardFormat "How's it going finding those magical materials?"
                    - run QuestProgressHandler def:UnlockBlink instantly
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                - define quest_internalname UnlockBlink
                - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.current_stage]> == 1:
                    - inject UnlockBlinkQuestDeliveryHandler
                - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.current_stage]> == 2:
                    - inject UnlockBlinkQuestExperienceDeliveryHandler
        BlinkUnlocked:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - narrate format:WiseWizardFormat "Greetings, <player.name>."
                    - if <proc[QuestsAvailableHandler].context[WiseWizard]>:
                        - narrate format:WiseWizardformat "Ready to learn some more spells?"
                    - else if <yaml[quest_npc_list].read[WiseWizard].contains_any[<yaml[<[data]>].list_keys[quests.active]>].if_null[false]>:
                        - foreach <yaml[quest_npc_list].read[WiseWizard].shared_contents[<yaml[<[data]>].list_keys[quests.active]>]>:
                            - define quest_internalname <[value]>
                            - inject QuestProgressHandler
                        - narrate format:WiseWizardFormat "Keep up with gathering those reagents!"
                    - else:
                        - narrate format:WiseWizardFormat "For now, I've taught you all I can."
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                # Let's try making a menu!
                # Active quests first, if any
                - define npc_name WiseWizard
                - if <proc[ActiveQuestsCheck].context[<[npc_name]>].size.if_null[0]> > 0:
                    - inject ActiveQuestInventoryGUIHandler
                    - stop
                # Available quests next, if any
                - if <proc[QuestsAvailableHandler].context[<[npc_name]>].if_null[false]>:
                    - inject AvailableQuestInventoryGUIHandler
                    - stop
                - else:
                    - narrate format:WiseWizardFormat "I'm sorry, I don't have any quests available for you right now."
        ActiveQuestManagement:
            proximity trigger:
                exit:
                    script:
                    - zap BlinkUnlocked

WiseWizardActiveQuests:
    type: inventory
    inventory: chest
    debug: false
    gui: true
    title: Active Quests
    size: 54
    slots:
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] [AvailableQuestsIcon]

WiseWizardAvailableQuests:
    type: inventory
    inventory: chest
    debug: false
    gui: true
    title: Available Quests
    size: 54
    slots:
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] [ActiveQuestsIcon]
