# WIP script to handle villager NPCs at spawn for centralized trading

Trading_Enchant_Data:
    type: data
    debug: false
    enchantments:
        arrow_damage: 5
        arrow_fire: 1
        arrow_infinite: 1
        arrow_knockback: 2
        binding_curse: 1
        channeling: 1
        damage_all: 5
        damage_arthropods: 5
        damage_undead: 5
        depth_strider: 3
        dig_speed: 5
        durability: 3
        fire_aspect: 2
        frost_walker: 2
        impaling: 5
        knockback: 2
        loot_bonus_blocks: 3
        loot_bonus_mobs: 3
        loyalty: 3
        luck: 3
        lure: 3
        mending: 1
        multishot: 1
        oxygen: 3
        piercing: 4
        protection_environmental: 4
        protection_explosions: 4
        protection_fall: 4
        protection_fire: 4
        protection_projectile: 4
        quick_charge: 3
        riptide: 3
        silk_touch: 1
        soul_speed: 3
        sweeping_edge: 3
        thorns: 3
        vanishing_curse: 1
        water_worker: 1
    treasure:
    - frost_walker
    - binding_curse
    - soul_speed
    - vanishing_curse
    - mending

Buying_Item_Prices:
    type: data
    debug: false
    prices:
        andesite: 16
        beef: 10
        beetroot: 15
        black_dye: 12
        black_wool: 18
        blue_dye: 12
        book: 4
        brown_dye: 12
        brown_wool: 18
        carrot: 22
        chicken: 14
        clay_ball: 10
        coal: 15
        cod: 15
        compass: 1
        cyan_dye: 12
        diamond: 1
        diorite: 16
        dried_kelp_block: 10
        feather: 24
        flint: 30
        glass_bottle: 9
        glass_pane: 11
        gold_ingot: 3
        granite: 16
        gray_dye: 12
        gray_wool: 18
        green_dye: 12
        ink_sac: 5
        iron_ingot: 4
        lava_bucket: 1
        leather: 6
        light_blue_dye: 12
        light_gray_dye: 12
        lime_dye: 12
        magenta_dye: 12
        melon: 4
        mutton: 7
        nether_wart: 22
        orange_dye: 12
        paper: 24
        pink_dye: 12
        porkchop: 7
        potato: 26
        pufferfish: 4
        pumpkin: 16
        purple_dye: 12
        quartz: 12
        rabbit: 4
        rabbit_foot: 2
        rabbit_hide: 9
        red_dye: 12
        rotten_flesh: 32
        salmon: 13
        scute: 4
        stick: 32
        stone: 20
        string: 20
        sweet_berries: 10
        tripwire_hook: 8
        tropical_fish: 6
        wheat: 20
        white_dye: 12
        white_wool: 18
        yellow_dye: 12

