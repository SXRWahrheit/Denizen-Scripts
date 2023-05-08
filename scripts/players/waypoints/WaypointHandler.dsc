Waypoint_Command:
    type: command
    name: ftw
    description: View unlocked waypoints. Travel to one by selecting it from the menu.
    usage: /ftw
    script:
    - inventory open d:Waypoint_Inventory
    #- if <player.gamemode> == survival:
    #    - fakeitem <item[air].repeat_as_list[36]> slot:1 player_only

Waypoint_Add_Command:
    type: command
    name: ftwadd
    description: Adds a new waypoint to the server.
    usage: /ftwadd [name] [display] [material] [description]
    permission: god.ftwadd
    permission message: <red>YOU DARE TRY TO WIELD THE POWERS OF THE GODS?
    script:
    - if <context.args.size> < 4:
        - narrate "<red>Arguments missing! Usage: /ftwadd [name] <&dq>[display]<&dq> [material] <&dq>[description]<&dq>"
        - stop
    - if <context.args.size> > 4:
        - narrate "<red>Too many arguments! Don't forget to <&dq>quote<&dq> the display name and description!"
        - stop
    - if <location[<context.args.get[1]>].if_null[false]>:
        - narrate "<red>Waypoint already exists - use /ftwset to update!"
        - stop
    - note <player.location> as:waypoint_<context.args.get[1]>
    - note <player.location.sub[5,5,5].to_cuboid[<player.location.add[5,5,5]>]> as:waypoint_<context.args.get[1]>_cuboid
    - flag server waypoints:<server.flag[waypoints].include[<map.with[<context.args.get[1]>].as[<map.with[display].as[<context.args.get[2]>].with[material].as[<context.args.get[3]>].with[description].as[<context.args.get[4]>]>]>]>
    - narrate "Waypoint <green><context.args.get[1]> added with data: <map.with[<context.args.get[1]>].as[<map.with[display].as[<context.args.get[2]>].with[material].as[<context.args.get[3]>].with[description].as[<context.args.get[4]>]>]>"

Waypoint_Set_Command:
    type: command
    name: ftwset
    description: Modifies an existing waypoint.
    usage: /ftwset name [display/material/description/location] [value]
    permission: god.ftwset
    permission message: <red>YOU DARE TRY TO WIELD THE POWERS OF THE GODS?
    tab completions:
        1: <server.flag[waypoints].keys>
        2: display|material|description|location

    script:
    - if <context.args.size> > 3:
        - narrate "<red>Too many arguments! Modify one attribute at a time."
        - stop
    - if <context.args.size> < 3 && <context.args.get[2]> != location:
        - narrate "<red>Insufficient arguments! Must specify both attribute and value, e.g. <green>/ftwset [waypoint] material bone"
        - stop
    - if !<server.has_flag[waypoints.<context.args.get[1]>]>:
        - narrate "<red>Waypoint <bold><context.args.get[1]> <red>does not exist!"
        - stop
    - choose <context.args.get[2]>:
        - case display:
            - flag server waypoints.<context.args.get[1]>.display:<context.args.get[3]>
            - narrate "<green>Waypoint <context.args.get[1]> display is now <gold><context.args.get[3]>"
        - case material:
            - if <item[<context.args.get[3]>].if_null[true]>:
                - narrate "<red>Invalid material specified: <bold><context.args.get[3]>"
                - stop
            - else:
                - flag server waypoints.<context.args.get[1]>.material:<context.args.get[3]>
                - narrate "<green>Waypoint <context.args.get[1]> material is now <gold><context.args.get[3]>"
        - case description:
            - flag server waypoints.<context.args.get[1]>.description:<context.args.get[3]>
            - narrate "<green>Waypoint <context.args.get[1]> description is now <gold><context.args.get[3]>"
        - case location:
            - note <player.location> as:waypoint_<context.args.get[1]>
            - note <player.location.sub[5,5,5].to_cuboid[<player.location.add[5,5,5]>]> as:waypoint_<context.args.get[1]>_cuboid
            - narrate "<green>Waypoint <context.args.get[1]> location set to player location."

Waypoint_Inventory:
    type: inventory
    debug: true
    inventory: chest
