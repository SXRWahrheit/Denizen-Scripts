Adventurers_Crystal:
    type: item
    material: prismarine_crystals
    debug: false
    display name: <&a>Adventurer's Crystal
    data:
        lore_list:
        - <aqua>A powerful crystal imbued with spatial magic. When activated, it will teleport you to a random location just beyond Dawn's Landing.
    enchantments:
    - MENDING:1
    flags:
        uncraftable: true
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        hides:
        - enchants
        custom_model_data: 100001

Spawn_Escape_Handler:
    type: world
    debug: true
    events:
        on player right clicks block with:Adventurers_Crystal:
        - determine passively cancelled
        - if <player.has_flag[channelling_teleport]>:
            - stop
        - if <player.is_op>:
            - teleport <player> <server.flag[leave_spawn_teleport_locations].random>
            - narrate "<green>You complete the channel and activate the magic of the Adventurer's Crystal!"
            - stop
        - define channel_location <player.location>
        - flag <player> channelling_teleport expire:5s
        - narrate "<green>Channeling the magic of the Adventurer's Crystal to teleport you outside of Dawn's Landing... stay still and don't take damage!"
        - repeat 5:
            - wait 1s
            - if <player.location.distance[<[channel_location]>]> > 1:
                - narrate "<red>You moved and interrupted your channel!"
                - stop
            - if !<player.inventory.contains_item[Adventurers_Crystal]>:
                - narrate "<red>You dropped your Adventurer's Crystal and interrupted your channel!"
                - stop
        - if !<player.has_flag[recent_damage]> && <player.location.distance[<[channel_location]>]> < 1:
            - take item:Adventurers_Crystal
            - teleport <player> <server.flag[leave_spawn_teleport_locations].random>
            - narrate "<green>You complete the channel and activate the magic of the Adventurer's Crystal!"
            - if !<player.flag[<player.world.name>_home].exists>:
                - flag <player> <player.world.name>_home:<player.location>
                - narrate "<green>Because you did not already have a home saved, you also used your magic to set your home here!"
                - narrate "<green>Return to this point at any time with the <aqua>/home<green> command!"
                - narrate "<green>If you want to set a new home, just use <aqua>/sethome<green> - but note that you are only powerful enough to save one home per world!"