#Needs_Updating
# This thing will manage the shooting range, sending carts and such.
# @author Wahrheit
# @version 1.2
# @last-updated September 30th 2017

Shooting_Range:
    type: assignment
    interact scripts:
    - Target Practice
    actions:
        on assignment:
        - run Slingshot

Range_Master_Format:
    type: format
    format: <gray>Range Master<white><&co> <[text]>

Slingshot:
    type: task
    script:
    - teleport npc location:<npc.anchor[sr1]>
    - trigger name:proximity toggle:true cooldown:0.1s radius:3
    - trigger name:chat toggle:true cooldown:0.1s radius:3

Minecart_listener:
    type: world
    events:
        on player destroys minecart:
#        - announce "Minecart was destroyed!"
        - if <server.flag[range-runs]||0> > 0:
            - if <player.name> == <server.flag[active-player]>:
                - flag server minecarts-hit:++

Roll_Carts:
    type: task
    script:
    - if <server.flag[range-runs]||0> < 10:
        - flag server range-runs:++
        - switch location:<npc.anchor[Minecart<util.random.int[1].to[5]><util.random.int[1].to[2]>]> state:on duration:0.5
        - run Roll_carts delay:6
    - else:
        - flag server range-runs:!
        - flag server range-level:!
        - flag server range-winnings:<server.flag[minecarts-hit].mul[3]>
        - narrate "format:Range Master Format" "Time's up! You won <server.flag[range-winnings]> gold!"
        - give money quantity:<server.flag[range-winnings]>
        - teleport <player> dawnslanding_shooting_range_finished
        - zap "script:Target Practice" "step:In Range"

Target_Practice:
    type: interact
    steps:
        'In Range*':
            proximity trigger:
                entry:
                    radius: 3
                    script:
                    - if <player.money> > 10 narrate "format:Range Master Format" "Hey there <player.name>! Come to practice your aim? It'll cost you 10 gold, but I'll give you 3 for each target! Right click me to start."
                    - if <player.money> == 10 narrate "format:Range Master Format" "Hey there <player.name>! Looks like you've got just enough to play a round, are you up for it? It'll cost 10 gold, but I'll give you 3 per target! Right click me to start."
                    - if <player.money> < 10 narrate "format:Range Master Format" "Hey there <player.name>! Doesn't look like you have enough cash to play, come back later and take a shot or two."
#                    - narrate "format:Range Master Format" "Hey <player.name>, click me if you'd like to shoot!"
                exit:
                    radius: 3
                    script:
                    - narrate "format:Range Master Format" "Thanks for visiting, come back soon."
            click trigger:
                script:
                - if <player.money> >= 10:
                    - narrate "format:Range Master Format" "Click me once more to get started. Make sure you have a bow and arrows!"
                    - zap 'step:Game Start'
                - else:
                    - narrate "format:Range Master Format" "Sorry, you don't have 10 gold so you can't shoot!"

        'Game Start':
            click trigger:
                script:
                - take money quantity:10
                - narrate "format:Range Master Format" "Okay, you've got 1 minute! Good luck!"
                - teleport <player> dawnslanding_shooting_range_start
                - flag server active-player:<player.name>
                - flag server minecarts-hit:0
                - run Roll_Carts