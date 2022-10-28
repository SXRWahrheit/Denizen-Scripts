# This thing handles the first stripper in the leaky bucket
# It was written by Wahrheit and you better believe it
# @author Wahrheit
# @version 1.0
# @last-updated June 27 2013

"Destiny":
    type: assignment
    interact scripts:
    - Busta Move
    actions:
        on assignment:
        - runtask 'script:Dance with me' instant
        
"Dance with me":
    type: task
    script:
    - trigger name:proximity toggle:true cooldown:0.1s radius:3
    
"Get Funky":
    type: task
    script:
    - sit location:287.5,79,129.5,prosperus
    - random 4
    - wait 10.5s
    - wait 10.25s
    - wait 11s
    - wait 10.75s
    - stand
    - if <flag.p:strip1> == 1 runtask "script:Get Funky" "queue:<util.random.uuid>"
"Busta Move":
    type: interact
    steps:
        'Dirty Dancing*':
            proximity trigger:
                entry:
                    radius: 3
                    script:
                    - runtask "script:Get Funky" instant
                    - flag strip1:1
                exit:
                    radius: 3
                    script:
                    - stand
                    - flag strip1:0