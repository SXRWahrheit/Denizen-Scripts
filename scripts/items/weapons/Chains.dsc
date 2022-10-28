ImbuedChains_sealed_potential:
    type: item
    debug: false
    no_id: true
    material: diamond_sword
    display name: <&9>Imbued Diamond Chains
    lore_list:
    - <&9><&o>Veteran
    - <&f>These chains have a mystic presence.
    - <&c>Strikes all enemies nearby when charged
    - <&c>Grapples to target on use when charged
    - <&6>Sealed Potential
    enchantments:
    - DAMAGE_ALL:6
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.movementSpeed/mainhand/1/0.1
        - generic.attackSpeed/mainhand/1/-0.47
        - generic.attackDamage/mainhand/0/9.0
        nbt:
        - equipment_type/weapon
        - weapon_type/chains
        - item_tier/veteran
        - sealed_potential/true

BurnishedChains_sealed_potential:
    type: item
    debug: false
    no_id: true
    material: diamond_sword
    display name: <&d>Burnished Diamond Chains
    lore_list:
    - <&d><&o>Elite
    - <&f>These chains seep magical energy.
    - <&c>Strikes multiple enemies in an area when charged
    - <&c>Grapples to target on use when charged
    - <&6>Sealed Potential
    enchantments:
    - DAMAGE_ALL:7
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.movementSpeed/mainhand/1/0.1
        - generic.attackSpeed/mainhand/1/-0.44
        - generic.attackDamage/mainhand/0/10.0
        nbt:
        - equipment_type/weapon
        - weapon_type/chains
        - item_tier/elite
        - sealed_potential/true