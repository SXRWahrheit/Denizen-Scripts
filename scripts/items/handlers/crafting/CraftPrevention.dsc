nbt_craft_prevention:
    type: world
    debug: false
    events:
        on player crafts item:
        - if <context.recipe.filter[nbt[uncraftable]].size> >= 1:
            - determine cancelled

flag_craft_prevention:
    type: world
    debug: false
    events:
        on player crafts item:
        - if <context.recipe.filter[has_flag[uncraftable]].size> >= 1:
            - determine cancelled