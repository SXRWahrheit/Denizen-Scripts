Wind_Skip:
    type: world
    debug: false
    events:
        after mythickeys key pressed id:minecraft:jump flagged:wind_skip_enabled:
        - if <player.is_on_ground>:
            - flag <player> jump_rate_limit:true expire:3t
        after mythickeys key pressed id:minecraft:jump flagged:!wind_skip_capped|!jump_rate_limit|wind_skip_enabled:
        - if <player.is_on_ground>:
            - stop
        - if <player.location.with_pose[90,90].ray_trace.distance[<player.location>].is_less_than[0.6].if_null[true]>:
            - stop
        # - narrate <player.location.with_pose[90,90].precise_cursor_on.distance[<player.location>]>
        - if <player.is_sprinting>:
            - define forward 0.2
        - else:
            - define forward 0.1
        - adjust <player> velocity:<player.location.forward[<[forward]>].above[0.5].sub[<player.location>]>
        - playeffect effect:cloud at:<player.location> quantity:10 data:1
        - flag <player> wind_skip_capped
        - run Wind_Skip_Landing_Tracker

Wind_Skip_Landing_Tracker:
    type: task
    debug: false
    speed: 0
    script:
    - while <player.has_flag[wind_skip_capped]>:
        - if <player.is_on_ground>:
            - flag <player> wind_skip_capped:!
        - wait 1t