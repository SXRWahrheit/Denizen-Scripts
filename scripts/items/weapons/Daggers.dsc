ImbuedDagger_sealed_potential:
    type: item
    debug: false
    no_id: true
    material: diamond_sword
    display name: <&9>Imbued Diamond Dagger
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>This dagger has a mystic presence.
        - <&c>2.0x damage on backstab
        - <&6>Sealed Potential
    enchantments:
    - DAMAGE_ALL:6
    flags:
        equipment_type: weapon
        item_tier: veteran
        sealed_potential: true
        backstab: true
        backstab_multiplier: 2.0
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.movementSpeed/mainhand/1/0.1
        - generic.attackSpeed/mainhand/1/-0.47
        - generic.attackDamage/mainhand/0/7.5
        nbt:
        - equipment_type/weapon
        - item_tier/veteran
        - sealed_potential/true
        - backstab/true
        - backstab_multiplier/2.0

BurnishedDagger_sealed_potential:
    type: item
    debug: false
    no_id: true
    material: diamond_sword
    display name: <&d>Burnished Diamond Dagger
    data:
        lore_list:
        - <&d><&o>Elite
        - <&f>This dagger seeps magical energy.
        - <&c>2.5x damage on backstab
        - <&6>Sealed Potential
    enchantments:
    - DAMAGE_ALL:7
    flags:
        equipment_type: weapon
        item_tier: elite
        sealed_potential: true
        backstab: true
        backstab_multiplier: 2.5
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.movementSpeed/mainhand/1/0.1
        - generic.attackSpeed/mainhand/1/-0.44
        - generic.attackDamage/mainhand/0/8.0
        nbt:
        - equipment_type/weapon
        - item_tier/elite
        - sealed_potential/true
        - backstab/true
        - backstab_multiplier/2.5