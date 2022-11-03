Investment_NPC_Assignment:
    type: assignment
    debug: false
    interact scripts:
    - Investment_NPC_Interact
    actions:
        on assignment:
        - trigger name:proximity toggle:true radius:2
        - trigger name:click toggle:true

Investment_NPC_Format:
    type: format
    debug: false
    format: <dark_green>Feste, Fortune's Herald<&f><&co> <[text]>

Investment_NPC_Inventory_Prompts:
    type: inventory
    inventory: chest
    debug: false
    title: Investments
    size: 54
    slots:
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [Investment_Status] [] [Investment_Gold] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []

Investment_Upgrade_Progress_Procedure:
    type: procedure
    debug: false
    script:
    - define next_tier <yaml[VillagerPrices].read[investments.current_tier].add[1]>
    - if <[next_tier]> > 10:
        - determine "Maximum tier reached!"
    - else:
        - determine "<yaml[VillagerPrices].read[investments.progress]> / <yaml[VillagerPrices].read[investment_tiers.<[next_Tier]>.cost]>"

Investment_Status:
    type: item
    material: paper
    display name: <gold>Market investment status
    data:
        lore_list:
        - <gold>Investment tier: <green><yaml[VillagerPrices].read[investments.current_tier]>
        - <gold>Upgrade progress: <green><proc[Investment_Upgrade_Progress_Procedure]>
        - <gold>Discount: <green><yaml[VillagerPrices].read[investment_tiers.<yaml[VillagerPrices].read[investments.current_tier]>.discount_percentage].mul[100]><&pc>
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        hides:
        - all

Investment_Gold:
    type: item
    material: gold_ingot
    display name: <gold>Invest in market supplies
    data:
        lore_list:
        - <white>Contributing gold towards the market supplies allows traders to gather supplies more efficiently from other realms. Supply prices will decrease as trade routes gain heavier investment. Trade routes  require maintenance and protection, so weekly upkeep is required to maintain investment levels.
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        hides:
        - all

Investment_Inventory_Handler:
    type: world
    debug: false
    events:
        on player clicks Investment_Status in Investment_NPC_Inventory_Prompts:
        - determine passively cancelled
        - wait 1t
        - inventory close
        on player clicks Investment_Gold in Investment_NPC_Inventory_Prompts:
        - determine passively cancelled
        - wait 1t
        - inventory close
        - if <yaml[VillagerPrices].read[investments.current_tier]> >= 10:
            - narrate format:Investment_NPC_Format "The trade routes are already as upgraded as we can keep them for now! Hold on to your gold, we'll need it for next week's maintenance and repairs."
            - stop
        - zap Investment_NPC_Interact Invest_Gold
        - inject Invest_Gold_Prompt
        on player clicks in Investment_NPC_Inventory_Prompts priority:100:
        - determine cancelled
        on player drags in Investment_NPC_Inventory_Prompts:
        - determine cancelled

Invest_Gold_Prompt:
    type: task
    debug: false
    script:
    - narrate format:Investment_NPC_Format "Ah, so you'd like to invest in upgrading our trade routes? Excellent. How much would you like to contribute?"

