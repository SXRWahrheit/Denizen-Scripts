alchemist_arcaena:
    type: assignment
    interact scripts:
    - alchemist_arcaena_interact
    actions:
        on assignment:
        - teleport npc <npc.anchor[alchemist_arcaena]>
        - trigger name:proximity toggle:true
        - trigger name:chat toggle:true

alchemist_arcaena_format:
    type: format
    format: <dark_green>Alchemist Arcaena<white><&co> <[text]>

alchemist_arcaena_interact:
    type: interact
    steps:
        "Player_Seen*":
            proximity trigger:
                entry:
                    script:
                    - narrate format:alchemist_arcaena_format "Hello, adventurer! Come to peruse my magical brews? Bring me the right ingredients and I can craft you some enchanted cocktails."
                    - narrate format:alchemist_arcaena_format "The various potions I can brew require different kinds of ingredients. Right click me to browse my offerings."
                exit:
                    script:
                    - narrate format:alchemist_arcaena_format "Good luck on your adventures! Visit me again when you need another magical drink."
            click trigger:
                script:
                - narrate format:alchemist_arcaena_format "Okay, here's what I have to offer."
                - wait 1s
                - inventory open d:alchemist_arcaena_inventory_menu

alchemist_arcaena_inventory_menu:
    type: inventory
    inventory: chest
    title: Enchanted Cocktails
    size: 45
    slots:
    - [DropRateBooster2xMenu] [] [GoldBooster2xMenu] [] [] [] [] [] []
    - [DropRateBooster4xMenu] [] [GoldBooster4xMenu] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []


DropRateBooster2xMenu:
    type: item
    material: potion
    display name: <&a>Bottled Luck
    data:
        purifieddarkmattercost: 32
        crystallizedexperienceingotcost: 1
        lore_list:
        - <&f>This magic potion will give you a 2x chance to find rare items while hunting monsters!
        - <&6>Ingredients
        - <&f><script.data_key[purifieddarkmattercost]>x Purified Dark Matter
        - <&f><script.data_key[crystallizedexperienceingotcost]>x Crystallized Experience Ingot
    enchantments:
    - MENDING:1
    mechanisms:
        hides:
        - enchants
        - potion_effects
        nbt:
        - uncraftable/true
        color: <color[0,0,255]>
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>

DropRateBooster4xMenu:
    type: item
    material: potion
    display name: <&a>Improved Bottled Luck
    data:
        purifieddarkmattercost: 96
        crystallizedexperienceingotcost: 3
        lore_list:
        - <&f>This magic potion will give you a 4x chance to find rare items while hunting monsters!
        - <&6>Ingredients
        - <&f><script.data_key[data.purifieddarkmattercost]>x Purified Dark Matter
        - <&f><script.data_key[data.crystallizedexperienceingotcost]>x Crystallized Experience Ingot
    enchantments:
    - MENDING:1
    mechanisms:
        hides:
        - enchants
        - potion_effects
        nbt:
        - uncraftable/true
        color: <color[0,0,255]>
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>

GoldBooster2xMenu:
    type: item
    material: potion
    display name: <&a>Golden Brew
    data:
        purifieddarkmattercost: 32
        crystallizedexperienceingotcost: 1
        lore_list:
        - <&f>This magic potion will give you a 2x chance to find extra gold from slain monsters!
        - <&6>Ingredients
        - <&f><script.data_key[purifieddarkmattercost]>x Purified Dark Matter
        - <&f><script.data_key[crystallizedexperienceingotcost]>x Crystallized Experience Ingot
    enchantments:
    - MENDING:1
    mechanisms:
        hides:
        - enchants
        - potion_effects
        nbt:
        - uncraftable/true
        color: <color[255,255,0]>
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>

GoldBooster4xMenu:
    type: item
    material: potion
    display name: <&a>Improved Golden Brew
    data:
        purifieddarkmattercost: 96
        crystallizedexperienceingotcost: 3
        lore_list:
        - <&f>This magic potion will give you a 4x chance to find extra gold from slain monsters!
        - <&6>Ingredients
        - <&f><script[GoldBooster4xMenu].data_key[purifieddarkmattercost]>x Purified Dark Matter
        - <&f><script[GoldBooster4xMenu].data_key[crystallizedexperienceingotcost]>x Crystallized Experience Ingot
    enchantments:
    - MENDING:1
    mechanisms:
        hides:
        - enchants
        - potion_effects
        nbt:
        - uncraftable/true
        color: <color[255,255,0]>
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>


