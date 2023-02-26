FishingNewbieAssignment:
    type: assignment
    interact scripts:
    - FishingNewbieInteract
    actions:
        on assignment:
        - teleport npc location:<npc.anchor[fishingnewbie]>
        - trigger name:proximity state:true
        - trigger name:chat state:true

FishingNewbieFormat:
    type: format
    format: <gray>Fishing Newbie<white><&co> <[text]>

FishingNewbieInteract:
    type: interact
    steps:
        Unmet*:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyFishingChallenge]>:
                        - zap DailyFishingChallengeActive
                    - else if <yaml[<[data]>].contains[quests.completed.DailyFishing]>:
                        - zap DailyFishingChallengeOffer
                    - else if <yaml[<[data]>].contains[quests.completed.FindFishingNewbie]>:
                        - zap DailyFishingOffer
                    - else if <yaml[<[data]>].contains[quests.active.FindFishingNewbie]>:
                        - narrate format:FishingNewbieFormat "Oh, hello! The Quest Master sent you, huh? That's so nice of him, he's always looking out for me."
                    - else:
                        - narrate format:FishingNewbieFormat "Oh, hi! I'm trying to learn how to fish. Maybe you can help me!"
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                - if <yaml[<[data]>].contains[quests.active.FindFishingNewbie]>:
                    - run QuestCompletionHandler def:FindFishingNewbie instantly
                    - zap TeachFishingNewbieOffer
        TeachFishingNewbieOffer:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.FindFishingNewbie]>:
                        - narrate format:FishingNewbieFormat "Oh, hello! The Quest Master sent you, huh? That's so nice of him, he's always looking out for me."
                    - else:
                        - narrate format:FishingNewbieFormat "Hi again, <player.name>! Do you think you can help me learn how to fish?"
            click trigger:
                script:
                - narrate format:PlayerChatformat "Sure, I can help you out."
                - run QuestAcceptHandler def:TeachFishingNewbie
                - zap TeachFishingNewbieActive
            chat trigger:
                TeachFishingNewbieOffer:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - narrate format:PlayerChatFormat "Sure, I can help you out."
                    - run QuestAcceptHandler def:TeachFishingNewbie
        TeachFishingNewbieActive:
            proximity trigger:
                entry:
                    script:
                    - narrate format:FishingNewbieFormat "Still fishing, huh? Be sure to look for those bubbles in the water!"
                    - run QuestProgressHandler def:TeachFishingNewbie
        DailiesAvailableCheck:
            proximity trigger:
                entry:
                    script:
                    - inject FishingNewbieDailyQuestsCheck
        DailyFishingOffer:
            proximity trigger:
                entry:
                    script:
                    # If the player does not have a flag indicating a chosen quest, go back to the daily check step and run the check script
                    - if <player.has_flag[FishingNewbieQuest].not>:
                        - zap DailiesAvailableCheck
                        - inject FishingNewbieDailyQuestsCheck
                exit:
                    script:
                    # Remove the chosen quest flag when the player walks away and go back to the daily check step
                    - if <player.has_flag[FishingNewbieQuest]>:
                        - flag <player> FishingNewbieQuest:!
                        - zap DailiesAvailableCheck
            chat trigger:
                FishingQuestAccept:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - if <player.has_flag[FishingNewbieQuest]>:
                        - narrate format:PlayerChatFormat "You got it!"
                        - run QuestAcceptHandler def:<player.flag[FishingNewbieQuest]>
                        - zap DailiesAvailableCheck
            click trigger:
                script:
                - if <player.has_flag[FishingNewbieQuest]>:
                    - narrate format:PlayerChatFormat "You got it!"
                    - run QuestAcceptHandler def:<player.flag[FishingNewbieQuest]>
                    - zap DailiesAvailableCheck


FishingNewbieDailyQuestsCheck:
    type: task
    debug: false
    script:
    - define data <player.uuid>_quest_data
    - if <yaml[<[data]>].contains[quests.active.DailyFishingChallenge]>:
        - narrate format:FishingNewbieFormat "You'd better hurry up if you want to beat my fishing challenge, <player.name>!"
    - else if <yaml[<[data]>].contains[quests.active.DailyFishingChallenge].not> && <yaml[<[data]>].contains[quests.completed.DailyFishing]>:
        - if <yaml[<[data]>].contains[quests.active.DailyFishing]> && <proc[QuestAvailabilityHandler].context[DailyFishingChallenge]>:
            - narrate format:FishingNewbieFormat "Still hooking those fish, huh? If you think you've got what it takes, I have an extra challenge for you, too! Sound like fun?"
            - flag <player> FishingNewbieQuest:DailyFishingChallenge duration:10m
            - zap FishingNewbieInteract DailyFishingOffer duration:10m
        - else:
            - narrate format:FishingNewbieFormat "Still hooking those fish, huh? Keep up the good work! Fishing is so peaceful, it's a nice way to take a break from fighting monsters."
    - else if <proc[QuestAvailabilityHandler].context[DailyFishing]>:
        - narrate format:FishingNewbieFormat "Howdy, <player.name>! You up for catching some more fish?"
        - flag <player> FishingNewbieQuest:DailyFishing duration:10m
        - zap FishingNewbieInteract DailyFishingOffer duration:10m
    - else:
        - narrate format:FishingNewbieFormat "Hey there, <player.name>! Thanks for the help today!"
        - zap FishingNewbieInteract DailiesAvailableCheck

FishingNewbieFishingHandler:
    type: world
    debug: false
    events:
        on player fishes while caught_fish:
        - define data <player.uuid>_quest_data
        - if <yaml[<[data]>].contains[quests.active.DailyFishing].not> && <yaml[<[data]>].contains[quests.active.DailyFishingChallenge].not> && <yaml[<[data]>].contains[quests.active.TeachFishingNewbie].not>:
            - stop
        - if <yaml[<[data]>].contains[quests.active.DailyFishing]>:
            - define quest_internalname DailyFishing
            - define objective 1
            - yaml id:<[data]> set quests.active.DailyFishing.stages.1.objectives.1.progress:++
            - if <yaml[<[data]>].read[quests.active.DailyFishing.stages.1.objectives.1.progress]> >= 16:
                - run QuestCompletionHandler def:DailyFishing
            - else:
                - run QuestProgressHandler def:<[quest_internalname]>|<[objective]> instantly
        - else if <yaml[<[data]>].contains[quests.active.DailyFishingChallenge]>:
            - define quest_internalname DailyFishingChallenge
            - define objective 1
            - yaml id:<[data]> set quests.active.DailyFishingChallenge.stages.1.objectives.1.progress:++
            - if <yaml[<[data]>].read[quests.active.DailyFishingChallenge.stages.1.objectives.1.progress]> >= 32:
                - run QuestCompletionHandler def:DailyFishingChallenge
            - else:
                - run QuestProgressHandler def:<[quest_internalname]>|<[objective]> instantly