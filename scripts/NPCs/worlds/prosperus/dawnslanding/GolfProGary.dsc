GolfProAssignment:
    type: assignment
    debug: false
    interact scripts:
    - GolfProInteract
    actions:
        on assignment:
        - trigger name:proximity toggle:true radius:4
        - trigger name:click toggle:true

GolfProFormat:
    type: format
    debug: false
    format: <dark_green>Golf Pro Gary<white><&co> <[text]>

GolfProInteract:
    type: interact
    debug: false
    steps:
        Greeting*:
            proximity trigger:
                entry:
                    script:
                    - if <player.inventory.contains_item[item_flagged:golfball]>:
                        - narrate format:GolfProFormat "Here to return some golf balls?"
                        - narrate "<gray>Right-click the Golf Pro to return your extra golf balls and get some of your gold back!"
                        - zap ReturnBalls
                    - else:
                        - narrate format:GolfProFormat "Well hey there <player.name>, you here for some mini-golf? I've got plenty of golf balls here for you!"
                        - wait 0.5s
                        - narrate format:GolfProFormat "Just a note - they're enchanted! They'll fizzle away after a little while and plop back into these buckets. Not that you'd ever try to steal my golf balls, I'm sure."
                        - wait 0.5s
                        - narrate format:GolfProFormat "It's only 25 gold to check out a golf ball! What do you say?"
                        - narrate "<gray>Right-click the Golf Pro to see the golf balls he has available!"
                exit:
                    script:
                    - narrate format:GolfProFormat "Good to see you!"
            click trigger:
                script:
                - if <player.money> >= 25:
                    - inventory open d:GolfBallInventory_Base
                - else:
                    - narrate format:GolfProFormat "Trying to get yourself a free golf ball, are you? Come back when you've got 25 gold!"
        ReturnBalls:
            click trigger:
                script:
                - define quantity <player.inventory.quantity_item[item_flagged:golfball]>
                - take flagged:golfball
                - give money quantity:<[quantity].mul[5]>
                - narrate format:GolfProFormat "Thanks for returning those golf balls! Here's <[quantity].mul[5]> gold for your trouble."
                - zap Greeting
            proximity trigger:
                exit:
                    script:
                    - narrate format:GolfProFormat "Good to see you!"
                    - zap Greeting

GolfBallInventory_Base:
    type: inventory
    inventory: chest
    debug: false
#   title: Mini-Golf Rentals<&chr[00A0].repeat[1000]><white><&font[sxrmenus]><&chr[F801].repeat[83]><&chr[F801].repeat[4000]><&chr[F801].repeat[8]><&chr[E007]><&chr[F801].repeat[177]><&chr[E008]><&chr[F801].repeat[177]><&chr[E009]>
#   temporary title until hiding player inventory works:
    title: Mini-Golf Rentals<&chr[00A0].repeat[1000]><white><&font[sxrmenus]><&chr[F801].repeat[83]><&chr[F801].repeat[4000]><&chr[F801].repeat[8]><&chr[E007]><&chr[F801].repeat[177]><&chr[E008]><&chr[F801].repeat[177]><&chr[E01C]><&chr[F801].repeat[177]><&chr[E009]>
    size: 54
    slots:
    - [] [] [] [] [] [] [] [] []
    - [GolfBall_White] [GolfBall_Red] [GolfBall_Orange] [GollfBall_Yellow] [GolfBall_Green] [GolfBall_Sky] [GolfBall_Blue] [GolfBall_Violet] [GolfBall_Purple]
    - [GolfBall_Gray] [GolfBall_Brown] [GolfBall_Goldenrod] [GolfBall_Lime] [GolfBall_Olive] [GolfBall_Cyan] [GolfBall_Black] [GolfBall_Beige] [GolfBall_Pink]
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] [Patron_GolfBall_Inventory_Arrow]

GolfballInventory_Patron:
    type: inventory
    inventory: chest
    debug: false
