PatronChoice:
    debug: false
    type: command
    name: patronchoice
    description: Choose Duke or Duchess.
    usage: /patronchoice Duke or /patronchoice Duchess
    permission: group.patron
    permission message: "Sorry, you're not a patron! Back us on Patreon: https://patreon.com/summacrossroads"
    script:
    - if <context.args.get[1]||null> == Duke:
        - group add Duke
        - group remove Duchess
        - group remove GenerousDuchess
        - group remove EsteemedDuchess
        - if <player.in_group[esteemedpatron]>:
            - group add EsteemedDuke
            - group add GenerousDuke
        - else if <player.in_group[generouspatron]>:
            - group add GenerousDuke
        - narrate "<&a>Congratulations, you are now a Duke!"
    - if <context.args.get[1]||null> == Duchess:
        - group add Duchess
        - group remove Duke
        - group remove GenerousDuke
        - group remove EsteemedDuke
        - if <player.in_group[esteemedpatron]>:
            - group add EsteemedDuchess
            - group add GenerousDuchess
        - else if <player.in_group[generouspatron]>:
            - group add GenerousDuchess
        - narrate "<&a>Congratulations, you are now a Duchess!"
    - if <context.args.get[1]||null> == Patron:
        - group remove Duke
        - group remove GenerousDuke
        - group remove EsteemedDuke
        - group remove Duchess
        - group remove GenerousDuchess
        - group remove EsteemedDuchess
        - narrate "<&a>Congratulations, you are now a Patron!"
    - else:
        - narrate "<&a>You did not specify Duke, Duchess, or Patron - please choose one!"
DukeChoice:
    debug: false
    type: command
    name: duke
    description: Choose the Duke title.
    usage: /duke
    permission: group.patron
    permission message: "Sorry, you're not a patron! Back us on Patreon: https://patreon.com/summacrossroads"
    script:
    - group add Duke
    - group remove Duchess
    - group remove GenerousDuchess
    - group remove EsteemedDuchess
    - if <player.in_group[esteemedpatron]>:
        - group add EsteemedDuke
        - group add GenerousDuke
    - else if <player.in_group[generouspatron]>:
        - group add GenerousDuke
    - narrate "<&a>Congratulations, you are now a Duke!"
DuchessChoice:
    debug: false
    type: command
    name: duchess
    description: Choose the Duchess title.
    usage: /duchess
    permission: group.patron
    permission message: "Sorry, you're not a patron! Back us on Patreon: https://patreon.com/summacrossroads"
    script:
    - group add Duchess
    - group remove Duke
    - group remove GenerousDuke
    - group remove EsteemedDuke
    - if <player.in_group[esteemedpatron]>:
        - group add EsteemedDuchess
        - group add GenerousDuchess
    - else if <player.in_group[generouspatron]>:
        - group add GenerousDuchess
    - narrate "<&a>Congratulations, you are now a Duchess!"