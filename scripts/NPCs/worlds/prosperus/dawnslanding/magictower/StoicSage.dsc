# Page guy

StoicSageAssignment:
    type: assignment
    debug: false
    interact scripts:
    - StoicSageInteract
    actions:
        on assignment:
        - teleport npc location:<npc.anchor[StoicSage]>
        - trigger name:proximity state:true
        - trigger name:chat state:true

StoicSageFormat:
    type: format
    debug: false
    format: <dark_green>Stoic Sage<white><&co> <[text]>

StoicSageInteract:
    type: interact
    debug: false
    speed: 0
    steps:
        Greeting*:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.completed.UnlockBlink]> && <player.has_permission[server.page]>:
                        - narrate format:StoicSageFormat "Greetings, <player.name>."
                        - if <proc[QuestsAvailableHandler].context[StoicSage]>:
                            - narrate format:StoicSageformat "Ready to learn some more spells?"
                        - else:
                            - narrate format:StoicSageFormat "For now, I've taught you all I can."
                        - zap BlinkUnlocked
                    - else if <player.has_permission[server.page]>:
                        - narrate format:StoicSageFormat "Greetings, <player.name>. The Wise Wizard can help you get started in your journey to become a master of magical energy. Once you've learned the Blink spell, come and find me again."
                    - else if <yaml[<[data]>].contains[quests.completed.UnlockBlink]>:
                        - narrate format:StoicSageFormat "Greetings, <player.name>. You're not quite ready for me to teach you my spells. Once you've become a Page, come and find me again."
                    - else:
                        - narrate format:StoicSageFormat "Greetings, <player.name>. You're not quite ready for me to teach you my spells. The Wise Wizard can help you get started in your journey to become a master of magical energy. You'll need to both learn the Blink spell and become a Page. Once you've done both of those things, come and find me again."
        BlinkUnlocked:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - narrate format:StoicSageFormat "Greetings, <player.name>."
                    - if <proc[QuestsAvailableHandler].context[StoicSage]>:
                        - narrate format:StoicSageformat "Ready to learn some more spells?"
                    - else:
                        - narrate format:StoicSageFormat "For now, I've taught you all I can."
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                # Active quests first, if any
                - define npc_name StoicSage
                - if <proc[ActiveQuestsCheck].context[<[npc_name]>].size.if_null[0]> > 0:
                    - inject ActiveQuestInventoryGUIHandler
                    - stop
                # Available quests next, if any
                - if <proc[QuestsAvailableHandler].context[<[npc_name]>].if_null[false]>:
                    - inject AvailableQuestInventoryGUIHandler
                    - stop
                - else:
                    - narrate format:StoicSageFormat "I'm sorry, I don't have any quests available for you right now."