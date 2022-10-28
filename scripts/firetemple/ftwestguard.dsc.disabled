# This thing handles west guard in the fire temple
# It was written by Wahrheit and you better believe it
# @author Wahrheit
# @version 1.0
# @last-updated July 1 2013

"West Guard":
    type: assignment
    interact scripts:
    - Player Approaches
    actions:
        on assignment:
        - runtask 'script:West Challenge' instant
        
"West Challenge":
    type: task
    script:
    - teleport npc location:<npc.anchor[ftwest]>
    - trigger name:proximity toggle:true cooldown:0.1s radius:3
    
"Wave1":
    type: task
    script:
    - execute as_npc "spawnmob zombie 15 -55,65,-32"
    - listen kill script:Wave2 id:Wave1 type:entity target:zombie qty:10
"Wave2":
    type: task
    script:
    - execute as_npc "spawnmob magmacube 15 -55,65,-32"
    - listen kill script:Wave3 id:Wave2 type:entity target:Magma_Cube qty:10
"Wave3":
    type: task
    script:
    - execute as_npc "spawnmob spider 10 -55,65,-32"
    - listen kill script:wave4 id:wave3 type:entity target:spider qty:5
"Wave4":
    type: task
    script:
    - execute as_npc "spawnmob slime 10 -55,65,-32"
    - listen kill script:Completed id:wave4 type:entity target:slime qty:5
"Completed":
    type: task
    script:
    - switch state:off location:2,74,1,ultimatus
    - narrate "format:Fire Guard Format" "Well done, <player.name>. I have placed my key."
    - switch state:on location:-1,74,4,ultimatus
    - zap "script:Player Approaches" step:Winner
    
"Player Approaches":
    type: interact
    steps:
        'Entry*':
            proximity trigger:
                entry:
                    radius: 3
                    script:
                    - narrate "format:Fire Guard Format" "Hello, <player.name>. The great God of fire presents you with a challenge."
                    - narrate "format:Fire Guard Format" "If you wish to begin, right click me."
            click trigger:
                script:
                - narrate "format:Fire Guard Format" "Alright, here we go."
                - switch state:on location:2,74,1,ultimatus
                - runtask 'script:Wave1' instant
                - zap step:Fight
        'Fight':
            click trigger:
                script:
                - narrate "format:Fire Guard Format" "You must survive! Fight off the beasts!"
        'Winner':
            click trigger:
                script:
                - narrate "format:Fire Guard Format" "You have already bested this challenge."
#            chat trigger:
#                'Repeat':
#                    trigger: 'Please /repeat/ the challenge.'
#                    script:
#                    - narrate "format:Fire Guard Format" "Very well. Challenge reset."
#                    - switch state:off location:-1,74,4,ultimatus
#                    - zap step:Entry