Selling_Item_Prices:
    type: data
    debug: false
    prices:
        iron_helmet:
            price: 5
            quantity: 1
        iron_chestplate:
            price:  9
            quantity: 1
        iron_leggings:
            price: 7
            quantity: 1
        iron_boots:
            price: 4
            quantity: 1
        bell:
            price: 36
            quantity: 1
        chainmail_leggings:
            price: 3
            quantity: 1
        chainamil_boots:
            price: 1
            quantity: 1
        chainmail_helmet:
            price: 1
            quantity: 1
        chainmail_chestplate:
            price: 4
            quantity: 1
        shield:
            price: 5
            quantity: 1
        diamond_leggings:
            price: 33
            quantity: 1
        diamond_boots:
            price: 27
            quantity: 1
        diamond_helmet:
            price: 27
            quantity: 1
        diamond_chestplate:
            price: 35
            quantity: 1
        rabbit_stew:
            price: 1
            quantity: 1
        cooked_porkchop:
            price: 1
            quantity: 5
        cooked_chicken:
            price: 1
            quantity: 8
        item_frame:
            price: 7
            quantity: 1
        globe_banner_pattern:
            price: 8
            quantity: 1
        redstone:
            price: 1
            quantity: 2
        lapis_lazuli:
            price: 1
            quantity: 1
        glowstone:
            price: 4
            quantity: 1
        ender_pearl:
            price: 5
            quantity: 1
        bread:
            price: 1
            quantity: 6
        pumpkin_pie:
            price: 1
            quantity: 4
        apple:
            price: 1
            quantity: 4
        cookie:
            price: 3
            quantity: 18
        cake:
            price: 1
            quantity: 1
        golden_carrot:
            price: 3
            quantity: 3
        glistering_melon_slice:
            price: 4
            quantity: 3
        bucket_of_cod:
            price: 3
            quantity: 1
        campfire:
            price: 2
            quantity: 1
        arrow:
            price: 1
            quantity: 16
        bow:
            price: 2
            quantity: 1
        crossbow:
            price: 3
            quantity: 1
        leather_leggings:
            price: 3
            quantity: 1
        leather_chestplate:
            price: 7
            quantity: 1
        leather_helmet:
            price: 5
            quantity: 1
        leather_boots:
            price: 4
            quantity: 1
        leather_horse_armor:
            price: 6
            quantity: 1
        saddle:
            price: 6
            quantity: 1
        bookshelf:
            price: 9
            quantity: 1
        lantern:
            price: 1
            quantity: 1
        glass:
            price: 1
            quantity: 4
        clock:
            price: 5
            quantity: 1
        compass:
            price: 4
            quantity: 1
        name_tag:
            price: 20
            quantity: 1
        brick:
            price: 1
            quantity: 10
        chiseled_stone_bricks:
            price: 1
            quantity: 4
        polished_andesite:
            price: 1
            quantity: 4
        polished_granite:
            price: 1
            quantity: 4
        polished_diorite:
            price: 1
            quantity: 4
        quartz_pillar:
            price: 1
            quantity: 1
        quartz_block:
            price: 1
            quantity: 1
        shears:
            price: 2
            quantity: 1
        painting:
            price: 2
            quantity: 3
        stone_axe:
            price: 1
            quantity: 1
        stone_shovel:
            price: 1
            quantity: 1
        stone_pickaxe:
            price: 1
            quantity: 1
        stone_hoe:
            price: 1
            quantity: 1
        iron_axe:
            price: 20
            quantity: 1
        iron_shovel:
            price: 21
            quantity: 1
        iron_pickaxe:
            price: 22
            quantity: 1
        diamond_hoe:
            price: 4
            quantity: 1
        diamond_axe:
            price: 31
            quantity: 1
        diamond_shovel:
            price: 24
            quantity: 1
        diamond_pickaxe:
            price: 32
            quantity: 1
        iron_sword:
            price: 21
            quantity: 1
        diamond_sword:
            price: 27
            quantity: 1

Weaponsmith_Buyer_Assignment:
    type: assignment
    debug: false
    interact scripts:
    - Weaponsmith_Buyer_Interact
    actions:
        on assignment:
        - trigger name:proximity toggle:true radius:2
        - trigger name:click toggle:true

Weaponsmith_Buyer_Interact:
    type: interact
    debug: false
    speed: 0
    steps:
        Greeting*:
            click trigger:
                script:
                - inject WeaponSmith_Inventory_Buyer

WeaponSmith_Inventory_Buyer:
    type: task
    debug: true
    speed: 0
    script:
    - define trades_buy <list[coal|iron_ingot|flint|diamond]>
    - foreach <[trades_buy]> as:item:
        - define trades_list:->:<map.with[<[item]>].as[<script[Buying_Item_Prices].data_key[prices].get[<[item]>]>]>
    - define trades <list[]>
    - define current_tier <yaml[VillagerPrices].read[investments.current_tier]>
    - define discount <element[1].sub[<yaml[VillagerPrices].read[investment_tiers.<[current_tier]>.discount_percentage]>]>
    - foreach <[trades_list]>:
        - define item <[trades_buy].get[<[loop_index]>]>
        - define quantity <script[Buying_Item_Prices].data_key[prices].get[<[item]>].mul[1.2].round_up>
        - if <[current_tier]> > 0:
            - define quantity <[quantity].mul[<[discount]>].round_up>
        - define trades <[trades].include[trade[max_uses=1000;inputs=<[item]>[quantity=<[quantity]>];result=emerald]]>
    - opentrades <[trades]>

