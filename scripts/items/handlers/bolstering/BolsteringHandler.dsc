save_bolstered_items_handler:
    type: world
    debug: false
    events:
        on player dies:
        - define bolstered_items <player.inventory.list_contents.filter_tag[has_nbt[bolstered]]>
        # - define bolstered_items <player.inventory.list_contents.filter_tag[has_flag[bolstered]]>
        - flag <player> bolstered_items:<[bolstered_items]>
        after player respawns:
        - give <player.flag[bolstered_items]>