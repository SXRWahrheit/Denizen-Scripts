ImbuedSpear_sealed_potential:
    type: item
    debug: false
    no_id: true
    material: diamond_sword
    display name: <&9>Imbued Diamond Spear
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>This spear has a mystic presence.
        - <&c>Attacks pierce a line of enemies in front of you when charged
        - <&6>Sealed Potential
    enchantments:
    - DAMAGE_ALL:6
    flags:
        equipment_type: weapon
        weapon_type: spear
        item_tier: veteran
        sealed_potential: true
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.movementSpeed/mainhand/1/0.1
        - generic.attackSpeed/mainhand/1/-0.67
        - generic.attackDamage/mainhand/0/12.0
        nbt:
        - equipment_type/weapon
        - weapon_type/spear
        - item_tier/veteran
        - sealed_potential/true

BurnishedSpear_sealed_potential:
    type: item
    debug: false
    no_id: true
    material: diamond_sword
    display name: <&d>Burnished Diamond Spear
    data:
        lore_list:
        - <&d><&o>Elite
        - <&f>This spear seeps magical energy.
        - <&c>Attacks pierce a line of enemies in front of you when charged
        - <&6>Sealed Potential
    enchantments:
    - DAMAGE_ALL:7
    flags:
        equipment_type: weapon
        weapon_type: spear
        item_tier: elite
        sealed_potential: true
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.movementSpeed/mainhand/1/0.1
        - generic.attackSpeed/mainhand/1/-0.64
        - generic.attackDamage/mainhand/0/13.0
        nbt:
        - equipment_type/weapon
        - weapon_type/spear
        - item_tier/elite
        - sealed_potential/true