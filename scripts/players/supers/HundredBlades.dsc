"Hundred Blades Cast":
    type: world
    debug: false
    events:
        on mm denizen mechanic:
        - if <context.skill> == "hundredblades-cast":
            - define caster <context.caster>
            - define duration 20
            - define super-passive-spending 4
            - define super-max-energy 300
            - define wait 5
            - define duration-calculated <[super-max-energy].div[<[duration]>].sub[<[super-passive-spending]>].div[20].mul[<[wait]>]>
            - if <[caster].as_player.has_flag[hundredblades-activated]>:
#                - narrate "Caster already had the flag" targets:<[caster]>
                - stop
            - flag <[caster]> hundredblades-activated:1
            - while <yaml[super-counter].read[energy.<context.caster.uuid>].is[more].than[0]>:
                - yaml id:super-counter set energy.<context.caster.uuid>:<yaml[super-counter].read[energy.<context.caster.uuid>].sub[<[duration-calculated]>]>
                - wait <[wait]>t
            - flag <[caster]> hundredblades-activated:!
        on player damages entity:
        - if <player.has_flag[hundredblades-activated]>:
            - flag <context.entity> hundredblades-multiplier:+:0.1 duration:30s
            - determine <context.damage.mul[<context.entity.flag[hundredblades-multiplier].add[1]>]>