boatlauncher:
    type: world
    debug: false
    events:
        on player enters boatlauncher2:
        - if <context.cuboids.contains_text[boatlauncher2]>:
            - wait 5t
            - define vehicle <player.vehicle>
            - define speed <player.vehicle.speed>
            - mount <player>|<[vehicle]> cancel
            - adjust <[vehicle]>|<player> velocity:<[vehicle].location.direction.vector.mul[<[speed]>].mul[1.5].add[0,2,0]>
            - wait 1s
            - mount <player>|boat