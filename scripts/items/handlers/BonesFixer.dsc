Bones_Fixer_Join:
    type: world
    debug: false
    events:
        after player joins:
        - inject Bones_Fixer

Bones_Fixer:
    type: task
    debug: false
    script:
    - define list <player.inventory.list_contents.filter_tag[<[filter_value].script.name.is[==].to[VeteranToken].if_null[null]>]>
    - if !<[list].is_empty>:
        - foreach <[list]>:
            - if <[value].all_raw_nbt> == <item[VeteranToken].all_raw_nbt>:
                - foreach skip
            - else:
                - flag <player> bone_update
    - if <player.has_flag[bone_update]>:
        - define quantity <player.inventory.quantity_item[VeteranToken]>
        - take scriptname:VeteranToken quantity:<[quantity]>
        - give VeteranToken quantity:<[quantity]>