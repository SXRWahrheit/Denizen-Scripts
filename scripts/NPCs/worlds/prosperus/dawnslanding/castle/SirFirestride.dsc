SirFirestrideAssignment:
    type: assignment
    debug: false
    interact scripts:
    - SirFirestrideInteract
    actions:
        on assignment:
        - teleport npc location:<npc.anchor[SirFirestride]>
        - trigger name:proximity state:true
        - trigger name:chat state:true

SirFirestrideFormat:
    type: format
    debug: false
    format: <dark_green>Sir Firestride<white><&co> <[text]>

SirFirestrideInteract:
    type: interact
    debug: false
    speed: 0
    steps:
        Greeting*:
            proximity trigger:
                entry:
                    script:
                    - narrate format:SirFirestrideFormat "Hail, <player.name>!"
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                # Let's try making a menu!
                # Active quests first, if any
                - define npc_name SirFirestride
                - if <proc[ActiveQuestsCheck].context[<[npc_name]>].size.if_null[0]> > 0:
                    - inject ActiveQuestInventoryGUIHandler
                    - stop
                # Available quests next, if any
                - if <proc[QuestsAvailableHandler].context[<[npc_name]>].if_null[false]>:
                    - inject AvailableQuestInventoryGUIHandler
                    - stop
                - else:
                    - narrate format:SirFirestrideFormat "I'm sorry, I don't have any quests available for you right now."