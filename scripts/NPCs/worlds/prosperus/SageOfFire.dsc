SageOfFireAssignment:
    type: assignment
    debug: false
    interact scripts:
    - SageOfFireInteract
    actions:
        on assignment:
        - teleport npc location:<npc.anchor[SageOfFire]>
        - trigger name:proximity state:true
        - trigger name:chat state:true

SageOfFireFormat:
    type: format
    debug: false
    format: "<dark_green>Sage of Fire<white><&co> <[text]>"

SageOfFireInteract:
    type: interact
    debug: false
    steps:
        Greeting*:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.completed.FindFireTemple]>:
                        - narrate format:SageOfFireFormat "Greetings, <player.name>."
                        - zap NoSageOfFireStorylineQuests
                    - else if <player.has_flag[SageOfFireSeen]>:
                        - narrate format:SageOfFireFormat "Greetings, <player.name>."
                        - zap GeneralDialogue
                    - else:
                        - flag <player> SageOfFireSeen:true
                        - narrate format:SageOfFireFormat "Well, hello. With this sweltering heat, I don't get too many visitors."
                        - zap GeneralDialogue
                    - if <yaml[<[data]>].contains[quests.active.FindFireTemple]>:
                        - narrate "The Royal Geographer sent you? Yes, I haven't spoken to him in quite some time. Unfortunately, things are quite dire."
                        - wait 0.7s
                        - narrate "I had to lock the portal to the Fire Temple. The forces of evil have overtaken it. My only choice was to keep them from spreading."
                        - yaml id:<[data]> set quests.active.FindFireTemple.stages.1.objectives.1.progress:1
                        - run QuestCompletionHandler def:FindFireTemple
                        - run FindFireTempleCompletion
        GeneralDialogue:
            proximity trigger:
                entry:
                    script:
                    - narrate format:SageOfFireFormat "Greetings, <player.name>."
        NoSageOfFireStorylineQuests:
            proximity trigger:
                entry:
                    script:
                    - narrate format:SageOfFireformat "Greetings, <player.name>."