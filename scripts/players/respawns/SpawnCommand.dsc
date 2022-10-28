Spawn_Command:
    type: command
    debug: false
    name: spawn
    description: Return to Dawn's Landing.
    usage: /spawn
    script:
    - if <player.has_flag[channelling_teleport]>:
        - stop
    - if <player.is_op>:
        - teleport <player> spawn
        - narrate "<green>You complete the channel and teleport to Dawn's Landing!"
        - stop
    - define channel_location <player.location>
    - flag <player> channelling_teleport expire:5s
    - narrate "<green>Channeling magic to return you to Dawn's Landing... stay still and don't take damage!"
    - repeat 5:
        - wait 1s
        - if <player.location.distance[<[channel_location]>]> > 1:
            - narrate "<red>You moved and interrupted your channel!"
            - stop
    - if !<player.has_flag[recent_damage]> && <player.location.distance[<[channel_location]>]> < 1:
        - teleport <player> spawn
        - narrate "<green>You complete the channel and teleport to Dawn's Landing!"