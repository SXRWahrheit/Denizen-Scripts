Veteran_Flame_Helm_sealed_potential:
    type: item
    debug: false
    no_id: true
    material: Leather_Helmet
    display name: <&9>Smoldering Leather Helm
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>This helm is warm to the touch, radiating the energy of fire magic.
        - <&b>+25 Fire Magic Power
        - <&b>Set bonus: Additional 0/25/50/100
        - <&6>Sealed Potential
    enchantments:
    - PROTECTION_ENVIRONMENTAL:5
    - PROTECTION_FIRE:3
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
        - armor_set/veteran_flame
        - fire_magic_power/25
        - enable_mana/true

Veteran_Flame_Chest_sealed_potential:
    type: item
    debug: false
    no_id: true
    material: Leather_Chestplate
    display name: <&9>Smoldering Leather Chestplate
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>This chestplate is warm to the touch, radiating the energy of fire magic.
        - <&b>+60 Fire Magic Power
        - <&b>Set bonus: Additional 0/25/50/100
        - <&6>Sealed Potential
    enchantments:
    - PROTECTION_ENVIRONMENTAL:5
    - PROTECTION_FIRE:5
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
        - armor_set/veteran_flame
        - fire_magic_power/60
        - enable_mana/true

Veteran_Flame_Legs_sealed_potential:
    type: item
    debug: false
    no_id: true
    material: Leather_Leggings
    display name: <&9>Smoldering Leather Leggings
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>These leggings are warm to the touch, radiating the energy of fire magic.
        - <&b>+40 Fire Magic Power
        - <&b>Set bonus: Additional 0/25/50/100
        - <&6>Sealed Potential
    enchantments:
    - PROTECTION_ENVIRONMENTAL:5
    - PROTECTION_FIRE:3
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
        - armor_set/veteran_flame
        - fire_magic_power/4
        - enable_mana/true

Veteran_Flame_Boots_sealed_potential:
    type: item
    debug: false
    no_id: true
    material: Leather_Boots
    display name: <&9>Smoldering Leather Boots
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>These boots are warm to the touch, radiating the energy of fire magic.
        - <&b>+25 Fire Magic Power
        - <&b>Set bonus: Additional 0/25/50/100
        - <&6>Sealed Potential
    enchantments:
    - PROTECTION_ENVIRONMENTAL:5
    - PROTECTION_FIRE:3
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
        - armor_set/veteran_flame
        - fire_magic_power/25
        - enable_mana/true


Veteran_Flame_Helm:
    type: item
    debug: false
    no_id: true
    material: Leather_Helmet
    display name: <&9>Smoldering Leather Helm
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>This helm is warm to the touch, radiating the energy of fire magic.
        - <&b>+25 Fire Magic Power
        - <&b>Set bonus: Additional 0/25/50/100
    enchantments:
    - PROTECTION_ENVIRONMENTAL:5
    - PROTECTION_FIRE:3
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.maxHealth/head/0/4.0
        - generic.armorToughness/head/0/2.0
        - generic.armor/head/0/2.0
        nbt:
        - equipment_type/armor
        - item_tier/veteran
        - armor_set/veteran_flame
        - fire_magic_power/25
        - enable_mana/true

Veteran_Flame_Chest:
    type: item
    debug: false
    no_id: true
    material: Leather_Chestplate
    display name: <&9>Smoldering Leather Chestplate
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>This chestplate is warm to the touch, radiating the energy of fire magic.
        - <&b>+60 Fire Magic Power
        - <&b>Set bonus: Additional 0/25/50/100
    enchantments:
    - PROTECTION_ENVIRONMENTAL:5
    - PROTECTION_FIRE:5
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.maxHealth/chest/0/8.0
        - generic.armorToughness/chest/0/2.0
        - generic.armor/chest/0/4.0
        nbt:
        - equipment_type/armor
        - item_tier/veteran
        - armor_set/veteran_flame
        - fire_magic_power/60
        - enable_mana/true

Veteran_Flame_Legs:
    type: item
    debug: false
    no_id: true
    material: Leather_Leggings
    display name: <&9>Smoldering Leather Leggings
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>These leggings are warm to the touch, radiating the energy of fire magic.
        - <&b>+40 Fire Magic Power
        - <&b>Set bonus: Additional 0/25/50/100
    enchantments:
    - PROTECTION_ENVIRONMENTAL:5
    - PROTECTION_FIRE:3
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.maxHealth/legs/0/6.0
        - generic.armorToughness/legs/0/2.0
        - generic.armor/legs/0/3.0
        nbt:
        - equipment_type/armor
        - item_tier/veteran
        - armor_set/veteran_flame
        - fire_magic_power/40
        - enable_mana/true

Veteran_Flame_Boots:
    type: item
    debug: false
    no_id: true
    material: Leather_Boots
    display name: <&9>Smoldering Leather Boots
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>These boots are warm to the touch, radiating the energy of fire magic.
        - <&b>+25 Fire Magic Power
        - <&b>Set bonus: Additional 0/25/50/100
    enchantments:
    - PROTECTION_ENVIRONMENTAL:5
    - PROTECTION_FIRE:3
    mechanisms:
        nbt_attributes:
        - generic.maxHealth/feet/0/2.0
        - generic.armorToughness/feet/0/2.0
        - generic.armor/feet/0/2.0
        nbt:
        - equipment_type/armor
        - item_tier/veteran
        - armor_set/veteran_flame
        - fire_magic_power/25
        - enable_mana/true
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>

veteran_flame_armor_set_data:
    type: data
    debug: false
    set_name: veteran_flame
    set_variable: fire_magic_power

veteran_flame_armor_set_bonuses:
    type: procedure
    definitions: set_piece_count
    data:
        scale:
            1: 0
            2: 25
            3: 50
            4: 100
    script:
    - determine <script.data_key[data.scale.<[set_piece_count].min[4].max[1].round>]>