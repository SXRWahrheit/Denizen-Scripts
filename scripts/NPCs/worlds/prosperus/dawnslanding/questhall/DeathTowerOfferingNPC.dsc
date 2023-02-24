DeathTowerOfferingNPCAssignment:
    type: assignment
    interact scripts:
    - DeathTowerOfferingNPCInteract
    actions:
        on assignment:
        - teleport npc location:<npc.anchor[DeathTowerOfferingNPC]>
        - trigger name:proximity state:true
        - trigger name:chat state:true

DeathTowerOfferingNPCFormat:
    type: format
    format: <gray>He Jumps Once<white><&co> <[text]>

DeathTowerOfferingNPCInteract:
    type: interact
    steps:
        DeathTowerQuest*:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyJQ_DeathTower]>:
                        - narrate format:DeathTowerOfferingNPCFormat "Hey, do you want to go back to the jump quest course?"
                    - else if <yaml[<[data]>].contains[quests.active.DailyJQ_DeathTower].not> && <proc[QuestAvailabilityHandler].context[DailyJQ_DeathTower]>:
                        - narrate format:DeathTowerOfferingNPCFormat "Looking for a jumping challenge? I can send you to a faraway land where you can test your parkour skills. Complete the course for a reward!"
            click trigger:
                script:
                - if <yaml[<[data]>].contains[quests.active.DailyJQ_DeathTower].not> && <proc[QuestAvailabilityHandler].context[DailyJQ_DeathTower]>:
                    - run QuestAcceptHandler def:DailyJQ_DeathTower
                    - teleport <player> <location[-68.45822017098273,115.5,-76.65867088499863,-9.83225154876709,-178.91549682617188,infinitus]>
            chat trigger:
                DeathTowerQuestAccept:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - if <yaml[<[data]>].contains[quests.active.DailyJQ_DeathTower].not> && <proc[QuestAvailabilityHandler].context[DailyJQ_DeathTower]>:
                        - run QuestAcceptHandler def:DailyJQ_DeathTower
                        - teleport <player> <location[-68.45822017098273,115.5,-76.65867088499863,-9.83225154876709,-178.91549682617188,infinitus]>