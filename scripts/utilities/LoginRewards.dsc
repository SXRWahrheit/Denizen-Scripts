Player_Login_Checker:
    type: world
    debug: false
    events:
        on player joins:
        - announce to_console "Checking if player <player.name> has daily login flag, flag is <server.flag[daily-login.<player.uuid>].if_null[non-existent]>"
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

LoginReset:
    type: command
    name: loginreset
    description: Reset your daily login reward.
    usage: /loginreset
    debug: false
    permissions: denizen.admin
    script:
        - flag <player> daily-spin-available:1
        - flag server daily-login.<player.uuid>:1

DailyLogin:
    type: command
    name: dailylogin
    description: Receive your daily login reward, if available.
    usage: /dailylogin
    debug: false
    script:
    - if <player.has_flag[daily-spin-available]>:
        - flag <player> daily-spin-available:!
        - run daily_login_spinner
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
    flags:
        bonusbox: veteran
    mechanisms:
        hides:
        - enchants

EliteBox:
    type: item
    debug: false
    material: pink_shulker_box
    display name: <&d>Elite Bonus Box
    lore:
    - <&6>A bonus box containing powerful gear!
    enchantments:
    - MENDING:1
    flags:
        bonusbox: elite
    mechanisms:
        hides:
        - enchants

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