Toolsmith_Buyer_Assignment:
    type: assignment
    debug: false
    interact scripts:
    - Toolsmith_Buyer_Interact
    actions:
        on assignment:
        - trigger name:proximity toggle:true radius:2
        - trigger name:click toggle:true

Toolsmith_Buyer_Interact:
    type: interact
    debug: false
    speed: 0
    steps:
        Greeting*:
            click trigger:
                script:
                - inject ToolSmith_Inventory_Buyer

ToolSmith_Inventory_Buyer:
    type: task
    debug: false
    script:
    - define trades_buy <list[coal|iron_ingot|flint|diamond]>
    - foreach <[trades_buy]> as:item:
        - define trades_list:->:<map.with[<[item]>].as[<script[Buying_Item_Prices].data_key[prices].get[<[item]>]>]>
    - define trades <list[]>
    - define current_tier <yaml[VillagerPrices].read[investments.current_tier]>
    - define discount <element[1].sub[<yaml[VillagerPrices].read[investment_tiers.<[current_tier]>.discount_percentage]>]>
    - foreach <[trades_list]>:
        - define item <[trades_buy].get[<[loop_index]>]>
        - define quantity <script[Buying_Item_Prices].data_key[prices].get[<[item]>].mul[1.2].round_up>
        - if <[current_tier]> > 0:
            - define quantity <[quantity].mul[<[discount]>].round_up>
        - define trades <[trades].include[trade[max_uses=1000;inputs=<[item]>[quantity=<[quantity]>];result=emerald]]>
    - opentrades <[trades]>

Leatherworker_Buyer_Assignment:
    type: assignment
    debug: false
    interact scripts:
    - Leatherworker_Buyer_Interact
    actions:
        on assignment:
        - trigger name:proximity toggle:true radius:2
        - trigger name:click toggle:true

Leatherworker_Buyer_Interact:
    type: interact
    debug: false
    speed: 0
    steps:
        Greeting*:
            click trigger:
                script:
                - inject Leatherworker_Inventory_Buyer

Leatherworker_Inventory_Buyer:
    type: task
    debug: false
    script:
    - define trades_buy <list[leather|flint|rabbit_hide|scute]>
    - foreach <[trades_buy]> as:item:
        - define trades_list:->:<map.with[<[item]>].as[<script[Buying_Item_Prices].data_key[prices].get[<[item]>]>]>
    - define trades <list[]>
    - define current_tier <yaml[VillagerPrices].read[investments.current_tier]>
    - define discount <element[1].sub[<yaml[VillagerPrices].read[investment_tiers.<[current_tier]>.discount_percentage]>]>
    - foreach <[trades_list]>:
        - define item <[trades_buy].get[<[loop_index]>]>
        - define quantity <script[Buying_Item_Prices].data_key[prices].get[<[item]>].mul[1.2].round_up>
        - if <[current_tier]> > 0:
            - define quantity <[quantity].mul[<[discount]>].round_up>
        - define trades <[trades].include[trade[max_uses=1000;inputs=<[item]>[quantity=<[quantity]>];result=emerald]]>
    - opentrades <[trades]>

Farmer_Buyer_Assignment:
    type: assignment
    debug: false
    interact scripts:
    - Farmer_Buyer_Interact
    actions:
        on assignment:
        - trigger name:proximity toggle:true radius:2
        - trigger name:click toggle:true

