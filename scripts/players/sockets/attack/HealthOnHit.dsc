socket_gem_attack_health_on_hit_handler:
    type: world
    debug: false
    events:
        on player damages entity:
        - define gem_count 0
        - if <context.damager.equipment.include[<context.damager.item_in_hand>].size> == 0:
            - stop
        - foreach <context.damager.equipment.include[<context.damager.item_in_hand>]>:
            - define gem_count <[gem_count].add[<[value].nbt.filter[regex_matches[socket[0-9]+_gem/socket_gem_attack_health_on_hit]].size||0>]>
        - repeat <[gem_count]>:
            - heal <context.final_damage.div[16]> <context.damager>

socket_gem_attack_health_on_hit:
    debug: false
    type: item
    material: emerald
    display name: <&c>Gem of Health on Hit
    lore:
    - <&6>Gem
    - <&c>Attack
    - <&f>+1/8 damage dealt healed on hit
    enchantments:
    - MENDING:1
    mechanisms:
        hides:
        - attributes
        - enchants
        nbt:
        - uncraftable/true
        - gem_type/attack
        - gem_specific/socket_gem_attack_health_on_hit
