# Knight and above lady

ArchmageAlestraAssignment:
    type: assignment
    debug: false
    interact scripts:
    - ArchmageAlestraInteract
    actions:
        on assignment:
        - teleport npc location:<npc.anchor[ArchmageAlestra]>
        - trigger name:proximity state:true
        - trigger name:chat state:true

ArchmageAlestraFormat:
    type: format
    debug: false
    format: "<dark_green>Archmage Alestra<white><&co> <[text]>"

ArchmageAlestraInteract:
    type: interact
    debug: false
    steps:
        Greeting*:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.completed.UnlockBlink]> && <player.has_permission[server.apprentice]>:
                        - narrate format:ArchmageAlestraFormat "Greetings, <player.name>."
                        - if <proc[QuestsAvailableHandler].context[ArchmageAlestra]>:
                            - narrate format:ArchmageAlestraformat "Ready to learn some more spells?"
                        - else:
                            - narrate format:ArchmageAlestraFormat "For now, I've taught you all I can."
                        - zap BlinkUnlocked
                    - else if <player.has_permission[server.apprentice]>:
                        - narrate format:ArchmageAlestraFormat "Greetings, <player.name>. The Wise Wizard can help you get started in your journey to become a master of magical energy. Once you've learned the Blink spell, come and find me again."
                    - else if <yaml[<[data]>].contains[quests.completed.UnlockBlink]>:
                        - narrate format:ArchmageAlestraFormat "Greetings, <player.name>. You're not quite ready for me to teach you my spells. Once you've become an Knight, come and find me again."
                    - else:
                        - narrate format:ArchmageAlestraFormat "Greetings, <player.name>. You're not quite ready for me to teach you my spells. The Wise Wizard can help you get started in your journey to become a master of magical energy. You'll need to both learn the Blink spell and become an Knight. Once you've done both of those things, come and find me again."
        BlinkUnlocked:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - narrate format:ArchmageAlestraFormat "Greetings, <player.name>."
                    - if <proc[QuestsAvailableHandler].context[ArchmageAlestra]>:
                        - narrate format:ArchmageAlestraformat "Ready to learn some more spells?"
                    - else:
                        - narrate format:ArchmageAlestraFormat "For now, I've taught you all I can."
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                - if <proc[QuestsAvailableHandler].context[ArchmageAlestra]>:
                    - inject QuestInventoryGUIHandler def:ArchmageAlestra
                - else:
                    - narrate format:ArchmageAlestraFormat "I'm sorry, I don't have any quests available for you right now."