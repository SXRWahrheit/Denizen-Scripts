socket_gem_attackdamage_mainhand:
    debug: false
    type: item
    material: emerald
    display name: <&c>Gem of Main Hand Attack Damage
    lore:
    - <&6>Gem
    - <&c>Attack
    - <&f>+0.5 Attack Damage when held in Main Hand
    enchantments:
    - MENDING:1
    data:
        gem_attributes:
            generic_attack_damage:
                1:
                    operation: add_number
                    amount: 0.5
                    slot: main_hand
    flags:
        uncraftable: true
        gem_type: attack
        gem_specific: socket_gem_attackdamage_mainhand
        gem_attributes:
            generic_attack_damage:
                1:
                    operation: add_number
                    amount: 0.5
                    slot: main_hand
    mechanisms:
        hides:
        - attributes
        - enchants