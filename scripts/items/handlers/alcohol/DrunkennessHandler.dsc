# Adds to player's drunkenness as they consume alcohol. Higher levels of drunkenness may result in alcohol poisoning.

drunkenness_consumption_handler:
    type: world
    debug: true
    events:
        after player consumes item_flagged:alcohol:
        - flag <player> drunkenness:+:<context.item.flag[alcohol.strength]> expire:30m
        - cast confusion duration:6s amplifier:0
        - cast slow duration:6s amplifier:0
        - narrate "<red>You have a drink and begin to feel its effects..."
        - wait 6s
        # Player blacks out
        - if <player.flag[drunkenness]> > 40:
            - flag <player> blackout expire:5m
            - if <player.has_flag[blackout]>:
                - stop
            - narrate "<red>You've had quite a bit to drink..."
            - wait 1s
            - cast blindness duration:6s amplifier:0
            - cast confusion duration:10s amplifier:0
            - cast hunger duration:10s amplifier:0
            - cast slow duration:10s amplifier:0
            - narrate "<red>You start to feel downright sick..."
            - wait 10s
            - cast blindness duration:10s amplifier:1
            - cast confusion duration:20s amplifier:1
            - cast hunger duration:20s amplifier:1
            - cast slow duration:20s amplifier:1
            - narrate "<red>You're losing your footing..."
            - wait 20s
            - cast blindness duration:10s amplifier:2
            - cast confusion duration:10s amplifier:2
            - cast hunger duration:10s amplifier:2
            - cast slow duration:10s amplifier:2
            - narrate "<red>Wait a minute... where did the ground come from?"
            - cast blindness duration:30s amplifier:5
            - cast confusion duration:30s amplifier:2
            - cast hunger duration:30s amplifier:2
            - cast slow duration:30s amplifier:2
            - wait 20s
            - narrate "<red>Things are fading..."
            - teleport <player> spawn
            - cast confusion duration:10m amplifier:1
            - cast hunger duration:10m amplifier:0
            - cast slow duration:10m amplifier:0
            - narrate "<red>You wake up in Dawn's Landing with a splitting headache."
            - flag <player> drunkenness:0
            - stop
        - if <player.flag[drunkenness]> > 36:
            - narrate "<red>You're becoming really quite drunken..."
            - wait 5s
            - cast confusion duration:10s amplifier:0
            - cast slow duration:10s amplifier:0
            - cast hunger duration:10s amplifier:0
            - narrate "<red>You think you might be approaching your limits..."
            - wait 10s
            - cast confusion duration:30s amplifier:1
            - cast slow duration:30s amplifier:1
            - cast hunger duration:30s amplifier:1
            - narrate "<red>If you take a break for a while, things might be fine..."
            - wait 30s
            - cast confusion duration:2m amplifier:0
            - cast slow duration:2m amplifier:0
            - cast hunger duration:2m amplifier:0
            - stop
        - if <player.flag[drunkenness]> > 24:
            - narrate "<red>You're getting quite drunk..."
            - wait 1s
            - cast confusion duration:20s amplifier:0
            - cast slow duration:20s amplifier:0
            - cast hunger duration:20s amplifier:0
            - stop
        - if <player.flag[drunkenness]> > 12:
            - narrate "<red>You're getting quite tipsy..."
            - wait 1s
            - cast confusion duration:10s amplifier:0
            - cast slow duration:10s amplifier:0
            - cast hunger duration:10s amplifier:0
            - stop