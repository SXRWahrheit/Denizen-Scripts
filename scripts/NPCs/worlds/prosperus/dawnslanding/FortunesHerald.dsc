FortunesHeraldAssignment:
    type: assignment
    debug: false
    interact scripts:
    - FortunesHeraldInteract
    actions:
        on assignment:
        - teleport npc location:<npc.anchor[FortunesHerald]>
        - trigger name:proximity state:true
        - trigger name:chat state:true

FortunesHeraldformat:
    type: format
    debug: false
    format: "<dark_green>Feste, Fortune's Herald<white><&co> <[text]>"

FortunesHeraldInteract:
    type: interact
    debug: false
    steps:
        Greeting*:
            proximity trigger:
                entry:
                    script:
                    - narrate format:FortunesHeraldFormat "Greatest of greetings to you, oh noble <player.name>!"
                    - wait 0.7s
                    - narrate format:FortunesHeraldFormat "I am Feste, the Fortunes' Herald, a bringer of good news and good fortunes to adventurers across the lands."
                    - wait 0.7s
                    - narrate format:FortunesHeraldFormat "I wish to bequeath upon the humble residents of Dawn's Landing a great and splendid gift."
                    - wait 0.7s
                    - narrate format:FortunesHeraldFormat "But alas, to make it happen, I must collect enough funding. So... can you spare some coin?"
                    - zap HeraldMet
        HeraldMet:
            proximity trigger:
                entry:
                    script:
                    - narrate format:FortunesHeraldFormat "A warmest of welcomed returns to you, oh noble <player.name>! Say, did you bring me any coin...?"
            click trigger:
                script:
                - narrate format:PlayerChatFormat "Yes, I brought you some gold for the cause!"
                - narrate format:FortunesHeraldFormat "Oh, how tremendous! Your contribution will go to a good cause... I promise. So, how much gold would you like to donate?"
                - zap Donation
        Donation:
            chat trigger:
                DonationTrigger:
                    trigger: /REGEX:\d+/
                    hide trigger message: true
                    script:
                    - define donation_amount <context.message.replace[regex:\D+]>
                    - narrate format:PlayerChatFormat "I'd like to offer <[donation_amount]> gold."
                    - if <[donation_amount]> == 0:
                        - narrate format:FortunesHeraldFormat "What a miser you are! Come back when you're willing to help the cause, then."
                        - zap HeraldMet
                    - else if <player.money> >= <[donation_amount]>:
                        - take money quantity:<[donation_amount]>
                        - narrate format:FortunesHeraldFormat "Oh, how tremendous! Your contribution will go to a good cause... I promise."
                        - flag server FortunesHeraldContributions.<player>:+:<[donation_amount]>
                        - flag server FortunesHeraldContributions.total:+:<[donation_amount]>
                        - wait 0.7s
                        - narrate format:FortunesHeraldFormat "So far, you lovely adventurers have contributed <gold><server.flag[FortunesHeraldContributions.total]> gold<white>! The more we can get, the more fortune I can bring, so get your friends to sink their gold in..."
                        - zap HeraldMet
                    - else:
                        - narrate format:FortunesHeraldFormat "Well, you do seem to be noble, but you are unfortunately also a liar. You haven't got that much gold. You can't fool me!"
                        - zap HeraldMet
                Fail:
                    trigger: /*/
                    hide trigger message: true
                    script:
                    - narrate format:PlayerChatFormat <context.message>
                    - narrate format:FortunesHeraldFormat "That's no number I've ever heard of. Are you trying to fool me?"
                    - zap HeraldMet
            proximity trigger:
                exit:
                    script:
                    - narrate format:FortunesHeraldFormat "See you soon, <player.name>... bring some of your friends to help contribute their coin!"
                    - zap HeraldMet