"Excavation Master":
    type: assignment
    interact scripts:
    - Excavation
    actions:
        on assignment:
        - teleport npc <npc.anchor[excavationmaster]>
        - trigger name:proximity state:true
        - trigger name:chat state:true
    
ExcavationMasterFormat:
    type: format
    format: "<gray>Head Excavator<white><&co> <[text]>"

"Excavation":
    type: interact
    steps:
        'Player Seen*':
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - define quest_internalname:MeetSkillTrainers
                    - define objective:3
                    - if <yaml[<[data]>].contains[quests.active.<[quest_internalname]>]> && <yaml[<[data]>].read[quests.active.<[quest_internalname]>.objective.<[objective]>].progress> == 0:
                        - yaml set id:<[data]> quests.active.<[quest_internalname]>.objective.<[objective]>.progress:1
                        - narrate format:ExcavationMasterFormat "Hey there <player.name>! Quest Master sent you? Right on. I can teach you some excavation skills in exchange for gold."
                        - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]>
                    - else:
                        - narrate format:ExcavationMasterFormat "Hey there dirt grub. Want to learn about excavation? I'll teach ya."
                    - narrate "<grey>Right click the Head Excavator for training!"
                exit:
                    script:
                    - narrate format:ExcavationMasterFormat "Come back in the mud soon."
            click trigger:
                script:
                - narrate format:ExcavationMasterFormat "Alright, let's get you some training. I'll give you 100 Excavation XP for 1 gold. Say how much gold you want to spend, or anything else to cancel."
                - zap 'step:Payment'
        'Payment':
            chat trigger:
                'Confirm':
                    trigger: I'd like to pay /REGEX:\d+/ gold.
                    script:
                    - flag <player> ChosenAmount:<context.message.replace[regex:\D+]>
                    - announce to_console "player.flag[ChosenAmount] equals <player.flag[ChosenAmount]>"
                    - announce to_console "player.money is <player.money>"
                    - if <player.flag[ChosenAmount].is[OR_LESS].than[<player.money>]>:
                        - narrate format:ExcavationMasterFormat "Okay, let's get you trained up."
                        - execute as_server "addxp <player.name> excavation <player.flag[ChosenAmount].mul[100]||0>"
                        - announce to_console "ran command 'addxp <player.name> excavation <player.flag[ChosenAmount].mul[100]||0>'"
                        - take money qty:<player.flag[ChosenAmount]>
                        - flag <player> ChosenAmount:!
                        - narrate format:ExcavationMasterFormat "All done. Enjoy."
                    - else:
                        - narrate format:ExcavationMasterFormat "You don't have that much gold."
                    - zap 'step:Player Seen'
                'Fail':
                    trigger: "/REGEX:.+/"
                    script:
                    - narrate format:ExcavationMasterFormat "I don't think that's a number. Sorry, I can't work with that."
                    - zap 'step:Player Seen'
            click trigger:
                script:
                - narrate format:ExcavationMasterFormat "Just say how much gold you want to pay for XP, or anything else to cancel."