# Replaces the consumed bottle with an empty bottle of the correct type.

alcohol_consumption_handler:
    type: world
    debug: false
    events:
        on player consumes item_flagged:alcohol:
        - determine <context.item.flag[empty].if_null[glass_bottle]>