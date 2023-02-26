Woodcutting_Master:
    type: assignment
    interact scripts:
    - Woodcutting
    actions:
        on assignment:
        - teleport npc <npc.anchor[woodcuttingmaster]>
        - trigger name:proximity state:true
        - trigger name:chat state:true

WoodcuttingMasterFormat:
    type: format
    format: <gray>Expert Logger<white><&co> <[text]>

Woodcutting:
    type: interact
    steps:
        'Player_Seen*':
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - define quest_internalname:MeetSkillTrainers
                    - define objective:4
                    - if <yaml[<[data]>].contains[quests.active.<[quest_internalname]>]> && <yaml[<[data]>].read[quests.active.<[quest_internalname]>.objective.<[objective]>.progress]> == 0:
                        - yaml set id:<[data]> quests.active.<[quest_internalname]>.objective.<[objective]>.progress:1
                        - narrate format:WoodcuttingMasterFormat "Chop chop, <player.name>, the day waits for no one! The Quest master sent you to find me, did he? Tremendous. I can teach you what I know about woodcutting - for a price, of course."
                        - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]>
                    - else:
                        - narrate format:WoodcuttingMasterFormat "Howdy sapling! Want to learn about woodcutting? I'll show you the ropes. Right click me."
                    - narrate "<gray>Right click the Expert Logger for training!"
                exit:
                    script:
                    - narrate format:WoodcuttingMasterFormat "Happy cuts!"
            click trigger:
                script:
                - narrate format:WoodcuttingMasterFormat "Alright, let's get you some training. I'll give you 100 Woodcutting XP for 1 gold. Say how much gold you want to spend, or anything else to cancel."
                - zap step:Payment
        'Payment':
            chat trigger:
                'Confirm':
                    trigger: I'd like to pay /REGEX:\d+/ gold.
                    script:
                    - flag <player> ChosenAmount:<context.message.replace[regex:\D+]>
                    - announce to_console "player.flag[ChosenAmount] equals <player.flag[ChosenAmount]>"
                    - announce to_console "player.money is <player.money>"
                    - if <player.flag[ChosenAmount].is[OR_LESS].than[<player.money>]>:
                        - narrate format:WoodcuttingMasterFormat "Okay, let's get you trained up."
                        - execute as_server "addxp <player.name> woodcutting <player.flag[ChosenAmount].mul[100]||0>"
                        - announce to_console "ran command 'addxp <player.name> woodcutting <player.flag[ChosenAmount].mul[100]||0>'"
                        - take money qty:<player.flag[ChosenAmount]>
                        - flag <player> ChosenAmount:!
                        - narrate format:WoodcuttingMasterFormat "All done. Enjoy."
                    - else:
                        - narrate format:WoodcuttingMasterFormat "You don't have that much gold."
                    - zap step:Player_Seen
                'Fail':
                    trigger: /REGEX:.+/
                    script:
                    - narrate format:WoodcuttingMasterFormat "I don't think that's a number. Sorry, I can't work with that."
                    - zap step:Player_Seen
            click trigger:
                script:
                - narrate format:WoodcuttingMasterFormat "Just say how much gold you want to pay for XP, or anything else to cancel."