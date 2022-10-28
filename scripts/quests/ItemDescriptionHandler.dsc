#    - if <[InProgress]>:
#        - narrate format:StoicSageFormat <proc[ItemDescriptionHandler_Spells].context[<[delivery_item]>]>


ItemDescriptionHandler_Spells:
    debug: false
    type: procedure
    definitions: item
    script:
    - choose <[item]>:
        - case redstone:
            - random:
                - determine "Thanks for the redstone! As I'm sure you know, it's quite important for magical endeavors."
        - case gold_ingot:
            - random:
                - determine "Gold ingots help concentrate magical power. You can mine gold from the ground, of course, or scavenge bits of gold from the corpses of zombie pigmen in the Nether."
        - case diamond:
            - random:
                - determine "Diamonds are rare, of course, but there's very little that's better at concentrating magical energy."
        - case arrow:
            - random:
                - determine "Arrows are an essential element for projectile magic. Having a hard time finding some? Go skeleton hunting!"
        - case glowstone:
            - random:
                - determine "Glowstone will help you capture the radiance of its light."
        - case oak_sapling:
            - random:
                - determine "Oak saplings are chock full of nature magic!"
        - case raw_fish:
            - random:
                - determine "Gone fishing, have you? Those fish will be useful for manipulating water magic."
        - case ender_pearl:
            - random:
                - determine "Ender pearls are filled with spacial magic. If you can't find enough endermen in Prosperus, you can head to The End, but beware - there are more Veterans and Elites there!"
        - case feather:
            - random:
                - determine "Feathers are lightweight, but they have quite the variety of magical properties!"
        - case soul_sand:
            - random:
                - determine "Soul sand's inherent properties help us channel magic that will slow your enemies."
        - case fermented_spider_eye:
            - random:
                - determine "Fermented spider eyes take a little bit of work to produce, but they're tremendous magical reagents."
        - case chorus_fruit:
            - random:
                - determine "Chorus fruit takes a considerable amount of effort to farm, and of course you have to get some from The End to even farm it in the first place. Good on you for managing to get some!"
        - case prismarine_crystals:
            - random:
                - determine "Prismarine crystals may look harmless, but they are absolutely overflowing with magical energy."
        - case brick:
            - random:
                - determine "Those brick blocks will help channel the magic to hold your enemies in place."
        - case blaze_rod:
            - random:
                - determine "Blaze rods, as you might suspect, are absolutely brimming with fire magic!"
        - case ghast_tear:
            - random:
                - determine "Those ghast tears are hard to come by. Be sure to wait until a ghast is over land before you shoot it out of the sky!"
        - case magma_cream:
            - random:
                - determine "Magma cream contains the magical essence we need to confuse those monsters. Thankfully, it's quite plentiful!"
        - case ice:
            - random:
                - determine "Ice is an essential element of all frost magic. Remember, you need a Silk Touch pickaxe to gather it!"
        - case fireball:
            - random:
                - determine "Fire charges are a specialized reagent for fire magic. They're particularly useful for projectile spells!"
        - case seeds:
            - random:
                - determine "Just like you plant seeds in the ground, using seeds as magical reagents is helpful for growth spells."
        - case iron_ingot:
            - random:
                - determine "Iron ingots are versatile. They can be used to channel magic for hardiness in many forms!"
        - case granite:
            - random:
                - determine "Granite is beautiful and strong all at once. We can pull that essence out of it to teach you some incredible spells!"
        - case rabbit_foot:
            - random:
                - determine "Rabbits' feet are full of luck. It takes a little skill - and a little luck yourself - to use them as reagents."
        - case totem:
            - random:
                - determine "Totems of Undying let you cheat death on their own, sure, but did you know we can use them for spells, too? They're hard to come by, but the spells you can learn if you gather them are worth it."
        - case string:
            - random:
                - determine "String can be used to do all sorts of interesting things with magic. Binding things up, bringing things together... really, it's about how clever you can be!"

ItemDescriptionHandler_Gathering:
    debug: false
    type: procedure
    definitions: item
    script:
    - choose <[item]>:
        - case carrot:
            - random:
                - determine "Thank you!"
                - determine "Carrots really are quite wonderful. I hear that eating them improves your vision! Really, I just like the crunch."
                - determine "Keep up the good work, these will make great healthy snacks for the city's children!"
        - case potato:
            - random:
                - determine "Thank you!"
                - determine "Potatoes are such a useful food! They can be made into all sorts of lovely dishes."
                - determine "I think we'll use these to make a big batch of mashed potatoes!"
        - case wheat:
            - random:
                - determine "Thank you!"
                - determine "This sure will help us make a lot of bread!"
                - determine "Have you tried your hand at baking yet? The results can be so scrumptious!"
        - case pumpkin:
            - random:
                - determine "Thank you!"