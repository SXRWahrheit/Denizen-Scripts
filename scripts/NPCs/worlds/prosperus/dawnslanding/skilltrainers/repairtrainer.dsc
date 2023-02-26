Repair_Master:
    type: assignment
    interact scripts:
    - Repair
    actions:
        on assignment:
        - teleport npc <npc.anchor[repairmaster]>
        - trigger name:proximity state:true
        - trigger name:chat state:true

RepairMasterFormat:
    type: format
    format: <gray>Master Repairman<white><&co> <[text]>

Repair:
    type: interact
    steps:
        'Player_Seen*':
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - define quest_internalname:MeetSkillTrainers
                    - define objective:5
                    - if <yaml[<[data]>].contains[quests.active.<[quest_internalname]>]> && <yaml[<[data]>].read[quests.active.<[quest_internalname]>.objective.<[objective]>.progress]> == 0:
                        - yaml set id:<[data]> quests.active.<[quest_internalname]>.objective.<[objective]>.progress:5
                        - narrate format:RepairMasterFormat "A new iron for the fire! Nice to meet you, <player.name>. The Quest Master sent you, you say? Fantastic! If you've got gold, I'll teach you what I know about repair."
                        - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]>
                    - else:
                        - narrate format:RepairMasterFormat "Hello, apprentice! Want to learn about repair? I'll help you refine your craft. Right click me."
                    - narrate "<gray>Right click the Master Repairman for training!"
                exit:
                    script:
                    - narrate format:RepairMasterFormat "Have a good one!"
            click trigger:
                script:
                - narrate format:RepairMasterFormat "Alright, let's get you some training. I'll give you 100 Repair XP for 1 gold. Say how much gold you want to spend, or anything else to cancel."
                - zap step:Payment
        Payment:
            chat trigger:
                'Confirm':
                    trigger: I'd like to pay /REGEX:\d+/ gold.
                    script:
                    - flag <player> ChosenAmount:<context.message.replace[regex:\D+]>
                    - announce to_console "player.flag[ChosenAmount] equals <player.flag[ChosenAmount]>"
                    - announce to_console "player.money is <player.money>"
                    - if <player.flag[ChosenAmount].is[OR_LESS].than[<player.money>]>:
                        - narrate format:RepairMasterFormat "Okay, let's get you trained up."
                        - execute as_server "addxp <player.name> repair <player.flag[ChosenAmount].mul[100]||0>"
                        - announce to_console "ran command 'addxp <player.name> repair <player.flag[ChosenAmount].mul[100]||0>'"
                        - take money qty:<player.flag[ChosenAmount]>
                        - flag <player> ChosenAmount:!
                        - narrate format:RepairMasterFormat "All done. Enjoy."
                    - else:
                        - narrate format:RepairMasterFormat "You don't have that much gold."
                    - zap step:Player_Seen
                'Fail':
                    trigger: /REGEX:.+/
                    script:
                    - narrate format:RepairMasterFormat "I don't think that's a number. Sorry, I can't work with that."
                    - zap step:Player_Seen
            click trigger:
                script:
                - narrate format:RepairMasterFormat "Just say how much gold you want to pay for XP, or anything else to cancel."