spear_ready_check:
    type: world
    debug: false
    events:
        # Affects targets rather than amounts; use an early-firing priority
        on player damages entity priority:-15:
        - if <player.item_in_hand.flag[weapon_type].if_null[null]> == spear && <player.has_flag[attack_cooldown].not>:
            - flag <player> attack_cooldown:true duration:<player.attack_cooldown_max_duration>
            - define entity_list <player.eye_location.points_between[<player.eye_location.forward[8]>].parse[find.entities.within[1]].combine.deduplicate.exclude[<context.damager>|<context.entity>]>
            - hurt <context.damage> <[entity_list]> source:<player> cause:entity_attack
            - playeffect effect:damage_indicator at:<[entity_list].parse[location]> visibility:500 quantity:3 offset:0.5
        - else if <player.item_in_hand.flag[weapon_type].if_null[null]> == spear:
            - flag <player> attack_cooldown:true duration:<player.attack_cooldown_max_duration>
        on player left clicks block:
        - if <player.item_in_hand.flag[weapon_type].if_null[null]> == spear && <player.has_flag[attack_cooldown].not>:
            - flag <player> attack_cooldown:true duration:<player.attack_cooldown_max_duration>
            - define entity_list <player.eye_location.points_between[<player.eye_location.forward[8]>].parse[find.entities.within[1]].combine.deduplicate.exclude[<player>]>
            - hurt <context.damage> <[entity_list]> source:<player> cause:entity_attack
            - playeffect effect:damage_indicator at:<[entity_list].parse[location]> visibility:500 quantity:3 offset:0.5
        - else if <player.item_in_hand.flag[weapon_type].if_null[null]> == spear:
            - flag <player> attack_cooldown:true duration:<player.attack_cooldown_max_duration>