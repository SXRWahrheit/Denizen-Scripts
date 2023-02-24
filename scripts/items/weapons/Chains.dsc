ImbuedChains_sealed_potential:
    type: item
    debug: false
    no_id: true
    material: diamond_sword
    display name: <&9>Imbued Diamond Chains
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>These chains have a mystic presence.
        - <&c>Strikes all enemies nearby when charged
        - <&c>Grapples to target on use when charged
        - <&6>Sealed Potential
    enchantments:
    - DAMAGE_ALL:6
    flags:
        equipment_type: weapon
        weapon_type: chains
        item_tier: veteran
        sealed_potential: true
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        attribute_modifiers:
            generic_movement_speed:
                1:
                    operation: add_scalar
                    amount: 0.1
                    slot: hand
                    id: 10000000-1000-1000-1000-100000000000
            generic_attack_speed:
                1:
                    operation: add_scalar
                    amount: -0.47
                    slot: hand
                    id: 10000000-1000-1000-1000-100000000001
            generic_attack_damage:
                1:
                    operation: add_number
                    amount: 9.0
                    slot: hand
                    id: 10000000-1000-1000-1000-100000000002

BurnishedChains_sealed_potential:
    type: item
    debug: false
    no_id: true
    material: diamond_sword
    display name: <&d>Burnished Diamond Chains
    data:
        lore_list:
        - <&d><&o>Elite
        - <&f>These chains seep magical energy.
        - <&c>Strikes multiple enemies in an area when charged
        - <&c>Grapples to target on use when charged
        - <&6>Sealed Potential
    enchantments:
    - DAMAGE_ALL:7
    flags:
        equipment_type: weapon
        weapon_type: chains
        item_tier: elite
        sealed_potential: true
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        attribute_modifiers:
            generic_movement_speed:
                1:
                    operation: add_scalar
                    amount: 0.1
                    slot: hand
                    id: 10000000-1000-1000-1000-100000000000
            generic_attack_speed:
                1:
                    operation: add_scalar
                    amount: -0.44
                    slot: hand
                    id: 10000000-1000-1000-1000-100000000001
            generic_attack_damage:
                1:
                    operation: add_number
                    amount: 10.0
                    slot: hand
                    id: 10000000-1000-1000-1000-100000000002