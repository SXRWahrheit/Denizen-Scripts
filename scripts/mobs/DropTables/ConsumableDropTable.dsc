veteran_consumable_drop:
    type: world
    debug: false
    events:
        on entity killed by player:
        - if !<context.entity.name.starts_with[<&9>]||null>:
            - stop
        - if <context.entity.location.is_within[arena_avenfeld]>:
            - stop
        - else if <context.entity.name.starts_with[<&9>]||null>:
            - define multiplier:<proc[DropMultiplierHandler]>
            - if <util.random.int[1].to[150]> <= <[multiplier]>:
                - drop <yaml[droptables].read[consumable_drop_list].random[1]> location:<context.entity.location>
elite_consumable_drop:
    type: world
    debug: false
    events:
        on entity killed by player:
        - if !<context.entity.name.starts_with[<&d>]||null>:
            - stop
        - if <context.entity.location.is_within[arena_avenfeld]>:
            - stop
        - else if <context.entity.name.starts_with[<&d>]||null>:
            - define multiplier:<proc[DropMultiplierHandler]>
            - if <util.random.int[1].to[50]> <= <[multiplier]>:
                - drop <yaml[droptables].read[consumable_drop_list].random[1]> location:<context.entity.location>