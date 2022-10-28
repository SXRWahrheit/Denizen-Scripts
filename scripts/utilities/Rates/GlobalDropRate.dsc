#mm_drop_modifier:
#    type: world
#    debug: false
#    events:
#        on mythicmob mob dies:
#        - narrate "context.drops: <context.drops>"
#        - narrate "context.mob: <context.mob>"
#        - narrate "context.xp: <context.xp>"
#drop_rate_data:
#    type: yaml data
#    debug: false
#    drop_rate_multiplier: 1
#    drop_multiplier_active: true
drop_rate_announcement:
    type: world
    debug: false
    events:
        on player joins:
        - if <yaml[events].read[tribute.active]>:
            - stop
        - if <yaml[rates].read[drops.active]>:
            - wait 4s
            - narrate "<&6>A bonus drop rate event is active! Go monster hunting with a <yaml[rates].read[drops.multiplier]>x chance for rare item drops!"