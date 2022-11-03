Broken_Interact_Step_Fixer:
    type: world
    debug: false
    events:
        after player joins:
        - foreach <util.scripts.filter_tag[container_type.is[==].to[interact]]> as:script:
            - if !<[script].list_keys[steps].contains[<[script].step[<player>]>]>:
                - zap <[script]> <[script].default_step>