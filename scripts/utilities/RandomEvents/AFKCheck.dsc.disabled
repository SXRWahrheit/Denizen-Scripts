afk_player_handler:
    type: world
    debug: false
    events:
        on delta time minutely:
        - foreach <server.list_online_players> as:player:
            - flag <[player]> afk_last_location:<[player].location>
            - if <[player].location.distance_squared[<[player].flag[afk_last_location]>]> >= 100 || <[player].location.pitch> != <[player].flag[afk_last_location].pitch> || <[player].location.yaw> != <[player].flag[afk_last_location].yaw>:
                - flag <[player]> afk_timer:0
            - else:
                - flag <[player]> afk_timer:++
            - if <[player].flag[afk_timer]> >= 10:
                - kick <[player]> "reason:Disconnected for being AFK"
            - else if <[player].flag[afk_timer]> == 9:
                - narrate "<red>HEY! You're going to be disconnected if you don't move around a little bit in the next minute!"
            - else if <[player].flag[afk_timer]> >= 5:
                - narrate "<red>Hey! Are you AFK? You've been in the same area for quite a while! If you don't move in the next <element[10].sub[<[player].flag[afk_timer]>]> minutes, you'll be disconnected!"
        on player steps on block flagged:afk_timer:
        - if <context.location.above.material.name.contains_text[water]>:
            - stop
        - flag <player> afk_timer:!
        - flag <player> afk_risk:!