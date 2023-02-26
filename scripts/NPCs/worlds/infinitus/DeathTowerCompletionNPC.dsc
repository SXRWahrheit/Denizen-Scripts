DeathTowerFinishingNPCAssignment:
    type: assignment
    interact scripts:
    - DeathTowerOfferingNPCInteract
    actions:
        on assignment:
        - teleport npc location:<npc.anchor[DeathTowerOfferingNPC]>
        - trigger name:proximity state:true
        - trigger name:chat state:true

DeathTowerFinishingNPCFormat:
    type: format
    format: <gray>He Jumped Death<white><&co> <[text]>

DeathTowerFinishingNPCInteract:
    type: interact
    steps:
        JQ1Quest*:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <yaml[<[data]>].contains[quests.active.DailyJQ_DeathTower]>:
                        - narrate format:DeathTowerOfferingNPCFormat "Hey there, <player.name>! Right click me to complete the course!"
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                - if <yaml[<[data]>].contains[quests.active.DailyJQ_DeathTower]>:
                    - run QuestCompletionHandler def:DailyJQ_DeathTower