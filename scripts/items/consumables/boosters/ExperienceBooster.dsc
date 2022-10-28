ExperienceBooster2x:
    type: item
    material: potion
    display name: <&a>Liquid Courage
    enchantments:
    - MENDING:1
    data:
        lore_list:
        - <&6>This magic potion was brewed by and elder wizard. Drinking it will improve your ability to extract experience from defeated monsters!
    mechanisms:
        hides:
        - enchants
        - potion_effects
        nbt:
        - uncraftable/true
        color: <color[0,255,0]>
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>

ExperienceBooster4x:
    type: item
    material: potion
    display name: <&a>Improved Liquid Courage
    enchantments:
    - MENDING:1
    data:
        lore_list:
        - <&6>This magic potion was brewed by and elder wizard. Drinking it will greatly improve your ability to extract experience from defeated monsters!
    mechanisms:
        hides:
        - enchants
        - potion_effects
        nbt:
        - uncraftable/true
        color: <color[0,255,0]>
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>

exp_booster_handler:
    type: world
    debug: false
    events:
        on player consumes ExperienceBooster2x:
        - take item:ExperienceBooster2x
        - narrate "<&6>You consume the potion and are imbued with magical energy allowing you to extract more experience from defeated monsters!"
        - flag <player> player_exp_rate:2 duration:30m
        - wait 30m
        - narrate "<&6>The experience magic wears off..."
        on player consumes ExperienceBooster4x:
        - take item:ExperienceBooster4x
        - narrate "<&6>You consume the potion and are imbued with magical energy allowing you to extract more experience from defeated monsters!"
        - flag <player> player_exp_rate:4 duration:30m
        - wait 30m
        - narrate "<&6>The experience magic wears off..."