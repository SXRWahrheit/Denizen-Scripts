"Bed Percentage":
    type: world
    events:
        on player enters bed:
        - flag server bedcount.<player.world.name>:->:<player>
        - if <server.flag[bedcount.<player.world.name>].as_list.size> >= <player.world.players.size.div[2]>:
            - adjust <player.world> time:600
            - animate <server.flag[bedcount.<player.world.name>].as_list> animation:stop_sleeping
            - flag server bedcount.<player.world.name>:!
        on player leaves bed:
        - flag server bedcount.<player.world.name>:<-:<player>