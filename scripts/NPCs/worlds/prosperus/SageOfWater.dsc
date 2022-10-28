SageOfWaterAssignment:
    type: assignment
    debug: false
    interact scripts:
    - SageOfWaterInteract
    actions:
        on assignment:
        - teleport npc location:<npc.anchor[SageOfWater]>
        - trigger name:proximity state:true
        - trigger name:chat state:true

SageOfWaterFormat:
    type: format
    debug: false
    format: "<dark_green>Sage of Water<white><&co> <[text]>"

SageOfWaterInteract:
    type: interact
    debug: false
    steps:
        Greeting*:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.completed.FindWaterTemple]>:
                        - narrate format:SageOfWaterFormat "Greetings, <player.name>."
                        - zap NoSageOfWaterStorylineQuests
                    - else if <player.has_flag[SageOfWaterSeen]>:
                        - narrate format:SageOfWaterFormat "Greetings, <player.name>."
                        - zap GeneralDialogue
                    - else:
                        - flag <player> SageOfWaterSeen:true
                        - narrate format:SageOfWaterFormat "Oh? Hello. Deep in these waters, I don't get many visitors."
                        - zap GeneralDialogue
                    - if <yaml[<[data]>].contains[quests.active.FindWaterTemple]>:
                        - narrate "The Royal Geographer sent you? Yes, I haven't spoken to him in quite some time. Unfortunately, things are quite dire."
                        - wait 0.7s
                        - narrate "I had to lock the portal to the Water Temple. The forces of evil have overtaken it. My only choice was to keep them from spreading."
                        - yaml id:<[data]> set quests.active.FindWaterTemple.stages.1.objectives.1.progress:1
                        - run QuestCompletionHandler def:FindWaterTemple
                        - run FindWaterTempleCompletion
        GeneralDialogue:
            proximity trigger:
                entry:
                    script:
                    - narrate format:SageOfWaterFormat "Greetings, <player.name>."
        NoSageOfWaterStorylineQuests:
            proximity trigger:
                entry:
                    script:
                    - narrate format:SageOfWaterformat "Greetings, <player.name>."