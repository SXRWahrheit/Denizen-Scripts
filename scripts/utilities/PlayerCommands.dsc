# https://one.denizenscript.com/denizen/lngs/command%20script%20containers
TowerOfTheGodsCommand:
    type: command
    name: godstower
    description: Warp to the Tower of the Gods parkour course.
    usage: /godstower
    aliases:
    - towerofthegods
    permission: denizen.godstower
    permission message: Sorry, you can't warp to the Tower of the Gods!
    script:
    - teleport <player> GodsTower
    - if <player.world.name> == infinitus:
        - inventory clear
        - narrate "<green>Welcome to the Tower of the Gods! You can get back to the main world with the <&click[/spawn]><aqua>/spawn<&end_click><green> command."
DeathTowerCommand:
    type: command
    name: deathtower
    description: Warp to the Death Tower parkour course.
    usage: /deathtower
    aliases:
    - towerofdeath
    permission: denizen.deathtower
    permission message: Sorry, you can't warp to the Death Tower!
    script:
    - teleport <player> deathtower
    - if <player.world.name> == infinitus:
        - inventory clear
    - narrate "<green>Welcome to the Death Tower! You can get back to the main world with the <&click[/spawn]><aqua>/spawn<&end_click><green> command."
BoatRace1Command:
    type: command
    name: boatrace-1
    description: Warp to the Suicune boat race.
    usage: /boatrace-1
    aliases:
    - boatrace
    permission: denizen.boatrace-1
    permission-message: Sorry, you can't warp to the boat race!
    script:
    - teleport <player> boatrace-1
    - wait 20t
    - give oak_boat
    - narrate "<green>Welcome to the Suicune boat race!"
BoatRace2Command:
    type: command
    name: boatrace-2
    description: Warp to the frozen caves boat race.
    usage: /boatrace-2
    permission: denizen.boatrace-2
    permission-message: Sorry, you can't warp to the boat race!
    script:
    - teleport <player> boatrace-2
    - wait 20t
    - give oak_boat
    - narrate "<green>Welcome to the frozen caves boat race!"
HelpCommand:
    type: command
    name: help
    description: Get some information about the server and helpful commands.
    usage: /help
    aliases:
    - ?
    - helpme
    script:
    - narrate "<gold>-=<aqua><&n>Useful Commands<gold>=-"
    - narrate " "
    - narrate "<&click[/spawn]><aqua>/spawn<&end_click><white> - Go to spawn. No mobs, and useful things nearby."
    - narrate "<&click[/spawn]><aqua>/sethome<&end_click><white> - Set your home. Use <aqua>/home<white> later to go back."
    - narrate "<&click[/spawn]><aqua>/money<&end_click><white> - View your gold balance. Use <aqua>/money help <white> to view more commands."
    - narrate "<&click[/spawn]><aqua>/ftw<&end_click><white> - View your available warps. Use <aqua>/ftw warpname<white> to go there. Find more to unlock them."
    - narrate "<&click[/spawn]><aqua>/pa list<&end_click><white> - List of PVP Arenas. Use <aqua>/pa arenaname<white> to join."
    - narrate "<&click[/spawn]><aqua>/ma list<&end_click><white> - List of Mob Arenas. Use <aqua>/ma join arenaname<white> to join."
    - narrate "<&click[/spawn]><aqua>/map<&end_click><white> - Get a link to the live map. Sign in to see yourself."
    - narrate "<&click[/spawn]><aqua>/deathtower<&end_click><white> - Go to our hard-tier parkour course."
    - narrate "<&click[/spawn]><aqua>/godstower<&end_click><white> - Go to our insane-tier parkour course."
    - narrate "<&click[/spawn]><aqua>/lwc<&end_click><white> - View information on locking your chests."
    - narrate "<&click[/spawn]><aqua>/where<&end_click><white> - View your coordinates and orientation N/S/E/W."
    - narrate "<&click[/spawn]><aqua>/quests<&end_click><white> - View commands for managing your quests. You can also see the quests you're currently on with <aqua>/quest<white>."
    - narrate " "
    - narrate "<aqua><&o>Need more help?<&r><aqua> Join the forums at <green>https://summaxr.com<aqua>!"
MapCommand:
    type: command
    name: map
    description: Get a link to our online map.
    usage: /map
    script:
    - narrate "<gold>-=<aqua><&n>Online World Map<gold>=-"
    - narrate " "
    - narrate "<white>Click the link below to check out our live map - the world is huge!"
    - narrate " "
    - narrate <green>http://mc.summaxr.com
RanksCommand:
    type: command
    name: ranks
    description: Get information about our server ranks.
    usage: /ranks
    script:
    - narrate "<gold>-=<aqua><&n>Server Ranks<gold>=-"
    - narrate " "
    - narrate "Our world has a wide range of ranks available for its adventurers to achieve. As you rank up, you get new abilities and become even more powerful and prestigious."
    - narrate " "
    - narrate "<aqua>For a list of ranks<white> and how to get them, please visit: <green>https://summaxr.com/mcranks"
PatreonCommand:
    type: command
    name: patreon
    description: Get information about Patreon.
    usage: /patreon
    script:
    - narrate <gold>-=<aqua><&n>Patreon<gold>=-
    - narrate " "
    - narrate "Please consider backing us on Patreon if you enjoy the server! As we reach goals, perks are unlocked for all players on the server!"
    - narrate " "
    - narrate "<aqua>To learn more and become a Patron,<white> please visit:<green>https://patreon.com/summacrossroads"
GoldCommand:
    type: command
    name: gold
    description: Check your gold balance. Alias for /money.
    usage: /gold
    script:
    - execute as_player "money <context.raw_args>"
BalanceCommand:
    type: command
    name: balance
    description: Check your gold balance. Alias for /money.
    usage: /balance
    script:
    - execute as_player "money <context.raw_args>"

GetNewPlayerBookCommand:
    type: command
    name: newplayerguide
    description: View the New Player Guide.
    usage: /newplayerguide
    script:
    - adjust <player> show_book:<item[NewPlayerBook]>