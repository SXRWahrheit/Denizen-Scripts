ArchArtificerAssignment:
    type: assignment
    debug: false
    interact scripts:
    - Artificing
    actions:
        on assignment:
        - trigger name:proximity toggle:true
        - trigger name:chat toggle:true

ArchArtificerFormat:
    type: format
    debug: false
    format: "<dark_green>Arch Artificer<white><&co> <[text]>"

CrystallizedExperienceSliver:
    type: item
    debug: false
    material: emerald
    display name: <&a>Sliver of Crystallized Experience
    data:
        lore_list:
        - <&6>The Arch Artificer Created this by crystallizing a small number of levels.
    enchantments:
    - MENDING:1
    flags:
        experiencecrystal: sliver
        uncraftable: true
    mechanisms:
        hides:
        - enchants
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        custom_model_data: 100004

CrystallizedExperienceChunk:
    type: item
    debug: false
    material: emerald
    display name: <&a>Chunk of Crystallized Experience
    data:
        lore_list:
        - <&6>The Arch Artificer Created this by crystallizing a fair number of levels.
    enchantments:
    - MENDING:1
    flags:
        experiencecrystal: chunk
        uncraftable: true
    mechanisms:
        hides:
        - enchants
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        custom_model_data: 100005

CrystallizedExperienceBillet:
    type: item
    debug: false
    material: emerald
    display name: <&a>Billet of Crystallized Experience
    data:
        lore_list:
        - <&6>The Arch Artificer Created this by crystallizing a sizable number of levels.
    enchantments:
    - MENDING:1
    flags:
        experiencecrystal: billet
        uncraftable: true
    mechanisms:
        hides:
        - enchants
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        custom_model_data: 100006

CrystallizedExperienceBloom:
    type: item
    debug: false
    material: emerald
    display name: <&a>Bloom of Crystallized Experience
    data:
        lore_list:
        - <&6>The Arch Artificer Created this by crystallizing a large number of levels.
    enchantments:
    - MENDING:1
    flags:
        experiencecrystal: bloom
        uncraftable: true
    mechanisms:
        hides:
        - enchants
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        custom_model_data: 100007

CrystallizedExperienceIngot:
    type: item
    debug: false
    material: emerald
    display name: <&a>Ingot of Crystallized Experience
    data:
        lore_list:
        - <&6>The Arch Artificer Created this by crystallizing a tremendous number of levels.
    enchantments:
    - MENDING:1
    flags:
        experiencecrystal: ingot
        uncraftable: true
    mechanisms:
        hides:
        - enchants
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        custom_model_data: 100008

ArtificingInventory:
    type: inventory
    inventory: chest
    debug: false
#   title: <white><&font[sxrmenus]><&chr[F808]><&chr[E002]><&chr[F801].repeat[177]><&chr[E00F]>
#   temporary title until hiding player inventory works:
    title: <white><&font[sxrmenus]><&chr[F808]><&chr[E002]><&chr[F801].repeat[177]><&chr[E00F]><&chr[F801].repeat[177]><&chr[E01E]>
    size: 45
    slots:
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [ArtificingSliver] [] [ArtificingChunk] [] [ArtificingBillet] [] [ArtificingBloom] [] [ArtificingIngot]
    - [] [] [] [] [] [] [] [] []

ArtificingSliver:
    type: item
    debug: false
    material: emerald
    display name: <&a>Sliver of Crystallized Experience
    data:
        lore_list:
        - <&6>Craft a <&a>Sliver of Crystallized Experience
        - <&6>Costs 30 levels
    enchantments:
    - MENDING:1
    flags:
        experiencecrystal: sliver
        uncraftable: true
    mechanisms:
        hides:
        - enchants
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        custom_model_data: 100004

ArtificingChunk:
    type: item
    debug: false
    material: emerald
    display name: <&a>Chunk of Crystallized Experience
    data:
        lore_list:
        - <&6>Craft a <&a>Chunk of Crystallized Experience
        - <&6>Costs 50 levels
    enchantments:
    - MENDING:1
    flags:
        experiencecrystal: chunk
        uncraftable: true
    mechanisms:
        hides:
        - enchants
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        custom_model_data: 100005

ArtificingBillet:
    type: item
    debug: false
    material: emerald
    display name: <&a>Billet of Crystallized Experience
    data:
        lore_list:
        - <&6>Craft a <&a>Billet of Crystallized Experience
        - <&6>Costs 70 levels
    enchantments:
    - MENDING:1
    flags:
        experiencecrystal: billet
        uncraftable: true
    mechanisms:
        hides:
        - enchants
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        custom_model_data: 100006

