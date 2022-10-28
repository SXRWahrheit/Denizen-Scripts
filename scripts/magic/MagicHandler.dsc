# Use with PAPI placeholders of the relevant magic type e.g. %denizen_<proc[Magic_Power_Handler].context[fire]>%
Magic_Power_Handler:
    type: procedure
    debug: false
    definitions: magic_type
    script:
    - define set_list <player.equipment.parse[nbt[armor_set]||null].deduplicate>
    - if <[set_list]> == <list[null]>:
        - define set_list <list[]>
    - if <[set_list].is_empty> && !<player.has_flag[<[magic_type]>_magic_power]>:
        - define power <player.equipment.parse[nbt[<[magic_type]>_magic_power]||0].sum.add[100]>
    - else:
        - define power <player.equipment.parse[nbt[<[magic_type]>_magic_power]||0].sum.add[<player.flag[<[magic_type]>_magic_power]||0>].add[100]>
    - if !<[set_list].is_empty>:
        - define power <[power].add[<proc[<[value]>_armor_set_bonuses].context[<player.equipment.parse[nbt[armor_set]].filter[matches[<[value]>]].size>]>]>
    - determine <[power]>

    ## Use this to get all of the magic powers for some reason
    ## Not sure what to do with it but I scripted it so I might as well keep it
    #- foreach <player.equipment>:
    #    - define equipment <[value]>
    #    - foreach <[equipment].nbt_keys.filter[matches[[a-zA-Z]+_magic_power]]>:
    #        - define power <[equipment].nbt_keys.filter[matches[[a-zA-Z]+_magic_power]].get[<[loop_index]>]>
    #        - define <[power]> <[power].add[<[equipment].nbt[<[power]>]>||0]>
    #    - define set_list <[set_list].include[<[value].nbt[armor_set]>]>
    #- foreach <[set_list].deduplicated>:
    #    - define fire_magic_power <[fire_magic_power].add[<proc[<[value]>_armor_set_bonuses].context[<[set_list].find_all[<[value]>].size>]>

Spell_Loader:
    type: world
    debug: false
    events:
        on server start:
        - yaml load:../MagicSpells/spells-elemental.yml id:spells-elemental

#Spell_Power_Handler:
#    type: world
#    debug: false
#    events:
#        on magicspells player casts spell:
#        - if <yaml[spells-elemental].read[<context.spell>.spell-magic-type]||null> == null:
#            - stop
#        - else:
#            - determine power:<proc[Magic_Power_Handler].context[<yaml[spells-elemental].read[<context.spell>.spell-magic-type]>]||1>