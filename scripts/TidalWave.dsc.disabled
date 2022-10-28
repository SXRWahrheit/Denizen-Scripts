WaveShooter:
    type: task
    definitions: caster
    speed: 0
    script:
    - if <[caster]||null> == null:
        - define caster <player>
    - define source <[caster].location.with_pitch[0]>
    - define forward <[source].direction.vector>
    - define offset <[forward].rotate_around_y[<util.pi.div[2]>].div[2]>
    - define source_position <[caster].location>
    - define wave_width 5
    - define wave_total <[wave_width].mul[2]>
    - define origin_list li@
    - define speed 0.5
    - define wave_landing 5
    - define wave_length 30
    # origin repeat
    - repeat <[wave_total]>:
        - define total_offset <[offset].mul[<[value].sub[0.5]>]>
        - define origin_list <[origin_list].include[<[source].add[<[total_offset]>]>]>
        - define origin_list <[origin_list].include[<[source].sub[<[total_offset]>]>]>
    # shooting repeat
    - repeat <[wave_length].div[<[speed]>]>:
        - define entities li@
        - define total_forward <[forward].mul[<[value]>].mul[<[speed]>]>
#        - define total_landing <[forward].mul[<[value]>].mul[<[speed]>].mul[<[wave_landing]>]>
        - foreach <[origin_list]> as:locations:
#            - shoot falling_block,concrete,11[fallingblock_drop_item=false] origin:<[value].add[<[total_forward]>]> destination:<[value].add[<[total_landing]>]> save:Wave
            - shoot falling_block,concrete,11[fallingblock_drop_item=false] origin:<[locations].add[<[total_forward]>]> save:Wave
            - foreach <entry[Wave].shot_entities> as:shot_blocks:
                - yaml id:WaveManager set <[shot_blocks].uuid>:RemoveOnLand
            - if <[locations].find.living_entities.within[1.0].exclude[<[caster]>].deduplicate.size> > 0:
                - define entities <[entities].include.[<[locations].find.living_entities.within[1.0]>].exclude[<[caster]>].deduplicate>
            - if <[entities].size> > 0:
                - foreach <[entities]> as:HitEntity:
                    - shoot <[HitEntity]> origin:<[HitEntity].location> destination:<[HitEntity].location.add[0,10,0]>
        - wait 1t
WaveFlagManager:
    type: world
    events:
        on server start:
        - yaml create id:WaveManager
RemoveWater:
    type: world
    events:
        on falling_block changes block:
        - if <yaml[WaveManager].read[<context.entity.uuid>]> == RemoveOnLand:
            - determine cancelled
        #- narrate "context.entity.uuid is <context.entity.uuid>" targets:<server.match_player[Wahrheit]>
        #- narrate "context.old_material is <context.old_material>" targets:<server.match_player[Wahrheit]>
        #- narrate "context.new_material is <context.new_material>" targets:<server.match_player[Wahrheit]>
