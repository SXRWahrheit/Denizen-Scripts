chains_ready_check:
    type: world
    debug: false
    events:
        # Affects targets rather than amounts; use an early-firing priority
        after player damages entity priority:-15:
        - if <player.item_in_hand.flag[weapon_type].if_null[null]> == chains && <player.has_flag[attack_cooldown].not>:
            - flag <player> attack_cooldown:true duration:<player.attack_cooldown_max_duration>
            - hurt <context.damage> <player.location.find_entities.within[2].exclude[<context.damager>|<context.entity>]> source:<player> cause:entity_attack
            - playeffect effect:crit at:<context.entity.location> visibility:500 quantity:100 offset:1.5,1.5,1.5
        - else if <player.item_in_hand.flag[weapon_type].if_null[null]> == chains:
            - flag <player> attack_cooldown:true duration:<player.attack_cooldown_max_duration>
        after player left clicks block:
        - if <player.item_in_hand.flag[weapon_type].if_null[null]> == chains:
            - flag <player> attack_cooldown:true duration:<player.attack_cooldown_max_duration>
        after player right clicks block:
        - if <player.item_in_hand.flag[weapon_type].if_null[null]> == chains && <player.has_flag[attack_cooldown].not> && <player.has_flag[chains_cooldown].not>:
            - flag <player> attack_cooldown:true duration:<player.attack_cooldown_max_duration>
            - if <player.location.distance_squared[<player.target.location||null>]||100> <= 91:
                - animate <player> arm_swing
                - push <player> destination:<player.target.location> no_damage
                - narrate "<&a>You grapple your target and rush toward them!"
                - adjust <player> attack_cooldown_percent:0
                - flag <player> chains_cooldown:true duration:10s
                - bossbar create chains_<player.uuid> players:<player> "title:Grapple Charging" progress:0 color:green style:solid
                - ^repeat 20:
                    - bossbar update chains_<player.uuid> players:<player> progress:<[value].div[20]>
                    - wait 10t
                - bossbar remove chains_<player.uuid>