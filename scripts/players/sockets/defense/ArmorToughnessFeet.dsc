socket_gem_defense_armor_toughness_feet:
    debug: false
    type: item
    material: emerald
    display name: <&9>Gem of Boots Armor Toughness
    lore:
    - <&6>Gem
    - <&9>Defense
    - <&f>+0.5 Armor Toughness when added to Boots
    enchantments:
    - MENDING:1
    mechanisms:
        hides:
        - attributes
        - enchants
        nbt:
        - uncraftable/true
        - gem_type/defense
        - gem_specific/socket_gem_defense_armor_toughness_feet
        - gem_attribute1/generic&dotarmorToughness/feet/0/0.5