Farmer_Buyer_Interact:
    type: interact
    debug: false
    speed: 0
    steps:
        Greeting*:
            click trigger:
                script:
                - inject Farmer_Inventory_Buyer

Farmer_Inventory_Buyer:
    type: task
    debug: false
    script:
    - define trades_buy <list[wheat|potato|carrot|beetroot|pumpkin|melon]>
    - foreach <[trades_buy]> as:item:
        - define trades_list:->:<map.with[<[item]>].as[<script[Buying_Item_Prices].data_key[prices].get[<[item]>]>]>
    - define trades <list[]>
    - define current_tier <yaml[VillagerPrices].read[investments.current_tier]>
    - define discount <element[1].sub[<yaml[VillagerPrices].read[investment_tiers.<[current_tier]>.discount_percentage]>]>
    - foreach <[trades_list]>:
        - define item <[trades_buy].get[<[loop_index]>]>
        - define quantity <script[Buying_Item_Prices].data_key[prices].get[<[item]>].mul[1.2].round_up>
        - if <[current_tier]> > 0:
            - define quantity <[quantity].mul[<[discount]>].round_up>
        - define trades <[trades].include[trade[max_uses=1000;inputs=<[item]>[quantity=<[quantity]>];result=emerald]]>
    - opentrades <[trades]>

Fisherman_Buyer_Assignment:
    type: assignment
    debug: false
    interact scripts:
    - Fisherman_Buyer_Interact
    actions:
        on assignment:
        - trigger name:proximity toggle:true radius:2
        - trigger name:click toggle:true

Fisherman_Buyer_Interact:
    type: interact
    debug: false
    speed: 0
    steps:
        Greeting*:
            click trigger:
                script:
                - inject Fisherman_Inventory_Buyer

Fisherman_Inventory_Buyer:
    type: task
    debug: false
    script:
    - define trades_buy <list[string|coal|cod|salmon|tropical_fish|pufferfish]>
    - foreach <[trades_buy]> as:item:
        - define trades_list:->:<map.with[<[item]>].as[<script[Buying_Item_Prices].data_key[prices].get[<[item]>]>]>
    - define trades <list[]>
    - define current_tier <yaml[VillagerPrices].read[investments.current_tier]>
    - define discount <element[1].sub[<yaml[VillagerPrices].read[investment_tiers.<[current_tier]>.discount_percentage]>]>
    - foreach <[trades_list]>:
        - define item <[trades_buy].get[<[loop_index]>]>
        - define quantity <script[Buying_Item_Prices].data_key[prices].get[<[item]>].mul[1.2].round_up>
        - if <[current_tier]> > 0:
            - define quantity <[quantity].mul[<[discount]>].round_up>
        - define trades <[trades].include[trade[max_uses=1000;inputs=<[item]>[quantity=<[quantity]>];result=emerald]]>
    - opentrades <[trades]>

Fletcher_Buyer_Assignment:
    type: assignment
    debug: false
    interact scripts:
    - Fletcher_Buyer_Interact
    actions:
        on assignment:
        - trigger name:proximity toggle:true radius:2
        - trigger name:click toggle:true

Fletcher_Buyer_Interact:
    type: interact
    debug: false
    speed: 0
    steps:
        Greeting*:
            click trigger:
                script:
                - inject Fletcher_Inventory_Buyer

Fletcher_Inventory_Buyer:
    type: task
    debug: false
    script:
    - define trades_buy <list[stick|flint|string|feather|tripwire_hook]>
    - foreach <[trades_buy]> as:item:
        - define trades_list:->:<map.with[<[item]>].as[<script[Buying_Item_Prices].data_key[prices].get[<[item]>]>]>
    - define trades <list[]>
    - define current_tier <yaml[VillagerPrices].read[investments.current_tier]>
    - define discount <element[1].sub[<yaml[VillagerPrices].read[investment_tiers.<[current_tier]>.discount_percentage]>]>
    - foreach <[trades_list]>:
        - define item <[trades_buy].get[<[loop_index]>]>
        - define quantity <script[Buying_Item_Prices].data_key[prices].get[<[item]>].mul[1.2].round_up>
        - if <[current_tier]> > 0:
            - define quantity <[quantity].mul[<[discount]>].round_up>
        - define trades <[trades].include[trade[max_uses=1000;inputs=<[item]>[quantity=<[quantity]>];result=emerald]]>
    - opentrades <[trades]>

