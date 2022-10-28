GoldBooster2x:
    type: item
    material: potion
    display name: <&a>Golden Brew
    enchantments:
    - MENDING:1
    data:
        lore_list:
        - <&6>There's gold in them there hills - or, rather, in the pockets of them there monsters! Drink this potion to improve gold drops from monsters you slay.
    mechanisms:
        hides:
        - enchants
        - potion_effects
        nbt:
        - uncraftable/true
        color: <color[255,255,0]>
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>

GoldBooster4x:
    type: item
    material: potion
    display name: <&a>Improved Golden Brew
    enchantments:
    - MENDING:1
    data:
        lore_list:
        - <&6>There's gold in them there hills - or, rather, in the pockets of them there monsters! Drink this potion to greatly improve gold drops from monsters you slay.
    mechanisms:
        hides:
        - enchants
        - potion_effects
        nbt:
        - uncraftable/true
        color: <color[255,255,0]>
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>

gold_booster_handler:
    type: world
    debug: false
    events:
        on player consumes GoldBooster2x:
        - take item:GoldBooster2x
        - narrate "<&6>You feel a golden aura about you! For the next 30 minutes, you'll find more gold drops from slain monsters!"
        - flag <player> player_gold_rate:2 duration:30m
        - wait 30m
        - narrate "<&6>Your golden aura wears off..."
        on player consumes GoldBooster4x:
        - take item:GoldBooster4x
        - narrate "<&6>You feel a golden aura about you! For the next 30 minutes, you'll find more gold drops from slain monsters!"
        - flag <player> player_gold_rate:4 duration:30m
        - wait 30m
        - narrate "<&6>Your golden aura wears off..."