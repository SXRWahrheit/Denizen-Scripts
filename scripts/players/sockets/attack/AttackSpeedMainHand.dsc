socket_gem_attackspeed_mainhand:
    debug: false
    type: item
    material: emerald
    display name: <&c>Gem of Main Hand Attack Speed
    lore:
    - <&6>Gem
    - <&c>Attack
    - <&f>+0.01<&pc> Attack Speed when held in Main Hand
    enchantments:
    - MENDING:1
    mechanisms:
        hides:
        - attributes
        - enchants
        nbt:
        - uncraftable/true
        - gem_type/attack
        - gem_specific/socket_gem_attackspeed_mainhand
        - gem_attribute1/generic&dotattackSpeed/mainhand/1/0.01