LadyBrightswordAssignment:
    type: assignment
    debug: false
    interact scripts:
    - LadyBrightswordInteract
    actions:
        on assignment:
        - teleport npc location:<npc.anchor[LadyBrightsword]>
        - trigger name:proximity state:true
        - trigger name:chat state:true

LadyBrightswordFormat:
    type: format
    debug: false
    format: <dark_green>Lady Brightsword<white><&co> <[text]>

LadyBrightswordInteract:
    type: interact
    debug: false
    speed: 0
    steps:
        Greeting*:
            proximity trigger:
                entry:
                    script:
                    - narrate format:LadyBrightswordFormat "Hail, <player.name>!"
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                # Let's try making a menu!
                # Active quests first, if any
                - define npc_name LadyBrightsword
                - if <proc[ActiveQuestsCheck].context[<[npc_name]>].size.if_null[0]> > 0:
                    - inject ActiveQuestInventoryGUIHandler
                    - stop
                # Available quests next, if any
                - if <proc[QuestsAvailableHandler].context[<[npc_name]>].if_null[false]>:
                    - inject AvailableQuestInventoryGUIHandler
                    - stop
                - else:
                    - narrate format:LadyBrightswordFormat "I'm sorry, I don't have any quests available for you right now."