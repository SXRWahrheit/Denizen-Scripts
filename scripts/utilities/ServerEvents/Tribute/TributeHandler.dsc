Tribute_Task:
    type: task
    debug: false
    script:
    - yaml set id:events tribute.active:false
    - yaml set id:events tribute.mcmmo.rate:1
    - yaml set id:events tribute.mcmmo.progress:0
    - yaml set id:events tribute.drops.rate:1
    - yaml set id:events tribute.drops.progress:0
    - yaml set id:events tribute.experience.rate:1
    - yaml set id:events tribute.experience.progress:0
    - yaml set id:rates drops.active:false
    - yaml set id:rates drops.multiplier:1
    - yaml set id:rates experience.active:false
    - yaml set id:rates experience.multiplier:1
    - yaml id:rates savefile:scriptdata/Rates.yml
    - yaml id:events savefile:scriptdata/Events.yml
    - execute as_server "xprate reset"
    - reload

Tribute_Activate_Task:
    type: task
    debug: false
    script:
    - yaml set id:events tribute.active:true
    - yaml set id:rates drops.active:true
    - yaml set id:rates drops.multiplier:1
    - yaml set id:rates experience.active:true
    - yaml set id:rates experience.multiplier:1
    - yaml id:rates savefile:scriptdata/Rates.yml
    - yaml id:events savefile:scriptdata/Events.yml
    - announce to_console "Reloading scripts"
    - discord id:sxr message channel:191040977652285450 "**Tribute is active! Seek the favor of the Gods and bring Tribute to the Oracle in Dawn's Landing!**"
    - reload

