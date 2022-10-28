AntiFarm_Proc:
    type: procedure
    definitions: entity
    debug: false
    # usage: <proc[AntiFarm_Proc].context[<EntityTag>]>
    script:
    - if <yaml[antifarm-flags].read[expirations.<[entity].location.simple>].as_list.size||0> >= 2:
        - determine true
    - else:
        - determine false

YAML_AntiFarm:
    type: world
    debug: false
    events:
        on server start:
        - wait 5s
        - yaml create id:antifarm-flags
        on shutdown:
        - yaml unload id:antifarm-flags

        on entity dies:
        # Check to see if entity was a player
        - define entity <context.entity>
        - if <[entity].is_player>:
            # If so, cancel all below checks
            - stop

        # Check to see if any timers exist on this block
        - if <yaml[antifarm-flags].contains[expirations.<context.entity.location.simple>]>:
        # If yes, clear any old timers
            - yaml id:antifarm-flags set expirations.<context.entity.location.simple>:<yaml[antifarm-flags].read[expirations.<context.entity.location.simple>].as_list.filter[is_before[<util.time_now>]]>

        # Add a timer for this mob's death
        - yaml id:antifarm-flags set expirations.<context.entity.location.simple>:<list[<util.time_now.add[30m]>].include[<yaml[antifarm-flags].read[expirations.<context.entity.location.simple>]||<list[]>>]>

        # Check to see whether there are too many timers on this block
        - if <yaml[antifarm-flags].read[expirations.<context.entity.location.simple>].as_list.size||0> >= 2:
            # Debug messages
#            - announce to_console "[DEBUG] Normal mobs YAML same location: <context.entity.location.simple>"
#            - announce to_console "[DEBUG] Normal mobs YAML same location size: <yaml[antifarm-flags].read[expirations.<context.entity.location.simple>].as_list.size>"

            # Cancel drops and experience
            - determine NO_DROPS_OR_XP
            - stop

        on mythicmob mob dies:
        - define entity <context.entity>

        # Check to see if any timers exist on this block
        - if <yaml[antifarm-flags].contains[expirations.<context.entity.location.simple>]>:
        # If yes, clear any old timers
            - yaml id:antifarm-flags set expirations.<context.entity.location.simple>:<yaml[antifarm-flags].read[expirations.<context.entity.location.simple>].as_list.filter[is_before[<util.time_now>]]>

        # Add a timer for this mob's death
        - yaml id:antifarm-flags set expirations.<context.entity.location.simple>:<list[<util.time_now.add[30m]>].include[<yaml[antifarm-flags].read[expirations.<context.entity.location.simple>]||<list[]>>]>

        # Check to see whether there are too many timers on this block
        - if <yaml[antifarm-flags].read[expirations.<context.entity.location.simple>].as_list.size||0> >= 2:
            # Debug messages
#            - announce to_console "[DEBUG] Normal mobs YAML same location: <context.entity.location.simple>"
#            - announce to_console "[DEBUG] Normal mobs YAML same location size: <yaml[antifarm-flags].read[expirations.<context.entity.location.simple>].as_list.size>"

            # Cancel drops and experience
            - determine <list>

        # Check for and cancel an empty gold message
        on player receives message:
        - if "<context.message.contains_text[dropped 0.0 gold]>":
            - determine CANCELLED

Anti_Spawner_YAML:
    type: world
    debug: false
    events:
        on server start:
        - wait 5s
        - yaml create id:antispawner-flags
        - yaml id:antispawner-flags set entities.spawned-by-spawner:!
        on shutdown:
        - yaml unload id:antispawner-flags

        on entity spawns:
        - if <context.entity.is_player>:
            - stop
#        - announce to_console "[DEBUG] context.entity.location.find.blocks[mob_spawner].within[8] is <context.entity.location.find.blocks[mob_spawner].within[8]>"
#        - if <context.entity.location.find.blocks[mob_spawner].within[8]> != li@:
#            - wait 1t
##            - announce to_console "[DEBUG] Mob spawned within 8 blocks of spawner, reason is <context.reason>"
#            - yaml id:antispawner-flags set entities.spawned-by-spawner:->:<context.entity.uuid>
        - if <context.reason> == SPAWNER:
            - wait 1t
#            - announce to_console "mob with reason SPAWNER spawned"
            - yaml id:antispawner-flags set entities.spawned-by-spawner:->:<context.entity.uuid>
#            - announce to_console <context.entity.uuid>
#        - if <context.reason> == CUSTOM:
#            - wait 1t
#            - yaml id:antispawner-flags set entities.spawned-by-spawner:->:<context.entity.uuid>

        on entity dies:
        - define entity <context.entity>
        - if <[entity].is_player>:
            - stop

        #- announce to_console <[entity].uuid>
        - if <yaml[antispawner-flags].read[entities.spawned-by-spawner].contains[<[entity].uuid>].if_null[false]>:
#            - announce to_console "[DEBUG] Normal mobs YAML spawner"
            - determine NO_DROPS_OR_XP
            - yaml id:antispawner-flags set entities.spawned-by-spawner:<-:<[entity].uuid>

        #on mythicmobs lootdrop:
        #- if <yaml[antispawner-flags].read[entities.spawned-by-spawner].contains[<context.activemob.uuid||null>]||null>:
#       #     - announce to_console "[DEBUG] MythicMobs YAML spawner"
        #    - determine <list[]>
        #    - yaml id:antispawner-flags set entities.spawned-by-spawner:<-:<context.activemob.uuid>