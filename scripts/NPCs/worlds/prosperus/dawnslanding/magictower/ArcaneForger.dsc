ArcaneForgerAssignment:
    type: assignment
    debug: false
    interact scripts:
    - ArcaneForgerInteract
    actions:
        on assignment:
        - trigger name:proximity toggle:true
        - trigger name:chat toggle:true

ArcaneForgerFormat:
    type: format
    debug: false
    format: <dark_green>Arcane Forger<white><&co> <[text]>

ArcaneForgerInteract:
    type: interact
    debug: false
    steps:
        "Player_Seen*":
            proximity trigger:
                entry:
                    script:
                    - narrate format:ArcaneForgerFormat "Welcome, adventurer! I am a master of extracting magical energies and manipulating them for heroes like yourself. If you collect enough of these items on your adventures, I can help you harness this power."
                    - narrate format:ArcaneForgerFormat "The various services I can provide require different amounts of magical energy. Right click me to browse my offerings."
                exit:
                    script:
                    - narrate format:ArcaneForgerFormat "Good luck on your adventures! Visit me again when you need my help."
            click trigger:
                script:
                - narrate format:ArcaneForgerFormat "Okay, here's what I have to offer."
                - wait 1s
                - inventory open d:<inventory[ArcaneForgerInventoryMenu]>

ArcaneForgerInventoryMenu:
    type: inventory
    inventory: chest
    debug: false
#   title: <white><&font[sxrmenus]><&chr[F808]><&chr[E002]><&chr[F801].repeat[177]><&chr[E00E]><&chr[F801].repeat[133]><blue><&font[sxrmenus]><&chr[E004]><&chr[F801].repeat[17]><&chr[E004]><&chr[F801].repeat[89]><light_purple><&font[sxrmenus]><&chr[E00A]><&chr[F801].repeat[17]><&chr[E00A]>
#   temporary title until hiding player inventory works:
    title: <white><&font[sxrmenus]><&chr[F808]><&chr[E002]><&chr[F801].repeat[177]><&chr[E00E]><&chr[F801].repeat[177]><&chr[E01E]><&chr[F801].repeat[133]><blue><&font[sxrmenus]><&chr[E004]><&chr[F801].repeat[17]><&chr[E004]><&chr[F801].repeat[89]><light_purple><&font[sxrmenus]><&chr[E00A]><&chr[F801].repeat[17]><&chr[E00A]>
    size: 45
    slots:
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [VeteranToolForge] [] [VeteranWeaponForge] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [EliteToolForge] [] [EliteWeaponForge] [] [] []

VeteranToolForge:
    type: item
    debug: false
    material: diamond
    display name: <&9>Forge a Veteran Tool
    data:
        lore_list:
        - <&6>Requires <server.flag[VeteranToolForgeCost]> Phantasmal Bones and 1 Sliver of Crystallized Experience.
    enchantments:
    - MENDING:1
    mechanisms:
        hides:
        - attributes
        - enchants
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        custom_model_data: 100001

VeteranWeaponForge:
    type: item
    debug: false
    material: diamond
    display name: <&9>Forge a Veteran Armament
    data:
        lore_list:
        - <&6>Requires <server.flag[VeteranWeaponForgeCost]> Phantasmal Bones and 1 Sliver of Crystallized Experience.
    enchantments:
    - MENDING:1
    mechanisms:
        hides:
        - attributes
        - enchants
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        custom_model_data: 100002

EliteToolForge:
    type: item
    debug: false
    material: diamond
    display name: <&d>Forge an Elite Tool
    data:
        lore_list:
        - <&6>Requires <server.flag[EliteToolForgeCost]> Phantasmal Bones and 1 Chunk of Crystallized Experience.
    enchantments:
    - MENDING:1
    mechanisms:
        hides:
        - attributes
        - enchants
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        custom_model_data: 100003

EliteWeaponForge:
    type: item
    debug: false
    material: diamond
    display name: <&d>Forge an Elite Armament
    data:
        lore_list:
        - <&6>Requires <server.flag[EliteWeaponForgeCost]> Phantasmal Bones and 1 Chunk of Crystallized Experience.
    enchantments:
    - MENDING:1
    mechanisms:
        hides:
        - attributes
        - enchants
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        custom_model_data: 100004