Tribute_Handler:
    type: world
    debug: false
    events:
        on system time hourly:
        # - announce to_console "Tribute Handler system time event run"
        - if <util.time_now.format[EEE]> != Fri && <util.time_now.format[EEE]> != Mon:
            #- announce to_console "Date is not Friday or Monday, Tribute Handler stopping"
            - stop
        - else if <util.time_now.format[EEE]> == Fri:
            # - announce to_console "Date is Friday, Tribute Handler running"
            - if <yaml[events].read[tribute.active]>:
                # - announce to_console "Tribute event already active, Tribute Handler stopping"
                - stop
            - else:
                - announce to_console "Activating Tribute"
                - yaml set id:events tribute.active:true
                - yaml set id:rates drops.active:true
                - yaml set id:rates drops.multiplier:1
                - yaml set id:rates experience.active:true
                - yaml set id:rates experience.multiplier:1
                - yaml id:rates savefile:scriptdata/Rates.yml
                - yaml id:events savefile:scriptdata/Events.yml
                - announce to_console "Reloading scripts"
                - discord id:sxr message channel:191040977652285450 "**Tribute is active! Seek the favor of the Gods and bring Tribute to the Oracle in Dawn's Landing!**"
                - reload
        - else if <util.time_now.format[EEE]> == Mon:
            - if !<yaml[events].read[tribute.active]>:
                - stop
            - else:
                - yaml set id:events tribute.active:false
                - yaml set id:events tribute.mcmmo.rate:1
                - yaml set id:events tribute.mcmmo.progress:0
                - yaml set id:events tribute.drops.rate:1
                - yaml set id:events tribute.drops.progress:0
                - yaml set id:events tribute.experience.rate:1
                - yaml set id:events tribute.experience.progress:0
                - yaml set id:rates drops.active:false
                - yaml set id:rates drops.multiplier:1
                - yaml set id:rates experience.active:false
                - yaml set id:rates experience.multiplier:1
                - yaml id:rates savefile:scriptdata/Rates.yml
                - yaml id:events savefile:scriptdata/Events.yml
                - execute as_server "xprate reset"
                - reload
        on player joins:
        - if <yaml[events].read[tribute.active].not>:
            - stop
        - if <yaml[events].read[tribute.active]>:
            - wait 3s
            - clickable TributeEventExplanation for:<player> save:explanation
            - narrate <element[<&6>The Gods seek your offerings of Tribute! Collect Tribute and deliver it to the <&2>Oracle of the Gods<&6> in the castle in Dawn's Landing!].on_click[<entry[explanation].command>].on_hover[Click for details!]>
            - if <yaml[events].read[tribute.mcmmo.rate]> > 1 || <yaml[events].read[tribute.drops.rate]> > 1 || <yaml[events].read[tribute.experience.rate]> > 1:
                - narrate "<&a>Current blessings:"
                #- narrate "<&a>Blessing of Skillfulness: <&6><yaml[events].read[tribute.mcmmo.rate]>x"
                - narrate "<&a>Blessing of Luck: <&6><yaml[events].read[tribute.drops.rate]>x"
                - narrate "<&a>Blessing of Wisdom: <&6><yaml[events].read[tribute.experience.rate]>x"
        on player receives message:
        - if <context.message.contains_text[mcMMO is currently in an XP rate event]> && <yaml[events].read[tribute.active]>:
            - determine cancelled

Tribute_Power_Hour:
    type: world
    debug: false
    events:
        on system time 19:00:
        - if <util.time_now.format[EEE]> != Fri && <util.time_now.format[EEE]> != Sat && <util.time_now.format[EEE]> != Sun:
            - announce to_console "It's not the weekend, Tribute Power Hour stopping"
            - stop
        - if <server.has_flag[tribute_power_hour]>:
            - stop
        - else:
            - flag server tribute_power_hour:true duration:2h
            - announce "<&a>The Gods present an opportunity to win their favor! For the next two hours, Tribute will appear more often!"
            - discord id:sxr message channel:191040977652285450 "**The Gods present an opportunity to win their favor! For the next two hours, Tribute will appear more often!**"

Tribute_DropTable_Veteran:
    type: world
    debug: false
    events:
        on entity killed by player:
        - if !<yaml[events].read[tribute.active]>:
            - stop
        - if !<context.entity.name.starts_with[<&9>].if_null[null]>:
            - stop
        - if <context.entity.location.is_within[arena_avenfeld]>:
            - stop
        - else if <context.entity.name.starts_with[<&9>].if_null[null]>:
            - if <server.has_flag[tribute_power_hour]>:
                - drop GodsTribute location:<context.entity.location> quantity:<util.random.int[1].to[2]>
            - else:
                - drop GodsTribute location:<context.entity.location> quantity:<util.random.int[1].to[1]>

Tribute_DropTable_Elite:
    type: world
    debug: false
    events:
        on entity killed by player:
        - if !<yaml[events].read[tribute.active]>:
            - stop
        - if !<context.entity.name.starts_with[<&d>].if_null[null]>:
            - stop
        - if <context.entity.location.is_within[arena_avenfeld]>:
            - stop
        - else if <context.entity.name.starts_with[<&d>].if_null[null]>:
            - if <server.has_flag[tribute_power_hour]>:
                - drop GodsTribute location:<context.entity.location> quantity:<util.random.int[1].to[4]>
            - else:
                - drop GodsTribute location:<context.entity.location> quantity:<util.random.int[1].to[2]>

Tribute_Drops_Mining:
    type: world
    debug: false
    events:
        on player breaks block with:*_pickaxe:
        - if !<yaml[events].read[tribute.active]>:
            - stop
        - if !<yaml[mining].read[materials].contains[<context.material.name>]>:
            - stop
        - if <util.random.int[1].to[500]> <= 1:
            - announce to_console "Tribute drop for <player.name> caused by gaining mining exp"
            - if <server.has_flag[tribute_power_hour]>:
                - give GodsTribute quantity:2
            - else:
                - give GodsTribute
            - narrate "<&a>You found a Tribute to the Gods!"

Tribute_Drops_Harvesting:
    type: world
    debug: false
    events:
        on player breaks block:
        - if !<yaml[events].read[tribute.active]>:
            - stop
        - if !<yaml[harvesting].read[materials].contains[<context.material.name>]>:
            - stop
        - if <context.material.age||0> != <context.material.maximum_age.if_null[null]>:
            - stop
        - if <util.random.int[1].to[200]> <= 1:
            - announce to_console "Tribute drop for <player.name> caused by gaining harvesting exp"
            - if <server.has_flag[tribute_power_hour]>:
                - give GodsTribute quantity:2
            - else:
                - give GodsTribute
            - narrate "<&a>You found a Tribute to the Gods!"

Tribute_Drops_Foraging:
    type: world
    debug: false
    events:
        on player breaks block:
        - if !<yaml[events].read[tribute.active]>:
            - stop
        - if !<yaml[foraging].read[materials].contains[<context.material.name>]>:
            - stop
        - if <context.material.age||0> != <context.material.maximum_age.if_null[null]>:
            - stop
        - if <util.random.int[1].to[200]> <= 1:
            - announce to_console "Tribute drop for <player.name> caused by gaining foraging exp"
            - if <server.has_flag[tribute_power_hour]>:
                - give GodsTribute quantity:2
            - else:
                - give GodsTribute
            - narrate "<&a>You found a Tribute to the Gods!"

Tribute_Drops_Fishing:
    type: world
    debug: false
    events:
        on player fishes while caught_fish:
        - if !<yaml[events].read[tribute.active]>:
            - stop
        - if <util.random.int[1].to[30]> <= 1:
            - announce to_console "Tribute drop for <player.name> caused by gaining fishing exp"
            - if <server.has_flag[tribute_power_hour]>:
                - give GodsTribute quantity:2
            - else:
                - give GodsTribute
            - narrate "<&a>You found a Tribute to the Gods!"

Tribute_Drops_Lumberjacking:
    type: world
    debug: false
    events:
        on player breaks block with:*_axe:
        - if !<yaml[events].read[tribute.active]>:
            - stop
        - if !<yaml[lumberjacking].read[materials].contains[<context.material.name>]>:
            - stop
        - if <util.random.int[1].to[100]> <= 1:
            - announce to_console "Tribute drop for <player.name> caused by gaining woodcutting exp"
            - if <server.has_flag[tribute_power_hour]>:
                - give GodsTribute quantity:2
            - else:
                - give GodsTribute
            - narrate "<&a>You found a Tribute to the Gods!"

#Tribute_Drops_Digging:
#    type: world
#    debug: false
#    events:
#        on player breaks block with:*_shovel:
#        - if !<yaml[events].read[tribute.active]>:
#            - stop
#        - if !<yaml[digging].read[materials].contains[<context.material.name>]>:
#            - stop
#        - if <util.random.int[1].to[500]> <= 1:
#            - announce to_console "Tribute drop for <player.name> caused by gaining digging exp"
#            - if <server.has_flag[tribute_power_hour]>:
#                - give GodsTribute quantity:2
#            - else:
#                - give GodsTribute
#            - narrate "<&a>You found a Tribute to the Gods!"