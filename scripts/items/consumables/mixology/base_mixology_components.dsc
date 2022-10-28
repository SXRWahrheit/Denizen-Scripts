
# Reference links

# http://www.madehow.com/Volume-5/Vodka.html

# Refinement components

yeast:
    type: item
    debug: false
    display name: Yeast
    material: yellow_dye
    flags:
        crafting_type: mixology
malt_meal:
    type: item
    debug: false
    display name: Malt meal
    material: brown_dye
    flags:
        crafting_type: mixology
sugar_cane_juice:
    type: item
    debug: false
    display name: Sugar cane juice
    material: potion
    flags:
        crafting_type: mixology
    mechanisms:
        hides:
        - item_data
molasses:
    type: item
    debug: false
    display name: Molasses
    material: potion
    flags:
        crafting_type: mixology
    mechanisms:
        hides:
        - item_data
juniper:
    type: item
    debug: false
    display name: Juniper
    material: fern
    flags:
        crafting_type: mixology
    mechanisms:
        hides:
        - item_data
angelica:
    type: item
    debug: false
    display name: Angelica
    material: fern
    flags:
        crafting_type: mixology
    mechanisms:
        hides:
        - item_data
coriander:
    type: item
    debug: false
    display name: Coriander
    material: fern
    flags:
        crafting_type: mixology
    mechanisms:
        hides:
        - item_data
agave:
    type: item
    debug: false
    display name: Agave
    material: cactus
    flags:
        crafting_type: mixology
wormwood:
    type: item
    debug: false
    display name: Wormwood
    material: fern
    flags:
        crafting_type: mixology

# Refinement products

pina:
    type: item
    debug: false
    display name: Piña
    material: fern
    flags:
        crafting_type: mixology
    mechanisms:
        hides:
        - item_data
roasted_pina:
    type: item
    debug: false
    display name: Roasted piña
    material: fern
    flags:
        crafting_type: mixology
    mechanisms:
        hides:
        - item_data


# Cocktail components

simple_syrup:
    type: item
    debug: false
    display name: Simple syrup
    material: potion
    flags:
        crafting_type: mixology
    mechanisms:
        hides:
        - item_data

# Spirits

whiskey_bottle:
    type: item
    debug: false
    display name: <white>Bottle of whiskey
    material: honey_bottle
    flags:
        crafting_type: mixology
        alcohol:
            type: spirit
            strength: 2
        empty: whiskey_bottle_empty
    mechanisms:
        hides:
        - item_data
        custom_model_data: 110100

whiskey_bottle_empty:
    type: item
    debug: false
    display name: <white>Empty whiskey bottle
    material: glass_bottle
    flags:
        uncraftable: true
        crafting_type: mixology
    mechanisms:
        hides:
        - item_data
        custom_model_data: 111100

vodka_bottle:
    type: item
    debug: false
    display name: <white>Bottle of vodka
    material: honey_bottle
    flags:
        crafting_type: mixology
        alcohol:
            type: spirit
            strength: 2
        empty: vodka_bottle_empty
    mechanisms:
        hides:
        - item_data
        custom_model_data: 110200

vodka_bottle_empty:
    type: item
    debug: false
    display name: <white>Empty vodka bottle
    material: glass_bottle
    flags:
        uncraftable: true
    mechanisms:
        hides:
        - item_data
        custom_model_data: 111200

white_rum_bottle:
    type: item
    debug: false
    display name: <white>White rum
    material: honey_bottle
    flags:
        crafting_type: mixology
        alcohol:
            type: spirit
            strength: 2
    mechanisms:
        hides:
        - item_data
        custom_model_data: 110300

dark_rum_bottle:
    type: item
    debug: false
    display name: <white>Dark rum
    material: honey_bottle
    flags:
        crafting_type: mixology
        alcohol:
            type: spirit
            strength: 2
    mechanisms:
        hides:
        - item_data
        custom_model_data: 110400

gin_bottle:
    type: item
    debug: false
    display name: Gin
    material: honey_bottle
    flags:
        crafting_type: mixology
        alcohol:
            type: spirit
            strength: 2
    mechanisms:
        hides:
        - item_data
        custom_model_data: 110500

tequila_bottle:
    type: item
    debug: false
    display name: <white>Bottle of tequila
    material: honey_bottle
    flags:
        crafting_type: mixology
        alcohol:
            type: spirit
            strength: 2
        empty: tequila_bottle_empty
    mechanisms:
        hides:
        - item_data
        custom_model_data: 110600

tequila_bottle_empty:
    type: item
    debug: false
    display name: <white>Empty tequila bottle
    material: glass_bottle
    flags:
        uncraftable: true
    mechanisms:
        hides:
        - item_data
        custom_model_data: 111600

malort_bottle:
    type: item
    debug: false
    display name: <white>Malort
    material: honey_bottle
    flags:
        crafting_type: mixology
        alcohol:
            type: spirit
            strength: 2
    mechanisms:
        hides:
        - item_data
        custom_model_data: 110700

# Beer

generic_lager_bottle:
    type: item
    debug: false
    display name: <white>Bottle of lager beer
    material: honey_bottle
    flags:
        alcohol:
            type: beer
            strength: 1
        uncraftable: true
    mechanisms:
        hides:
        - item_data
        custom_model_data: 110800

generic_lager_bottle_empty:
    type: item
    debug: false
    display name: <white>Empty lager bottle
    material: glass_bottle
    flags:
        uncraftable: true
    mechanisms:
        hides:
        - item_data
        custom_model_data: 111800