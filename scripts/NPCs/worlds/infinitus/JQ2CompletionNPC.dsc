JQ2CompletionNPCAssignment:
    type: assignment
    interact scripts:
    - JQ2CompletionNPCInteract
    actions:
        on assignment:
        - teleport npc location:<npc.anchor[JQ2CompletionNPC]>
        - trigger name:proximity state:true
        - trigger name:chat state:true

JQ2CompletionNPCFormat:
    type: format
    format: <gray>He Jumped Twice<white><&co> <[text]>

JQ2CompletionNPCInteract:
    type: interact
    steps:
        JQ2Quest*:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyJQ2]>:
                        - narrate format:JQ2CompletionNPCFormat "Hey there, <player.name>! Right click me to complete the course!"
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                - if <yaml[<[data]>].contains[quests.active.DailyJQ2]>:
                    - run QuestCompletionHandler def:DailyJQ2