#   title: <white><&font[sxrmenus]><&chr[F808]><&chr[E012]><&chr[F801].repeat[177]><&chr[E00B]><&chr[F801].repeat[177]><&chr[E011]>
#   temporary title until hiding player inventory works:
    title: <white><&font[sxrmenus]><&chr[F808]><&chr[E012]><&chr[F801].repeat[177]><&chr[E00B]><&chr[F801].repeat[177]><&chr[E011]><&chr[F801].repeat[177]><&chr[E01F]>
    gui: true
    size: 54
    slots:
    - [air] [air] [air] [air] [air] [air] [air] [air] [air]
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    procedural items:
    - define list <list>
    - foreach <player.flag[waypoints.unlocked].alphabetical>:
        - define destination <location[waypoint_<[value]>]>
        # Item material
        - define material <server.flag[waypoints.<[value]>.material]>
        # Display name for waypoint from server data
        - define name <server.flag[waypoints.<[value]>.display]>
        # Empty list for lore
        - define lore <list>
        # Cost
        - define cost <player.location.with_world[prosperus].distance[<[destination]>].div[500].add[<player.mcmmo.level.div[25]>].round_up>
        - if <player.world.name> != prosperus:
            - define cost <[cost].add[5000]>
        - if <player.money.if_null[0]> >= <[cost]>:
            - define lore <[lore].include[<gold>Cost: <[cost]>g]>
            - define lore <[lore].include[<green>Can afford]>
        - else:
            - define lore <[lore].include[<gold>Cost: <[cost]>g]>
            - define lore <[lore].include[<red>Cannot afford; only have <gold><player.money.if_null[0]>g<red>]>
        # Description
        - define description <server.flag[waypoints.<[value]>.description]>
        - define lore <[lore].include[<white><[description]>]>
        # Location
        - define location "<[destination].x.round_up>, <[destination].z.round_up>"
        - define lore <[lore].include[<[location]>]>
        # Finalize lore
        - define item_lore <proc[lore_builder].context[<list[40].include_single[<[lore]>]>]>
        - define list <[list].include[<item[<[material]>].with[display_name=<reset><gold><[name]>;hides=ALL].with_map[<map.with[lore].as[<[item_lore]>]>].with_flag[waypoint:<[destination]>].with_flag[cost:<[cost]>].with_flag[display:<[name]>]>]>
    - determine <[list]>

Waypoint_Inventory_Choice:
    type: world
    debug: true
    events:
        after player clicks item_flagged:waypoint in Waypoint_Inventory:
        - inventory close
        - inventory update
        - if <player.money> >= <context.item.flag[cost]>:
            - money take quantity:<context.item.flag[cost]>
            - teleport <player> <context.item.flag[waypoint]>
            - narrate "<green>You channeled magic through the waypoint network to travel to <context.item.flag[display]> for <gold><context.item.flag[cost]>g<green>!"
        - else:
            - narrate "<red>You can't afford to travel there! You need <context.item.flag[cost]>g and you only have <gold><player.money>g"

Waypoint_Unlock:
    type: world
    debug: true
    events:
        after player enters waypoint_*_cuboid:
        - define waypoint_name <context.area.note_name.after[_].before[_]>
        - if <player.flag[waypoints.unlocked].contains[<[waypoint_name]>].if_null[false]>:
            - stop
        - if !<player.flag[waypoints.unlocked].contains[<[waypoint_name]>].if_null[false]>:
            - flag <player> waypoints.unlocked:->:<[waypoint_name]>
        - narrate "You visited <green><bold><server.flag[waypoints.<[waypoint_name]>.display]> <green>for the first time and unlocked its waypoint! Congratulations!"



Waypoint_List_Test:
    type: task
    speed: 0
    script:
    # If no arguments, display list of unlocked waypoints
    # Read the player's unlocked waypoints
    - foreach <player.flag[waypoints.unlocked].alphabetical>:
        # Cost forumula: ([DISTANCE] / 500) + ([PWRLVL] / 25)
        - define destination <location[waypoint_<[value]>]>
        - define cost <player.location.with_world[prosperus].distance[<[destination]>].div[500].add[<player.mcmmo.level.div[25]>].round_up>
        - if <player.world.name> != prosperus:
            - define cost <[cost].add[5000]>
        - narrate "<blue><[value].to_titlecase>: <gold><[cost]>g"


Waypoint_Teleport_Test:
    type: task
    definitions: waypoint
    speed: 0
    script:
    - define waypoint_name <[waypoint]>
    - teleport waypoint_<[waypoint_name]>

Waypoints_List:
    type: data
    waypoints:
        Arrakis:
            display: Arrakis
            description: A sandy outpost in the southwest deserts.
            material: sand
        EdensEnd:
            display: Eden's End
            description: Hidden beneath a waterfall.
            material: water_bucket
        HawksNest:
            display: Hawk's Nest
            description: A modern refuge in a dense jungle.
            material: vine
        Infernus:
            display: Infernus Oasis
            description: A small respite in the southeast desert.
            material: sand
        Kunedor:
            display: Kunedor
            description: A dwarven mountain town.
            material: iron_pickaxe
        LockhartIsland:
            display: Lockhart Island
            description: Mac's pig-friendly paradise.
            material: pink_banner
        Mabville:
            display: Mabville
            description: Mable's newbie-friendly outpost.
            material: torch
        NeedlesPoint:
            display: Needle's Point
            description: Bryant's modern defiance of swampland.
            material: redstone_lamp
        PinpointIsland:
            display: Pinpoint Island
            description: Gus's cactus-producing fortress.
            material: cactus
        Riverwind:
            display: Riverwind
            description: A haven for mages in the near south.
            material: book
        SeveredPeak:
            display: Severed Peak
            description: Missionaviat's secret lair.
            material: diamond
        Skyreach:
            display: Skyreach
            description: A vertical construction in the mountains of the southern contintent.
            material: feather
        Spira:
            display: Spira
            description: A spire-based outpost in the far southeast.
            material: oak_fence
        Timbervale:
            display: Timbervale
            description: A homely town bordering the craterous lake.
            material: spruce_log
        Westreach:
            display: Westreach Hold
            description: A far-northwest settlement for intrepid adventurers.
            material: iron_chestplate