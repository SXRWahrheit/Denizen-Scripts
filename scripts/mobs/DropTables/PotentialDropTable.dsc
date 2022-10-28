
veteran_potential_drop:
    type: world
    debug: false
    events:
        on entity killed by player:
        - if !<context.entity.name.starts_with[<&9>]||null>:
            - stop
        - if <context.entity.location.is_within[arena_avenfeld]>:
            - stop
        - else if <proc[AntiFarm_Proc].context[<context.entity>]>:
            - stop
        - else if <context.entity.name.starts_with[<&9>]||null>:
            - define multiplier:<proc[DropMultiplierHandler]>
            - if <util.random.int[1].to[400]> <= <[multiplier]>:
                - drop <yaml[droptables].read[veteran_potential_drop_list].random[1]> location:<context.entity.location>
            - if <util.random.int[1].to[15]> <= <[multiplier]>:
                - drop SocketMaker location:<context.entity.location>

elite_potential_drop:
    type: world
    debug: false
    events:
        on entity killed by player:
        - if !<context.entity.name.starts_with[<&d>]||null>:
            - stop
        - if <context.entity.location.is_within[arena_avenfeld]>:
            - stop
        - else if <proc[AntiFarm_Proc].context[<context.entity>]>:
            - stop
        - else if <context.entity.name.starts_with[<&d>]||null>:
            - define multiplier:<proc[DropMultiplierHandler]>
            - if <util.random.int[1].to[200]> <= <[multiplier]>:
                - drop <yaml[droptables].read[veteran_potential_drop_list].random[1]> location:<context.entity.location>
            - if <util.random.int[1].to[400]> <= <[multiplier]>:
                - drop <yaml[droptables].read[elite_potential_drop_list].random[1]> location:<context.entity.location>
            - if <util.random.int[1].to[5]> <= <[multiplier]>:
                - drop SocketMaker location:<context.entity.location>
            - if <util.random.int[1].to[100]> <= <[multiplier]>:
                - drop <yaml[droptables].read[gem_drop_list].random[1]> location:<context.entity.location>
