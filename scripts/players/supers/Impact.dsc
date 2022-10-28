#Needs_Updating
Impact_Cast:
    type: world
    debug: false
    events:
        on impact_cast command:
        - if <context.skill> == impact-cast:
            - define caster <context.caster>
#            - narrate "Impact cast" targets:<[caster]>
            - if <[caster].as_player.has_flag[impact-activated]>:
#                - narrate "Caster already had the flag" targets:<[caster]>
                - stop
#            - define cost 125
#            - yaml id:super-counter set energy.<context.caster.uuid>:<yaml[super-counter].read[energy.<context.caster.uuid>].sub[<[cost]>]>
            - adjust <[caster]> gravity:false
            - adjust <[caster]> velocity:0,0.5,0
            - flag <[caster]> impact-activated:1
            - wait 8s
#            - narrate "Wait finished" targets:<[caster]>
#            - narrate "<[caster].as_player.has_flag[impact-activated]>" targets:<[caster]>
#            - narrate "<[caster]>" targets:<[caster]>
            - if <[caster].as_player.has_flag[impact-activated]>:
#                - narrate "Caster has flag, adjusting values" targets:<[caster]>
                - flag <[caster]> impact-activated:!
                - adjust <[caster]> gravity:true
Impact_Swing:
    type: world
    debug: false
    events:
        on impact_swing command:
        - if <context.skill> == impact-swing:
            - define caster <context.caster>
#            - define cost 200
            - if <[caster].as_player.has_flag[impact-activated]>:
#                - yaml id:super-counter set energy.<context.caster.uuid>:<yaml[super-counter].read[energy.<context.caster.uuid>].sub[<[cost]>]>
                - adjust <[caster]> gravity:true
                - adjust <[caster]> velocity:<[caster].location.with_pose[<[caster].location.pitch.abs>,<[caster].location.yaw>].direction.vector.mul[5]>
                - while <[caster].location.sub[0,1,0].material.name> == air:
                    - wait 5t
                - adjust <[caster]> velocity:0,0,0
                - define mobs <[caster].location.find_entities.within[15].exclude[<[caster].location.find_entities[player].within[15]>]>
                - define players <[caster].location.find_entities[player].within[15]>
                - define particle-count 0
                - repeat 160:
                    - playeffect <context.target.location> effect:CLOUD visibility:500 quantity:10 data:1 offset:<[particle-count].div[20]>,0.1,<[particle-count].div[20]>
                    - define particle-count <[particle-count].add[1]>
                - playsound <[caster]> sound:ENTITY_GENERIC_EXPLODE
                - flag <[caster]> impact-activated:!
                - hurt 40 <[mobs]> source:<[caster]>
                - hurt 15 <[players]> source:<[caster]>