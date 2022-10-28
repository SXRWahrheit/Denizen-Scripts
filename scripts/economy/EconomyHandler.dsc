# The script name will be shown to the economy provider as the name of the economy system.
Economy_Script_Handler:
    type: economy
    debug: false
    # The Bukkit service priority. Priorities are Lowest, Low, Normal, High, Highest.
    priority: normal
    # The name of the currency in the singular (such as "dollar" or "euro").
    name single: gold
    # The name of the currency in the plural (such as "dollars" or "euros").
    name plural: gold
    # How many digits after the decimal to include. For example, '2' means '1.05' is a valid amount, but '1.005' will be rounded.
    digits: 0
    # Format the standard output for the money in human-readable format. Use "<amount>" for the actual amount to display.
    # Fully supports tags.
    format: <amount>g
    # A tag that returns the balance of a linked player. Use a 'proc[]' tag if you need more complex logic.
    # Must return a decimal number.
    balance: <player.flag[money]>
    # A tag that returns a boolean indicating whether the linked player has the amount specified by auto-tag "<amount>".
    # Use a 'proc[]' tag if you need more complex logic.
    # Must return 'true' or 'false'.
    has: <player.flag[money].is[or_more].than[<amount>]>
    # A script that removes the amount of money needed from a player.
    # Note that it's generally up to the systems calling this script to verify that the amount can be safely withdrawn, not this script itself.
    # However you may wish to verify that the player has the amount required within this script.
    # The script may determine a failure message if the withdraw was refused. Determine nothing for no error.
    # Use def 'amount' for the amount to withdraw.
    withdraw:
    - flag <player> money:-:<[amount]>
    # A script that adds the amount of money needed to a player.
    # The script may determine a failure message if the deposit was refused. Determine nothing for no error.
    # Use def 'amount' for the amount to deposit.
    deposit:
    - flag <player> money:+:<[amount]>

#Money_Converter:
#    type: task
#    debug: true
#    script:
#    - foreach <server.players> as:player:
#        - flag <[player]> money:<[player].money>

Money_Command:
    type: command
    name: money
    debug: true
    usage: /money
    description: Money stuff is a weekday newsletter by Matt Levine.
    tab completions:
        1: <tern[<player.is_op>].pass[balance|pay|give|take|top|set].fail[balance|pay]>
        2: <server.online_players.parse[name]>
    script:
    - if <context.args.size> == 0:
        - narrate "You have <player.money> gold"
        - stop
    - if <context.args.size> > 0 && <context.args.get[1]> != top:
        - define player <server.match_offline_player[<context.args.get[2]>]||null>
        - if <[player]> == null:
            - narrate "<red>Invalid player specified! <context.args.get[2]> is not a valid username!"
        - if <context.args.get[1]> == balance:
            - if <context.args.size> == 1:
                - narrate "You have <gold><player.money> gold"
                - stop
            - narrate "<[player].name>'s balance: <gold><[player].money>g"
            - stop
        - define amount <context.args.get[3]||0>
        - if !<[amount].is_integer> || <[amount]> <= 0:
            - narrate "<red>Invalid amount specified - not a whole number or less than 1!"
            - stop
        - if <context.args.get[1]> == pay:
            - define sender <player>
            - define recipient <[player]>
            - if <context.args.size> == 1:
                - narrate "<red>Must specify player and amount, e.g. <green>/money pay Wahrheit 5"
                - stop
            - if <player.money> >= <context.args.get[3]>:
                - take money quantity:<context.args.get[3]>
                - give money quantity:<context.args.get[3]> player:<[recipient]>
                - narrate "<green>Transferred <context.args.get[3]> gold to <[recipient].name>"
                - narrate "<green>Received <context.args.get[3]> gold from <[sender].name>" player:<[recipient]>
                - stop
            - else:
                - narrate "<red>Insufficient funds! You tried to pay <context.args.get[2]> <gold><context.args.get[3]>g<red> but you only have <gold><player.money>g<red>!"
                - stop
        - if <context.args.get[1]> == give:
            - if !<player.is_op>:
                - narrate "<red>YOU DARE TRY TO WIELD THE POWERS OF THE GODS?!"
                - stop
            - if <context.args.size> == 1:
                - narrate "<red>Must specify player and amount, e.g. <green>/money give Wahrheit 5"
                - stop
            - define sender <player>
            - give money quantity:<context.args.get[3]> player:<[player]>
            - narrate "<green>Gave <context.args.get[3]>g to <[player].name>"
            - narrate "<green>Received <context.args.get[3]> gold from <[sender].name> as a gift from the Gods" player:<[player]>
        - if <context.args.get[1]> == take:
            - if !<player.is_op>:
                - narrate "<red>YOU DARE TRY TO WIELD THE POWERS OF THE GODS?!"
                - stop
            - if <context.args.size> == 1:
                - narrate "<red>Must specify player and amount, e.g. <green>/money take Wahrheit 5"
                - stop
            - if <[amount]> > <[player].money>:
                - narrate "<red>Amount to be taken exceeds player's total balance of <gold><[player].money>g<red>!"
            - take money quantity:<context.args.get[3]> player:<[player]>
            - narrate "<green>Took <context.args.get[3]>g from <[player].name>"
        - if <context.args.get[1]> == set:
            - if !<player.is_op>:
                - narrate "<red>YOU DARE TRY TO WIELD THE POWERS OF THE GODS?!"
                - stop
            - if <context.args.size> != 3:
                - narrate "<red>Must specify player and amount, e.g. <green>/money set Wahrheit 5"
                - stop
            - flag <[player]> money:<context.args.get[3]>
            - narrate "Set <[player].name>'s money to <[amount]>"
    - if <context.args.get[1]> == top:
        - if !<player.is_op>:
            - narrate "<red>YOU DARE TRY TO WIELD THE POWERS OF THE GODS?!"
            - stop
        - if <context.args.size> == 2:
            - if !<context.args.get[2].is_integer> || <context.args.get[2]> <= 0 || <context.args.get[2]> > 91:
                - narrate "<red>List start must be a whole number between 1 and 91!"
            - narrate "<gold><bold><underline>Top money balances (starting at <context.args.get[2]>)"
            - foreach <server.flag[money_top_100].highest[money].count[100].get[<context.args.get[2]>].to[<context.args.get[2].add[9]>]>:
                - narrate "<[loop_index].add[<context.args.get[2]>].sub[1]>. <[value].name>: <gold><[value].money>g"

        - else:
            - narrate "<gold><bold><underline>Top money balances"
            - narrate " "
            - foreach <server.flag[money_top_100].highest[money].count[10]>:
                - narrate "<[loop_index]>. <[value].name>: <gold><[value].money>g"

Money_Missing_Fixer:
    type: world
    debug: false
    events:
        on player joins:
        - wait 6s
        - if !<player.has_flag[money]>:
            - flag <player> money:100
        - if !<player.money.is_integer>:
            - flag <player> money:<player.money.round_down>

Money_Top_Handler:
    type: world
    debug: false
    events:
        on delta time hourly:
        - ~flag server money_top_100:<server.players.highest[money].count[100].sort_by_number[money]>