ArcaneForgerInventoryHandler:
    type: world
    debug: false
    events:
        on server start:
        - flag server VeteranToolForgeCost:150
        - flag server VeteranWeaponForgeCost:200
        - flag server EliteToolForgeCost:900
        - flag server EliteWeaponForgeCost:1200
        on player clicks in ArcaneForgerInventoryMenu priority:100:
        - determine cancelled
        on player drags in ArcaneForgerInventoryMenu priority:100:
        - determine cancelled
        on player clicks VeteranToolForge in ArcaneForgerInventoryMenu:
        - determine passively cancelled
        - wait 1t
        - inventory close
#        - narrate format:ArcaneForgerFormat "You clicked the Veteran Tool Forge option!"
        - announce to_console <player.inventory.list_contents>
        - if <player.inventory.contains_item[VeteranToken].quantity[<server.flag[VeteranToolForgeCost]>]> && <player.inventory.contains_item[CrystallizedExperienceSliver].quantity[1]>:
#            - narrate format:ArcaneForgerFormat "You have enough bones for a special magic doodad!"
            - take scriptname:VeteranToken quantity:<server.flag[VeteranToolForgeCost]>
            - take scriptname:CrystallizedExperienceSliver quantity:1
            - random:
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive an <&9>Imbued Axe<&f>!"
                    - announce to_console "<player.name> received an Imbued Axe"
                    - give <mythic_item[ImbuedAxe]> quantity:1
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive an <&9>Imbued Pickaxe<&f>!"
                    - announce to_console "<player.name> received an Imbued Pickaxe"
                    - give <mythic_item[ImbuedPickaxe]> quantity:1
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive an <&9>Imbued Shovel<&f>!"
                    - announce to_console "<player.name> received an Imbued Shovel"
                    - give <mythic_item[ImbuedShovel]> quantity:1
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive an <&9>Imbued Hoe<&f>!"
                    - announce to_console "<player.name> received an Imbued Hoe"
                    - give <mythic_item[ImbuedHoe]> quantity:1
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive an <&9>Imbued Fishing Rod<&f>!"
                    - announce to_console "<player.name> received an Imbued Fishing Rod"
                    - give <mythic_item[ImbuedFishingRod]> quantity:1
        - else:
            - narrate format:ArcaneForgerFormat "Sorry, you don't have enough for that!"
        - narrate format:ArcaneForgerFormat "Right click me again if you'd like to choose another option!"
        on player clicks VeteranWeaponForge in ArcaneForgerInventoryMenu:
        - determine passively cancelled
        - wait 1t
        - inventory close
#        - narrate format:ArcaneForgerFormat "You clicked the Veteran Weapon Forge option!"
        - announce to_console <player.inventory.list_contents>
        - if <player.inventory.contains_item[VeteranToken].quantity[<server.flag[VeteranWeaponForgeCost]>]> && <player.inventory.contains_item[CrystallizedExperienceSliver].quantity[1]>:
#            - narrate format:ArcaneForgerFormat "You have enough bones for a special magic doodad!"
            - take scriptname:VeteranToken quantity:<server.flag[VeteranWeaponForgeCost]>
            - take scriptname:CrystallizedExperienceSliver quantity:1
            - random:
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive an <&9>Imbued Sword<&f>!"
                    - announce to_console "<player.name> received an Imbued Sword"
                    - give <mythic_item[ImbuedSword]> quantity:1
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive an <&9>Imbued Bow<&f>!"
                    - announce to_console "<player.name> received an Imbued Bow"
                    - give <mythic_item[ImbuedBow]> quantity:1
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive an <&9>Imbued Shield<&f>!"
                    - announce to_console "<player.name> received an Imbued Shield"
                    - give <mythic_item[ImbuedShield]> quantity:1
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive an <&9>Imbued Helm<&f>!"
                    - announce to_console "<player.name> received an Imbued Helm"
                    - give <mythic_item[ImbuedHelm]> quantity:1
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive an <&9>Imbued Chestplate<&f>!"
                    - announce to_console "<player.name> received an Imbued Chestplate"
                    - give <mythic_item[ImbuedChest]> quantity:1
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive a pair of <&9>Imbued Leggings<&f>!"
                    - announce to_console "<player.name> received Imbued Leggings"
                    - give <mythic_item[ImbuedLegs]> quantity:1
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive a pair of <&9>Imbued Boots<&f>!"
                    - announce to_console "<player.name> received Imbued Boots"
                    - give <mythic_item[ImbuedBoots]> quantity:1
        - else:
            - narrate format:ArcaneForgerFormat "Sorry, you don't have enough for that!"
        - narrate format:ArcaneForgerFormat "Right click me again if you'd like to choose another option!"
        on player clicks EliteToolForge in ArcaneForgerInventoryMenu:
        - determine passively cancelled
        - wait 1t
        - inventory close
