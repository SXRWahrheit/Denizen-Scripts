Player_Login_Checker:
    type: world
    debug: false
    events:
        on player joins:
        - announce to_console "Checking if player <player.name> has daily login flag, flag is <server.flag[daily-login.<player.uuid>]>"
        - if !<server.has_flag[daily-login.<player.uuid>]>:
            - announce to_console "Player <player.name> daily login flag did not exist, running "
            - announce to_console "Increasing login count for <player.name>, current count <server.flag[daily-login-count.<player.uuid>]>"
            - flag server daily-login-count.<player.uuid>:++
            - announce to_console "New login count for <player.name> is <server.flag[daily-login-count.<player.uuid>]>"
            - flag <player> daily-spin-available:1
            - flag server daily-login.<player.uuid>:1
            - announce to_console "Flagged daily spin available and login used, checking if login above 28 - current count for <player.name> is <server.flag[daily-login-count.<player.uuid>]>"
            - if <server.flag[daily-login-count.<player.uuid>]> > 28:
                - announce to_console "Daily login count for <player.name> above 28, setting to 1"
                - flag server daily-login-count.<player.uuid>:1
        - if <player.has_flag[daily-spin-available]>:
            - wait 4s
            - narrate "<&a>Your daily login reward is available, <&click[/dailylogin]><&b>click here or type /dailylogin<&end_click><&a> to get it!" targets:<player>
        on system time 19:00:
        - announce to_console "Daily rewards should be resetting"
        - flag server daily-login:!
        - announce "<&a>Daily server rewards have reset and will become available when you next log in!"
        - discord id:sxr message channel:343105813293826059 "<&lt>@&223441207341219840<&gt>, daily login rewards have been reset!"

DailyLogin:
    type: command
    name: dailylogin
    description: Receive your daily login reward, if available.
    usage: /dailylogin
    debug: false
    script:
    - if <player.has_flag[daily-spin-available]>:
        - flag <player> daily-spin-available:!
        - run daily-login-spinner
        - narrate "<&a>You are on day <&b><server.flag[daily-login-count.<player.uuid>]><&a> of <&b>28<&a> for daily login rewards!"
    - else:
        - narrate "<&c>Sorry, your daily login reward is unavailable!"
        - narrate "<&c>You are on day <&b><server.flag[daily-login-count.<player.uuid>]><&c> of <&b>28<&c> for daily login rewards!"
    - if <server.flag[daily-login-count.<player.uuid>]> >= 28:
        - flag server daily-login-count.<player.uuid>:0

DownArrow:
    type: item
    debug: false
    material: arrow
    display name: <&2>Prize Slot
    mechanisms:
        custom_model_data: 100003

UpArrow:
    type: item
    debug: false
    material: arrow
    display name: <&2>Prize Slot
    mechanisms:
        custom_model_data: 100004

VeteranBox:
    type: item
    debug: false
    material: blue_shulker_box
    display name: <&9>Veteran Bonus Box
    lore:
    - <&6>A bonus box containing powerful gear!
    enchantments:
    - MENDING:1
    mechanisms:
        hides:
        - enchants
        nbt:
        - bonusbox/veteran

EliteBox:
    type: item
    debug: false
    material: pink_shulker_box
    display name: <&d>Elite Bonus Box
    lore:
    - <&6>A bonus box containing powerful gear!
    enchantments:
    - MENDING:1
    mechanisms:
        hides:
        - enchants
        nbt:
        - bonusbox/elite

daily_spinner_inventory:
    type: inventory
    inventory: chest
    debug: false
    title: <&6><&l>Daily Login Reward
#   Once the calling-menu-indirectly issue is fixed, we can use the below title for the custom menu (or one of them)
#   title: <white><&font[sxrmenus]><&chr[F808]><&chr[E002]><&chr[F801].repeat[177]><&chr[E021]><&chr[F801].repeat[177]><&chr[E020]>
#   temporary title until hiding player inventory works:
#   title: <white><&font[sxrmenus]><&chr[F808]><&chr[E002]><&chr[F801].repeat[177]><&chr[E021]><&chr[F801].repeat[177]><&chr[E020]><&chr[F801].repeat[177]><&chr[E01E]>
    size: 27
#   size: 45 #use this one instead of the above when we implement the custom menu
    slots:
#   - [air] [air] [air] [air] [air] [air] [air] [air] [air] # uncomment when we implement the custom menu
#   - [air] [air] [air] [air] [air] [air] [air] [air] [air] # uncomment when we implement the custom menu
    - [air] [air] [air] [air] [DownArrow] [air] [air] [air] [air]
    - [] [] [] [] [] [] [] [] []
    - [air] [air] [air] [air] [UpArrow] [air] [air] [air] [air]

