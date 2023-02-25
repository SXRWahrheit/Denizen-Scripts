warhammer_ready_check:
    type: world
    debug: false
    events:
        # Affects targets rather than amounts; use an early-firing priority
        on player damages entity priority:-15:
        - if <player.item_in_hand.flag[weapon_type].if_null[null]> == warhammer && <player.has_flag[attack_cooldown].not>:
            - flag <player> attack_cooldown:true duration:<player.attack_cooldown_max_duration>
            - hurt <context.damage> <context.entity.location.find_entities.within[1.5].exclude[<context.damager>|<context.entity>]> source:<player> cause:entity_attack
            - playeffect effect:explosion at:<context.entity.location> visibility:500 quantity:100 offset:1.5,1.5,1.5
        - else if <player.item_in_hand.flag[weapon_type].if_null[null]> == warhammer:
            - flag <player> attack_cooldown:true duration:<player.attack_cooldown_max_duration>
        on player left clicks block:
        - if <player.item_in_hand.flag[weapon_type].if_null[null]> == warhammer:
            - flag <player> attack_cooldown:true duration:<player.attack_cooldown_max_duration>