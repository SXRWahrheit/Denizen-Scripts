enchantarrows_nature:
    type: task
    debug: false
    definitions: player
    script:
    - flag <[player]> enchantarrows-nature:true duration:300s
enchantarrows_nature_handler:
    type: world
    debug: false
    events:
        on player flagged:enchantarrows_nature shoots bow:
        - define entity <context.entity>
        - if <[entity].has_flag[enchantarrows-nature].if_null[null]>:
            - flag <context.projectile> enchanted:true
            - flag <context.projectile> enchantment:nature
        on player flagged:enchantarrows_nature damages entity:
        - define entity <context.entity>
        - if <context.damager.has_flag[enchantarrows-nature]> && <context.projectile.flag[enchantment].if_null[null]> == nature:
            - flag <[entity]> no-fall-damage:true duration:1.5s
            - cast jump duration:1s power:-7 <[entity]>
            - cast slow duration:1s power:10 <[entity]>
        on entity damaged:
        - define entity <context.entity>
        - if <[entity].has_flag[no_fall_damage]> && <context.cause> == fall:
            - determine cancelled