veteran_spinner_inventory:
    type: inventory
    inventory: chest
    debug: false
    title: <&6><&l>Veteran BONUS ROUND
#   Once the calling-menu-indirectly issue is fixed, we can use the below title for the custom menu (or one of them)
#   title: <white><&font[sxrmenus]><&chr[F808]><&chr[E002]><&chr[F801].repeat[177]><&chr[E021]><&chr[F801].repeat[177]><&chr[E020]>
#   temporary title until hiding player inventory works:
#   title: <white><&font[sxrmenus]><&chr[F808]><&chr[E002]><&chr[F801].repeat[177]><&chr[E021]><&chr[F801].repeat[177]><&chr[E020]><&chr[F801].repeat[177]><&chr[E01E]>
    size: 27
#   size: 45 #use this one instead of the above when we implement the custom menu
    slots:
#   - [air] [air] [air] [air] [air] [air] [air] [air] [air] # uncomment when we implement the custom menu
#   - [air] [air] [air] [air] [air] [air] [air] [air] [air] # uncomment when we implement the custom menu
    - [air] [air] [air] [air] [DownArrow] [air] [air] [air] [air]
    - [] [] [] [] [] [] [] [] []
    - [air] [air] [air] [air] [UpArrow] [air] [air] [air] [air]

elite_spinner_inventory:
    type: inventory
    inventory: chest
    debug: false
    title: <&6><&l>Elite BONUS ROUND
#   Once the calling-menu-indirectly issue is fixed, we can use the below title for the custom menu (or one of them)
#   title: <white><&font[sxrmenus]><&chr[F808]><&chr[E002]><&chr[F801].repeat[177]><&chr[E021]><&chr[F801].repeat[177]><&chr[E020]>
#   temporary title until hiding player inventory works:
#   title: <white><&font[sxrmenus]><&chr[F808]><&chr[E002]><&chr[F801].repeat[177]><&chr[E021]><&chr[F801].repeat[177]><&chr[E020]><&chr[F801].repeat[177]><&chr[E01E]>
    size: 27
#   size: 45 #use this one instead of the above when we implement the custom menu
    slots:
#   - [air] [air] [air] [air] [air] [air] [air] [air] [air] # uncomment when we implement the custom menu
#   - [air] [air] [air] [air] [air] [air] [air] [air] [air] # uncomment when we implement the custom menu
    - [air] [air] [air] [air] [DownArrow] [air] [air] [air] [air]
    - [] [] [] [] [] [] [] [] []
    - [air] [air] [air] [air] [UpArrow] [air] [air] [air] [air]



