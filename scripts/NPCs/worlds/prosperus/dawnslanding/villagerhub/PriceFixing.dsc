Villager_Price_Loader:
    type: world
    debug: false
    events:
        on server start:
        - yaml load:scriptdata/worlds/prosperus/dawnslanding/VillagerPrices.yml id:VillagerPrices

Villager_Price_Calculator:
    type: task
    debug: false
    # Requires: <[EnchTier]>
    definitions: EnchTier
    script:
    - define current_tier <yaml[VillagerPrices].read[investments.current_tier]>
    - define progress <yaml[VillagerPrices].read[investments.progress]>
    - define discount <yaml[VillagerPrices].read[investment_tiers.<[current_tier]>.discount_percentage]>
    - define price <yaml[VillagerPrices].read[default_sell_costs.<[EnchTier]>].mul[<element[1].sub[<[discount]>]>].round_up>
    - determine <[price]>

Upgrade_Check:
    type: task
    debug: false
    definitions: VillagerID
    # Requires: <[VillagerID]>
    script:
    - define current_tier <yaml[VillagerPrices].read[investments.current_tier]>
    - define progress <yaml[VillagerPrices].read[investments.progress]>
    - define cost <yaml[VillagerPrices].read[investment_tiers.<[current_tier].add[1]>.cost>
    - define upgrade_amount <[cost].sub[<[progress]>]>

Supply_And_Demand:
    type: world
    debug: false
    events:
        on system time 19:00:
        - if <util.time_now.format[EEE]> != Fri:
            - stop
        - announce to_console "Villager price fixing event run"
        - if <yaml[VillagerPrices].read[investments.current_tier]> >= 1:
            - yaml id:VillagerPrices set investments.current_tier:<yaml[VillagerPrices].read[investments.current_tier].sub[1]>
        - announce to_console "New price tier is <yaml[VillagerPrices].read[investments.current_tier]>"
        - yaml id:VillagerPrices set investments.progress:0

Trade_Pricing_Task:
    type: task
    debug: true
    script:
    - define current_tier <yaml[VillagerPrices].read[investments.current_tier]>
    - define discount <element[1].sub[<yaml[VillagerPrices].read[investment_tiers.<[current_tier]>.discount_percentage]>]>
    - define ench_lv1_price <[discount].mul[19].round_up>
    - define ench_lv2_price <[discount].mul[32].round_up>
    - define ench_lv3_price <[discount].mul[45].round_up>
    - define ench_lv4_price <[discount].mul[58].round_up>
    - define ench_lv5_price <[discount].mul[64].round_up>