Home_Command:
    type: command
    debug: false
    name: home
    description: Return to your home in this world, if one exists.
    usage: /home
    script:
    - if <player.has_flag[channelling_teleport]>:
        - stop
    - if <player.flag[<player.world.name>_home].exists>:
        - if <player.is_op>:
            - teleport <player> <player.flag[<player.world.name>_home]>
            - narrate "<green>You complete the channel and teleport to your home!"
            - stop
        - define channel_location <player.location>
        - flag <player> channelling_teleport expire:5s
        - narrate "<green>Channeling magic to return you to to your home... stay still and don't take damage!"
        - repeat 5:
            - wait 1s
            - if <player.location.distance[<[channel_location]>]> > 1:
                - narrate "<red>You moved and interrupted your channel!"
                - stop
        - if !<player.has_flag[recent_damage]> && <player.location.distance[<[channel_location]>]> < 1:
            - teleport <player> <player.flag[<player.world.name>_home]>
            - narrate "<green>You complete the channel and teleport to your home!"
    - else:
        - narrate "<red>You haven't saved a home in this world!"