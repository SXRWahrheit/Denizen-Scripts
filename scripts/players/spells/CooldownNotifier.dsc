Cooldown_Notifier:
    type: task
    debug: true
    speed: 0
    definitions: cooldown|type
    script:
    - wait <[cooldown]>
    - if <player.has_flag[cooldown_actionbar]>:
        - actionbar targets:<player> "<green><underline><[type]> ready!"
    - if <player.has_flag[cooldown_sound]>:
        - playsound <player> sound:block_note_block_chime pitch:2