# This thing will do arena shit and eventually switch between them
# It was written by Wahrheit and you better believe it
# @author Wahrheit
# @version 1.0
# @last-updated Feb 17 2013

Arena_master:
    type: assignment
    interact scripts:
    - Round 1
    actions:
        on assignment:
        - run SummonPlayersArena

SummonPlayersArena:
    type: task
    script:
    - teleport npc location:<npc.anchor[ma1]>
    - trigger name:proximity toggle:true cooldown:0.1s radius:3
    - trigger name:chat toggle:true cooldown:0.1s radius:3

Round_1:
    type: interact
    steps:
        Player_Seen*:
            proximity trigger:
                entry:
                    radius: 3
                    script:
                    - narrate "<gray>Arena Master<&co> <white>Hey man, you here for a fight? I've got a challenge."
                    - narrate "<gray>Arena Master<&co> <white>Otherwise, just say 'leave' and I'll take you to spawn."
                exit:
                    radius: 3
                    script:
                    - narrate "<gray>Arena Master<&co> <white>Come back when you've got some bigger balls."
            click trigger:
                script:
                - narrate "<gray>Arena Master<&co> <white>If you want to fight, click me again and I'll send you to the prep room."
                - zap Game_On
            chat trigger:
                'Leave':
                    trigger: /leave/
                    script:
                    - execute as_player spawn
        Game_On:
            click trigger:
                script:
                - narrate "<gray>Arena Master<&co> <white>Alright, here you go. Right click a sign and then punch the iron block."
                - execute as_player "ma join Underdome"
                - zap Player_Seen