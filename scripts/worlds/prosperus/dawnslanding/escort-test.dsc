# This thing handles the first stripper in the leaky bucket
# It was written by Wahrheit and you better believe it
# @author Wahrheit
# @version 1.0
# @last-updated June 27 2013

Destiny:
    type: assignment
    interact scripts:
    - Busta Move
    actions:
        on assignment:
        - run Dance_with_me

Dance_With_Me:
    type: task
    script:
    - trigger name:proximity toggle:true cooldown:0.1s radius:3

Get_Funky:
    type: task
    script:
    - sit location:287.5,79,129.5,prosperus
    - random 4
    - wait 10.5s
    - wait 10.25s
    - wait 11s
    - wait 10.75s
    - stand
    - if <player.flag[strip1]> == 1:
        - run Get_Funky
Busta_Move:
    type: interact
    steps:
        'Dirty Dancing*':
            proximity trigger:
                entry:
                    radius: 3
                    script:
                    - run Get_Funky
                    - flag <player> strip1:1
                exit:
                    radius: 3
                    script:
                    - stand
                    - flag <player> strip1:1