daily-login-spinner:
    type: task
    debug: false
    speed: 0
    script:
    # Create some cleared lists to work with
    - define daily-display-list <list[]>
    - define daily-roll-list <list[]>
    - define pick <list[]>
    - flag <player> cannot_close_inv:1

    # Create your list of weighted items

    # Days 1-6
    - if <server.flag[daily-login-count.<player.uuid>]> >= 1 && <server.flag[daily-login-count.<player.uuid>]> <= 6:
        # A list of items, with their respective weights.
        - define itemlist <list[<item[VeteranBox]>/4|<item[VeteranToken].with[quantity=32]>/160|<item[VeteranToken].with[quantity=64]>/40|<item[diamond].with[quantity=16]>/20|<item[diamond].with[quantity=8]>/40|<item[emerald_block].with[quantity=8]>/20|<item[emerald].with[quantity=16]>/40]>

        # Assemble a usable list to take from.
        - foreach <[itemlist]>:
            - define daily-display-list <[daily-display-list].pad_left[<[daily-display-list].size.add[<[value].after_last[/]>]>].with[<[value].before_last[/]>]>
    - else if <server.flag[daily-login-count.<player.uuid>]> == 7:
        # A list of items, with their respective weights.
        - define itemlist <list[<item[VeteranBox]>/12|<item[VeteranToken].with[quantity=32]>/80|<item[VeteranToken].with[quantity=64]>/80|<item[diamond].with[quantity=16]>/40|<item[diamond].with[quantity=8]>/20|<item[emerald_block].with[quantity=8]>/40|<item[emerald].with[quantity=16]>/20]>

        # Assemble a usable list to take from.
        - foreach <[itemlist]>:
            - define daily-display-list <[daily-display-list].pad_left[<[daily-display-list].size.add[<[value].after_last[/]>]>].with[<[value].before_last[/]>]>
    - else if <server.flag[daily-login-count.<player.uuid>]> >= 8 && <server.flag[daily-login-count.<player.uuid>]> <= 13:
        # A list of items, with their respective weights.
        - define itemlist <list[<item[VeteranBox]>/8|<item[VeteranToken].with[quantity=32]>/150|<item[VeteranToken].with[quantity=64]>/50|<item[diamond].with[quantity=32]>/20|<item[diamond].with[quantity=16]>/40|<item[emerald_block].with[quantity=16]>/20|<item[emerald].with[quantity=32]>/40]>

        # Assemble a usable list to take from.
        - foreach <[itemlist]>:
            - define daily-display-list <[daily-display-list].pad_left[<[daily-display-list].size.add[<[value].after_last[/]>]>].with[<[value].before_last[/]>]>
    - else if <server.flag[daily-login-count.<player.uuid>]> == 14:
        # A list of items, with their respective weights.
        - define itemlist <list[<item[VeteranBox]>/16|<item[VeteranToken].with[quantity=32]>/50|<item[VeteranToken].with[quantity=64]>/150|<item[diamond].with[quantity=32]>/40|<item[diamond].with[quantity=16]>/20|<item[emerald_block].with[quantity=16]>/40|<item[emerald].with[quantity=32]>/20]>

        # Assemble a usable list to take from.
        - foreach <[itemlist]>:
            - define daily-display-list <[daily-display-list].pad_left[<[daily-display-list].size.add[<[value].after_last[/]>]>].with[<[value].before_last[/]>]>
    - else if <server.flag[daily-login-count.<player.uuid>]> >= 15 && <server.flag[daily-login-count.<player.uuid>]> <= 20:
        # A list of items, with their respective weights.
        - define itemlist <list[<item[VeteranBox]>/12|<item[VeteranToken].with[quantity=32]>/140|<item[VeteranToken].with[quantity=64]>/60|<item[diamond].with[quantity=48]>/60|<item[diamond].with[quantity=24]>/40|<item[emerald_block].with[quantity=24]>/20|<item[emerald].with[quantity=48]>/40]>

        # Assemble a usable list to take from.
        - foreach <[itemlist]>:
            - define daily-display-list <[daily-display-list].pad_left[<[daily-display-list].size.add[<[value].after_last[/]>]>].with[<[value].before_last[/]>]>
    - else if <server.flag[daily-login-count.<player.uuid>]> == 21:
        # A list of items, with their respective weights.
        - define itemlist <list[<item[VeteranBox]>/24|<item[VeteranToken].with[quantity=32]>/60|<item[VeteranToken].with[quantity=64]>/140|<item[diamond].with[quantity=48]>/40|<item[diamond].with[quantity=24]>/20|<item[emerald_block].with[quantity=24]>/40|<item[emerald].with[quantity=48]>/20]>

        # Assemble a usable list to take from.
        - foreach <[itemlist]>:
            - define daily-display-list <[daily-display-list].pad_left[<[daily-display-list].size.add[<[value].after_last[/]>]>].with[<[value].before_last[/]>]>
    - else if <server.flag[daily-login-count.<player.uuid>]> >= 22 && <server.flag[daily-login-count.<player.uuid>]> <= 27:
        # A list of items, with their respective weights.
        - define itemlist <list[<item[VeteranBox]>/16|<item[VeteranToken].with[quantity=32]>/130|<item[VeteranToken].with[quantity=64]>/70|<item[diamond].with[quantity=64]>/20|<item[diamond].with[quantity=32]>/40|<item[emerald_block].with[quantity=32]>/20|<item[emerald].with[quantity=64]>/40]>

        # Assemble a usable list to take from.
        - foreach <[itemlist]>:
            - define daily-display-list <[daily-display-list].pad_left[<[daily-display-list].size.add[<[value].after_last[/]>]>].with[<[value].before_last[/]>]>
    - else if <server.flag[daily-login-count.<player.uuid>]> == 28:
        # A list of items, with their respective weights.
        - define itemlist <list[<item[VeteranBox]>/200|<item[EliteBox]>/50]>

        # Assemble a usable list to take from.
        - foreach <[itemlist]>:
            - define daily-display-list <[daily-display-list].pad_left[<[daily-display-list].size.add[<[value].after_last[/]>]>].with[<[value].before_last[/]>]>
    # Pick 60 random items from the weighted list
    - define roll-size 60
    - define daily-roll-list <[daily-display-list].random[60]>
    - note <inventory[daily_spinner_inventory]> as:daily-spinner.<player.uuid>
    - inventory open d:daily-spinner.<player.uuid>
    # Roll
    - repeat 50:
        - inventory set d:<inventory[daily-spinner.<player.uuid>]> o:<[daily-roll-list].get[<[value]>].to[<[value].add[8]>]> slot:10
