JQ2OfferingNPCAssignment:
    type: assignment
    interact scripts:
    - JQ2OfferingNPCInteract
    actions:
        on assignment:
        - teleport npc location:<npc.anchor[JQ2OfferingNPC]>
        - trigger name:proximity state:true
        - trigger name:chat state:true

JQ2OfferingNPCFormat:
    type: format
    format: <gray>He Jumps Twice<white><&co> <[text]>

JQ2OfferingNPCInteract:
    type: interact
    steps:
        JQ2Quest*:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyJQ2]>:
                        - narrate format:JQ2OfferingNPCFormat "Hey, do you want to go back to the jump quest course?"
                    - else if <yaml[<[data]>].contains[quests.active.DailyJQ2].not> && <proc[QuestAvailabilityHandler].context[DailyJQ2]>:
                        - narrate format:JQ2OfferingNPCFormat "Looking for a jumping challenge? I can send you to a faraway land where you can test your parkour skills. Complete the course for a reward!"
            click trigger:
                script:
                - if <yaml[<[data]>].contains[quests.active.DailyJQ2].not> && <proc[QuestAvailabilityHandler].context[DailyJQ2]>:
                    - run QuestAcceptHandler def:DailyJQ2
                    - teleport <player> <location[72.58323675043975,106,-64.10703844964986,3.2370898723602295,180.99081420898438,infinitus]>
            chat trigger:
                JQ2QuestAccept:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - if <yaml[<[data]>].contains[quests.active.DailyJQ2].not> && <proc[QuestAvailabilityHandler].context[DailyJQ2]>:
                        - run QuestAcceptHandler def:DailyJQ2
                        - teleport <player> <location[72.58323675043975,106,-64.10703844964986,3.2370898723602295,180.99081420898438,infinitus]>