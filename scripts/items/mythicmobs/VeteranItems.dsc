ImbuedSword_sealed_potential:
    type: item
    no_id: true
    material: diamond_sword
    display name: <&9>Imbued Diamond Sword
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>This blade has a mystic presence.
        - <&6>Sealed Potential
    enchantments:
    - DAMAGE_ALL:6
    flags:
        equipment_type: weapon
        item_tier: veteran
        sealed_potential: true
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.movementSpeed/mainhand/1/0.1
        - generic.attackSpeed/mainhand/1/-0.57
        - generic.attackDamage/mainhand/0/12.5
        nbt:
        - equipment_type/weapon
        - item_tier/veteran
        - sealed_potential/true

ImbuedHelm_sealed_potential:
    type: item
    no_id: true
    material: Diamond_Helmet
    display name: <&9>Imbued Diamond Helm
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>This helm has a mystic presence.
        - <&6>Sealed Potential
    enchantments:
    - PROTECTION_ENVIRONMENTAL:5
    flags:
        equipment_type: armor
        item_tier: veteran
        sealed_potential: true
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.maxHealth/head/0/4.0
        - generic.armorToughness/head/0/2.0
        - generic.armor/head/0/3.0
        nbt:
        - equipment_type/armor
        - item_tier/veteran
        - sealed_potential/true

ImbuedChest_sealed_potential:
    type: item
    no_id: true
    material: Diamond_Chestplate
    display name: <&9>Imbued Diamond Chestplate
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>This chestplate has a mystic presence.
        - <&6>Sealed Potential
    enchantments:
    - PROTECTION_ENVIRONMENTAL:5
    - PROTECTION_EXPLOSIONS:2
    flags:
        equipment_type: armor
        item_tier: veteran
        sealed_potential: true
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.maxHealth/chest/0/8.0
        - generic.armorToughness/chest/0/2.0
        - generic.armor/chest/0/8.0
        nbt:
        - equipment_type/armor
        - item_tier/veteran
        - sealed_potential/true

ImbuedLegs_sealed_potential:
    type: item
    no_id: true
    material: Diamond_Leggings
    display name: <&9>Imbued Diamond Leggings
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>These leggings have a mystic presence.
        - <&6>Sealed Potential
    enchantments:
    - PROTECTION_ENVIRONMENTAL:5
    flags:
        equipment_type: armor
        item_tier: veteran
        sealed_potential: true
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.maxHealth/legs/0/6.0
        - generic.armorToughness/legs/0/2.0
        - generic.armor/legs/0/6.0
        nbt:
        - equipment_type/armor
        - item_tier/veteran
        - sealed_potential/true

ImbuedBoots_sealed_potential:
    type: item
    no_id: true
    material: Diamond_Boots
    display name: <&9>Imbued Diamond Boots
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>These boots have a mystic presence
        - <&6>Sealed Potential
    enchantments:
    - PROTECTION_ENVIRONMENTAL:5
    flags:
        equipment_type: armor
        item_tier: veteran
        sealed_potential: true
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.maxHealth/feet/0/2.0
        - generic.armorToughness/feet/0/2.0
        - generic.armor/feet/0/3.0
        nbt:
        - equipment_type/armor
        - item_tier/veteran
        - sealed_potential/true

ImbuedBow_sealed_potential:
    type: item
    no_id: true
    material: Bow
    display name: <&9>Imbued Bow
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>This bow has a mystic presence.
        - <&6>Sealed Potential
    enchantments:
    - ARROW_DAMAGE:6
    - ARROW_KNOCKBACK:2
    flags:
        equipment_type: weapon
        item_tier: veteran
        sealed_potential: true
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt:
        - equipment_type/weapon
        - item_tier/veteran
        - sealed_potential/true

ImbuedShield_sealed_potential:
    type: item
    no_id: true
    material: Shield
    display name: <&9>Imbued Shield
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>This shield has a mystic presence.
        - <&6>Sealed Potential
    enchantments:
    - DURABILITY:3
    flags:
        equipment_type: armor
        item_tier: veteran
        sealed_potential: true
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.maxHealth/offhand/0/4.0
        - generic.armorToughness/offhand/0/2.0
        nbt:
        - equipment_type/armor
        - item_tier/veteran
        - sealed_potential/true

ImbuedAxe_sealed_potential:
    type: item
    no_id: true
    material: Diamond_Axe
    display name: <&9>Imbued Axe
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>This axe has a mystic presence.
        - <&6>Sealed Potential
    enchantments:
    - DAMAGE_ALL:6
    - DIG_SPEED:6
    flags:
        equipment_type: weapon
        item_tier: veteran
        sealed_potential: true
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.attackSpeed/mainhand/1/-0.73
        - generic.attackDamage/mainhand/0/13.5
        - generic.armorToughness/mainhand/0/2.0
        nbt:
        - equipment_type/weapon
        - item_tier/veteran
        - sealed_potential/true

TestItem:
    type: item
    no_id: true
    material: Diamond_Axe
    display name: <&9>Imbued Axe
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>This axe has a mystic presence.
        - <&6>Sealed Potential
    enchantments:
    - DAMAGE_ALL:11
    - DIG_SPEED:6
    flags:
        equipment_type: weapon
        item_tier: veteran
        sealed_potential: true
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.attackSpeed/mainhand/1/-0.73
        - generic.attackDamage/mainhand/0/13.5
        - generic.armorToughness/mainhand/0/2.0
        nbt:
        - equipment_type/weapon
        - item_tier/veteran
        - sealed_potential/true
