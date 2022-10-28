socket_gem_defense_armor_toughness_chest:
    debug: false
    type: item
    material: emerald
    display name: <&9>Gem of Chestplate Armor Toughness
    lore:
    - <&6>Gem
    - <&9>Defense
    - <&f>+0.5 Armor Toughness when added to Chestplate
    enchantments:
    - MENDING:1
    mechanisms:
        hides:
        - attributes
        - enchants
        nbt:
        - uncraftable/true
        - gem_type/defense
        - gem_specific/socket_gem_defense_armor_toughness_chest
        - gem_attribute1/generic&dotarmorToughness/chest/0/0.5