Shepherd_Buyer_Assignment:
    type: assignment
    debug: false
    interact scripts:
    - Shepherd_Buyer_Interact
    actions:
        on assignment:
        - trigger name:proximity toggle:true radius:2
        - trigger name:click toggle:true

Shepherd_Buyer_Interact:
    type: interact
    debug: false
    speed: 0
    steps:
        Greeting*:
            click trigger:
                script:
                - inject Shepherd_Inventory_Buyer

Shepherd_Inventory_Buyer:
    type: task
    debug: false
    script:
    - define trades_buy <list[white_wool|brown_wool|black_wool|gray_wool|black_dye|gray_dye|lime_dye|light_blue_dye|white_dye|red_dye|light_gray_dye|pink_dye|yellow_dye|orange_dye|green_dye|brown_dye|blue_dye|purple_dye|cyan_dye|magenta_dye]>
    - foreach <[trades_buy]> as:item:
        - define trades_list:->:<map.with[<[item]>].as[<script[Buying_Item_Prices].data_key[prices].get[<[item]>]>]>
    - define trades <list[]>
    - define current_tier <yaml[VillagerPrices].read[investments.current_tier]>
    - define discount <element[1].sub[<yaml[VillagerPrices].read[investment_tiers.<[current_tier]>.discount_percentage]>]>
    - foreach <[trades_list]>:
        - define item <[trades_buy].get[<[loop_index]>]>
        - define quantity <script[Buying_Item_Prices].data_key[prices].get[<[item]>].mul[1.2].round_up>
        - if <[current_tier]> > 0:
            - define quantity <[quantity].mul[<[discount]>].round_up>
        - define trades <[trades].include[trade[max_uses=1000;inputs=<[item]>[quantity=<[quantity]>];result=emerald]]>
    - opentrades <[trades]>

Armorer_Buyer_Assignment:
    type: assignment
    debug: false
    interact scripts:
    - Armorer_Buyer_Interact
    actions:
        on assignment:
        - trigger name:proximity toggle:true radius:2
        - trigger name:click toggle:true

Armorer_Buyer_Interact:
    type: interact
    debug: false
    speed: 0
    steps:
        Greeting*:
            click trigger:
                script:
                - inject Armorer_Inventory_Buyer

Armorer_Inventory_Buyer:
    type: task
    debug: false
    script:
    - define trades_buy <list[coal|iron_ingot|lava_bucket|diamond]>
    - foreach <[trades_buy]> as:item:
        - define trades_list:->:<map.with[<[item]>].as[<script[Buying_Item_Prices].data_key[prices].get[<[item]>]>]>
    - define trades <list[]>
    - define current_tier <yaml[VillagerPrices].read[investments.current_tier]>
    - define discount <element[1].sub[<yaml[VillagerPrices].read[investment_tiers.<[current_tier]>.discount_percentage]>]>
    - foreach <[trades_list]>:
        - define item <[trades_buy].get[<[loop_index]>]>
        - define quantity <script[Buying_Item_Prices].data_key[prices].get[<[item]>].mul[1.2].round_up>
        - if <[current_tier]> > 0:
            - define quantity <[quantity].mul[<[discount]>].round_up>
        - define trades <[trades].include[trade[max_uses=1000;inputs=<[item]>[quantity=<[quantity]>];result=emerald]]>
    - opentrades <[trades]>

