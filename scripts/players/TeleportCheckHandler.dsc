Teleport_Check_Handler:
    type: world
    debug: false
    events:
        on player_flagged:channelling_teleport damaged:
        - flag <player> recent_damage expire:5s
        - narrate "<red>You took damage and your channel was interrupted!"