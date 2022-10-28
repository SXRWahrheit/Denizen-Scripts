socket_gem_attack_crit_chance_handler:
    type: world
    debug: false
    events:
        on player damages entity priority:-10:
        - define critchance 0
        - define gem_count 0
        - foreach <context.damager.equipment.include[<context.damager.item_in_hand>]>:
            - define gem_count <[gem_count].add[<[value].nbt.filter[regex_matches[socket[0-9]+_gem/socket_gem_attack_crit_chance]].size||0>]>
        - define critchance <[gem_count].mul[5]>
        - if <util.random.int[1].to[1000]> <= <[critchance]>:
            - determine <context.damage.mul[1.5]>
            - playeffect <context.entity.location.add[0,0.5,0]> effect:crit quantity:20 offset:0.0

socket_gem_attack_crit_chance:
    debug: false
    type: item
    material: emerald
    display name: <&c>Gem of Critical Chance
    lore:
    - <&6>Gem
    - <&c>Attack
    - <&f>+0.5<&pc> critical hit chance
    enchantments:
    - MENDING:1
    mechanisms:
        hides:
        - attributes
        - enchants
        nbt:
        - uncraftable/true
        - gem_type/attack
        - gem_specific/socket_gem_attack_crit_chance