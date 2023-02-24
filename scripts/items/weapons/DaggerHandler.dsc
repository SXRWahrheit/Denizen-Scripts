backstab_check:
    type: world
    debug: false
    events:
        on player damages entity priority:100:
        #- if <player.item_in_hand.has_nbt[backstab]>:
        #    - narrate "Initial damage was <context.final_damage>"
        - if <player.item_in_hand.flag[backstab].if_null[null]> && <player.target.location.facing[<player>].degrees[120].not>:
            - narrate "<&c>You backstab your target and deal <context.final_damage.mul[<player.item_in_hand.flag[backstab_multiplier].if_null[1]>].round_to[1]> damage!"
            - determine <context.final_damage.mul[<player.item_in_hand.flag[backstab_multiplier].if_null[1]>].round_to[1]>