#       - inventory set d:<inventory[daily-spinner.<player.uuid>]> o:<[daily-roll-list].get[<[value]>].to[<[value].add[8]>]> slot:28 #use this one instead of the above when we implement the custom menu
        - wait <util.e.power[<[value].mul[0.125].sub[3]>].round_up>t
    - if <player.open_inventory.slot[14].scriptname> == VETERANBOX:
#   - if <player.open_inventory.slot[32].scriptname> == VETERANBOX: #use this one instead of the above when we implement the custom menu
        - flag <player> cannot_close_inv:!
        - inventory close
        - note remove as:daily-spinner.<player.uuid>
        - run Veteran-Spinner
        - stop
    - else if <player.open_inventory.slot[14].scriptname> == ELITEBOX:
#   - else if <player.open_inventory.slot[32].scriptname> == ELITEBOX: #use this one instead of the above when we implement the custom menu
        - flag <player> cannot_close_inv:!
        - inventory close
        - note remove as:daily-spinner.<player.uuid>
        - run Elite-Spinner
        - stop
    - else:
        - wait 1s
        - narrate "<&a>You got <&f><[daily-roll-list].get[54].as_item.display||<[daily-roll-list].get[54].as_item.formatted.to_titlecase>><&a>!"
        - announce to_console "<player.name> got <[daily-roll-list].get[54].as_item.display||<[daily-roll-list].get[54].as_item.formatted.to_titlecase>>"
        - give <[daily-roll-list].get[54]>
        - note remove as:daily-spinner.<player.uuid>
        - flag <player> cannot_close_inv:!
        - inventory close

Veteran-Spinner:
    type: task
    debug: false
    speed: 0
    script:
    # Create some cleared lists to work with
    - define veteran-display-list <list[]>
    - define veteran-roll-list <list[]>
    - define pick <list[]>
    - flag <player> cannot_close_inv:1
    - define itemlist <list[<item[EliteBox]>/20|<mythic_item[ImbuedSword]>/20|<mythic_item[ImbuedBow]>/20|<mythic_item[ImbuedShield]>/20|<mythic_item[ImbuedHelm]>/20|<mythic_item[ImbuedChest]>/20|<mythic_item[ImbuedLegs]>/20|<mythic_item[ImbuedBoots]>/20|<mythic_item[ImbuedAxe]>/20|<mythic_item[ImbuedPickaxe]>/20|<mythic_item[ImbuedShovel]>/20|<mythic_item[ImbuedHoe]>/20|<mythic_item[ImbuedFishingRod]>/20]>
    - foreach <[itemlist]>:
        - define veteran-display-list <[veteran-display-list].pad_left[<[veteran-display-list].size.add[<[value].after_last[/]>]>].with[<[value].before_last[/]>]>
    # Pick 60 random items from the weighted list
    - define roll-size 60
    - define veteran-roll-list <[veteran-display-list].random[60]>
    - note <inventory[veteran_spinner_inventory]> as:veteran-spinner.<player.uuid>
    - inventory open d:veteran-spinner.<player.uuid>
    # Roll
    - repeat 50:
        - inventory set d:veteran-spinner.<player.uuid> o:<[veteran-roll-list].get[<[value]>].to[<[value].add[8]>]> slot:10
#       - inventory set d:veteran-spinner.<player.uuid> o:<[veteran-roll-list].get[<[value]>].to[<[value].add[8]>]> slot:28 #use this one instead of the above when we implement the custom menu
        - wait <util.e.power[<[value].mul[0.125].sub[3]>].round_up>t
    - if <player.open_inventory.slot[14].scriptname> == ELITEBOX:
#   - if <player.open_inventory.slot[32].scriptname> == ELITEBOX: #use this one instead of the above when we implement the custom menu
        - flag <player> cannot_close_inv:!
        - note remove as:veteran-spinner.<player.uuid>
        - run Elite-Spinner
    - else:
        - wait 1s
        - narrate "<&a>You got <&f><[veteran-roll-list].get[54].as_item.display||<[veteran-roll-list].get[54].as_item.formatted.to_titlecase>><&a>!"
        - announce to_console "<player.name> got <[veteran-roll-list].get[54].as_item.display||<[veteran-roll-list].get[54].as_item.formatted.to_titlecase>>"
        - give <[veteran-roll-list].get[54]>
        - flag <player> cannot_close_inv:!
        - note remove as:veteran-spinner.<player.uuid>
        - inventory close

