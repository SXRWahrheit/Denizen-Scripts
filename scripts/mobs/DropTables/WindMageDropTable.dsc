wind_mage_drop:
    type: world
    debug: false
    events:
        on entity killed by player:
        - if !<context.entity.name.starts_with[<&d>].if_null[null]>:
            - stop
        - if <context.entity.location.is_within[arena_avenfeld]>:
            - stop
        - else if <proc[AntiFarm_Proc].context[<context.entity>].if_null[null]>:
            - stop
        - else if <context.entity.name.starts_with[<&d>Cultist Wind Mage].if_null[null]>:
            - define multiplier:<proc[DropMultiplierHandler]>
            - if <util.random.int[1].to[300]> <= <[multiplier]>:
                - drop <yaml[droptables].read[wind_mage_weapon_drop_list].random[1]> location:<context.entity.location>
            - else if <util.random.int[1].to[200]> <= <[multiplier]>:
                - drop <yaml[droptables].read[wind_mage_armor_drop_list_sealed_potential].random[1]> location:<context.entity.location>
            - else if <util.random.int[1].to[100]> <= <[multiplier]>:
                - drop <yaml[droptables].read[wind_mage_armor_drop_list].random[1]> location:<context.entity.location>