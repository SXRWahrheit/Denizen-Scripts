WarmasterReinwaldAssignment:
    type: assignment
    debug: false
    interact scripts:
    - WarmasterReinwaldInteract
    actions:
        on assignment:
        - teleport npc location:<npc.anchor[warmasterreinwald]>
        - trigger name:proximity state:true
        - trigger name:chat state:true
        - trigger name:click state:true

WarmasterReinwaldFormat:
    type: format
    debug: false
    format: "<dark_green>Warmaster Reinwald<white><&co> <[text]>"

WarmasterReinwaldInteract:
    type: interact
    debug: false
    speed: 0
    steps:
        Greeting*:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.completed.EliteHunt]>:
                        - zap EliteHuntCompleted
                    - else if <yaml[<[data]>].contains[quests.completed.LichHunt]>:
                        - if <yaml[<[data]>].contains[quests.active.EliteHunt]>:
                            - zap EliteHuntActive
                        - else:
                            - zap EliteHuntOffer
                    - else if <yaml[<[data]>].contains[quests.completed.VeteranHunt]>:
                        - if <yaml[<[data]>].contains[quests.active.LichHunt]>:
                            - zap LichHuntActive
                        - else:
                            - zap LichHuntOffer
                    - else if <yaml[<[data]>].contains[quests.completed.SkeletalRogueHunt]>:
                        - if <yaml[<[data]>].contains[quests.active.VeteranHunt]>:
                            - zap VeteranHuntActive
                        - else:
                            - zap VeteranHuntOffer
                    - else if <yaml[<[data]>].contains[quests.completed.FirstMobHunting]>:
                        - if <yaml[<[data]>].contains[quests.active.SkeletalRogueHunt]>:
                            - zap SkeletalRogueHuntActive
                        - else:
                            - zap SkeletalRogueHuntOffer
                    - else if <yaml[<[data]>].contains[quests.completed.FindReinwald]>:
                        - if <yaml[<[data]>].contains[quests.active.FirstMobHunting]>:
                            - zap FirstMobHuntingActive
                        - else:
                            - zap FirstMobHuntingOffer
                    - else if <player.has_flag[ReinwaldSeen]>:
                        - zap GeneralDialogue
                        - narrate format:WarmasterReinwaldFormat "Hail, <player.name>!"
                    - else:
                        - flag <player> ReinwaldSeen:true
                        - narrate format:WarmasterReinwaldFormat "Hail, <player.name>! Pleasure to meet you. Here to help with the fight against the darkness?"
                        - zap GeneralDialogue
            click trigger:
                script:
                - cooldown 5s
                - define data <player.uuid>_quest_data
                - if <yaml[<[data]>].contains[quests.active.FindReinwald]>:
                    - run QuestCompletionHandler def:FindReinwald instantly
                    - zap FirstMobHuntingOffer
        GeneralDialogue:
            proximity trigger:
                entry:
                    script:
                    - narrate format:WarmasterReinwaldFormat "Hail, <player.name>!"
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.FindReinwald]>:
                        - wait 0.7s
                        - narrate format:WarmasterReinwaldFormat "Did the Quest Master send you?"
                        - narrate "<gray>Right-click Reinwald to complete the quest!"
            click trigger:
                script:
                - cooldown 5s
                - define data <player.uuid>_quest_data
                - if <yaml[<[data]>].contains[quests.active.FindReinwald]>:
                    - run QuestCompletionHandler def:FindReinwald instantly
                    - zap FirstMobHuntingOffer
        FirstMobHuntingOffer:
            proximity trigger:
                entry:
                    script:
                    - narrate format:WarmasterReinwaldFormat "Hail, <player.name>!"
                    - wait 0.7s
                    - narrate format:WarmasterReinwaldFormat "You look like you're just about ready to start hunting some monsters. How about it?"
            click trigger:
                script:
                - cooldown 5s
                - narrate format:PlayerChatFormat "Absolutely, I'm ready to fight back!"
                - run QuestAcceptHandler def:FirstMobHunting instantly
                - zap FirstMobHuntingActive
            chat trigger:
                FirstMobHuntingAcceptance:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - cooldown 5s
                    - narrate format:PlayerChatFormat "Absolutely, I'm ready to fight back!"
                    - run QuestAcceptHandler def:FirstMobHunting instantly
                    - zap FirstMobHuntingActive
        FirstMobHuntingActive:
            proximity trigger:
                entry:
                    script:
                    - narrate format:WarmasterReinwaldFormat "Hail, <player.name>!"
                    - wait 0.7s
                    - narrate format:WarmasterReinwaldFormat "How is your hunt going?"
                    - run QuestProgressHandler def:FirstMobHunting instantly
        SkeletalRogueHuntOffer:
            proximity trigger:
                entry:
                    script:
                    - narrate format:WarmasterReinwaldFormat "Hail, <player.name>!"
                    - wait 0.7s
                    - narrate format:WarmasterReinwaldFormat "You've fought your first monsters, but the darkness is growing. When you're ready, I have your next challenge - I need you to hunt and kill Skeletal Rogues."
                    - wait 0.7s
                    - narrate format:WarmasterReinwaldFormat "Skeletal Rogues are what we classify as '<&9>Veteran<&f>' monsters. They're going to put up much more of a fight, but I think you can take 'em."
            click trigger:
                script:
                - cooldown 5s
                - narrate format:PlayerChatFormat "I'm not afraid - I'm ready to hunt those Skeletal Rogues!"
                - run QuestAcceptHandler def:SkeletalRogueHunt instantly
                - zap SkeletalRogueHuntActive
            chat trigger:
                SkeletalRogueHuntAcceptance:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - cooldown 5s
                    - narrate format:PlayerChatFormat "I'm not afraid - I'm ready to hunt those Skeletal Rogues!"
                    - run QuestAcceptHandler def:SkeletalRogueHunt instantly
                    - zap SkeletalRogueHuntActive
        SkeletalRogueHuntActive:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.completed.SkeletalRogueHunt]>:
                        - narrate format:WarmasterReinwaldFormat "Hail, <player.name>!"
                        - wait 0.7s
                        - narrate format:WarmasterReinwaldFormat "Skeletal Rogues were just the beginning of your endeavors - there are far more Veteran monsters out there, and as soon as you're ready, we need you to slay as many as you can."
                        - zap VeteranHuntOffer
                        - stop
                    - narrate format:WarmasterReinwaldFormat "Hail, <player.name>!"
                    - wait 0.7s
                    - narrate format:WarmasterReinwaldFormat "Still hunting for those Skeletal Rogues? Don't let them get your spirits down! Be sure to bring a shield."
                    - run QuestProgressHandler def:SkeletalRogueHunt instantly
        VeteranHuntOffer:
            proximity triger:
                entry:
                    script:
                    - narrate format:WarmasterReinwaldFormat "Hail, <player.name>!"
                    - wait 0.7s
                    - narrate format:WarmasterReinwaldFormat "Skeletal Rogues were just the beginning of your endeavors - there are far more Veteran monsters out there, and as soon as you're ready, we need you to slay as many as you can."
            click trigger:
                script:
                - cooldown 5s
                - narrate format:PlayerChatFormat "Those Veterans won't know what's coming!"
                - run QuestAcceptHandler def:VeteranHunt instantly
                - zap VeteranHuntActive
            chat trigger:
                SkeletalRogueHuntAcceptance:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - cooldown 5s
                    - narrate format:PlayerChatFormat "Those Veterans won't know what's coming!"
                    - run QuestAcceptHandler def:VeteranHunt instantly
                    - zap VeteranHuntActive
        VeteranHuntActive:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.completed.VeteranHunt]>:
                        - narrate format:WarmasterReinwaldFormat "Hail, <player.name>!"
                        - wait 0.7s
                        - narrate format:WarmasterReinwaldFormat "You've slain your fair share of Veterans by now, so it's time to move on to something a little more challenging."
                        - zap LichHuntOffer
                        - stop
                    - narrate format:WarmasterReinwaldFormat "Hail, <player.name>!"
                    - wait 0.7s
                    - narrate format:WarmasterReinwaldFormat "You're making great strides against the darkness - keep hunting down those Veterans!"
                    - run QuestProgressHandler def:VeteranHunt instantly
        LichHuntOffer:
            proximity trigger:
                entry:
                    script:
                    - narrate format:WarmasterReinwaldFormat "Hail, <player.name>!"
                    - wait 0.7s
                    - narrate format:WarmasterReinwaldFormat "You've slain your fair share of Veterans by now, so it's time to move on to something a little more challenging."
                    - wait 0.7s
                    - narrate format:WarmasterReinwaldFormat "It's time for you to hunt a monster that we classify as an '<&d>Elite<&f>'. They're even tougher than Veterans, and substantially more clever. Are you up to the task?"
            click trigger:
                script:
                - cooldown 5s
                - narrate format:PlayerChatFormat "What's one more zombie on the pile? I'm in!"
                - run QuestAcceptHandler def:LichHunt instantly
                - zap LichHuntActive
            chat trigger:
                LichHuntAcceptance:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - narrate format:PlayerChatFormat "What's one more zombie on the pile? I'm in!"
                    - run QuestAcceptHandler def:LichHunt instantly
                    - zap LichHuntActive
        LichHuntActive:
            proximity trigger:
                entry:
                    script:
                    - narrate format:WarmasterReinwaldFormat "Hail, <player.name>!"
                    - wait 0.7s
                    - narrate format:WarmasterReinwaldFormat "Be careful when you go and hunt that Lich - it won't hold anything back!"
                    - run QuestProgressHandler def:LichHunt instantly
        EliteHuntOffer:
            proximity trigger:
                entry:
                    script:
                    - narrate format:WarmasterReinwaldFormat "Hail, <player.name>!"
                    - wait 0.7s
                    - narrate format:WarmasterReinwaldFormat "You've slain your first Elite, and thus proven that you're ready to take on the Elite ranks in greater numbers. You know what I'm about to ask - go and crush them wherever they are."
            click trigger:
                script:
                - narrate format:PlayerChatFormat "I've come so far - I know I can do this!"
                - run QuestAcceptHandler def:EliteHunt instantly
                - zap EliteHuntActive
            chat trigger:
                EliteHuntAcceptance:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - narrate format:PlayerChatFormat "I've come so far - I know I can do this!"
                    - run QuestAcceptHandler def:EliteHunt instantly
                    - zap EliteHuntActive
        EliteHuntActive:
            proximity trigger:
                entry:
                    script:
                    - narrate format:WarmasterReinwaldFormat "Hail, <player.name>!"
                    - wait 0.7s
                    - narrate format:WarmasterReinwaldFormat "Your efforts to push back the darkness make us all proud. Keep hunting those Elites!"
                    - run QuestProgressHandler def:EliteHunt instantly
        EliteHuntComplete:
            proximity trigger:
                entry:
                    script:
                    - narrate format:WarmasterReinwaldFormat "Hail, <player.name>!"
                    - wait 0.7s
                    - narrate format:WarmasterReinwaldFormat "Now that you've proven you're a reliable recruit, I'm willing to share some of the war coffers with you. In exchange for you slaying more Veterans and Elites, of course!"
                    - wait 0.7s
                    - narrate format:WarmasterReinwaldFormat "Each week, if you can take down enough baddies, I'll share some extra loot with you. Just be sure to come find me!"
                    - narrate "<gray>Right-click Warmaster Reinwald to view available quests!"
                    - zap NoReinwaldStorylineQuests
        NoReinwaldStorylineQuests:
            proximity trigger:
                entry:
                    script:
                    - narrate format:WarmasterReinwaldFormat "Hail, <player.name>!"
                    - wait 0.7s
                    - narrate format:WarmasterReinwaldFormat "What fortunes do you bring your Warmaster today?"
                    - narrate "<gray>Weekly quests coming soon!"
                    #- run ReinwaldWeeklyQuestsCheck
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                # Let's try making a menu!
                # Active quests first, if any
                - define npc_name WarmasterReinwald
                - if <proc[ActiveQuestsCheck].context[<[npc_name]>].size.if_null[0]> > 0:
                    - inject ActiveQuestInventoryGUIHandler
                    - stop
                # Available quests next, if any
                - if <proc[QuestsAvailableHandler].context[<[npc_name]>].if_null[false]>:
                    - inject AvailableQuestInventoryGUIHandler
                    - stop
                - else:
                    - if <yaml[<[data]>].contains[quests.active.WeeklyEliteHunt]> || <yaml[<[data]>].contains[quests.active.WeeklyVeteranHunt]>:
                        - narrate format:WarmasterReinwaldFormat "I appreciate your enthusiasm! But you've got all the quests I have to offer right now - keep up the hunt."

ReinwaldWeeklyQuestsCheck:
    type: task
    debug: false
    defintions: data
    script:
    - define data <player.uuid>_quest_data
    - if <yaml[<[data]>].contains[quests.active.EliteHunt]>:
        - if <proc[QuestsAvailableHandler].context[WarmasterReinwald]>:
            - narrate format:WarmasterReinwaldFormat "You're doing a good job hunting those Elites, but I've got more for you, too."
    - else if <yaml[<[data]>].contains[quests.active.VeteranHunt]>:
        - if <proc[QuestsAvailableHandler].context[WarmasterReinwald]>:
            - narrate format:WarmasterReinwaldFormat "You're doing a good job hunting those Veterans, but I've got more for you, too."
    - else if <proc[QuestsAvailableHandler].context[WarmasterReinwald]>:
        - narrate format:WarmasterReinwaldFormat "I've got some work for you. Are you ready to get back out there?"