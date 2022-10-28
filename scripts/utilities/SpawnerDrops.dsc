spawner_block_loot:
    type: world
    debug: false
    events:
        after player breaks spawner:
        - if <player.gamemode> == survival:
            - modifyblock <context.location> air
            - determine passively diamond_block
            - drop xp <context.location> quantity:1395

spawner_self_nuke:
    type: world
    debug: false
    events:
        after entity spawns because spawner:
        - if <context.location.find_blocks[spawner].within[5].size> == 0:
            - stop
        - else:
            - foreach <context.location.find_blocks[spawner].within[5]>:
                - modifyblock <[value]> air
                - announce to_console "Spawner replaced with air at <[value]>"
        after spawner spawns entity:
        - modifyblock <context.spawner_location> air
        - announce to_console "Spawner replaced with air at <context.spawner_location>"