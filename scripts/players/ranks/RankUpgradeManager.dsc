# Replace generic requirements with rank-up quests; hunt down and kill mini-boss to receive a blessing from the gods

RankupCommand:
    type: command
    name: rankup
    description: Check the requirements to earn the next rank.
    usage: /rankup
    script:
    - if <player.in_group[Knight]>:
        - narrate "<&a>Congratulations, you're already at the highest rank currently achievable!"
        - stop
    - else if <player.in_group[Apprentice]>:
        - narrate "<&a>You're currently an <&b>Apprentice<&a>! Here are the requirements to level up to <&b>Knight<&a>:"
        - narrate "<&f>• A sacrifice to the Gods of 500 levels of experience: <tern[<player.xp_level.is[or_more].to[500]>].pass[<green>Ready].fail[<red>Not Ready]>"
        - narrate "<&f>• A sacrifice to the Gods of 100,000 gold: <tern[<player.money.is[or_more].to[100000]>].pass[<green>Ready].fail[<red>Not Ready]>"
        - narrate "<red>Note: This rank-up is currently disabled as new requirements are being implemented!"
        #- narrate "<&f>• Combined skill level of 5000: <tern[<player.mcmmo.level.is[or_more].to[5000]>].pass[<green>Ready].fail[<red>Not Ready]>"

    - else if <player.in_group[Squire]>:
        - narrate "<&a>You're currently a <&b>Squire<&a>! Here are the requirements to level up to <&b>Apprentice<&a>:"
        - narrate "<&f>• A sacrifice to the Gods of 250 levels of experience: <tern[<player.xp_level.is[or_more].to[250]>].pass[<green>Ready].fail[<red>Not Ready]>"
        - narrate "<&f>• A sacrifice to the Gods of 50,000 gold: <tern[<player.money.is[or_more].to[50000]>].pass[<green>Ready].fail[<red>Not Ready]>"
        - narrate "<red>Note: This rank-up is currently disabled as new requirements are being implemented!"
        #- narrate "<&f>• Combined skill level of 1500: <tern[<player.mcmmo.level.is[or_more].to[1500]>].pass[<green>Ready].fail[<red>Not Ready]>"

    - else if <player.in_group[Page]>:
        - narrate "<&a>You're currently a <&b>Page<&a>! Here are the requirements to level up to <&b>Squire<&a>:"
        - narrate "<&f>• A sacrifice to the Gods of 100 levels of experience: <tern[<player.xp_level.is[or_more].to[100]>].pass[<green>Ready].fail[<red>Not Ready]>"
        - narrate "<&f>• A sacrifice to the Gods of 1,000 gold: <tern[<player.money.is[or_more].to[1000]>].pass[<green>Ready].fail[<red>Not Ready]>"
        #- narrate "<&f>• Combined skill level of 500: <tern[<player.mcmmo.level.is[or_more].to[500]>].pass[<green>Ready].fail[<red>Not Ready]>"

    - else if <player.in_group[Youngling]>:
        - narrate "<&a>You're currently a <&b>Youngling<&a>! Here are the requirements to level up to <&b>Page<&a>:"
        - narrate "<&f>• A sacrifice to the Gods of 30 levels of experience: <tern[<player.xp_level.is[or_more].to[30]>].pass[<green>Ready].fail[<red>Not Ready]>"
        - narrate "<&f>• A sacrifice to the Gods of 500 gold: <tern[<player.money.is[or_more].to[500]>].pass[<green>Ready].fail[<red>Not Ready]>"
        #- narrate "<&f>• Combined skill level of 200: <tern[<player.mcmmo.level.is[or_more].to[200]>].pass[<green>Ready].fail[<red>Not Ready]>"
    - else:
        - narrate "<&a>Congratulations, you're already at the highest rank currently achievable!"

Login_Upgrade:
    type: world
    debug: false
    events:
        on player joins:
        - wait 5s
        - inject Rank_Upgrade_Check

Rank_Upgrade_Check:
    type: task
    debug: false
    script:
    - if <player.in_group[Apprentice]>:
        - stop
        - if <player.money> >= 100000 && <player.xp_level> >= 500:
            - take money quantity:100000
            - experience take level 500
            - group remove Apprentice
            - group add Knight
            - narrate "<&a>You have given a sacrifice to the Gods of 500 levels and 100,000 gold."
            - narrate "<&a>They honor your sacrifice and recognize your glory and triumph."
            - narrate "<&a>Your personal growth is recognized. You are now a <&b>Knight<&a>!"
            - announce "<&a><player.name> has been recognized by the Gods and is now a <&b>Knight<&a>!"
            - discord id:sxr message channel:191040977652285450 "**THE GODS SPEAK: Rejoice! <player.name> has been recognized by the Gods and has earned the rank of Knight!**"
    - else if <player.in_group[Squire]>:
        - stop
        - if <player.money> >= 50000 && <player.xp_level> >= 250:
            - take money quantity:50000
            - experience take level 250
            - group remove Squire
            - group add Apprentice
            - narrate "<&a>You have given a sacrifice to the Gods of 250 levels and 50,000 gold."
            - narrate "<&a>They honor your sacrifice and recognize your glory and triumph."
            - narrate "<&a>Your personal growth is recognized. You are now an <&b>Apprentice<&a>!"
            - announce "<&a><player.name> has been recognized by the Gods and is now an <&b>Apprentice<&a>!"
            - discord id:sxr message channel:191040977652285450 "**THE GODS SPEAK: Rejoice! <player.name> has been recognized by the Gods and has earned the rank of Apprentice!**"
    - else if <player.in_group[Page]>:
        - if <player.money> >= 1000 && <player.xp_level> >= 100:
            - take money quantity:1000
            - experience take level 100
            - group remove Page
            - group add Squire
            - narrate "<&a>You have given a sacrifice to the Gods of 100 levels and 1000 gold."
            - narrate "<&a>They honor your sacrifice and recognize your glory and triumph."
            - narrate "<&a>Your personal growth is recognized. You are now a <&b>Squire<&a>!"
            - announce "<&a><player.name> has been recognized by the Gods and is now a <&b>Squire<&a>!"
            - discord id:sxr message channel:191040977652285450 "**THE GODS SPEAK: Rejoice! <player.name> has been recognized by the Gods and has earned the rank of Squire!**"
    - else if <player.in_group[Youngling]>:
        - if <player.money> >= 500 && <player.xp_level> >= 30:
            - take money quantity:500
            - experience take level 30
            - group remove Youngling
            - group add Page
            - narrate "<&a>You have given a sacrifice to the Gods of 30 levels and 500 gold."
            - narrate "<&a>They honor your sacrifice and recognize your glory and triumph."
            - narrate "<&a>Your personal growth is recognized. You are now a <&b>Page<&a>!"
            - announce "<&a><player.name> has been recognized by the Gods and is now a <&b>Page<&a>!"
            - discord id:sxr message channel:191040977652285450 "**THE GODS SPEAK: Rejoice! <player.name> has been recognized by the Gods and has earned the rank of Page!**"