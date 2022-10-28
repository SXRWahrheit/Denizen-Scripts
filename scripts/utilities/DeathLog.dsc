Player_Death_Logger_Monitor:
    type: world
    debug: false
    events:
        on player dies bukkit_priority:monitor:
        - announce to_console "Monitor Logger - <player.name> died at <player.location>, dObject <player>"
        - announce to_console "Player had <player.xp_level> levels and <player.xp_total> total XP"
        - announce to_console "Drops: <context.drops>"
        - flag <player> last_inventory:<context.drops>

#Player_Death_logger_lowest:
#    type: world
#    debug: false
#    events:
#        on player dies bukkit_priority:lowest:
#        - announce to_console "Lowest Logger - <player.name> died, dObject <player>"
#        - announce to_console "Player had <player.xp_level> levels and <player.xp_total> total XP"
#        - announce to_console "<player.name> had the following inventory:"
#        - announce to_console <player.inventory.list_contents.unescaped>
#        - announce to_console "<player.name> inventory escaped:"
#        - announce to_console <player.inventory.list_contents>
#        - announce to_console "Drops: <context.drops>"