ConfluxTimerHandler:
    type: world
    events:
        on system time minutely every:10:
            - if <util.random.int[1].to[8]> == 1:
                - run ConfluxCreationHandler
            - else:
                - flag server conflux_timer_count:++
                - if <server.flag[conflux_timer_count]> >= 8:
                    - run ConfluxCreationHandler

ConfluxCreationHandler:
    type: task
    script:
    - announce to_console "Conflux handler is creating a conflux!"
    - random:
        - define conflux_world prosperus
        - define conflux_world heavens
        - define conflux_world prosperus_nether
        - define conflux_world avenfeld
    - flag server conflux_location:<yaml[conflux_list_<[conflux_world]>].read[conflux_locations]>