#Needs_Updating

Super_YAML_Handler:
    type: world
    events:
        on server start:
        - yaml create id:super-counter
        on shutdown:
        - yaml unload id:super-counter

super_reset_on_equip:
    type: world
    debug: false
    events:
        on player equips chestplate:
        - if <context.new_item.nbt[item_tier]||null> == legendary:
            - yaml id:super-counter set energy.<player.uuid>:0
            - yaml id:super-counter set super-ready.<player.uuid>:0
            - yaml id:super-counter set super-activated.<player.uuid>:0
#            - narrate "Super energy reset"
#            - narrate "Super energy is <yaml[super-counter].read[energy.<player.uuid>]>"

Super_Enable_On_Login:
    type: world
    debug: false
    events:
        on player joins:
        - wait 20t
        - if <player.equipment_map.get[chestplate].nbt[item_tier]||null> == legendary:
            - wait 100t
            - yaml id:super-counter set energy.<player.uuid>:0
            - bossbar create super-bar.<player.uuid> players:<player> "title:Super Energy" progress:0 color:BLUE style:SEGMENTED_10
            - yaml id:super-counter set super-ready.<player.uuid>:0
            - yaml id:super-counter set super-activated.<player.uuid>:0
#            - narrate "Super energy reset"
#            - narrate "Super energy is <yaml[super-counter].read[energy.<player.uuid>]>"
        on player quits:
        - if <player.equipment_map.get[chestplate].nbt[item_tier]> == legendary:
            - bossbar remove super-bar.<player.uuid>

Damage_Super_Charge:
    type: world
    debug: false
    events:
        on player damages entity:
        - if <context.damager.equipment_map.get[chestplate].nbt[item_tier]||null> == legendary:
            - if <yaml[super-counter].read[super-activated.<player.uuid>]> == 0:
                - if <yaml[super-counter].read[energy.<player.uuid>]||0> < 300:
#                    - narrate "Damage logged as <context.final_damage>"
#                    - narrate "Super energy calculated as <context.final_damage.div[5.0].add[<yaml[super-counter].read[energy.<player.uuid>]||0>]>"
                    - yaml id:super-counter set energy.<player.uuid>:<context.final_damage.div[5.0].add[<yaml[super-counter].read[energy.<player.uuid>]||0>]>
#                    - narrate "Super energy is <yaml[super-counter].read[energy.<player.uuid>]>"
#                    - narrate "Bossbar updated to <yaml[super-counter].read[energy.<player.uuid>].div[300.0]>"
                    - bossbar update super-bar.<player.uuid> "title:Super Energy" progress:<yaml[super-counter].read[energy.<player.uuid>].div[300.0]>

                - if <yaml[super-counter].read[energy.<player.uuid>]||0> > 300:
                    - yaml id:super-counter set energy.<player.uuid>:300
                    - bossbar update super-bar.<player.uuid> "title:<yellow>SUPER CHARGED!" progress:1.0 color:YELLOW style:SOLID
                    - title "title:<yellow>SUPER CHARGED!" fade_in:1s stay:2s fade_out:1s targets:<player>
                    - yaml id:super-counter set super-ready.<player.uuid>:1
                    - yaml id:super-counter set super-activated.<player.uuid>:0

                - if <yaml[super-counter].read[energy.<player.uuid>]||0> == 300:
                    - yaml id:super-counter set energy.<player.uuid>:300
                    - bossbar update super-bar.<player.uuid> "title:<yellow>SUPER CHARGED!" progress:1.0 color:YELLOW style:SOLID
                    - yaml id:super-counter set super-ready.<player.uuid>:1
                    - yaml id:super-counter set super-activated.<player.uuid>:0

super_bossbar:
    type: world
    debug: false
    events:
        on player equips chestplate:
        - if <context.new_item.nbt[item_tier]||null> == legendary:
            - bossbar create super-bar.<player.uuid> players:<player> "title:Super Energy" progress:0.0 color:BLUE style:SEGMENTED_10
        on player unequips chestplate:
        - if <context.new_item.nbt[item_tier]||null> == legendary:
            - bossbar remove super-bar.<player.uuid>

super_conditions:
    type: world
    debug: false
    events:
        on mm denizen condition:
            - if <context.condition> == super-charged:
                - if <yaml[super-counter].read[super-ready.<context.entity.uuid>]||0> < 1:
                    - determine false
            - if <context.condition> == super-activated:
                - if <yaml[super-counter].read[super-activated.<context.entity.uuid>]||0> == 0:
                    - determine false
            - if <context.condition> == super-energy-remaining:
                - if <yaml[super-counter].read[energy.<context.entity.uuid>]||0> < 1:
                    - determine false

super_activtion_mechanic:
    type: world
    debug: false
    events:
        on mm denizen mechanic:
            - if <context.skill> == super-activate:
                - if <yaml[super-counter].read[super-activated.<context.caster.uuid>]> == 0:
#                    - announce to_console "Super activation event running"
                    - bossbar update super-bar.<context.caster.uuid> "title:<yellow>SUPER ACTIVE!"
                    - title "title:<yellow>SUPER ACTIVATED!" fade_in:1s stay:2s fade_out:1s targets:<context.caster>
                    - yaml id:super-counter set super-activated.<context.caster.uuid>:1
                    - if <yaml[super-counter].read[energy.<context.caster.uuid>]> < 1:
#                        - announce to_console "Super energy less than one, resetting"
                        - bossbar update super-bar.<context.caster.uuid> "title:Super Energy" progress:0.0 color:BLUE style:SEGMENTED_10
                        - yaml id:super-counter set energy.<context.caster.uuid>:0
                        - yaml id:super-counter set super-ready.<context.caster.uuid>:0
                        - yaml id:super-counter set super-activated.<context.caster.uuid>:0
                    - while <yaml[super-counter].read[energy.<context.caster.uuid>].is[more].than[0]>:
#                        - announce to_console "While loop run"
                        - playeffect <context.caster.location> effect:ENCHANTMENT_TABLE visibility:500 quantity:40 offset:1,1,1 data:5
                        - bossbar update super-bar.<context.caster.uuid> "title:<yellow>SUPER ACTIVE!" progress:<yaml[super-counter].read[energy.<context.caster.uuid>].div[300.0]>
                        - yaml id:super-counter set energy.<context.caster.uuid>:<yaml[super-counter].read[energy.<context.caster.uuid>].sub[1.0]>
                        - if <yaml[super-counter].read[energy.<context.caster.uuid>]> < 1:
#                            - announce to_console "Super energy less than one in while loop, resetting"
                            - bossbar update super-bar.<context.caster.uuid> "title:Super Energy" progress:0.0 color:BLUE style:SEGMENTED_10
                            - yaml id:super-counter set energy.<context.caster.uuid>:0
                            - yaml id:super-counter set super-ready.<context.caster.uuid>:0
                            - yaml id:super-counter set super-activated.<context.caster.uuid>:0
                        - wait 5t
                - if <yaml[super-counter].read[energy.<context.caster.uuid>]> < 1:
#                    - announce to_console "Super energy less than one, resetting"
                    - bossbar update super-bar.<context.caster.uuid> "title:Super Energy" progress:0.0 color:BLUE style:SEGMENTED_10
                    - yaml id:super-counter set energy.<context.caster.uuid>:0
                    - yaml id:super-counter set super-ready.<context.caster.uuid>:0
                    - yaml id:super-counter set super-activated.<context.caster.uuid>:0
            - if <context.skill> == super-swing:
                - yaml id:super-counter set energy.<context.caster.uuid>:<yaml[super-counter].read[energy.<context.caster.uuid>].sub[<context.args>]>