ArtificingBloom:
    type: item
    debug: false
    material: emerald
    display name: <&a>Bloom of Crystallized Experience
    data:
        lore_list:
        - <&6>Craft a <&a>Bloom of Crystallized Experience
        - <&6>Costs 90 levels
    enchantments:
    - MENDING:1
    flags:
        experiencecrystal: bloom
        uncraftable: true
    mechanisms:
        hides:
        - enchants
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        custom_model_data: 100007

ArtificingIngot:
    type: item
    debug: false
    material: emerald
    display name: <&a>Ingot of Crystallized Experience
    data:
        lore_list:
        - <&6>Craft an <&a>Ingot of Crystallized Experience
        - <&6>Costs 110 levels
    enchantments:
    - MENDING:1
    flags:
        experiencecrystal: ingot
        uncraftable: true
    mechanisms:
        hides:
        - enchants
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        custom_model_data: 100008

ArtificingInventoryHandler:
    type: world
    debug: false
    events:
        on player clicks in ArtificingInventory priority:100:
        - determine cancelled
        on player drags in ArtifciingInventory priority:100:
        - determine cancelled
        on player clicks ArtificingSliver in ArtificingInventory:
        - determine passively cancelled
        - wait 1t
        - if <player.xp.level> >= 30:
            - narrate format:ArchArtificerFormat "Sure thing, here you go!"
            - give CrystallizedExperienceSliver quantity:1
            #- execute as_server "xp -30l <player.name>"
            - experience take level 30
            - inventory close
        - else:
            - narrate format:ArchArtificerFormat "Sorry, you don't seem to have enough levels! Come back when you've got at least 30."
        on player clicks ArtificingChunk in ArtificingInventory:
        - determine passively cancelled
        - wait 1t
        - if <player.xp.level> >= 50:
            - narrate format:ArchArtificerFormat "Sure thing, here you go!"
            - give CrystallizedExperienceChunk quantity:1
            #- execute as_server "xp -50l <player.name>"
            - experience take level 50
            - inventory close
        - else:
            - narrate format:ArchArtificerFormat "Sorry, you don't seem to have enough levels! Come back when you've got at least 50."
        on player clicks ArtificingBillet in ArtificingInventory:
        - determine passively cancelled
        - wait 1t
        - if <player.xp.level> >= 70:
            - narrate format:ArchArtificerFormat "Sure thing, here you go!"
            - give CrystallizedExperienceBillet quantity:1
            #- execute as_server "xp -70l <player.name>"
            - experience take level 70
            - inventory close
        - else:
            - narrate format:ArchArtificerFormat "Sorry, you don't seem to have enough levels! Come back when you've got at least 70."
        on player clicks ArtificingBloom in ArtificingInventory:
        - determine passively cancelled
        - wait 1t
        - if <player.xp.level> >= 90:
            - narrate format:ArchArtificerFormat "Sure thing, here you go!"
            - give CrystallizedExperienceBloom quantity:1
            #- execute as_server "xp -90l <player.name>"
            - experience take level 90
            - inventory close
        - else:
            - narrate format:ArchArtificerFormat "Sorry, you don't seem to have enough levels! Come back when you've got at least 90."
        on player clicks ArtificingIngot in ArtificingInventory:
        - determine passively cancelled
        - wait 1t
        - if <player.xp.level> >= 110:
            - narrate format:ArchArtificerFormat "Sure thing, here you go!"
            - give CrystallizedExperienceIngot quantity:1
            #- execute as_server "xp -110l <player.name>"
            - experience take level 110
            - inventory close
        - else:
            - inventory close
            - narrate format:ArchArtificerFormat "Sorry, you don't seem to have enough levels! Come back when you've got at least 110."
Artificing:
    type: interact
    debug: false
    steps:
        "Player Seen*":
            proximity trigger:
                entry:
                    script:
                    - narrate format:ArchArtificerFormat "Hello, adventurer! What can I help you with?"
                    - narrate format:ArchArtificerFormat "I can take all of that magical experience you've earned from slaying monsters and crystallize it."
                    - narrate "<gray>Right-click the Arch Artificer to view crystallization options!"
                exit:
                    script:
                    - narrate format:ArchArtificerFormat "See you again, and good hunting!"
            click trigger:
                script:
                - inventory open d:ArtificingInventory