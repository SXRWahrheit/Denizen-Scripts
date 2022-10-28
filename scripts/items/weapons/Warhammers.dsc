ImbuedWarhammer_sealed_potential:
    type: item
    debug: false
    no_id: true
    material: diamond_sword
    display name: <&9>Imbued Diamond Warhammer
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>This warhammer has a mystic presence.
        - <&c>Strikes multiple enemies in an area when charged
        - <&6>Sealed Potential
    enchantments:
    - DAMAGE_ALL:6
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt:
        - equipment_type/weapon
        - weapon_type/warhammer
        - item_tier/veteran
        - sealed_potential/true
        nbt_attributes:
        - generic.movementSpeed/mainhand/1/0.1
        - generic.attackSpeed/mainhand/1/-0.77
        - generic.attackDamage/mainhand/0/14.0

BurnishedWarhammer_sealed_potential:
    type: item
    debug: false
    no_id: true
    material: diamond_sword
    display name: <&d>Burnished Diamond Warhammer
    data:
        lore_list:
        - <&d><&o>Elite
        - <&f>This warhammer seeps magical energy.
        - <&c>Strikes multiple enemies in an area when charged
        - <&6>Sealed Potential
    enchantments:
    - DAMAGE_ALL:7
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.movementSpeed/mainhand/1/0.1
        - generic.attackSpeed/mainhand/1/-0.74
        - generic.attackDamage/mainhand/0/15.0
        nbt:
        - equipment_type/weapon
        - weapon_type/warhammer
        - item_tier/elite
        - sealed_potential/true