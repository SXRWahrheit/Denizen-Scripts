"Heavens Portal Creation":
    type: world
    debug: false
    events:
        on player right clicks quartz_block with flint_and_steel in prosperus:
        - if <context.location.add[0,1,0].material.name> != air:
            - stop
        - if <context.location.add[1,0,0].material.name> == quartz_block && <context.location.add[-1,0,0].material.name> == quartz_block:
            - define axis-pos l@1,0,0
            - define axis-neg l@-1,0,0
            - define axis-data 1
        - else if <context.location.add[0,0,1].material.name> == quartz_block && <context.location.add[0,0,-1].material.name> == quartz_block:
            - define axis-pos l@0,0,1
            - define axis-neg l@0,0,-1
            - define axis-data 2
        - else
            - stop
        - define origin <context.location.add[0,1,0]>
        - define node <[origin]>
        - define air-list li@
        - define y-list li@
        - define y-max <[origin].y>
        - define y-min <[origin].y>
        - define x-max <[origin].x>
        - define x-min <[origin].x>
        - define z-max <[origin].z>
        - define z-min <[origin].z>
        - while <[node].material.name.is[==].to[air]>:
            - define air-list <[air-list].include[<[node]>]>
            - define y-list <[y-list].include[<[node]>]>
            - define y-max <[y-max].max[<[node].y>]>
            - define y-min <[y-min].min[<[node].y>]>
            - define node <[node].add[0,1,0]>
        - if <[node].material.name> != quartz_block:
            - stop
        - else:
            - foreach <[y-list]>:
                - define node <[value]>
                - while <[node].material.name.is[==].to[air]>:
                    - define air-list <[air-list].include[<[node]>]>
                    - if <[axis-data]> == 1:
                        - define x-max <[x-max].max[<[node].x>]>
                        - define x-min <[x-min].min[<[node].x>]>
                    - if <[axis-data]> == 2:
                        - define z-max <[z-max].max[<[node].z>]>
                        - define z-min <[z-min].min[<[node].z>]>
                    - define node <[node].add[<[axis-pos]>]>
                - if <[node].material.name> != quartz_block:
                    - stop
                - define node <[value]>
                - while <[node].material.name.is[==].to[air]>:
                    - define air-list <[air-list].include[<[node]>]>
                    - if <[axis-data]> == 1:
                        - define x-max <[x-max].max[<[node].x>]>
                        - define x-min <[x-min].min[<[node].x>]>
                    - if <[axis-data]> == 2:
                        - define z-max <[z-max].max[<[node].z>]>
                        - define z-min <[z-min].min[<[node].z>]>
                    - define node <[node].add[<[axis-neg]>]>
                - if <[node].material.name> != quartz_block:
                    - stop
        - modifyblock <[air-list]> m@end_gateway,<[axis-data]> no_physics
#        - announce to_console "cu@<[x-min].add[<[axis-neg].x>]>,<[y-min].add[-1]>,<[z-min].add[<[axis-neg].z>]>,prosperus|<[x-max].add[<[axis-pos].x>]>,<[y-max].add[1]>,<[z-max].add[<[axis-pos].z>]>,prosperus as:heavens-portal-<util.random.duuid>"
        - note cu@<[x-min].add[<[axis-neg].x>]>,<[y-min].add[-1]>,<[z-min].add[<[axis-neg].z>]>,prosperus|<[x-max].add[<[axis-pos].x>]>,<[y-max].add[1]>,<[z-max].add[<[axis-pos].z>]>,prosperus as:heavens-portal-<util.random.duuid>
"Heavens Portal Removal":
    type: world
    debug: false
    events:
        on player breaks end_gateway:
        - if <context.location.cuboids.contains_text[heavens-portal]>:
            - define notable <context.location.cuboids.filter[notable_name.starts_with[heavens-portal]].get[1]>
            - modifyblock <[notable].blocks[end_gateway]> m@air
            - note remove as:<[notable].notable_name>
        on player breaks quartz_block:
        - if <context.location.cuboids.contains_text[heavens-portal]>:
            - define notable <context.location.cuboids.filter[notable_name.starts_with[heavens-portal]].get[1]>
            - modifyblock <[notable].blocks[end_gateway]> m@air
            - flag server <context.cuboids.filter[notable_name.starts_with[heavens-portal]].get[1].notable_name>:!
            - note remove as:<[notable].notable_name>
