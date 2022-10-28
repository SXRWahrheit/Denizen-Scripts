wand_ready_check:
    type: world
    debug: false
    events:
        # Affects behavior; use an early-firing priority
        on player left clicks priority:-15:
        - if <player.item_in_hand.nbt[weapon_type]||null> == wand && <player.has_flag[attack_cooldown].not>:
            - flag <player> attack_cooldown:true duration:<player.attack_cooldown_max_duration>
            - flag <player> wand_cast:true duration:1s
            - execute as_player "cast <player.item_in_hand.nbt[spell]>"
        - else if <player.item_in_hand.nbt[weapon_type]||null> == wand:
            - flag <player> attack_cooldown:true duration:<player.attack_cooldown_max_duration>

wand_spell_handler:
    type: world
    debug: false
    events:
        on magicspells player casts spell:
        - if <player.item_in_hand.nbt[weapon_type]||null> == wand && <player.has_flag[wand_cast]> && <context.spell_name> == <player.item_in_hand.nbt[spell]>:
            - determine clear_reagents