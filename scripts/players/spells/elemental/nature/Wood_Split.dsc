wood_split_axe:
    type: item
    debug: false
    material: diamond_axe
    display name: Axe of Wood Splitting
    mechanisms:
        unbreakable: true
    lore:
    - Wahrheit designed this axe to test wood splitting.
    flags:
        wood_splitting: true

Wood_Split_Item_Event:
    type: world
    debug: false
    events:
        on player breaks *_log with:item_flagged:wood_splitting:
        # Don't allow use of this ability in protected areas
        - if !<player.worldguard.can_build[<context.location>]>:
            - stop
        - determine passively cancelled
        - wait 1t
        - define location <context.location>
        - inject Wood_Split_Task

Wood_Split_Command:
    type: command
    debug: false
    name: woodsplit
    description: Uses nature magic to split trees
    usage: /woodsplit
    script:
    - if <player.has_flag[wood_split_cooldown]>:
        - stop
    - flag <player> wood_split expire:10s
    - narrate "<green>You channel nature magic to empower you to split trees you punch for the next 10 seconds!"

Wood_Split_Ability:
    type: world
    debug: false
    events:
        after mythickeys key pressed id:sxr:utility_skill_* flagged:wood_split_selected:
        # Usage: Set a flag on the player, with the name of the flag being the ID of the key and the value being wood_split
        - if <player.flag[<context.id.after[sxr:]>]> != wood_split:
            - stop
        - if <player.has_flag[wood_split_cooldown]>:
            - stop
        - flag <player> wood_split expire:10s
        - narrate "<green>You channel nature magic to empower you to split trees you touch for the next 10 seconds!"
        after player flagged:wood_split left clicks *log:
        - define location <context.location>
        - if !<player.worldguard.can_build[<[location]>]>:
            - stop
        - inject Wood_Split_Task

Wood_Split_Task:
    type: task
    debug: false
    speed: 0
    script:
    # This shouldn't ever happen, but just in case the block at issue isn't a log, stop here
    - if !<[location].material.name.advanced_matches[*log]>:
        - stop
    # Don't try to split a tree that's already being split
    - if <[location].has_flag[wood_split]>:
        - stop
    # Don't allow use of this ability in protected areas
    - if !<player.worldguard.can_build[<[location]>]>:
        - stop
    # Maximum flood fill radius
    - define radius 20
    # Don't run the script if the flood fill target is too large
    - if <[location].flood_fill[<[radius]>].types[*_log]> != <[location].flood_fill[<[radius].add[1]>].types[*_log]>:
        - narrate "<red>You aren't strong enough to split quite so large an object as this!"
        - stop
    # Find log blocks in given flood fill radius
    - define block_list <[location].flood_fill[<[radius]>].types[*_log]>
    # Prevent additional attempts to split each block
    - foreach <[block_list]> as:block:
        - flag <[block]> wood_split expire:20s
    - narrate "<green>You channel your strength through nature magic to split the tree's core from the top down!"
    # Define the player's item in hand in case they change it
    - define item <player.item_in_hand>

    # Make a list of vertical layers
    - foreach <[block_list].sort_by_number[y].reverse.parse[y].deduplicate> as:layer:
        # Make a list of blocks in that vertical layer
        - define current_layer <[block_list].filter[y.equals[<[layer]>]]>
        # Break the layer of blocks
        - ~modifyblock <[current_layer]> air naturally:<[item]> delayed
        - playsound <[current_layer].first> sound:block_Wood_break volume:1.0 pitch:1.0
        - wait 2t