"Heavens Portal Entry":
    type: world
    debug: false
    events:
        on player enters notable cuboid:
        - if <context.cuboids.contains_text[heavens-portal]>:
            - define target-location l@<context.from.x.div[2].as_int>,<context.from.y.as_int>,<context.from.z.div[2].as_int>,heavens
#            - announce to_console "def target-location: <[target-location]>"
            - define target-material <[target-location].material.name>
#            - announce to_console "def target-material: <[target-material]>"
            - define portal <context.cuboids.filter[notable_name.starts_with[heavens-portal]].get[1]>
#            - announce to_console "def portal: <[portal]>"
            - define portal-exit <context.cuboids.filter[notable_name.starts_with[heavens-portal]].get[1].notable_name>
#            - announce to_console "def portal-exit: <[portal-exit]>"
            - define portal-unsafe-exit <[portal-exit]>-unsafe
#            - announce to_console "def portal-unsafe-exit: <[portal-unsafe-exit]>"
#            - wait 1t
            - if <server.has_flag[<[portal-exit]>]>:
                - wait 1t
                - teleport <server.flag[<[portal-exit]>]>
                - stop
            - if <server.has_flag[<[portal-unsafe-exit]>]>:
                - wait 1t
                - teleport <server.flag[<[portal-unsafe-exit]>]>
#                - announce to_console "teleport <server.flag[<[portal-unsafe-exit]>]>"
                - adjust <player> gliding:true
                - stop
            - if <[target-material]> == air && <[target-location].add[0,-1,0].material.name> != air && <[target-location].add[0,1,0].material.name> == air:
                - announce to_console "Initial block is safe"
                - define teleport-location l@<context.from.x.div[2]>,<context.from.y>,<context.from.z.div[2]>,heavens
                - wait 1t
                - teleport <[teleport-location]>
 #               - announce to_console "teleport <[teleport-location]>"
                - flag server <[portal-exit]>:<[teleport-location]>
                - stop
            - define size 10
            - if <[target-location].find.surface_blocks.within[<[size]>].size> >= 1:
                - announce to_console "Finding safe spot"
                - define safe-spot <[target-location].find.surface_blocks.within[<[size]>].random>
                - announce to_console "Safe spot: <[safe-spot]>"
                - wait 1t
                - teleport <[safe-spot]>
#                - announce to_console "teleport <[safe-spot]>"
                - flag server <[portal-exit]>:<[safe-spot]>
                - stop
            - else:
                - announce to_console "No safe spot, let's glide!"
                - flag server <[portal-unsafe-exit]>:l@<context.from.x.div[2]>,256,<context.from.z.div[2]>,heavens
                - define teleport-location l@<context.from.x.div[2]>,256,<context.from.z.div[2]>,heavens
                - wait 1t
                - teleport <[teleport-location]>
#                - announce to_console "teleport <[teleport-location]>"
                - adjust <player> gliding:true
                - stop
#            - determine cancelled
        on player stops gliding in heavens:
        - if <player.has_flag[player-gliding-chestplate]>:
            - equip <player> chest:<player.flag[player-gliding-chestplate]>
            - flag <player> player-gliding-chestplate:!
#"Portal Gliding Handler":
#    type: world
#    debug: false
#    events:
#        on player stops gliding in heavens:
#        - if <player.has_flag[portal-exiter]>:
##            - flag <player> portal-exiter:!
#            - determine cancelled
##        - determine cancelled
#        on player starts gliding in heavens:
#        - if <player.has_flag[portal-exiter]>:
##            - flag <player> portal-exiter:!
#            - determine cancelled:false