#        - narrate format:ArcaneForgerFormat "You clicked the Elite Tool Forge option!"
        - if <player.inventory.contains_item[VeteranToken].quantity[<server.flag[EliteToolForgeCost]>]> && <player.inventory.contains_item[CrystallizedExperienceChunk].quantity[1]>:
#            - narrate format:ArcaneForgerFormat "You have enough bones for a special magic doodad!"
            - take scriptname:VeteranToken quantity:<server.flag[EliteToolForgeCost]>
            - take scriptname:CrystallizedExperienceChunk quantity:1
            - random:
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive a <&d>Burnished Axe<&f>!"
                    - announce to_console "<player.name> received a Burnished Axe"
                    - give <mythic_item[BurnishedAxe]> quantity:1
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive a <&d>Burnished Pickaxe<&f>!"
                    - announce to_console "<player.name> received a Burnished Pickaxe"
                    - give <mythic_item[BurnishedPickaxe]> quantity:1
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive a <&d>Burnished Shovel<&f>!"
                    - announce to_console "<player.name> received a Burnished Shovel"
                    - give <mythic_item[BurnishedShovel]> quantity:1
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive a <&d>Burnished Hoe<&f>!"
                    - announce to_console "<player.name> received a Burnished Hoe"
                    - give <mythic_item[BurnishedHoe]> quantity:1
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive a <&d>Burnished Fishing Rod<&f>!"
                    - announce to_console "<player.name> received a Burnished Fishing Rod"
                    - give <mythic_item[BurnishedFishingRod]> quantity:1
        - else:
            - narrate format:ArcaneForgerFormat "Sorry, you don't have enough for that!"
        - narrate format:ArcaneForgerFormat "Right click me again if you'd like to choose another option!"
        on player clicks EliteWeaponForge in ArcaneForgerInventoryMenu:
        - determine passively cancelled
        - wait 1t
        - inventory close
#        - narrate format:ArcaneForgerFormat "You clicked the Elite Weapon Forge option!"
        - if <player.inventory.contains_item[VeteranToken].quantity[<server.flag[EliteWeaponForgeCost]>]> && <player.inventory.contains_item[CrystallizedExperienceChunk].quantity[1]>:
#            - narrate format:ArcaneForgerFormat "You have enough bones for a special magic doodad!"
            - take scriptname:VeteranToken quantity:<server.flag[EliteWeaponForgeCost]>
            - take scriptname:CrystallizedExperienceChunk quantity:1
            - random:
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive a <&d>Burnished Sword<&f>!"
                    - announce to_console "<player.name> received a Burnished Sword"
                    - give <mythic_item[BurnishedSword]> quantity:1
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive a <&d>Burnished Bow<&f>!"
                    - announce to_console "<player.name> received a Burnished Bow"
                    - give <mythic_item[BurnishedBow]> quantity:1
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive a <&d>Burnished Shield<&f>!"
                    - announce to_console "<player.name> received a Burnished Shield"
                    - give <mythic_item[BurnishedShield]> quantity:1
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive a <&d>Burnished Helm<&f>!"
                    - announce to_console "<player.name> received a Burnished Helm"
                    - give <mythic_item[BurnishedHelm]> quantity:1
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive a <&d>Burnished Chestplate<&f>!"
                    - announce to_console "<player.name> received a Burnished Chestplate"
                    - give <mythic_item[BurnishedChest]> quantity:1
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive a pair of <&d>Burnished Leggings<&f>!"
                    - announce to_console "<player.name> received a Burnished Leggings"
                    - give <mythic_item[BurnishedLegs]> quantity:1
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive a pair of <&d>Burnished Boots<&f>!"
                    - announce to_console "<player.name> received a Burnished Boots"
                    - give <mythic_item[BurnishedBoots]> quantity:1
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive a <&d>Bountiful Blade<&f>!"
                    - announce to_console "<player.name> received a Bountiful Blade"
                    - give <mythic_item[BountifulBlade]> quantity:1
                - repeat 1:
                    - narrate format:ArcaneForgerFormat "The magics coalesce... and you receive a <&d>Withering Blade<&f>!"
                    - announce to_console "<player.name> received a Withering Blade"
                    - give <mythic_item[WitheringBlade]> quantity:1
        - else:
            - narrate format:ArcaneForgerFormat "Sorry, you don't have enough for that!"
        - narrate format:ArcaneForgerFormat "Right click me again if you'd like to choose another option!"