Butcher_Buyer_Assignment:
    type: assignment
    debug: false
    interact scripts:
    - Butcher_Buyer_Interact
    actions:
        on assignment:
        - trigger name:proximity toggle:true radius:2
        - trigger name:click toggle:true

Butcher_Buyer_Interact:
    type: interact
    debug: false
    speed: 0
    steps:
        Greeting*:
            click trigger:
                script:
                - inject Butcher_Inventory_Buyer

Butcher_Inventory_Buyer:
    type: task
    debug: false
    script:
    - define trades_buy <list[chicken|porkchop|rabbit|coal|mutton|beef|dried_kelp_block|sweet_berries]>
    - foreach <[trades_buy]> as:item:
        - define trades_list:->:<map.with[<[item]>].as[<script[Buying_Item_Prices].data_key[prices].get[<[item]>]>]>
    - define trades <list[]>
    - define current_tier <yaml[VillagerPrices].read[investments.current_tier]>
    - define discount <element[1].sub[<yaml[VillagerPrices].read[investment_tiers.<[current_tier]>.discount_percentage]>]>
    - foreach <[trades_list]>:
        - define item <[trades_buy].get[<[loop_index]>]>
        - define quantity <script[Buying_Item_Prices].data_key[prices].get[<[item]>].mul[1.2].round_up>
        - if <[current_tier]> > 0:
            - define quantity <[quantity].mul[<[discount]>].round_up>
        - define trades <[trades].include[trade[max_uses=1000;inputs=<[item]>[quantity=<[quantity]>];result=emerald]]>
    - opentrades <[trades]>

Cleric_Buyer_Assignment:
    type: assignment
    debug: false
    interact scripts:
    - Cleric_Buyer_Interact
    actions:
        on assignment:
        - trigger name:proximity toggle:true radius:2
        - trigger name:click toggle:true

Cleric_Buyer_Interact:
    type: interact
    debug: false
    speed: 0
    steps:
        Greeting*:
            click trigger:
                script:
                - inject Cleric_Inventory_Buyer

Cleric_Inventory_Buyer:
    type: task
    debug: true
    script:
    - define trades_buy <list[rotten_flesh|gold_ingot|rabbit_foot|scute|glass_bottle|nether_wart]>
    - foreach <[trades_buy]> as:item:
        - define trades_list:->:<map.with[<[item]>].as[<script[Buying_Item_Prices].data_key[prices].get[<[item]>]>]>
    - define trades <list[]>
    - define current_tier <yaml[VillagerPrices].read[investments.current_tier]>
    - define discount <element[1].sub[<yaml[VillagerPrices].read[investment_tiers.<[current_tier]>.discount_percentage]>]>
    - foreach <[trades_list]>:
        - define item <[trades_buy].get[<[loop_index]>]>
        - define quantity <script[Buying_Item_Prices].data_key[prices].get[<[item]>].mul[1.2].round_up>
        - if <[current_tier]> > 0:
            - define quantity <[quantity].mul[<[discount]>].round_up>
        - define trades <[trades].include[trade[max_uses=1000;inputs=<[item]>[quantity=<[quantity]>];result=emerald]]>
    - opentrades <[trades]>

Cartographer_Buyer_Assignment:
    type: assignment
    debug: false
    interact scripts:
    - Cartographer_Buyer_Interact
    actions:
        on assignment:
        - trigger name:proximity toggle:true radius:2
        - trigger name:click toggle:true

Cartographer_Buyer_Interact:
    type: interact
    debug: false
    speed: 0
    steps:
        Greeting*:
            click trigger:
                script:
                - inject Cartographer_Inventory_Buyer

