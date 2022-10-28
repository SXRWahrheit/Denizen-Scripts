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
    mechanisms:
        hides:
        - attributes
        - enchants
        nbt:
        - uncraftable/true
        - gem_type/attack
        - gem_specific/socket_gem_attackdamage_mainhand
        - gem_attribute1/generic&dotattackDamage/mainhand/0/0.5