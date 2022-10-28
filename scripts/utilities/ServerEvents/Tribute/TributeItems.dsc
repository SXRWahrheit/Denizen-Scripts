GodsTribute:
    type: item
    debug: false
    material: gold_nugget
    display name: <&a>Tribute to the Gods
    data:
        lore_list:
        - <&a>Event Item
        - <&f>A token that radiates a divine presence.
    enchantments:
    - MENDING:1
    flags:
        event_item: gods_tribute
        uncraftable: true
        expiration: <util.time_now.next_day_of_week[monday]>
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        hides:
        - ENCHANTS
        custom_model_data: 100001

GodsTributeOld:
    type: item
    debug: false
    material: gold_nugget
    display name: <&a>Tribute to the Gods
    data:
        lore_list:
        - <&a>Event Item
        - <&f>A token that radiates a divine presence.
    enchantments:
    - MENDING:1
    flags:
        event_item: gods_tribute
        uncraftable: true
        expiration: <util.time_now.next_day_of_week[monday].sub[7d]>
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        hides:
        - ENCHANTS
        custom_model_data: 100001

GodsTributeExplanation:
    type: world
    debug: false
    events:
        on player right clicks block with:GodsTribute:
        - adjust <player> show_book:GodsTributeExplanationBook

GodsTributeExplanationBook:
    type: book
    title: Tribute to the Gods
    author: Wahrheit
    signed: true
    text:
    - Look at that, you've earned some <green>Tribute to the Gods!<reset> Nice work! During the <bold>Tribute event<reset>, the Gods will award you with Tribute for slaying minions of the darkness and for being a steward of the realms.
    - You can take your <green>Tribute to the Gods<reset> to the <bold>Oracle of the Gods<reset> in the castle in Dawn's Landing. Offer your tribute for the <bold>blessing<reset> of your choice!
    - Each <bold>blessing<reset> requires a substantial quantity of <green>Tribute<reset> to earn the Gods' favor, but <bold>contributions are shared by all adventurers<reset> and <bold>you earn more <green>Tribute<reset><bold> by working together.
    - Your <green>Tribute<reset> will fade away when the challenge period ends on Monday mornings, at which point any <bold>blessings<reset> will also expire. Gather and turn in your <green>Tribute<reset> quickly each week to maximize community <bold>blessings<reset>!

TributeEventExplanation:
    type: task
    debug: false
    script:
    - adjust <player> show_book:TributeEventExplanationBook

TributeEventExplanationBook:
    type: book
    title: Tribute to the Gods
    author: Wahrheit
    signed: true
    text:
    - A <bold>Tribute event<reset> is active! During the <bold>Tribute event<reset>, the Gods will award you with Tribute for slaying minions of the darkness and for being a steward of the realms.
    - You can take your <green>Tribute to the Gods<reset> to the <bold>Oracle of the Gods<reset> in the castle in Dawn's Landing. Offer your tribute for the <bold>blessing<reset> of your choice!
    - Each <bold>blessing<reset> requires a substantial quantity of <green>Tribute<reset> to earn the Gods' favor, but <bold>contributions are shared by all adventurers<reset> and <bold>you earn more <green>Tribute<reset><bold> by working together.
    - Your <green>Tribute<reset> will fade away when the challenge period ends on Monday mornings, at which point any <bold>blessings<reset> will also expire. Gather and turn in your <green>Tribute<reset> quickly each week to maximize community <bold>blessings<reset>!

TokenExpiration:
    type: world
    debug: false
    events:
        on player opens inventory:
        - define day <util.time_now>
        - if <context.inventory.list_contents.filter[has_flag[expiration]].filter_tag[<[day].is_after[<time[<[filter_value].flag[expiration]>]>]>].size> > 0:
            - foreach <context.inventory.list_contents.filter[has_flag[expiration]].filter_tag[<[day].is_after[<time[<[filter_value].flag[expiration]>]>]>]>:
                - take scriptname:<[value]> quantity:<[value].quantity> from:<context.inventory>
            - narrate "<&7><&o>The Tribute to the Gods fades away before your eyes..."
        - else if <player.inventory.list_contents.filter[has_flag[expiration]].filter_tag[<[day].is_after[<time[<[filter_value].flag[expiration]>]>]>].size> == 0:
            - stop
        - else:
            - foreach <player.inventory.list_contents.filter[has_flag[expiration]].filter_tag[<[day].is_after[<time[<[filter_value].flag[expiration]>]>]>]>:
                - take scriptname:<[value]> quantity:<[value].quantity> from:<player.inventory>
            - narrate "<&7><&o>The Tribute to the Gods fades away before your eyes..."
        after player clicks in inventory:
        - define day <util.time_now>
        - if <context.inventory.list_contents.filter[has_flag[expiration]].filter_tag[<[day].is_after[<time[<[filter_value].flag[expiration]>]>]>].size> > 0:
            - foreach <context.inventory.list_contents.filter[has_flag[expiration]].filter_tag[<[day].is_after[<time[<[filter_value].flag[expiration]>]>]>]>:
                - take scriptname:<[value]> quantity:<[value].quantity> from:<context.inventory>
            - narrate "<&7><&o>The Tribute to the Gods fades away before your eyes..."
        - else if <player.inventory.list_contents.filter[has_flag[expiration]].filter_tag[<[day].is_after[<time[<[filter_value].flag[expiration]>]>]>].size> == 0:
            - stop
        - else:
            - foreach <player.inventory.list_contents.filter[has_flag[expiration]].filter_tag[<[day].is_after[<time[<[filter_value].flag[expiration]>]>]>]>:
                - take scriptname:<[value]> quantity:<[value].quantity> from:<player.inventory>
            - narrate "<&7><&o>The Tribute to the Gods fades away before your eyes..."