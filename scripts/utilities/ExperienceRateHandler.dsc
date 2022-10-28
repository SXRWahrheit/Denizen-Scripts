experience_rate_handler:
    type: world
    debug: false
    events:
        on player changes xp:
        - if <context.amount> > 0:
            - define exp_rate 1
            - if <yaml[rates].read[experience.active]>:
                - define exp_rate <yaml[rates].read[experience.multiplier]>
            - if <player.has_flag[player_experience_rate]>:
                - define exp_rate <[exp_rate].mul[<player.flag[player_experience_rate]>]>
            - determine <context.amount.mul[<[exp_rate]>]>