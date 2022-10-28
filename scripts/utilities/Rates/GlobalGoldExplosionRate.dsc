gold_rate_data:
    type: yaml data
    debug: false
    gold_multiplier_active: false
    gold_rate_multiplier: 1
    gold_amount_multiplier: 3

gold_rate_announcement:
    type: world
    debug: false
    events:
        on player joins:
        - if <script[gold_rate_data].data_key[gold_multiplier_active]>:
            - wait 4s
            - narrate "<&6>A bonus gold rate event is active! Go monster hunting with a <script[gold_rate_data].data_key[gold_rate_multiplier]>x chance for monsters to drop bonus gold!"