Veteran_Air_Helm_sealed_potential:
    type: item
    no_id: true
    material: Leather_Helmet
    display name: <&9>Breezy Leather Helm
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>This helm is flowing with air magic, almost floating when held.
        - <&b>+0.25x Air Magic Effectiveness
        - <&6>Sealed Potential
    flags:
        equipment_type: armor
        item_tier: veteran
        sealed_potential: true
        armor_set: veteran_air
        air_magic_multiplier: 0.25
        enable_mana: true
    enchantments:
    - PROTECTION_ENVIRONMENTAL:5
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.maxHealth/head/0/4.0
        - generic.armorToughness/head/0/2.0
        - generic.armor/head/0/2.0
        nbt:
        - equipment_type/armor
        - item_tier/veteran
        - sealed_potential/true
        - armor_set/veteran_air
        - air_magic_multiplier/0.25
        - enable_mana/true

Veteran_Air_Chest_sealed_potential:
    type: item
    no_id: true
    material: Leather_Chestplate
    display name: <&9>Breezy Leather Chestplate
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>This chestplate is flowing with air magic, almost floating when held.
        - <&b>+0.6x Air Magic Effectiveness
        - <&6>Sealed Potential
    flags:
        equipment_type: armor
        item_tier: veteran
        sealed_potential: true
        armor_set: veteran_air
        air_magic_multiplier: 0.6
        enable_mana: true
    enchantments:
    - PROTECTION_ENVIRONMENTAL:5
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.maxHealth/chest/0/8.0
        - generic.armorToughness/chest/0/2.0
        - generic.armor/chest/0/4.0
        nbt:
        - equipment_type/armor
        - item_tier/veteran
        - sealed_potential/true
        - armor_set/veteran_air
        - air_magic_multiplier/0.6
        - enable_mana/true

Veteran_Air_Legs_sealed_potential:
    type: item
    no_id: true
    material: Leather_Leggings
    display name: <&9>Breezy Leather Leggings
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>These leggings are flowing with air magic, almost floating when held.
        - <&b>+0.4x Air Magic Effectiveness
        - <&6>Sealed Potential
    enchantments:
    - PROTECTION_ENVIRONMENTAL:5
    flags:
        equipment_type: armor
        item_tier: veteran
        sealed_potential: true
        armor_set: veteran_air
        air_magic_multiplier: 0.4
        enable_mana: true
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.maxHealth/legs/0/6.0
        - generic.armorToughness/legs/0/2.0
        - generic.armor/legs/0/3.0
        nbt:
        - equipment_type/armor
        - item_tier/veteran
        - sealed_potential/true
        - armor_set/veteran_air
        - air_magic_multiplier/0.4
        - enable_mana/true

Veteran_Air_Boots_sealed_potential:
    type: item
    no_id: true
    material: Leather_Boots
    display name: <&9>Breezy Leather Boots
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>These boots are flowing with air magic, almost floating when held.
        - <&b>+0.25x Air Magic Effectiveness
        - <&6>Sealed Potential
    enchantments:
    - PROTECTION_ENVIRONMENTAL:5
    flags:
        equipment_type: armor
        item_tier: veteran
        sealed_potential: true
        armor_set: veteran_air
        air_magic_multiplier: 0.25
        enable_mana: true
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.maxHealth/feet/0/2.0
        - generic.armorToughness/feet/0/2.0
        - generic.armor/feet/0/2.0
        nbt:
        - equipment_type/armor
        - item_tier/veteran
        - sealed_potential/true
        - armor_set/veteran_air
        - air_magic_multiplier/0.25
        - enable_mana/true

elite_windmage_elytra:
    type: item
    material: elytra
    display name: <&d>Cultist Wind Mage's Elytra
    data:
        lore_list:
        - <&d><&o>Elite
        - <&f>A cultist wind mage once owned this elytra.
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.maxHealth/chest/0/4.0
        - generic.armor/chest/0/4.0
        - generic.armorToughness/chest/0/2.0
    flags:
        equipment_type: armor
        item_tier: elite
        sealed_potential: false

veteran_air_armor_set_data:
    type: data
    debug: false
    set_name: veteran_air
    set_variable: air_magic_multiplier

veteran_air_armor_set_bonuses:
    type: procedure
    definitions: set_piece_count
    data:
        scale:
            1: 0
            2: 0.25
            3: 0.5
            4: 1
    script:
    - determine <script.data_key[data.scale.<[set_piece_count].min[4].max[1].round>]>