Elite-Spinner:
    type: task
    debug: false
    speed: 0
    script:
    # Create some cleared lists to work with
    - define elite-display-list <list[]>
    - define elite-roll-list <list[]>
    - define pick <list[]>
    - define itemlist <list[<mythic_item[BurnishedSword]>/20|<mythic_item[BurnishedBow]>/20|<mythic_item[BurnishedShield]>/20|<mythic_item[BountifulBlade]>/20|<mythic_item[WitheringBlade]>/20|<mythic_item[BurnishedHelm]>/20|<mythic_item[BurnishedChest]>/20|<mythic_item[BurnishedLegs]>/20|<mythic_item[BurnishedBoots]>/20|<mythic_item[BurnishedAxe]>/20|<mythic_item[BurnishedPickaxe]>/20|<mythic_item[BurnishedShovel]>/20|<mythic_item[BurnishedHoe]>/20|<mythic_item[BurnishedFishingRod]>/20]>
    - foreach <[itemlist]>:
        - define elite-display-list <[elite-display-list].pad_left[<[elite-display-list].size.add[<[value].after_last[/]>]>].with[<[value].before_last[/]>]>
    # Pick 60 random items from the weighted list
    - define roll-size 60
    - define elite-roll-list <[elite-display-list].random[60]>
    - note <inventory[elite_spinner_inventory]> as:elite-spinner.<player.uuid>
    - inventory open d:elite-spinner.<player.uuid>
    - flag <player> cannot_close_inv:1
    # Roll
    - repeat 50:
        - inventory set d:elite-spinner.<player.uuid> o:<[elite-roll-list].get[<[value]>].to[<[value].add[8]>]> slot:10
#       - inventory set d:elite-spinner.<player.uuid> o:<[elite-roll-list].get[<[value]>].to[<[value].add[8]>]> slot:28  #use this one instead of the above when we implement the custom menu
        - wait <util.e.power[<[value].mul[0.125].sub[3]>].round_up>t

    - wait 1s
    - narrate "<&a>You got <&f><[elite-roll-list].get[54].as_item.display||<[elite-roll-list].get[54].as_item.formatted.to_titlecase>><&a>!"
    - announce to_console "<player.name> got <[elite-roll-list].get[54].as_item.display||<[elite-roll-list].get[54].as_item.formatted.to_titlecase>>"
    - give <[elite-roll-list].get[54]>
    - flag <player> cannot_close_inv:!
    - note remove as:elite-spinner.<player.uuid>
    - inventory close

Spinner_Anti-Cheat:
    type: world
    debug: false
    events:
        on player clicks in inventory:
        - if <context.inventory.note_name||null> == daily-spinner.<player.uuid>:
            - determine cancelled
        - else if <context.inventory.note_name||null> == veteran-spinner.<player.uuid>:
            - determine cancelled
        - else if <context.inventory.note_name||null> == elite-spinner.<player.uuid>:
            - determine cancelled
        on player drags in inventory:
        - if <context.inventory.note_name||null> == daily-spinner.<player.uuid>:
            - determine cancelled
        - else if <context.inventory.note_name||null> == veteran-spinner.<player.uuid>:
            - determine cancelled
        - else if <context.inventory.note_name||null> == elite-spinner.<player.uuid>:
            - determine cancelled
        on player closes inventory:
        - if <context.inventory.note_name||null> == daily-spinner.<player.uuid>:
            - if <player.has_flag[cannot_close_inv]>:
                - wait 1t
                - inventory open d:daily-spinner.<player.uuid>
                - stop
            - flag <player> cannot_close_inv:!
        - else if <context.inventory.note_name||null> == veteran-spinner.<player.uuid>:
            - if <player.has_flag[cannot_close_inv]>:
                - wait 1t
                - inventory open d:veteran-spinner.<player.uuid>
                - stop
            - flag <player> cannot_close_inv:!
        - else if <context.inventory.note_name||null> == elite-spinner.<player.uuid>:
            - if <player.has_flag[cannot_close_inv]>:
                - wait 1t
                - inventory open d:elite-spinner.<player.uuid>
                - stop
            - flag <player> cannot_close_inv:!