daily_login_spinner:
    type: task
    debug: false
    speed: 0
    data:
        itemlist_week1:
            VeteranBox:
                item: VeteranBox
                quantity: 1
                weight: 4
            VeteranToken:
                item: VeteranToken
                quantity: 32
                weight: 160
            diamond_many:
                item: diamond
                quantity: 16
                weight: 20
            diamond_few:
                item: diamond
                quantity: 8
                weight: 40
            emerald_block:
                item: emerald_block
                quantity: 8
                weight: 20
            emerald:
                item: emerald
                quantity: 16
                weight: 40
        itemlist_day7:
            VeteranBox:
                item: VeteranBox
                quantity: 1
                weight: 12
            VeteranToken:
                item: VeteranToken
                quantity: 32
                weight: 80
            diamond_many:
                item: diamond
                quantity: 16
                weight: 40
            diamond_few:
                item: diamond
                quantity: 8
                weight: 20
            emerald_block:
                item: emerald_block
                quantity: 8
                weight: 40
            emerald:
                item: emerald
                quantity: 16
                weight: 20
        itemlist_week2:
            VeteranBox:
                item: VeteranBox
                quantity: 1
                weight: 8
            VeteranToken_few:
                item: VeteranToken
                quantity: 32
                weight: 150
            VeteranToken_many:
                item: VeteranToken
                quantity: 64
                weight: 50
            diamond_many:
                item: diamond
                quantity: 32
                weight: 20
            diamond_few:
                item: diamond
                quantity: 16
                weight: 40
            emerald_block:
                item: emerald_block
                quantity: 16
                weight: 20
            emerald:
                item: emerald
                quantity: 32
                weight: 40
        itemlist_day14:
            VeteranBox:
                item: VeteranBox
                quantity: 1
                weight: 16
            VeteranToken_few:
                item: VeteranToken
                quantity: 32
                weight: 50
            VeteranToken_many:
                item: VeteranToken
                quantity: 64
                weight: 150
            diamond_many:
                item: diamond
                quantity: 32
                weight: 40
            diamond_few:
                item: diamond
                quantity: 16
                weight: 20
            emerald_block:
                item: emerald_block
                quantity: 16
                weight: 40
            emerald:
                item: emerald
                quantity: 32
                weight: 20
        itemlist_week3:
            VeteranBox:
                item: VeteranBox
                quantity: 1
                weight: 12
            VeteranToken_few:
                item: VeteranToken
                quantity: 32
                weight: 140
            VeteranToken_many:
                item: VeteranToken
                quantity: 64
                weight: 60
            diamond_many:
                item: diamond
                quantity: 48
                weight: 60
            diamond_few:
                item: diamond
                quantity: 24
                weight: 40
            emerald_block:
                item: emerald_block
                quantity: 24
                weight: 20
            emerald:
                item: emerald
                quantity: 48
                weight: 40
        itemlist_day21:
            VeteranBox:
                item: VeteranBox
                quantity: 1
                weight: 24
            VeteranToken_few:
                item: VeteranToken
                quantity: 32
                weight: 60
            VeteranToken_many:
                item: VeteranToken
                quantity: 64
                weight: 140
            diamond_many:
                item: diamond
                quantity: 48
                weight: 40
            diamond_few:
                item: diamond
                quantity: 24
                weight: 20
            emerald_block:
                item: emerald_block
                quantity: 24
                weight: 40
            emerald:
                item: emerald
                quantity: 48
                weight: 20
        itemlist_week4:
            VeteranBox:
                item: VeteranBox
                quantity: 1
                weight: 16
            VeteranToken_few:
                item: VeteranToken
                quantity: 32
                weight: 130
            VeteranToken_many:
                item: VeteranToken
                quantity: 64
                weight: 70
            diamond_many:
                item: diamond
                quantity: 64
                weight: 20
            diamond_few:
                item: diamond
                quantity: 32
                weight: 40
            emerald_block:
                item: emerald_block
                quantity: 32
                weight: 20
            emerald:
                item: emerald
                quantity: 64
                weight: 40
        itemlist_day28:
            VeteranBox:
                item: VeteranBox
                quantity: 1
                weight: 200
            EliteBox:
                item: EliteBox
                quantity: 1
                weight: 50
        veteran_list:
            EliteBox:
                item: EliteBox
                quantity: 1
                weight: 20
            ImbuedSword:
                item: <mythic_item[ImbuedSword]>
                quantity: 1
                weight: 20
            ImbuedBow:
                item: <mythic_item[ImbuedBow]>
                quantity: 1
                weight: 20
            ImbuedShield:
                item: <mythic_item[ImbuedShield]>
                quantity: 1
                weight: 20
            ImbuedHelm:
                item: <mythic_item[ImbuedHelm]>
                quantity: 1
                weight: 20
            ImbuedChest:
                item: <mythic_item[ImbuedChest]>
                quantity: 1
                weight: 20
            ImbuedLegs:
                item: <mythic_item[ImbuedLegs]>
                quantity: 1
                weight: 20
            ImbuedBoots:
                item: <mythic_item[ImbuedBoots]>
                quantity: 1
                weight: 20
            ImbuedAxe:
                item: <mythic_item[ImbuedAxe]>
                quantity: 1
                weight: 20
            ImbuedPickaxe:
                item: <mythic_item[ImbuedPickaxe]>
                quantity: 1
                weight: 20
            ImbuedShovel:
                item: <mythic_item[ImbuedShovel]>
                quantity: 1
                weight: 20
            ImbuedHoe:
                item: <mythic_item[ImbuedHoe]>
                quantity: 1
                weight: 20
            ImbuedFishingRod:
                item: <mythic_item[ImbuedFishingRod]>
                quantity: 1
                weight: 20
        elite_list:
            BurnishedSword:
                item: <mythic_item[BurnishedSword]>
                quantity: 1
                weight: 20
            BurnishedBow:
                item: <mythic_item[BurnishedBow]>
                quantity: 1
                weight: 20
            BurnishedShield:
                item: <mythic_item[BurnishedShield]>
                quantity: 1
                weight: 20
            BurnishedHelm:
                item: <mythic_item[BurnishedHelm]>
                quantity: 1
                weight: 20
            BurnishedChest:
                item: <mythic_item[BurnishedChest]>
                quantity: 1
                weight: 20
            BurnishedLegs:
                item: <mythic_item[BurnishedLegs]>
                quantity: 1
                weight: 20
            BurnishedBoots:
                item: <mythic_item[BurnishedBoots]>
                quantity: 1
                weight: 20
            BurnishedAxe:
                item: <mythic_item[BurnishedAxe]>
                quantity: 1
                weight: 20
            BurnishedPickaxe:
                item: <mythic_item[BurnishedPickaxe]>
                quantity: 1
                weight: 20
            BurnishedShovel:
                item: <mythic_item[BurnishedShovel]>
                quantity: 1
                weight: 20
            BurnishedHoe:
                item: <mythic_item[BurnishedHoe]>
                quantity: 1
                weight: 20
            BurnishedFishingRod:
                item: <mythic_item[BurnishedFishingRod]>
                quantity: 1
                weight: 20

    script:
    # Create some cleared lists to work with
    - define display_list <list[]>
    - define roll_list <list[]>
    - define pick <list[]>
    - flag <player> cannot_close_inv:1

    # Define the list to pull from
    - choose <server.flag[daily-login-count.<player.uuid>]>:
        - case 0 1 2 3 4 5 6:
            - define sourcelist itemlist_week1
        - case 7:
            - define sourcelist itemlist_day7
        - case 8 9 10 11 12 13:
            - define sourcelist itemlist_week2
        - case 14:
            - define sourcelist itemlist_day14
        - case 15 16 17 18 19 20:
            - define sourcelist itemlist_week3
        - case 21:
            - define sourcelist itemlist_day21
        - case 22 23 24 25 26 27:
            - define sourcelist itemlist_week4
        - case 28:
            - define sourcelist itemlist_day28
    - inject spinner_handler

