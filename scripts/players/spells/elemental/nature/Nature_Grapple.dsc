Nature_Grapple_Command:
    type: command
    name: naturegrapple
    description: Uses nature magic to grapple leaves
    usage: /naturegrapple
    permission: naturemagic.naturegrapple
    permission message: "You haven't learned how to grapple leaves yet!"
    script:
    - if <player.has_flag[naturegrapple_cooldown]>:
        - narrate "<red>You're still channeling your nature magic from the last time you grappled."
        - stop
    - inject Nature_Grapple_Task

Nature_Grapple_Keypress:
    type: world
    events:
        on mythickeys key pressed id:sxr:travel_skill_* flagged:nature_grapple_selected:
        # Usage: Set a flag on the player, with the name of the flag being the ID of the key and the value being nature_grapple
        - if <player.flag[<context.id.after[sxr:]>]> != nature_grapple:
            - stop
        - if <player.has_flag[naturegrapple_cooldown]>:
            - stop
        - inject Nature_Grapple_Task

Nature_Grapple_Task:
    type: task
    debug: false
    script:
    - if !<player.cursor_on[20].exists>:
        - narrate "<red>Whatever you're looking at, you can't grapple it! Try getting closer and make sure you're looking at leaves."
        - stop
    - define target_location <player.cursor_on[20]>
    - if <[target_location].material.advanced_matches[*leaves].if_null[false]>:
        - flag <player> naturegrapple_cooldown expire:6s
        - narrate "<green>You begin to focus nature magic..."
        - define adjusted_location <[target_location].highest.above[3]>
        - define distance <[adjusted_location].distance[<player.location>]>
        - define ratio <[distance].div[10].add[1]>
        - define points <player.location.points_between[<[target_location]>].distance[0.2]>
        - foreach <[points]> as:point:
            - playeffect effect:block_crack special_data:<[target_location].material.name> at:<[point]> visibility:50 quantity:6 offset:0.2
            - define count:++
            - if <[count].mod[6]> == 0:
                - wait 1t
        - adjust <player> velocity:<[adjusted_location].sub[<player.location>].normalize.mul[<[ratio]>]>
        - narrate "<green>You channel your nature magic to grapple up to the leaves!"