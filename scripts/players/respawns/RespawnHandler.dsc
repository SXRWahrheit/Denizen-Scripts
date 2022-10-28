Respawn_Handler:
    type: world
    debug: false
    events:
        on player dies in:infinitus:
        - flag <player> death_world:infinitus
        on player respawns:
        - choose <player.flag[death_world].if_null[prosperus]>:
            - case infinitus:
                - determine <player.flag[<player.world.name>_home].if_null[<location[GodsTowerSpawn]>]>
            - case prosperus:
                - determine <location[spawn]>