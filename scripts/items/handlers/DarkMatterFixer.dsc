Dark_Matter_Fixer_Join:
    type: world
    debug: false
    events:
        after player joins:
        - inject Dark_Matter_Fixer

Dark_Matter_Fixer:
    type: task
    debug: false
    script:
    - define list <player.inventory.list_contents.filter_tag[<[filter_value].script.name.is[==].to[SocketMaker]||null>]>
    - if !<[list].is_empty>:
        - foreach <[list]>:
            - if <[value].all_raw_nbt> == <item[SocketMaker].all_raw_nbt>:
                - foreach skip
            - else:
                - flag <player> socket_maker_update
    - if <player.has_flag[socket_maker_update]>:
        - define quantity <player.inventory.quantity_item[SocketMaker]>
        - take scriptname:SocketMaker quantity:<[quantity]>
        - give SocketMaker quantity:<[quantity]>