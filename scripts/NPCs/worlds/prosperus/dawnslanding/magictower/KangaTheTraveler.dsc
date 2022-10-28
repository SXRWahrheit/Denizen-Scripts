# Etherea warp NPC

KangaAssignment:
    type: assignment
    debug: false
    interact scripts:
    - KangaInteract
    actions:
        on assignment:
        - trigger name:proximity state:true radius:3
        - trigger name:chat state:true

KangaFormat:
    type: format
    debug: false
    format: "<dark_green>Kanga<white><&co> <[text]>"

KangaInteract:
    type: interact
    debug: false
    steps:
        Greeting*:
            proximity trigger:
                entry:
                    script:
                    - narrate format:KangaFormat "HO, TRAVELER! It is always a pleasure to meet fresh faces! I am Kanga."
                    - wait 2.5s
                    - narrate format:KangaFormat "You have come quite a long way to reach the top of this tower. What brings you here?"
                    - wait 2.5s
                    - narrate format:PlayerChatFormat "I'm <player.name>, and I want to conquer every dark beast in every land!"
                    - wait 2.5s
                    - narrate format:KangaFormat "Every land, you say! You must be quite the adventurer. Well, that works out nicely, because I have discovered some absolutely fascinating lands."
                    - wait 2.5s
                    - narrate format:PlayerChatFormat "Fascinating? How so?"
                    - wait 2.5s
                    - narrate format:KangaFormat "Well, the lands I travel have the tendency to appear and disappear. They materialize overnight, and then fade from existence in a flash."
                    - wait 2.5s
                    - narrate format:PlayerChatFormat "That's almost unbelievable! There must be some force that controls their existence, surely?"
                    - wait 2.5s
                    - narrate format:KangaFormat "Perhaps. But so far, I have not been able to discern why or how this land twists, changes, or disappears. Still, however, the darkness fights for it!"
                    - wait 2.5s
                    - narrate format:KangaFormat "The good news is, of course, that you may plunder the land's rich bounties and slay all the enemies you like while you are there. After all, the next time you visit, Etherea may have become something new entirely without any warning!"
                    - wait 2.5s
                    - narrate format:PlayerChatFormat "That really is an adventure! So how do I get there?"
                    - wait 2.5s
                    - narrate format:KangaFormat "Well, Veriana over there uses her magic to channel the souls of monsters to create her portals. My magic comes from within, but it requires a considerable amount of focus and strength. So I need a hearty meal afterwards! That means I charge <gold>gold<white> to send you to Etherea. <gold>500 gold per trip<white>, to be exact."
                    - wait 2.5s
                    - narrate format:PlayerChatFormat "That sounds very reasonable."
                    - wait 2.5s
                    - narrate format:KangaFormat "Does it? HAH! Maybe I should raise my prices. Get a real banquet going."
                    - wait 2.5s
                    - narrate format:KangaFormat "Anyway, whenever you're ready, bring me <gold>500 gold<white> and I can send you to Etherea."
                    - wait 2.5s
                    - narrate format:PlayerChatFormat "Great! Sounds good to me!"
                    - if <player.money> >= 500:
                        - narrate format:PlayerChatFormat "I've already got <gold>500 gold<white>, in fact."
                        - wait 2.5s
                        - narrate format:KangaFormat "Excellent! You get a portal, and I get a feast. You all ready to go?"
                    - else:
                        - narrate format:KangaFormat "Come on back when you've got <gold>500 gold<white> and I can send you on over."
                        - wait 2.5s
                        - narrate format:PlayerChatFormat "Sounds good, I guess I'd better go make some money! Thanks Kanga!"
                    - zap Returning
        Returning:
            proximity trigger:
                entry:
                    script:
                    - narrate format:KangaFormat "HO, <player.name>!"
                    - wait 2.5s
                    - if <player.money> >= 500:
                        - narrate format:PlayerChatFormat "Hi there Kanga! I've brought you the <gold>500 gold<white>!"
                        - wait 2.5s
                        - narrate format:KangaFormat "OUTSTANDING! A portal for you, a feast for me! Are you ready?"
                        - narrate "<gray>Right-click Kanga when you're ready to travel!"
                        - zap Warp
                    - else:
                        - narrate format:KangaFormat "Your pockets look a little light! I need a good meal after I open up a portal to Etherea, you'll have to come back when you can pay me <gold>500 gold<white>."
                        - wait 2.5s
                        - narrate format:KangaFormat "Monsters often have some gold on them. SO GET TO SLAYING!"
                exit:
                    script:
                    - if <player.world.name> != prosperus:
                        - stop
                    - narrate format:KangaFormat "See you again soon! ETHEREA AWAITS!"
        Warp:
            click trigger:
                script:
                - if <player.money> >= 500:
                    - narrate format:KangaFormat "ALRIGHT! PORTAL TIME! Now hand over that gold."
                    - wait 0.5s
                    - narrate "<gray>You hand Kanga 500 gold."
                    - wait 0.5s
                    - take money quantity:500
                    - narrate format:KangaFormat "Excellent! AWAY YOU GO! TO ETHEREAAAAAAAAAA!"
                    - playeffect effect:portal at:<player.eye_location.sub[0,0.5,0]> visibility:200 quantity:1000 offset:0.5 data:2.0
                    - playeffect effect:end_rod at:<player.eye_location> visibility:200 quantity:100 offset:2.0 data:1.0
                    - wait 1s
                    - teleport <player> EthereaKangaWarp
                    - cast slow_falling d:30 a:0 <player>
                    - playeffect effect:end_rod at:<player.eye_location> visibility:200 quantity:1000 offset:2.0 data:1.0
                - zap Returning
            proximity trigger:
                exit:
                    script:
                    - zap Returning
                    - if <player.world.name> != prosperus:
                        - stop
                    - narrate format:KangaFormat "See you again soon! ETHEREA AWAITS!"