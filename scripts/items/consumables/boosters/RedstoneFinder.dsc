RedstoneFinderBooster2x:
    type: item
    material: potion
    display name: <&a>Magic-Leeching Brew
    enchantments:
    - MENDING:1
    data:
        lore_list:
        - <&6>This brew is radiating pure magical energy. Rumor has it that drinking it will attune you to the forces of magic.
    mechanisms:
        hides:
        - enchants
        - potion_effects
        nbt:
        - uncraftable/true
        color: <color[255,0,0]>
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
RedstoneFinderBooster4x:
    type: item
    material: potion
    display name: <&a>Improved Magic-Leeching Brew
    enchantments:
    - MENDING:1
    data:
        lore_list:
        - <&6>This brew is radiating pure magical energy. Rumor has it that drinking it will greatly attune you to the forces of magic.
    mechanisms:
        hides:
        - enchants
        - potion_effects
        nbt:
        - uncraftable/true
        color: <color[255,0,0]>
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>

redstone_finder_booster_handler:
    type: world
    debug: false
    events:
        on player consumes RedstoneFinderBooster2x:
        - take item:RedstoneFinderBooster2x
        - narrate "<&6>You consume the potion and become attuned to the forces of magic! Foes you slay may drop redstone."
        - flag <player> player_redstone_finder_rate:2 duration:30m
        - flag <player> has_buff:true duration:30m
        - wait 30m
        - narrate "<&6>The attunement to magic wears off..."
        on player consumes RedstoneFinderBooster4x:
        - take item:RedstoneFinderBooster4x
        - narrate "<&6>You consume the potion and become greatly attuned to the forces of magic! Foes you slay may drop redstone."
        - flag <player> player_redstone_finder_rate:4 duration:30m
        - flag <player> has_buff:true duration:30m
        - wait 30m
        - narrate "<&6>The attunement to magic wears off..."