Cartographer_Inventory_Buyer:
    type: task
    debug: false
    script:
    - define trades_buy <list[paper|glass_pane|compass]>
    - foreach <[trades_buy]> as:item:
        - define trades_list:->:<map.with[<[item]>].as[<script[Buying_Item_Prices].data_key[prices].get[<[item]>]>]>
    - define trades <list[]>
    - define current_tier <yaml[VillagerPrices].read[investments.current_tier]>
    - define discount <element[1].sub[<yaml[VillagerPrices].read[investment_tiers.<[current_tier]>.discount_percentage]>]>
    - foreach <[trades_list]>:
        - define item <[trades_buy].get[<[loop_index]>]>
        - define quantity <script[Buying_Item_Prices].data_key[prices].get[<[item]>].mul[1.2].round_up>
        - if <[current_tier]> > 0:
            - define quantity <[quantity].mul[<[discount]>].round_up>
        - define trades <[trades].include[trade[max_uses=1000;inputs=<[item]>[quantity=<[quantity]>];result=emerald]]>
    - opentrades <[trades]>

Librarian_Buyer_Assignment:
    type: assignment
    debug: false
    interact scripts:
    - Librarian_Buyer_Interact
    actions:
        on assignment:
        - trigger name:proximity toggle:true radius:2
        - trigger name:click toggle:true

Librarian_Buyer_Interact:
    type: interact
    debug: false
    speed: 0
    steps:
        Greeting*:
            click trigger:
                script:
                - inject Librarian_Inventory_Buyer

Librarian_Inventory_Buyer:
    type: task
    debug: false
    script:
    - define trades_buy <list[paper|book|ink_sac]>
    - foreach <[trades_buy]> as:item:
        - define trades_list:->:<map.with[<[item]>].as[<script[Buying_Item_Prices].data_key[prices].get[<[item]>]>]>
    - define trades <list[]>
    - define current_tier <yaml[VillagerPrices].read[investments.current_tier]>
    - define discount <element[1].sub[<yaml[VillagerPrices].read[investment_tiers.<[current_tier]>.discount_percentage]>]>
    - foreach <[trades_list]>:
        - define item <[trades_buy].get[<[loop_index]>]>
        - define quantity <script[Buying_Item_Prices].data_key[prices].get[<[item]>].mul[1.2].round_up>
        - if <[current_tier]> > 0:
            - define quantity <[quantity].mul[<[discount]>].round_up>
        - define trades <[trades].include[trade[max_uses=1000;inputs=<[item]>[quantity=<[quantity]>];result=emerald]]>
    - opentrades <[trades]>

# Emeralds for items go here

Farmer_Seller_Assignment:
    type: assignment
    debug: false
    interact scripts:
    - Farmer_Seller_Interact
    actions:
        on assignment:
        - trigger name:proximity toggle:true radius:2
        - trigger name:click toggle:true

Farmer_Seller_Interact:
    type: interact
    debug: false
    speed: 0
    steps:
        Greeting*:
            click trigger:
                script:
                - inject Farmer_Inventory_Seller

Farmer_Inventory_Seller:
    type: task
    debug: false
    script:
    - opentrades trade[max_uses=1000;inputs=emerald;result=bread[quantity=2]]|trade[max_uses=1000;inputs=emerald;result=pumpkin_pie[quantity=2]]|trade[max_uses=1000;inputs=emerald;result=apple[quantity=5]]|trade[max_uses=1000;inputs=emerald;result=cookie[quantity=6]]|trade[max_uses=1000;inputs=emerald;result=cake]

Librarian_Tools_Seller_Assignment:
    type: assignment
    debug: false
    interact scripts:
    - Librarian_Tools_Seller_Interact
    actions:
        on assignment:
        - trigger name:proximity toggle:true radius:2
        - trigger name:click toggle:true

Librarian_Tools_Seller_Interact:
    type: interact
    debug: false
    speed: 0
    steps:
        Greeting*:
            click trigger:
                script:
                - inject Librarian_Inventory_Seller_Tools

