RoyalGeographerAssignment:
    type: assignment
    debug: false
    interact scripts:
    - RoyalGeographerInteract
    actions:
        on assignment:
        - teleport npc location:<npc.anchor[RoyalGeographer]>
        - trigger name:proximity state:true
        - trigger name:chat state:true

RoyalGeographerFormat:
    type: format
    debug: false
    format: <dark_green>Royal Geographer<white><&co> <[text]>

RoyalGeographerInteract:
    type: interact
    debug: false
    steps:
        Greeting*:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.completed.FindFireTemple]> && <yaml[<[data]>].contains[quests.completed.FindWaterTemple]> && <yaml[<[data]>].contains[quests.completed.UnlockAvenfeld]>:
                        - zap NoRoyalGeographerStorylineQuests
                    - else if <yaml[<[data]>].contains[quests.completed.EliteHunt]>:
                        - if <yaml[<[data]>].contains[quests.active.UnlockAvenfeld]>:
                            - zap UnlockAvenfeldActive
                        - else:
                            - zap UnlockAvenfeldOffer
                    - else if <player.has_flag[RoyalGeographerSeen]>:
                        - zap GeneralDialogue
                        - narrate format:RoyalGeographerFormat "Good day, <player.name>!"
                    - else:
                        - flag <player> RoyalGeographerSeen:true
                        - narrate format:RoyalGeographerFormat "Aha! <player.name>, I presume? Salutations."
                        - zap GeneralDialogue
        GeneralDialogue:
            proximity trigger:
                entry:
                    script:
                    - narrate format:RoyalGeographerFormat "Good day, <player.name>!"
        UnlockAvenfeldOffer:
            proximity trigger:
                entry:
                    script:
                    - narrate format:RoyalGeographerFormat "Hail, <player.name>!"
                    - wait 0.7s
                    - narrate format:RoyalGeographerFormat "I've been looking for an adventurer to take on a challenge - exploring a new world. Can I count on you?"
            click trigger:
                script:
                - narrate format:PlayerChatFormat "Yes, I'm up for anything!"
                - run QuestAcceptHandler def:UnlockAvenfeld
                - zap UnlockAvenfeldActive
            chat trigger:
                UnlockAvenfeldAcceptance:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - narrate format:PlayerChatFormat "Yes, I'm up for anything!"
                    - run QuestAcceptHandler def:UnlockAvenfeld
                    - zap UnlockAvenfeldActive
        UnlockAvenfeldActive:
            proximity trigger:
                entry:
                    script:
                    - narrate format:RoyalGeographerFormat "Good day, <player.name>!"
                    - wait 0.7s
                    - narrate format:RoyalGeographerFormat "Still gathering those ingredients?"
                    - run QuestProgressHandler def:UnlockAvenfeld
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                - define quest_internalname:UnlockAvenfeld
                - if !<yaml[<[data]>].contains[quests.active.<[quest_internalname]>]>:
                    - stop
                - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.current_stage]> == 1:
                    - inject UnlockAvenfeldQuestDeliveryHandler

        FindFireTempleOffer:
            proximity trigger:
                entry:
                    script:
                    - narrate format:RoyalGeographerFormat "Good day, <player.name>!"
                    - wait 0.7s
                    - narrate format:RoyalGeographerFormat "In the south of Prosperus is the Altar of Flame, a sacred altar to the Gods attuned with the element of fire. The Sage of Flame guards a portal there that leads to the Fire Temple."
                    - wait 0.7s
                    - narrate format:RoyalGeographerFormat "I haven't heard from the Sage in some time. Can you please go check on him?"
            click trigger:
                script:
                - narrate format:PlayerChatFormat "You can count on me - I'll go check on the Sage of Flame!"
                - run QuestAcceptHandler def:FindFireTemple
                - zap FindFireTempleActive
            chat trigger:
                FindFireTempleAcceptance:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - narrate format:PlayerChatFormat "You can count on me - I'll go check on the Sage of Flame!"
                    - run QuestAcceptHandler def:FindFireTemple
                    - zap FindFireTempleActive
        FindFireTempleActive:
            proximity trigger:
                entry:
                    script:
                    - narrate format:RoyalGeographerFormat "Good day, <player.name>!"
                    - wait 0.7s
                    - narrate format:RoyalGeographerFormat "Have you found the Altar of Flame yet?"
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.FindFireTemple]> && <yaml[<[data]>].read[quests.active.FindFireTemple.current_stage]> == 2:
                        - run QuestCompletionHandler def:FindFireTemple
                        - zap FindWaterTempleOffer
                    - else:
                        - run QuestProgressHandler def:FindFireTemple
        FindWaterTempleOffer:
            proximity triger:
                entry:
                    script:
                    - narrate format:RoyalGeographerFormat "Good day, <player.name>!"
                    - wait 0.7s
                    - narrate format:RoyalGeographerFormat "In the northern waters of Prosperus is the Altar of Water, a sacred altar to the Gods attuned with the element of water. The Sage of Water guards a portal there that leads to the Water Temple."
                    - wait 0.7s
                    - narrate format:RoyalGeographerFormat "I haven't heard from the Sage in some time. Can you please go check on him?"
            click trigger:
                script:
                - narrate format:PlayerChatFormat "You can count on me - I'll go check on the Sage of Water!"
                - run QuestAcceptHandler def:FindWaterTemple
                - zap FindWaterTempleActive
            chat trigger:
                FindWaterTempleAcceptance:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - narrate format:PlayerChatFormat "You can count on me - I'll go check on the Sage of Water!"
                    - run QuestAcceptHandler def:FindWaterTemple
                    - zap FindWaterTempleActive
        FindWaterTempleActive:
            proximity trigger:
                entry:
                    script:
                    - narrate format:RoyalGeographerFormat "Good day, <player.name>!"
                    - wait 0.7s
                    - narrate format:RoyalGeographerFormat "Have you found the Altar of Water yet?"
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.FindWaterTemple]> && <yaml[<[data]>].read[quests.active.FindWaterTemple.current_stage]> == 2:
                        - run QuestCompletionHandler def:FindWaterTemple
                        - zap NoRoyalGeographerStorylineQuests
                    - else:
                        - run QuestProgressHandler def:FindWaterTemple
        NoRoyalGeographerStorylineQuests:
            proximity trigger:
                entry:
                    script:
                    - narrate format:RoyalGeographerFormat "Good day, <player.name>!"
                    - wait 0.7s
                    - narrate format:RoyalGeographerFormat "How goes your adventuring?"

RoyalGeographerWeeklyQuestsCheck:
    type: task
    debug: false
    script:
    - if <yaml[<[data]>].contains[quests.active.EliteHunt]>:
        - if <proc[QuestsAvailableHandler].context[RoyalGeographer]>:
            - narrate format:RoyalGeographerFormat "You're doing a good job hunting those Elites, but I've got more for you, too."
    - else if <yaml[<[data]>].contains[quests.active.VeteranHunt]>:
        - if <proc[QuestsAvailableHandler].context[RoyalGeographer]>:
            - narrate format:RoyalGeographerFormat "You're doing a good job hunting those Veterans, but I've got more for you, too."
    - else if <proc[QuestsAvailableHandler].context[RoyalGeographer]>:
        - narrate format:RoyalGeographerFormat "I've got some work for you. Are you ready to get back out there?"