
veteran_bones_drop:
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
            - drop VeteranToken location:<context.entity.location>
            - if <util.random.int[1].to[4]> <= <[multiplier]>:
                - drop VeteranToken quantity:<util.random.int[1].to[2]> location:<context.entity.location>

elite_bones_drop:
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
            - drop VeteranToken quantity:6 location:<context.entity.location>
            - if <util.random.int[1].to[4]> <= <[multiplier]>:
                - drop VeteranToken quantity:<util.random.int[1].to[6]> location:<context.entity.location>