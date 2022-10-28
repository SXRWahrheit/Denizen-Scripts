#Needs_Updating

frozen_wave_cast:
    type: world
    debug: false
    events:
        on mm denizen mechanic:
        - if <context.skill> == frozenwave-cast:
            - define caster <context.caster>
            - define location <context.caster.location>
            - if <[caster].as_player.has_flag[frozenwave-activated]>:
#                - narrate "Caster already had the flag" targets:<[caster]>
                - stop
            - flag <[caster]> frozenwave-activated:1
            - define radius 8
            - define angle 75
            - define radians <[angle].to_radians>
            - define edge <location[<[radius]>,0,0]>
            - define point-number 20

            - define edge <[edge].rotate_around_y[<[radians]>]>
            - define perp <[edge].rotate_around_y[<util.pi.div[4]>].div[<[radius]>]>
            - define edge-plus <[location].add[<[edge]>]>
            - define edge-minus <[location].sub[<[edge]>]>
            - define list <list[]>
            - define list-radius <[location].find.entities.within[8].exclude[<[caster]>]>
            - foreach <[list-radius]>:
                - if <[location].facing[<[value].location>].degrees[<[angle]>]>:
                    - define list <[list].include[<[value]>]>
            - foreach <[edge-minus].points_between[<[edge-plus]>].distance[<[radius].div[<[point-number]>]>]>:
                - define offset <[loop_index].mul[<util.pi>].div[<[point-number]>].sin>
                - define sin-angle <[loop_index].mul[<[radius]>].sin>
                - define list <[list].include[<[value].add[<[perp].mul[<[offset]>]>]>]>
            - playeffect <[list]> effect:blockcrack_12 quantity:12 offset:2,1,2 visibility:100
            - foreach <[location].find.entities.within[10].exclude[<[caster]>]>:
                - adjust <[value]> velocity:<[value].location.face[<[location]>].direction.vector.div[8]>
            - cast slow duration:5 power:4 <[location].find.entities.within[10].exclude[<[caster]>]>
            - flag <[caster]> frozenwave-activated:!

# Get point on edge of circle
# Define list of points between center and edge
