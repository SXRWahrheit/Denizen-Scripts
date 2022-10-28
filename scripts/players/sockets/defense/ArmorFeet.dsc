socket_gem_defense_armor_feet:
    debug: false
    type: item
    material: emerald
    display name: <&9>Gem of Boots Armor
    lore:
    - <&6>Gem
    - <&9>Defense
    - <&f>+1 Armor when added to Boots
    enchantments:
    - MENDING:1
    mechanisms:
        hides:
        - attributes
        - enchants
        nbt:
        - uncraftable/true
        - gem_type/defense
        - gem_specific/socket_gem_defense_armor_chest
        - gem_attribute1/generic&dotarmor/feet/0/1.0