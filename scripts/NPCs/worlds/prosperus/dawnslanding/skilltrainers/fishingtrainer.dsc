Fishing_Master:
    type: assignment
    interact scripts:
    - Fishing
    actions:
        on assignment:
        - teleport npc <npc.anchor[fishingmaster]>
        - trigger name:proximity state:true
        - trigger name:chat state:true

FishingMasterFormat:
    type: format
    format: <gray>Old Fisherman<white><&co> <[text]>

Fishing:
    type: interact
    steps:
        Player_Seen*:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - define quest_internalname:MeetSkillTrainers
                    - define objective:1
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.<[quest_internalname]>]> && <yaml[<[data]>].read[quests.active.<[quest_internalname]>.objective.<[objective]>.progress]> == 0:
                        - yaml set id:<[data]> quests.active.<[quest_internalname]>.objective.<[objective]>.progress:1
                        - narrate format:FishingMasterFormat "Well hello there, <player.name>! Oh, did the Quest Master send you? Wonderful, wonderful. I can teach you some fishing skills in exchange for gold, if you like."
                        - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]>
                    - else:
                        - narrate format:FishingMasterFormat "Well, hello there. Have you come to learn some tricks about fishing? I can teach you. Right click me."
                    - narrate "<gray>Right click the Old Fisherman for training!"
                exit:
                    script:
                    - narrate format:FishingMasterFormat "Thanks for visiting."
            click trigger:
                script:
                - narrate format:FishingMasterFormat "Alright, let's get you some training. I'll give you 100 Fishing XP for 1 gold. Say how much gold you want to spend, or anything else to cancel."
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
                        - narrate format:FishingMasterFormat "Okay, let's get you trained up."
                        - execute as_server "addxp <player.name> fishing <player.flag[ChosenAmount].mul[100]||0>"
                        - announce to_console "ran command 'addxp <player.name> fishing <player.flag[ChosenAmount].mul[100]||0>'"
                        - take money qty:<player.flag[ChosenAmount]>
                        - flag <player> ChosenAmount:!
                        - narrate format:FishingMasterFormat "All done. Enjoy."
                    - else:
                        - narrate format:FishingMasterFormat "You don't have that much gold."
                    - zap step:Player_Seen
                'Fail':
                    trigger: /REGEX:.+/
                    script:
                    - narrate format:FishingMasterFormat "I don't think that's a number. Sorry, I can't work with that."
                    - zap step:Player_Seen
            click trigger:
                script:
                - narrate format:FishingMasterFormat "Just say how much gold you want to pay for XP, or anything else to cancel."