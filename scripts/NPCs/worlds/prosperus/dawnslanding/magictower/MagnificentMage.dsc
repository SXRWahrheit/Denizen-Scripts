# Apprentice guy

MagnificentMageAssignment:
    type: assignment
    debug: false
    interact scripts:
    - MagnificentMageInteract
    actions:
        on assignment:
        - teleport npc location:<npc.anchor[MagnificentMage]>
        - trigger name:proximity state:true
        - trigger name:chat state:true

MagnificentMageFormat:
    type: format
    debug: false
    format: "<dark_green>Magnificent Mage<white><&co> <[text]>"

MagnificentMageInteract:
    type: interact
    debug: false
    speed: 0
    steps:
        Greeting*:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.completed.UnlockBlink]> && <player.has_permission[server.apprentice]>:
                        - narrate format:MagnificentMageFormat "Greetings, <player.name>."
                        - if <proc[QuestsAvailableHandler].context[MagnificentMage]>:
                            - narrate format:MagnificentMageformat "Ready to learn some more spells?"
                        - else:
                            - narrate format:MagnificentMageFormat "For now, I've taught you all I can."
                        - zap BlinkUnlocked
                    - else if <player.has_permission[server.apprentice]>:
                        - narrate format:MagnificentMageFormat "Greetings, <player.name>. The Wise Wizard can help you get started in your journey to become a master of magical energy. Once you've learned the Blink spell, come and find me again."
                    - else if <yaml[<[data]>].contains[quests.completed.UnlockBlink]>:
                        - narrate format:MagnificentMageFormat "Greetings, <player.name>. You're not quite ready for me to teach you my spells. Once you've become an Apprentice, come and find me again."
                    - else:
                        - narrate format:MagnificentMageFormat "Greetings, <player.name>. You're not quite ready for me to teach you my spells. The Wise Wizard can help you get started in your journey to become a master of magical energy. You'll need to both learn the Blink spell and become an Apprentice. Once you've done both of those things, come and find me again."
        BlinkUnlocked:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - narrate format:MagnificentMageFormat "Greetings, <player.name>."
                    - if <proc[QuestsAvailableHandler].context[MagnificentMage]>:
                        - narrate format:MagnificentMageformat "Ready to learn some more spells?"
                    - else:
                        - narrate format:MagnificentMageFormat "For now, I've taught you all I can."
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                # Let's try making a menu!
                # Active quests first, if any
                - define npc_name MagnificentMage
                - if <proc[ActiveQuestsCheck].context[<[npc_name]>].size.if_null[0]> > 0:
                    - inject ActiveQuestInventoryGUIHandler
                    - stop
                # Available quests next, if any
                - if <proc[QuestsAvailableHandler].context[<[npc_name]>].if_null[false]>:
                    - inject AvailableQuestInventoryGUIHandler
                    - stop
                - else:
                    - narrate format:MagnificentMageFormat "I'm sorry, I don't have any quests available for you right now."