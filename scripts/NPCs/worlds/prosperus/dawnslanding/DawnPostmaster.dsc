DawnPostmasterAssignment:
    type: assignment
    interact scripts:
    - DawnPostmasterInteract
    actions:
        on assignment:
        - teleport npc location:<npc.anchor[dawnpostmaster]>
        - trigger name:proximity state:true
        - trigger name:chat state:true
    
DawnPostmasterFormat:
    type: format
    format: "<darkgreen>Dawn Postmaster<white><&co> <[text]>"

DawnPostmasterInteract:
    type: interact
    steps:
        Unmet*:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.MeetPostmaster]>:
                        - narrate format:DawnPostmasterFormat "<player.name>, is it? And the Quest Master sent you?"
                        - zap MeetPostmasterActive
                    - else if <yaml[<[data]>].contains[quests.completed.MeetPostmaster]>:
                        - zap GenericDialogue
                    - else:
                        - narrate format:DawnPostmasterFormat "Welcome to the Dawn's Landing Post Office! If you haven't already started working with the Quest Master, I recommend you go see what he has to offer."
                    - zap TeachDawnPostmasterOffer
        MeetPostmasterActive:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.MeetPostmaster]>:
                        - narrate format:DawnPostmasterFormat "<player.name>, is it? And the Quest Master sent you?"
            click trigger:
                script:
                - narrate format:PlayerChatformat "He sure did!"
                - run QuestAcceptHandlerQuestCompletionHandler def:MeetPostmaster
                - zap GenericDialogue
        GenericDialogue:
            proximity trigger:
                entry:
                    script:
                    - if <yaml[<[data]>].contains[quests.active.FindDawnPostmaster]>:
                        - narrate format:DawnPostmasterFormat "Oh, hello! The Quest Master sent you, huh? That's so nice of him, he's always looking out for me."
                    - else:
                        - narrate format:DawnPostmasterFormat "Hi again, <player.name>! Have you visited all the settlements of Prosperus yet?"
            click trigger:
                script:
                - narrate format:PlayerChatformat "He sure did!"
                - run QuestAcceptHandlerQuestCompletionHandler def:MeetPOstmaster
                - zap TeachDawnPostmasterActive
            chat trigger:
                TeachDawnPostmasterOffer:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - narrate format:PlayerChatFormat "Sure, I can help you out."
                    - run QuestAcceptHandler def:TeachDawnPostmaster