Librarian_Inventory_Seller_Tools:
    type: task
    debug: true
    speed: 0
    definitions: ench_lvl1_price|ench_lvl3_price|ench_lv5_price
    script:
    - inject Trade_Pricing_Task
    - define trades_sell <list[water_worker|binding_curse|vanishing_curse|depth_strider|dig_speed|loot_bonus_blocks|frost_walker|luck|lure|mending|oxygen|riptide|silk_touch|soul_speed|durability]>
    - define trades <list[]>
    - define current_tier <yaml[VillagerPrices].read[investments.current_tier]>
    - foreach <[trades_sell]>:
        - define enchantment <[trades_sell].get[<[loop_index]>]>
        - define level <script[Trading_Enchant_Data].data_key[enchantments.<[enchantment]>]>
        - define item enchanted_book[enchantments=<[enchantment]>,<[level]>]
        - choose <[enchantment]>:
            - case frost_walker binding_curse soul_speed vanishing_curse mending:
                - define price <[ench_lv<[level]>_price].mul[2]>
            - default:
                - define price <[ench_lv<[level]>_price]>
        - define trades <[trades].include[trade[max_uses=1000;inputs=emerald[quantity=<[price]>];result=<[item]>]]>
    - opentrades <[trades]>

Librarian_Combat_Seller_Assignment:
    type: assignment
    debug: false
    interact scripts:
    - Librarian_Combat_Seller_Interact
    actions:
        on assignment:
        - trigger name:proximity toggle:true radius:2
        - trigger name:click toggle:true

Librarian_Combat_Seller_Interact:
    type: interact
    debug: false
    speed: 0
    steps:
        Greeting*:
            click trigger:
                script:
                - inject Librarian_Inventory_Seller_Combat

Librarian_Inventory_Seller_Combat:
    type: task
    debug: true
    speed: 0
    definitions: ench_lvl1_price|ench_lvl3_price|ench_lv5_price
    script:
    - inject Trade_Pricing_Task
    #- opentrades trade[max_uses=1000;inputs=emerald[quantity=<[ench_lv1_price]>];result=enchanted_book[enchantments=MENDING,1]]|trade[max_uses=1000;inputs=emerald[quantity=<[ench_lv5_price]>];result=enchanted_book[enchantments=ARROW_DAMAGE,5]]|trade[max_uses=1000;inputs=emerald[quantity=<[ench_lv5_price]>];result=enchanted_book[enchantments=DAMAGE_ALL,5]]|trade[max_uses=1000;inputs=emerald[quantity=<[ench_lv5_price]>];result=enchanted_book[enchantments=DAMAGE_ARTHROPODS,5]]|trade[max_uses=1000;inputs=emerald[quantity=<[ench_lv5_price]>];result=enchanted_book[enchantments=DAMAGE_UNDEAD,5]]|trade[max_uses=1000;inputs=emerald[quantity=<[ench_lv3_price]>];result=enchanted_book[enchantments=DURABILITY,3]]
    - define trades_sell <list[arrow_damage|arrow_fire|arrow_infinite|arrow_knockback|channeling|damage_all|damage_arthropods|damage_undead|fire_aspect|impaling|knockback|loot_bonus_mobs|loyalty|multishot|piercing|protection_environmental|protection_explosions|protection_fall|protection_fire|protection_projectile|quick_charge|sweeping_edge|thorns]>
    - define trades <list[]>
    - define current_tier <yaml[VillagerPrices].read[investments.current_tier]>
    - foreach <[trades_sell]>:
        - define enchantment <[trades_sell].get[<[loop_index]>]>
        - define level <script[Trading_Enchant_Data].data_key[enchantments.<[enchantment]>]>
        - define item enchanted_book[enchantments=<[enchantment]>,<[level]>]
        - choose <[enchantment]>:
            - case frost_walker binding_curse soul_speed vanishing_curse mending:
                - define price <[ench_lv<[level]>_price].mul[2]>
            - default:
                - define price <[ench_lv<[level]>_price]>
        - define trades <[trades].include[trade[max_uses=1000;inputs=emerald[quantity=<[price]>];result=<[item]>]]>
    - opentrades <[trades]>