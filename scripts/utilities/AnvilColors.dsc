Anvil_Color_Fixer:
    type: world
    debug: false
    events:
        on player prepares anvil craft item:
        - if !<context.item.has_flag[item_tier]>:
            - stop
        - else if <context.item.flag[item_tier]> == veteran:
            - determine <context.item.with[display=<context.item.display.parse_color.strip_color.color[blue]>]>
        - else if <context.item.flag[item_tier]> == elite:
            - determine <context.item.with[display=<context.item.display.parse_color.strip_color.color[light_purple]>]>
        - else if <context.item.flag[item_tier]> == champion:
            - determine <context.item.with[display=<context.item.display.parse_color.strip_color.color[yellow]>]>