Spinner_Handler:
    type: task
    debug: false
    definitions: sourcelist
    script:

    # Create your list of weighted items
    - define itemlist <list>
    - foreach <script[daily_login_spinner].data_key[data.<[sourcelist]>]> as:entry:
        - define itemlist <[itemlist].pad_left[<[itemlist].size.add[<[entry].get[weight]>]>].with[<[entry].get[item].parsed.as[item].with[quantity=<[entry].get[quantity]>]>]>

    # Pick 60 random items from the weighted list
    - define roll_size 60
    - define roll_list <[itemlist].random[<[roll_size]>]>
    - note <inventory[daily_spinner_inventory]> as:daily_spinner.<player.uuid>
    - inventory open d:daily_spinner.<player.uuid>
    # Roll
    - repeat 50:
        - inventory set d:<inventory[daily_spinner.<player.uuid>]> o:<[roll_list].get[<[value]>].to[<[value].add[8]>]> slot:10
        - wait <util.e.power[<[value].mul[0.125].sub[3]>].round_up>t
    - if <[roll_list].get[54].script.name> == VETERANBOX:
        - flag <player> cannot_close_inv:!
        - inventory close
        - note remove as:daily_spinner.<player.uuid>
        - define sourcelist veteran_list
        - inject spinner_handler
        - stop
    - else if <[roll_list].get[54].script.name> == ELITEBOX:
        - flag <player> cannot_close_inv:!
        - inventory close
        - note remove as:daily_spinner.<player.uuid>
        - define sourcelist elite_list
        - inject spinner_handler
        - stop
    - else:
        - wait 1s
        - narrate "<&a>You got <&f><[roll_list].get[54].as[item].display||<[roll_list].get[54].as[item].formatted.to_titlecase>><&a>!"
        - announce to_console "<player.name> got <[roll_list].get[54].as[item].display||<[roll_list].get[54].as[item].formatted.to_titlecase>>"
        - give <[roll_list].get[54]>
        - note remove as:daily_spinner.<player.uuid>
        - flag <player> cannot_close_inv:!
        - inventory close

Spinner_Anti_Cheat:
    type: world
    debug: false
    events:
        on player clicks in inventory:
        - if <context.inventory.note_name.if_null[null]> == daily_spinner.<player.uuid>:
            - determine cancelled
        - else if <context.inventory.note_name.if_null[null]> == veteran_spinner.<player.uuid>:
            - determine cancelled
        - else if <context.inventory.note_name.if_null[null]> == elite_spinner.<player.uuid>:
            - determine cancelled
        on player drags in inventory:
        - if <context.inventory.note_name.if_null[null]> == daily_spinner.<player.uuid>:
            - determine cancelled
        - else if <context.inventory.note_name.if_null[null]> == veteran_spinner.<player.uuid>:
            - determine cancelled
        - else if <context.inventory.note_name.if_null[null]> == elite_spinner.<player.uuid>:
            - determine cancelled
        on player closes inventory:
        - if <context.inventory.note_name.if_null[null]> == daily_spinner.<player.uuid>:
            - if <player.has_flag[cannot_close_inv]>:
                - wait 1t
                - inventory open d:daily_spinner.<player.uuid>
                - stop
            - flag <player> cannot_close_inv:!
        - else if <context.inventory.note_name.if_null[null]> == veteran_spinner.<player.uuid>:
            - if <player.has_flag[cannot_close_inv]>:
                - wait 1t
                - inventory open d:veteran_spinner.<player.uuid>
                - stop
            - flag <player> cannot_close_inv:!
        - else if <context.inventory.note_name.if_null[null]> == elite_spinner.<player.uuid>:
            - if <player.has_flag[cannot_close_inv]>:
                - wait 1t
                - inventory open d:elite_spinner.<player.uuid>
                - stop
            - flag <player> cannot_close_inv:!