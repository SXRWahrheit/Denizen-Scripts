SetHome_Command:
    type: command
    name: sethome
    description: Set your home in this world.
    usage: /sethome
    script:
    - if <location[<player.flag[<player.world.name>_home]>].exists> && !<player.has_flag[confirm_sethome]>:
        - narrate "<red>You already have a home in this world! Use this command again in the next 10 seconds to confirm you want to override it."
        - flag <player> confirm_sethome expire:10s
    - else if <location[<player.flag[<player.world.name>_home]>].exists> && <player.has_flag[confirm_sethome]>:
        - flag <player> <player.world.name>_home:<player.location>
        - narrate "<green>Your home for this world has been saved!"
    - else if !<location[<player.flag[<player.world.name>_home]>].exists>:
        - flag <player> <player.world.name>_home:<player.location>
        - narrate "<green>Your home for this world has been saved!"
    - else:
        - narrate "<red>Something has gone wrong! Tell Wahrheit!"