JQ1CompletionNPCAssignment:
    type: assignment
    interact scripts:
    - JQ1CompletionNPCInteract
    actions:
        on assignment:
        - teleport npc location:<npc.anchor[JQ1CompletionNPC]>
        - trigger name:proximity state:true
        - trigger name:chat state:true

JQ1CompletionNPCFormat:
    type: format
    format: <gray>He Jumped Once<white><&co> <[text]>

JQ1CompletionNPCInteract:
    type: interact
    steps:
        JQ1Quest*:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyJQ1]>:
                        - narrate format:JQ1CompletionNPCFormat "Hey there, <player.name>! Right click me to complete the course!"
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                - if <yaml[<[data]>].contains[quests.active.DailyJQ1]>:
                    - run QuestCompletionHandler def:DailyJQ1