Investment_NPC_Interact:
    type: interact
    debug: true
    speed: 0
    steps:
        Greeting*:
            proximity trigger:
                entry:
                    script:
                    - narrate format:Investment_NPC_Format "Hail, <player.name>!"
                    - wait 0.7s
                    - narrate format:Investment_NPC_Format "Welcome to the Dawn's Landing Trading Hall! We've been working on establishing trade routes across the realms. Our efforts thus far have brought a great variety of opportunities to trade, including both sales and purchases."
                    - wait 0.7s
                    - narrate format:Investment_NPC_Format "The traders here all deal in emeralds, not gold. If you find yourself looking for better prices, you can invest your gold into improving our trade routes - everyone's contributions make a difference! Upkeep is required, but all can invest, and all benefit from the investments."
                    - wait 0.7s
                    - narrate format:Investment_NPC_Format "Browse the hall as you like, and let me know if you'd like to know about the current trade route investment status or contribute some gold to the cause!"
                exit:
                    script:
                    - narrate format:Investment_NPC_Format "Take care!"
            click trigger:
                script:
                - narrate format:PlayerChatFormat "I'd like to know more about investing in the trade routes."
                - wait 0.7s
                - narrate format:Investment_NPC_Format "Excellent, can do!"
                - wait 0.7s
                - inventory open d:Investment_NPC_Inventory_Prompts
        Invest_Gold:
            proximity trigger:
                exit:
                    script:
                    - narrate format:Investment_NPC_Format "Not interested in contributing after all? No problem. Take care!"
                    - zap Greeting
            click trigger:
                script:
                - narrate format:Investment_NPC_Format "How much gold would you like to contribute?"
            chat trigger:
                DonationTrigger:
                    trigger: /REGEX:\d+/
                    hide trigger message: true
                    script:
                    - define donation_amount <context.message.abs||null>
                    - if !<[donation_amount].is_decimal>:
                        - narrate format:Investment_NPC_Format "You'd like to contribute <italic>how much<white> gold exeactly? Speak up."
                        - stop
                    - narrate format:PlayerChatFormat "I'd like to contribute <[donation_amount]> gold."
                    - if <[donation_amount]> <= 0:
                        - narrate format:Investment_NPC_Format "What a miser you are! Come back when you're willing to help the cause, then."
                        - zap Greeting
                    - else if <player.money> >= <[donation_amount]>:
                        # Pull some data
                        - define current_tier <yaml[VillagerPrices].read[investments.current_tier]>
                        - define progress <yaml[VillagerPrices].read[investments.progress]>
                        - define cost <yaml[VillagerPrices].read[investment_tiers.<[current_tier].add[1]>.cost]>
                        - define upgrade_amount <[cost].sub[<[progress]>]>
                        # If the amount on offer is more than the amount needed to upgrade...
                        - if <[donation_amount]> >= <[upgrade_amount]>:
                            # Save the extra money as the remainder
                            - define remainder <[donation_amount].sub[<[upgrade_amount]>]>
                            # Take the money actually needed to upgrade
                            - take money quantity:<[upgrade_amount]>
                            # Increase the tier
                            - yaml id:VillagerPrices set investments.current_tier:<yaml[VillagerPrices].read[investments.current_tier].add[1]>
                            # If the tier is STILL under the max of 10...
                            - if <yaml[VillagerPrices].read[investments.current_tier]> < 10:
                                # Redefine the progress definition
                                - define progress <yaml[VillagerPrices].read[investments.progress]>
                                - define current_tier <[current_tier].add[1]>
                                # Redefine the cost definition
                                - define cost <yaml[VillagerPrices].read[investment_tiers.<[current_tier].add[1]>.cost]>
                                - yaml id:VillagerPrices set investments.progress:0
                                - narrate format:Investment_NPC_Format "Your contribution is actually more than enough to establish upgraded trade routes! The extra <gold><[remainder]> gold<white> is yours to keep, although you're certainly welcome to contribute more. The next upgrade will cost <gold><[cost]> gold<white> total."
                            # If the tier is 10 or (somehow) above...
                            - else:
                                # Set progress to 0
                                - yaml id:VillagerPrices set investments.progress:0
                                - define progress 0
                                - take money quantity:<[upgrade_amount]>
                                - narrate format:Investment_NPC_Format "That's enough gold to get us all the way to the best upgrades we can make to our trade routes! What a hero you are! I actually only really need <gold><[upgrade_amount]> gold<white> from you, so you can keep <gold><[remainder]> gold<white> from what you offered."
                        - else:
                            - take money quantity:<[donation_amount]>
                            - narrate format:Investment_NPC_Format "How tremendous! Your contribution will help fund the establishment of trade routes across the realms."
                            - yaml id:VillagerPrices set investments.progress:<yaml[VillagerPrices].read[investments.progress].add[<[donation_amount]>]>
                        # Store the player's weekly contribution in a flag for historical purposes, maybe we'll do regression analysis on all of that data eventually
                        - flag server TradeRouteContributions.<util.time_now.year>.<util.time_now.month>.<util.time_now.next_day_of_week[monday].sub[7d].day>.<player>:+:<[donation_amount]>
                        # Store the all-time contributions
                        - flag server TradeRouteContributions.total:+:<[donation_amount]>
                        - ~yaml savefile:scriptdata/worlds/prosperus/dawnslanding/VillagerPrices.yml id:VillagerPrices
                        - zap Greeting
                    - else:
                        - narrate format:Investment_NPC_Format "Well, you do seem to be noble, but you are unfortunately also a liar. You haven't got that much gold. You can't fool me!"
                        - zap Greeting