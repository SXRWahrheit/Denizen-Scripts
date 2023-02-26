Sandstorm_Cast:
    type: world
    debug: false
    events:
        on sandstorm command:
        - if <context.skill> == sandstorm-cast:
            - define caster <context.caster>
            - define location <context.caster.location>
            - define duration 20
            - define super-passive-spending 4
            - define super-max-energy 300
            - define wait 1
            - define duration-calculated <[super-max-energy].div[<[duration]>].sub[<[super-passive-spending]>].div[20].mul[<[wait]>]>
            - if <[caster].has_flag[sandstorm-activated]>:
#               - narrate "Caster already had the flag" targets:<[caster]>
                - stop
            - flag <[caster]> sandstorm-activated:1
            - define radius 10
            - define angle-inc 10
            - define radians <[angle-inc].to_radians>
            - define edge1 <location[<[radius]>,0,0]>
            - define point-number 20
            - define amplitude 2
            - while <yaml[super-counter].read[energy.<context.caster.uuid>].is[more].than[0]>:
                - yaml id:super-counter set energy.<context.caster.uuid>:<yaml[super-counter].read[energy.<context.caster.uuid>].sub[<[duration-calculated]>]>
                - cast effect:slow duration:5 power:4 <[location].find_entities.within[10].exclude[<[caster]>]>
                # Rotates the main brace by the step angle
                - define edge1 <[edge1].rotate_around_y[<[radians]>]>
                # Defines the second brace on a 90 degree angle
                - define edge2 <[edge1].rotate_around_y[<util.pi.div[2]>]>
                # Defines the perpendicular scale
                - define scale <[amplitude].div[<[radius]>]>
                # Defines the perpendicular to the first brace as the second brace scaled
                - define perp1 <[edge2].mul[<[scale]>]>
                # Defines the perpendicular to the second brace as the first brace scaled
                - define perp2 <[edge1].mul[<[scale]>]>
                # Defines the start and end points of the first brace
                - define edge1-plus <[location].add[<[edge1]>]>
                - define edge1-minus <[location].sub[<[edge1]>]>
                - define list <list[]>
                - foreach <[edge1-minus].points_between[<[edge1-plus]>].distance[<[radius].div[<[point-number]>]>]>:
                    - define offset <[loop_index].mul[<util.pi>].div[<[point-number]>].sin>
                    - define sin-angle <[loop_index].mul[<[radius]>].sin>
                    - define list <[list].include[<[value].add[<[perp1].mul[<[offset]>]>]>]>
                # Defines the start and end points of the second brace
                - define edge2-plus <[location].add[<[edge2]>]>
                - define edge2-minus <[location].sub[<[edge2]>]>
                - foreach <[edge2-minus].points_between[<[edge2-plus]>].distance[<[radius].div[<[point-number]>]>]>:
                    - define offset <[loop_index].mul[<util.pi>].div[<[point-number]>].sin.mul[-1]>
                    - define sin-angle <[loop_index].mul[<[radius]>].sin>
                    - define list <[list].include[<[value].add[<[perp2].mul[<[offset]>]>]>]>
                - playeffect <[list]> effect:crit quantity:12 offset:2,1,2 visibility:100
                - foreach <[location].find_entities.within[10].exclude[<[caster]>]>:
                    - adjust <[value]> velocity:<[value].location.face[<[location]>].direction.vector.div[8]>
                - wait 1t
            - flag <[caster]> sandstorm-activated:!
