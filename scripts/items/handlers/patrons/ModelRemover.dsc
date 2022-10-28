Model_Remover:
    type: world
    debug: false
    events:
        on player picks up item_flagged:patron_only:
        - if !<player.has_permission[group.patron]>:
            - determine <context.item.with[custom_model_data=].with_flag[patron_only:!]>
        on player clicks item_flagged:patron_only in inventory:
        - determine passively cancelled
        - wait 1t
        - if !<player.has_permission[group.patron]>:
            - determine <context.item.with[custom_model_data=].with_flag[patron_only:!]>