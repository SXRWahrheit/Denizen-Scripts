BookkeeperAssignment:
    type: assignment
    interact scripts:
    - BookkeeperInteract
    actions:
        on assignment:
        - teleport npc location:<npc.anchor[Bookkeeper]>
        - trigger name:proximity state:true
        - trigger name:chat state:true

BookkeeperFormat:
    type: format
    format: <gray>Bookkeeper<white><&co> <[text]>

BookkeeperInteract:
    type: interact
    steps:
        DailyLibraryQuestOffer*:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyLibrary]>:
                        - narrate format:BookkeeperFormat "Hey <player.name>, on your way to find the Quest Master?"
                        - zap DailyLibraryQuestDelivery
                    - else if <yaml[<[data]>].contains[quests.active.DailyLibrary].not> && <proc[QuestAvailabilityHandler].context[DailyLibrary]>:
                        - narrate format:BookkeeperFormat "Congratulations on navigating the Grand Library, <player.name>!"
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                - if <yaml[<[data]>].contains[quests.active.DailyLibrary].not> && <proc[QuestAvailabilityHandler].context[DailyLibrary]>:
                    - run QuestAcceptHandler def:DailyLibrary
            chat trigger:
                DailyLibraryAccept:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyLibrary].not> && <proc[QuestAvailabilityHandler].context[DailyLibrary]>:
                        - run QuestAcceptHandler def:DailyLibrary
        DailyLibraryQuestDelivery:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyLibrary]>:
                        - narrate format:BookkeeperFormat "Hey <player.name>, on your way to find the Quest Master?"
                    - else:
                        - zap DailyLibraryQuestOffer