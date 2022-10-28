#Needs_Updating
Overgrowth Cast:
    type: world
    debug: false
    events:
        on mm denizen mechanic:
        - if <context.skill> == overgrowth-cast:
            - define caster <context.caster>
            - define duration 20
            - define super-passive-spending 4
            - define super-max-energy 300
            - define wait 5
            - define duration-calculated <[super-max-energy].div[<[duration]>].sub[<[super-passive-spending]>].div[20].mul[<[wait]>]>
            - if <[caster].as_player.has_flag[overgrowth-activated]>:
#                - narrate "Caster already had the flag" targets:<[caster]>
                - stop
            - flag <[caster]> max-health:<player.health.max>
            - flag <[caster]> overgrowth-activated:1
            - adjust <[caster]> max_health:<player.health.max.add[20]>
            - adjust <[caster]> health:<player.health.add[20]>
            - while <yaml[super-counter].read[energy.<context.caster.uuid>].is[more].than[0]>:
                - yaml id:super-counter set energy.<context.caster.uuid>:<yaml[super-counter].read[energy.<context.caster.uuid>].sub[<[duration-calculated]>]>
                - wait <[duration]>t
            - adjust <[caster]> max_health:<[caster].flag[max-health]>
            - if <[caster].health> > <[caster].flag[max-health]>:
                - adjust <[caster]> health:<[caster].flag[max-health]>
            - flag <[caster]> max-health:!
            - flag <[caster]> overgrowth-activated:!