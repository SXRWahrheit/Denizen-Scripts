NewPlayerJoin:
    type: world
    debug: false
    events:
        after player joins:
        - if <player.has_flag[joined]>:
            - stop
        - if <player.statistic[play_one_minute]> > 5:
            - flag <player> joined
            - stop
        - wait 0.5s
        - adjust <player> location:<location[swabby]>
        - wait 5s
        - narrate "<&a>The Gods welcome you to Prosperus! Check your pockets for a book with some useful information..."
        - narrate "<&a>If you'd like to go start building, use a boat to sail down the river. You can get more boats from the docks."
        - narrate "<&a>Be sure to use <&b>/sethome <&a>once you get to where you want to build. You can <&b>/home<&a> to it later. (Say, if you happened to die. Not that you would.)"
        - give NewPlayerBook
        - give oak_boat
        - give Adventurers_Crystal quantity:16
        - flag <player> money:100
        - flag <player> joined