HomeOther_Command:
    type: command
    name: homeother
    description: Teleport to the home of another player in this world, if one exists.
    usage: /homeother [player]
    permission: god.homeother
    permission message: <red>YOU DARE TRY TO WIELD THE POWERS OF THE GODS?
    script:
    - if <context.args.size> != 1:
        - narrate "<red>Invalid number of arguments! Usage is /sethome [player]"
        - stop
    - if <server.match_offline_player[<context.args.get[1]>].flag[<player.world.name>_home].exists>:
        - teleport <player> <server.match_offline_player[<context.args.get[1]>].flag[<player.world.name>_home]>
        - narrate "<green>You teleported to <context.args.get[1]>'s home!"