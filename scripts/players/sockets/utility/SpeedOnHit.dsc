socket_gem_utility_speed_on_hit_handler:
    type: world
    debug: false
    events:
        on player damages entity:
        - define gem_count 0
        - foreach <context.damager.equipment.include[<context.damager.item_in_hand>]>:
            - define gem_count <[gem_count].add[<[value].nbt.filter[regex_matches[socket[0-9]+_gem/socket_gem_utility_speed_on_hit]].size||0>]>
        - if <[gem_count]> == 0:
            - stop
        - cast speed duration:<[gem_count].mul[3]> p:1 <player>

socket_gem_utility_speed_on_hit:
    debug: false
    type: item
    material: emerald
    display name: <&a>Gem of Speed on Hit
    lore:
    - <&6>Gem
    - <&a>Utility
    - <&f>+3s Speed level 1 on hit
    enchantments:
    - MENDING:1
    mechanisms:
        hides:
        - attributes
        - enchants
        nbt:
        - uncraftable/true
        - gem_type/utility
        - gem_specific/socket_gem_utility_speed_on_hit