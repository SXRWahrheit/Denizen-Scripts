experience_rate_announcement:
    type: world
    debug: false
    events:
        on player joins:
        - if <yaml[events].read[tribute.active]>:
            - stop
        - if <yaml[rates].read[experience.active]>:
            - wait 4s
            - narrate "<&a><yaml[rates].read[experience.multiplier]>x Experience event active! <&6>Monsters you slay will drop <yaml[rates].read[experience.multiplier]>x experience!"