DropRateBooster2x:
    type: item
    material: potion
    display name: <&a>Bottled Luck
    enchantments:
    - MENDING:1
    data:
        lore_list:
        - <&6>Luck magic has been stopped inside this bottle. Release it to gain an aura improving your ability to find rare items from hunting monsters!
    mechanisms:
        hides:
        - enchants
        - potion_effects
        nbt:
        - uncraftable/true
        color: <color[0,0,255]>
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>

DropRateBooster4x:
    type: item
    material: potion
    display name: <&a>Improved Bottled Luck
    enchantments:
    - MENDING:1
    data:
        lore_list:
        - <&6>Luck magic has been stopped inside this bottle. Release it to gain an aura greatly improving your ability to find rare items from hunting monsters!
    mechanisms:
        hides:
        - enchants
        - potion_effects
        nbt:
        - uncraftable/true
        color: <color[0,0,255]>
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>

drop_rate_booster_handler:
    type: world
    debug: false
    events:
        on player consumes DropRateBooster2x:
        - take item:DropRateBooster2x
        - narrate "<&6>You consume the potion and are imbued with magical energy! Your ability to find rare items from hunting monsters is improved for the next 30 minutes."
        - flag <player> player_drop_rate:2 duration:30m
        - flag <player> has_buff:true duration:30m
        - wait 30m
        - narrate "<&6>The item-finding aura wears off..."
        on player consumes DropRateBooster4x:
        - take item:DropRateBooster4x
        - narrate "<&6>You consume the potion and are imbued with magical energy! Your ability to find rare items from hunting monsters is improved for the next 30 minutes."
        - flag <player> player_drop_rate:4 duration:30m
        - flag <player> has_buff:true duration:30m
        - wait 30m
        - narrate "<&6>The item-finding aura wears off..."