alchemist_arcaena_inventory_handler:
    type: world
    events:
        on player clicks in alchemist_arcaena_inventory_menu:
        - determine cancelled
        on player drags in alchemist_arcaena_inventory_menu:
        - determine cancelled
        on player clicks DropRateBooster2xMenu in alchemist_arcaena_inventory_menu:
        - determine passively cancelled
        - wait 1t
        - inventory close
        - announce to_console <player.inventory.list_contents>
        - if <player.inventory.contains_item[SocketMaker].quantity[<script[DropRateBooster2xMenu].data_key[purifieddarkmattercost]>]> && <player.inventory.contains_item[CrystallizedExperienceIngot].quantity[<script[DropRateBooster2xMenu].data_key[crystallizedexperienceingotcost]>]>:
            - take scriptname:SocketMaker quantity:<script[DropRateBooster2xMenu].data_key[purifieddarkmattercost]>
            - take scriptname:CrystallizedExperienceIngot quantity:<script[DropRateBooster2xMenu].data_key[crystallizedexperienceingotcost]>
            - give DropRateBooster2x quantity:1 to:<player.inventory>
            - narrate format:alchemist_arcaena_format "Here you go, bottoms up!"
        - else:
            - narrate format:alchemist_arcaena_format "Sorry, I need you to bring me the right ingredients for that!"
        - narrate format:alchemist_arcaena_format "Right click me again if you're looking for anything else!"
        on player clicks DropRateBooster4xMenu in alchemist_arcaena_inventory_menu:
        - determine passively cancelled
        - wait 1t
        - inventory close
        - announce to_console <player.inventory.list_contents>
        - if <player.inventory.contains_item[SocketMaker].quantity[<script[DropRateBooster4xMenu].data_key[purifieddarkmattercost]>]> && <player.inventory.contains_item[CrystallizedExperienceIngot].quantity[<script[DropRateBooster4xMenu].data_key[crystallizedexperienceingotcost]>]>:
            - take scriptname:SocketMaker quantity:<script[DropRateBooster4xMenu].data_key[purifieddarkmattercost]>
            - take scriptname:CrystallizedExperienceIngot quantity:<script[DropRateBooster4xMenu].data_key[crystallizedexperienceingotcost]>
            - give DropRateBooster4x quantity:1 to:<player.inventory>
            - narrate format:alchemist_arcaena_format "Here you go, bottoms up!"
        - else:
            - narrate format:alchemist_arcaena_format "Sorry, I need you to bring me the right ingredients for that!"
        - narrate format:alchemist_arcaena_format "Right click me again if you're looking for anything else!"
        on player clicks GoldBooster2xMenu in alchemist_arcaena_inventory_menu:
        - determine passively cancelled
        - wait 1t
        - inventory close
        - announce to_console <player.inventory.list_contents>
        - if <player.inventory.contains_item[SocketMaker].quantity[<script[GoldBooster2xMenu].data_key[purifieddarkmattercost]>]> && <player.inventory.contains_item[CrystallizedExperienceIngot].quantity[<script[GoldBooster2xMenu].data_key[crystallizedexperienceingotcost]>]>:
            - take scriptname:SocketMaker quantity:<script[GoldBooster2xMenu].data_key[purifieddarkmattercost]>
            - take scriptname:CrystallizedExperienceIngot quantity:<script[GoldBooster2xMenu].data_key[crystallizedexperienceingotcost]>
            - give GoldBooster2x quantity:1 to:<player.inventory>
            - narrate format:alchemist_arcaena_format "Here you go, bottoms up!"
        - else:
            - narrate format:alchemist_arcaena_format "Sorry, I need you to bring me the right ingredients for that!"
        - narrate format:alchemist_arcaena_format "Right click me again if you're looking for anything else!"
        on player clicks GoldBooster4xMenu in alchemist_arcaena_inventory_menu:
        - determine passively cancelled
        - wait 1t
        - inventory close
        - announce to_console <player.inventory.list_contents>
        - if <player.inventory.contains_item[SocketMaker].quantity[<script[GoldBooster4xMenu].data_key[purifieddarkmattercost]>]> && <player.inventory.contains_item[CrystallizedExperienceIngot].quantity[<script[GoldBooster4xMenu].data_key[crystallizedexperienceingotcost]>]>:
            - take scriptname:SocketMaker quantity:<script[GoldBooster4xMenu].data_key[purifieddarkmattercost]>
            - take scriptname:CrystallizedExperienceIngot quantity:<script[GoldBooster4xMenu].data_key[crystallizedexperienceingotcost]>
            - give GoldBooster4x quantity:1 to:<player.inventory>
            - narrate format:alchemist_arcaena_format "Here you go, bottoms up!"
        - else:
            - narrate format:alchemist_arcaena_format "Sorry, I need you to bring me the right ingredients for that!"
        - narrate format:alchemist_arcaena_format "Right click me again if you're looking for anything else!"