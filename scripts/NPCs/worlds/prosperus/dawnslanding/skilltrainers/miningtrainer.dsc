"Mining Master":
    type: assignment
    interact scripts:
    - Mining
    actions:
        on assignment:
        - teleport npc <npc.anchor[miningmaster]>
        - trigger name:proximity state:true
        - trigger name:chat state:true
    
MiningMasterFormat:
    type: format
    format: "<gray>Head Miner<white><&co> <[text]>"

"Mining":
    type: interact
    steps:
        'Player Seen*':
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - define quest_internalname:MeetSkillTrainers
                    - define objective:2
                    - if <yaml[<[data]>].contains[quests.active.<[quest_internalname]>]> && <yaml[<[data]>].read[quests.active.<[quest_internalname]>.objective.<[objective]>].progress> == 0:
                        - yaml set id:<[data]> quests.active.<[quest_internalname]>.objective.<[objective]>.progress:1
                        - narrate format:MiningMasterFormat "Oh. Hi, <player.name>. Don't see too many folks out this far. The Quest Master sent you? Well, that's nice. If you've got gold, I can teach you some mining skills."
                        - run QuestStageProgressHandler def:<[quest_internalname]>|<[objective]>
                    - else:
                        - narrate format:MiningMasterFormat "Hello stonesmasher! Want to learn about mining? I'll help you break some rocks. Right click me."
                    - narrate "<grey>Right click the Head Miner for training!"
                exit:
                    script:
                    - narrate format:MiningMasterFormat "Happy caving!"
            click trigger:
                script:
                - narrate format:MiningMasterFormat "Alright, let's get you some training. I'll give you 100 Mining XP for 1 gold. Say how much gold you want to spend, or anything else to cancel."
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
                        - narrate format:MiningMasterFormat "Okay, let's get you trained up."
                        - execute as_server "addxp <player.name> mining <player.flag[ChosenAmount].mul[100]||0>"
                        - announce to_console "ran command 'addxp <player.name> mining <player.flag[ChosenAmount].mul[100]||0>'"
                        - take money qty:<player.flag[ChosenAmount]>
                        - flag <player> ChosenAmount:!
                        - narrate format:MiningMasterFormat "All done. Enjoy."
                    - else:
                        - narrate format:MiningMasterFormat "You don't have that much gold."
                    - zap 'step:Player Seen'
                'Fail':
                    trigger: "/REGEX:.+/"
                    script:
                    - narrate format:MiningMasterFormat "I don't think that's a number. Sorry, I can't work with that."
                    - zap 'step:Player Seen'
            click trigger:
                script:
                - narrate format:MiningMasterFormat "Just say how much gold you want to pay for XP, or anything else to cancel."