#   title: Mini-Golf Rentals<&chr[00A0].repeat[1000]><white><&font[sxrmenus]><&chr[F801].repeat[83]><&chr[F801].repeat[4000]><&chr[F801].repeat[8]><&chr[E007]><&chr[F801].repeat[177]><&chr[E008]><&chr[F801].repeat[177]><&chr[E009]>
#   temporary title until hiding player inventory works:
    title: Mini-Golf Rentals<&chr[00A0].repeat[1000]><white><&font[sxrmenus]><&chr[F801].repeat[83]><&chr[F801].repeat[4000]><&chr[F801].repeat[8]><&chr[E007]><&chr[F801].repeat[177]><&chr[E008]><&chr[F801].repeat[177]><&chr[E01C]><&chr[F801].repeat[177]><&chr[E009]>
    size: 54
    slots:
    - [] [] [] [] [] [] [] [] []
    - [GolfBall_Baseball] [GolfBall_Basketball] [GolfBall_Soccerball] [GolfBall_Football] [GolfBall_TennisBall] [GolfBall_BilliardBall_8] [GolfBall_BilliardBall_9] [GolfBall_BeachBall] [GolfBall_BowlingBall_Black]
    - [GolfBall_Burger] [GolfBall_Taco] [GolfBall_HotDog] [GolfBall_Pizza] [GolfBall_BentoBox] [GolfBall_Cake] [GolfBall_PumpkinPie] [GolfBall_Melon] [GolfBall_GoldenApple]
    - [GolfBall_SmashBall] [GolfBall_MushroomPowerup] [GolfBall_Yoshi_Egg] [GolfBall_Lil_Sparky] [GolfBall_Kirby] [GolfBall_Pokeball] [GolfBall_Navi] [GolfBall_PacMan] [GolfBall_CompanionCube]
    - [GolfBall_R2D2] [GolfBall_Eye_Of_Sauron] [GolfBall_Pride] [GolfBall_TransPride] [GolfBall_USA] [GolfBall_UK] [GolfBall_CA] [GolfBall_AU] [GolfBall_Earth]
    - [Base_GolfBall_Inventory_Arrow] [] [] [] [] [] [] [] []

Patron_GolfBall_Inventory_Arrow:
    type: item
    material: arrow
    debug: false
    display name: Patron Mini-Golf Balls
    data:
        lore_list:
        - <&6>Click to view the golf ball skins exclusive to Patrons! Become a Patron via <&b>/patreon<&6>!
        - <&color[#FF424D]>Only Patrons can obtain these skins!
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        custom_model_data: 100002

Base_GolfBall_Inventory_Arrow:
    type: item
    material: arrow
    debug: false
    display name: Base Mini-Golf Balls
    data:
        lore_list:
        - <&6>Click to return to the base menu of colored golf balls!
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        custom_model_data: 100001

GolfBallInventoryHandler:
    type: world
    debug: false
    events:
        on player clicks GolfBall_* in GolfBallInventory*:
        - determine passively cancelled
        - wait 1t
        - inventory close
        - if <context.inventory.script.name.contains_any_text[patron]> && !<player.has_permission[group.patron]>:
            - narrate "<&c>You can't select that ball because you are not a Patron!"
            - inventory open d:GolfBallInventory_Base
            - stop
        - if <player.money> >= 25:
            - take money quantity:25
            - give <context.item.with[display=<&a>Mini-golf ball (<player.name>)]>
            - narrate "<gray>You pay 25 gold for your golf ball."
            - narrate format:GolfProFormat "Happy golfing!"
        on player clicks Patron_GolfBall_Inventory_Arrow in GolfBallInventory*:
        - determine passively cancelled
        - wait 1t
        - inventory open d:GolfballInventory_Patron
        on player clicks Base_GolfBall_Inventory_Arrow in GolfBallInventory*:
        - determine passively cancelled
        - wait 1t
        - inventory open d:GolfBallInventory_Base
        on player clicks in GolfBallInventory* priority:100:
        - determine cancelled
        on player drags in GolfBallInventory* priority:100:
        - determine cancelled