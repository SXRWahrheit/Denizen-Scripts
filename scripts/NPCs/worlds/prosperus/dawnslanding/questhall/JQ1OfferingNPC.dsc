JQ1OfferingNPCAssignment:
    type: assignment
    interact scripts:
    - JQ1OfferingNPCInteract
    actions:
        on assignment:
        - teleport npc location:<npc.anchor[JQ1OfferingNPC]>
        - trigger name:proximity state:true
        - trigger name:chat state:true

JQ1OfferingNPCFormat:
    type: format
    format: "<gray>He Jumps Once<white><&co> <[text]>"

JQ1OfferingNPCInteract:
    type: interact
    steps:
        JQ1Quest*:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyJQ1]>:
                        - narrate format:JQ1OfferingNPCFormat "Hey, do you want to go back to the jump quest course?"
                    - else if <yaml[<[data]>].contains[quests.active.DailyJQ1].not> && <proc[QuestAvailabilityHandler].context[DailyJQ1]>:
                        - narrate format:JQ1OfferingNPCFormat "Looking for a jumping challenge? I can send you to a faraway land where you can test your parkour skills. Complete the course for a reward!"
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                - if <yaml[<[data]>].contains[quests.active.DailyJQ1].not> && <proc[QuestAvailabilityHandler].context[DailyJQ1]>:
                    - run QuestAcceptHandler def:DailyJQ1
                    - teleport <player> <location[-83.42172384982014,107,43.51846056790148,5.937170028686523,89.94125366210938,infinitus]>
            chat trigger:
                JQ1QuestAccept:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyJQ1].not> && <proc[QuestAvailabilityHandler].context[DailyJQ1]>:
                        - run QuestAcceptHandler def:DailyJQ1
                        - teleport <player> <location[-83.42172384982014,107,43.51846056790148,5.937170028686523,89.94125366210938,infinitus]>