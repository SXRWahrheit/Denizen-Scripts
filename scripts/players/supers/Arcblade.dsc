#Needs_Updating

arcblade_yaml_handler:
    type: world
    debuge: false
    events:
        on server start:
        - yaml create id:arcblade
        on shutdown:
        - yaml unload id:arcblade

arcblade_chain:
    type: world
    debug: false
    events:
        on mm denizen mechanic:
        - if <context.skill> == arcblade-task-runner:
            - define L1 <context.target.location.find.entities.within[10].exclude[<context.caster>|<context.target>].get[1].to[5]>
            - if <[L1].size> == 0 stop
            - define L1_dist <[L1].last.location.distance[<context.target.location>]>
            - define L2 <list[]>
            - foreach <[L1]>:
                - define L2 <[L2].include[<[value].location.find.entities.within[10].exclude[<[L1].include[<context.caster>|<context.target>]>].filter[location.distance[<context.target.location>].is[MORE].than[<[L1_dist]>]]>]>
            - define L2 <[L2].deduplicate.get[1].to[6]>
            - foreach <[L1]>:
                - define ent <[value]>
                - playeffect <context.target.location.points_between[<[ent].location>].distance[0.1]> effect:villager_happy offset:0,0,0
                - repeat 2:
                    - if <[L2].size> == 0 stop
                    - define L2 <[L2].sort_by_number[location.distance[<[ent].location>]]>
                    - playeffect <[ent].location.points_between[<[L2].get[1].location>].distance[0.1]> effect:villager_happy offset:0,0,0
                    - define L2 <[L2].remove[1]>