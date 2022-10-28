QuestNameFormat:
    type: format
    format: "<green>Quest: <gold><[text]>"

QuestDescriptionFormat:
    type: format
    format: "<aqua>Description:<&r> <[text]>"

QuestDataHandler:
    debug: false
    type: world
    # Handles loading and unloading player quest data on join/quit
    events:
        on player joins:
        - define data <player.uuid>_quest_data
        - if <server.has_file[playerdata/<player.uuid>/quest_data.yml]>:
            - ~yaml load:playerdata/<player.uuid>/quest_data.yml id:<[data]>
        - else:
            - yaml create id:<[data]>
            - yaml id:<[data]> set player_uuid:<player.uuid>
            - ~yaml id:<[data]> savefile:playerdata/<player.uuid>/quest_data.yml
        - yaml id:<[data]> set player_last_known_name:<player.name>
        on player quits:
        - define data <player.uuid>_quest_data
        - ~yaml id:<[data]> savefile:playerdata/<player.uuid>/quest_data.yml

QuestRequirementsHandler:
    type: procedure
    debug: true
    definitions: quest_internalname
    script:
    - define data <player.uuid>_quest_data
    # Completed quests
    - if <yaml[<[quest_internalname]>].contains[config.requirements.quests_completed]>:
        - foreach <yaml[<[quest_internalname]>].read[config.requirements.quests_completed]> as:QuestsCompleted:
            - if <yaml[<[data]>].contains[quests.completed.<[QuestsCompleted]>].not>:
                - determine false
    # Player groups
    - if <yaml[<[quest_internalname]>].contains[config.requirements.groups]>:
        - foreach <yaml[<[quest_internalname]>].read[config.requirements.groups]> as:PlayerGroups:
            - if <player.groups.contains[<[PlayerGroups]>].not>:
                - determine false
    # Individual permissions
    - if <yaml[<[quest_internalname]>].contains[config.requirements.permissions]>:
        - foreach <yaml[<[quest_internalname]>].read[config.requirements.permissions]> as:PlayerPermissions:
            - if <player.has_permission[<[PlayerPermissions]>].not>:
                - determine false
    - determine true

QuestAcceptHandler:
    debug: true
    type: task
    speed: 0
    definitions: quest_internalname|quest
    # Handles accepting a quest
    script:
    - define data <player.uuid>_quest_data
    - yaml id:<[quest_internalname]> copykey:player_data.<[quest_internalname]> quests.active.<[quest_internalname]> to_id:<[data]>
    - yaml id:<[data]> set quests.active.<[quest_internalname]>.current_stage:1
    - define quest <yaml[<[data]>].read[quests.active.<[quest_internalname]>]>
    - define current_stage 1
    - title "title:<green>Quest accepted!" subtitle:<gold><[quest].get[name]> targets:<player>
    - narrate <yaml[<[quest_internalname]>].parsed_key[messages.offer]>
    - narrate format:QuestNameFormat <[quest].get[name]>
    - narrate format:QuestDescriptionFormat <[quest].get[description]>
    - narrate "<aqua>Stage <[current_stage]>: <&r><[quest].get[stages].get[<[current_stage]>].get[description]>"
    - foreach <[quest].deep_get[stages.<[current_stage]>.objectives]>:
        # If the objective is complete, it should be green, else aqua
        - if <[value].get[progress]> == <[value].get[total]>:
            - narrate "<green>• <[value].get[name]>: <[value].get[progress]>/<[value].get[total]> (COMPLETE)"
        - else:
            - narrate "<aqua>• <[value].get[name]>: <[value].get[progress]>/<[value].get[total]>"

QuestObjectiveProgressHandler:
    debug: true
    type: task
    speed: 0
    definitions: quest_internalname|objective
    # Completes the specified objective
    script:
    - define data <player.uuid>_quest_data
    - define quest <yaml[<[data]>].read[quests.active.<[quest_internalname]>]>
    # Set current stage definition
    - define current_stage <[quest].get[current_stage]>
    - define objective_progress <[quest].deep_get[stages.<[current_stage]>.progress].add[1]||1>
    - define objective_total <[quest].deep_get[stages.<[current_stage]>.total]>
    # Advance the current objective progress by 1
    - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[current_stage]>.progress:<[objective_progress]>
    - if <[objective_progress]> >= <[objective_total]>:
        - inject QuestStageProgressHandler instantly
    - else:
        - inject QuestProgressHandler

QuestStageProgressHandler:
    debug: true
    type: task
    speed: 0
    definitions: quest_internalname|objective
    ## This script will add 1 to the stage progress and should only be run when an objective is completed
    script:
    - define data <player.uuid>_quest_data
    - define quest <yaml[<[data]>].read[quests.active.<[quest_internalname]>]>
    # Set current stage definition
    - define current_stage <[quest].get[current_stage]>
    - define stage_progress <[quest].deep_get[stages.<[current_stage]>.progress]>
    - define stage_total <[quest].deep_get[stages.<[current_stage]>.total]>
    # Advance the current stage progress by 1
    - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[current_stage]>.progress:++
    # If the current stage progress is equal to or greater than the total for that stage,
    - if <[stage_progress].add[1]> >= <[stage_total]>:
        # Check whether there is another stage
        - if <yaml[<[data]>].contains[quests.active.<[quest_internalname]>.stages.<[current_stage].add[1]>]>:
            # If yes, advance to the next stage
            - run QuestStageAdvanceHandler def:<[quest_internalname]>
        - else:
            # If no, complete the quest
            - run QuestCompletionHandler def:<[quest_internalname]>
    # Display remaining objectives
    ## TODO: Replace with a foreach and conditional formatting for completed objectives
    - else if <[objective]||null> > 0:
        - narrate format:QuestNameFormat <[quest].get[name]>
        - narrate "• <[quest].get[stages].get[<[current_stage]>].get[objectives].get[<[objective]>].get[name]>: <[quest].get[stages].get[<[current_stage]>].get[objectives].get[<[objective]>].get[progress]>/<[quest].get[stages].get[<[current_stage]>].get[objectives].get[<[objective]>].get[total]>"

QuestItemDeliveryHandler:
    debug: true
    type: task
    speed: 0
    definitions: objective|quest_internalname|stage
    # Manages players delivering items to NPCs
    # Requires: <[objective]> AND <[quest_internalname]> AND <[stage]>
    script:
    - define data <player.uuid>_quest_data
    - define quest <yaml[<[data]>].read[quests.active.<[quest_internalname]>]>
    #- define progress <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress]>
    - define current_stage <[quest].get[current_stage]>
    - define progress <[quest].get[stages].get[<[current_stage]>].get[objectives].get[<[objective]>].get[progress]>
    #- define total <yaml[<[data]>].read[quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.total]>
    - define total <[quest].get[stages].get[<[current_stage]>].get[objectives].get[<[objective]>].get[total]>
    - define delivery_quantity <player.item_in_hand.quantity>
    - define delivery_item:<player.item_in_hand.script.name||<player.item_in_hand.material.name>>
    # We only want to take items if items need to be taken
    - if <[progress]> < <[total]>:
        - define remainder <[total].sub[<[progress]>]>
        - if <[delivery_quantity]> >= <[remainder]>:
            - take iteminhand quantity:<[remainder]>
            - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:<[total]>
            - define Delivery_Success true
            - define Enough_Items true
            # Advance a stage
            - inject QuestStageProgressHandler
        - else:
            - take iteminhand quantity:<[delivery_quantity]>
            - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:<[progress].add[<[delivery_quantity]>]>
            # Show current progress
            - inject QuestProgressHandler
            - define Delivery_Success true
    # If the progress is somehow already more than the total, move on
    - else if <[progress]> >= <[total]>:
        - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:<[total]>
        # Show quest progress
        - inject QuestProgressHandler

QuestProgressHandler:
    debug: true
    type: task
    speed: 0
    definitions: quest_internalname
    # Shows the player their progress for the designated quest
    script:
    - define data <player.uuid>_quest_data
    - define quest <yaml[<[data]>].read[quests.active.<[quest_internalname]>]>
    - define current_stage <[quest].get[current_stage]>
    # Show the quest name
    - narrate format:QuestNameFormat <[quest].get[name]>
    # Show the quest description
    - narrate format:QuestDescriptionFormat <[quest].get[description]>
    # Show the current stage
    - narrate "<aqua>Stage <[current_stage]>: <&r><[quest].get[stages].get[<[current_stage]>].get[description]>"
    # Show the current objectives
    - foreach <[quest].get[stages].get[<[current_stage]>].get[objectives]>:
        - if <[value].get[progress]> >= <[value].get[total]>:
            - narrate "<green>• <[value].get[name]>: <[value].get[progress]>/<[value].get[total]> (COMPLETE)"
        - else:
            - narrate "<aqua>• <[value].get[name]>: <[value].get[progress]>/<[value].get[total]>"

QuestStageAdvanceHandler:
    debug: false
    type: task
    speed: 0
    definitions: quest_internalname
    # Advances the quest stage by one and narrates information about the new stage
    script:
    - define data <player.uuid>_quest_data
    - define quest <yaml[<[data]>].read[quests.active.<[quest_internalname]>]>
    # Add one to the current stage
    - yaml id:<[data]> set quests.active.<[quest_internalname]>.current_stage:++
    - define quest <yaml[<[data]>].read[quests.active.<[quest_internalname]>]>
    - define current_stage <[quest].get[current_stage]>
    # Narrate the quest name
    - narrate format:QuestNameFormat <[quest].get[name]>
    # Narrate the quest description
    - narrate format:QuestDescriptionFormat <[quest].get[description]>
    # Narrate the new current stage
    - title "title:<green>Quest advanced!" "subtitle:<gold><[quest].get[name]> <aqua>Stage <[current_stage]>: <&r><[quest].get[stages].get[<[current_stage]>].get[description]>"
    - narrate "<aqua>Stage <[current_stage]>: <&r><[quest].get[stages].get[<[current_stage]>].get[description]>"
    # Narrate the new objectives
    - foreach <[quest].get[stages].get[<[current_stage]>].get[objectives]>:
        - narrate "<aqua>• <[value].get[name]>: <[value].get[progress]>/<[value].get[total]>"

QuestQuitHandler:
    debug: true
    type: task
    speed: 0
    definitions: quest|quest_internalname
    # Handles everything related to quitting a quest
    script:
    - define data <player.uuid>_quest_data
    - define quest <yaml[<[data]>].read[quests.active.<[quest_internalname]>]>
    - yaml id:<[data]> set quests.active.<[quest_internalname]>:!
    - if <yaml[<[quest_internalname]>].read[config.availability.offering_npc].exists> && <yaml[<[quest_internalname]>].read[config.quit_step].exists>:
        - zap <yaml[<[quest_internalname]>].read[config.availability.offering_npc]>Interact <yaml[<[quest_internalname]>].read[config.quit_step]>
    - title "title:<red>QUEST QUIT" subtitle:<gold><[quest].get[name]> targets:<player>
    - narrate "<red>QUEST QUIT: <[quest].get[name]>"

QuestCompletionHandler:
    debug: false
    type: task
    speed: 0
    definitions: quest_internalname
    # Handles everything related to completing a quest
    script:
    - define data <player.uuid>_quest_data
    - yaml id:<[data]> set quests.active.<[quest_internalname]>:!
    - yaml id:<[data]> set quests.completed.<[quest_internalname]>.completion_count:++
    - yaml id:<[data]> set quests.completed.<[quest_internalname]>.last_completed:<util.time_now>
    - run QuestResetTimeHandler def:<[quest_internalname]>
    - title "title:<green>QUEST COMPLETE!" subtitle:<gold><yaml[<[quest_internalname]>].read[player_data.<[quest_internalname]>.name]> targets:<player>
    - narrate "<gold>QUEST COMPLETE: <yaml[<[quest_internalname]>].read[player_data.<[quest_internalname]>.name]>"
    - narrate <yaml[<[quest_internalname]>].parsed_key[messages.completion]>
    - narrate <green>Rewards<&co>
    - run QuestRewardHandler def:<[quest_internalname]> instantly

QuestRepeatableHandler:
    debug: true
    type: procedure
    definitions: quest_internalname
    # Checks whether a quest is repeatable after a previous completion
    script:
    - define data <player.uuid>_quest_data
    - define reset_time <yaml[<[data]>].read[quests.completed.<[quest_internalname]>.reset_time].if_null[<util.time_now.sub[1h]>]>
    - if <util.time_now.is_after[reset_time]>:
        - determine true
    - if <util.time_now.is_before[reset_time]>:
        - determine false
    - else:
        - announce to_console "Something is terribly broken with the repeatable handler!"
        #- case 7d:
        #    - if <[current_week]> > <[reset_time]>:
        #        - determine true
        #    - else if <[current_week]> == <[last_completed].in_weeks> && <util.time_now.#day_of_week> > 6:
        #        - determine true
        #    - else if <util.time_now.day_of_week> == 6 && <util.time_now.hour> >= 19:
        #        - determine true
        #    - else:
        #        - determine false
        #- case 1d:
        #    - if <[current_day].sub[1]> > <[last_completed].in_days>:
        #        - determine true
        #    - else if <[current_day].sub[1]> == <[last_completed].in_days> && <#[last_completed].time.hour> < 19:
        #        - determine true
        #    - else if <[last_completed].time.hour> >= 19:
        #        - determine false
        #    - else if <[current_day]> == <[last_completed].in_days> && <util.time_now.hour> #>= 19 && <[last_completed].time.hour> < 19:
        #        - determine true
        #    - else:
        #        - determine false

QuestRewardHandler:
    debug: false
    type: task
    speed: 0
    definitions: quest_internalname
    # Handles quest reward distribution
    script:
    - define data <player.uuid>_quest_data
    - if <yaml[<[quest_internalname]>].contains[config.rewards.money]>:
        - money give quantity:<yaml[<[quest_internalname]>].read[config.rewards.money]> players:<player>
        - narrate "<gold>• <yaml[<[quest_internalname]>].read[config.rewards.money]> gold"
    - if <yaml[<[quest_internalname]>].contains[config.rewards.items]>:
        - foreach <yaml[<[quest_internalname]>].parsed_key[config.rewards.items]>:
            - give <[value]> player:<player>
            - narrate "<gold>• <[value].quantity.if_null[1]>x <[value].display.if_null[<[value].material.name.replace_text[_].with[<&sp>].to_titlecase>]>"
    - if <yaml[<[quest_internalname]>].contains[config.rewards.quest_points]>:
        - yaml id:<[data]> set career.quest_points:+:<yaml[<[quest_internalname]>].read[config.rewards.quest_points]>
        - narrate "<gold>• <yaml[<[quest_internalname]>].read[config.rewards.quest_points]> quest points"
    - if <yaml[<[quest_internalname]>].contains[config.rewards.scripts]>:
        - foreach <yaml[<[quest_internalname]>].read[config.rewards.scripts]>:
            - run <[value]> def:<[quest_internalname]>
    - if <yaml[<[quest_internalname]>].contains[config.rewards.commands]>:
        - foreach <yaml[<[quest_internalname]>].read[config.rewards.commands]>:
            - execute as_server <[value]>
        - foreach <yaml[<[quest_internalname]>].parsed_key[config.rewards.command_text]>:
            - narrate <[value]>

QuestLoginResetHandler:
    debug: false
    type: world
    # Handles any expirations and resets on login
    events:
        on player joins:
        - define data <player.uuid>_quest_data
        - if <yaml[<[data]>].read[quests.active].size||0> == 0:
            - stop
        - if <yaml[<[data]>].read[quests.active].is_empty>:
            - stop
        - foreach <yaml[<[data]>].read[quests.active]> as:quest_internalname:
            - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.reset_time].exists.not>:
                - foreach skip
            - define reset_time <yaml[<[data]>].read[quests.active.<[quest_internalname]>.reset_time]>
            - if <util.time_now> >= <[reset_time]>:
                - yaml id:<[data]> set quests.active.<[quest_internalname]>:!
                - narrate "<red>QUEST EXPIRED: <yaml[<[quest_internalname]>].read[player_data.<[quest_internalname]>.name]>"

QuestDailyResetHandler:
    debug: false
    type: world
    # Handles daily quest resets
    events:
        on system time 19:00:
        - foreach <server.online_players> as:player:
            - define data:<[player].uuid>_quest_data
            - foreach <yaml[<[data]>].read[quests.active]> as:quest_internalname:
                - define reset_time:<yaml[<[data]>].read[quests.active.<[quest_internalname]>.reset_time]>
                - if <util.time_now> >= <[reset_time]>:
                    - yaml id:<[data]> set quests.active.<[quest_internalname]>:!
                    - narrate "<red>QUEST EXPIRED: <yaml[<[quest_internalname]>].read[player_data.<[quest_internalname]>.name]>"

QuestResetTimeHandler:
    debug: false
    type: task
    speed: 0
    definitions: quest_internalname
    # Handles quest reset times
    script:
    - define data <player.uuid>_quest_data
    - choose <yaml[<[quest_internalname]>].read[config.reset.period]||null>:
        - case 7d:
            - if <util.time_now.day_of_week> == 5 && <util.time_now.hour> >= 19:
                - yaml id:<[data]> set quests.completed.<[quest_internalname]>.reset_time:<util.time_now.next_day_of_week[Friday].add[7d].add[19h].sub[5m]>
            - else:
                - yaml id:<[data]> set quests.completed.<[quest_internalname]>.reset_time:<util.time_now.next_day_of_week[Friday].add[19h].sub[5m]>
        - case 1d:
            - if <util.time_now.hour> >= 19:
                - yaml id:<[data]> set quests.completed.<[quest_internalname]>.reset_time:<util.time_now.start_of_day.add[1d].add[19h].sub[5m]>
            - else:
                - yaml id:<[data]> set quests.completed.<[quest_internalname]>.reset_time:<util.time_now.start_of_day.add[19h].sub[5m]>

QuestAvailabilityHandler:
    debug: true
    type: procedure
    definitions: quest_internalname
    # Checks whether a quest's reset time has passed
    script:
    - define data <player.uuid>_quest_data
    # Determine unavailable if the player has the quest active
    - if <yaml[<[data]>].contains[quests.active.<[quest_internalname]>]>:
        - determine false
    # Check whether the quest has been completed
    - if <yaml[<[data]>].contains[quests.completed.<[quest_internalname]>]>:
        # Check whether the quest has a reset time
        - if <yaml[<[data]>].contains[quests.completed.<[quest_internalname]>.reset_time]>:
            # If the reset time is later than the time now, the quest is unavailable
            - if <yaml[<[data]>].read[quests.completed.<[quest_internalname]>.reset_time].is_after[<util.time_now>]>:
                - determine false
        # If the quest has no reset time, it is unavailable
        - else:
            - determine false
    # Determine false if any requirements are unsatisfied
    - if <yaml[<[quest_internalname]>].contains[config.requirements]>:
        # If other quests must be completed first, check for completion
        - if <yaml[<[quest_internalname]>].contains[config.requirements.quests_completed]>:
            - foreach <yaml[<[quest_internalname]>].read[config.requirements.quests_completed]> as:quest_internalname:
                # If the required quest is not completed...
                - if !<yaml[<[data]>].contains[quests.completed.<[quest_internalname]>]>:
                    # ...then the current quest is unavailable
                    - determine false
        # If a permission is required, check for the permission
        - if <yaml[<[quest_internalname]>].contains[config.requirements.permissions]>:
            - foreach <yaml[<[quest_internalname]>].read[config.requirements.permissions]> as:permission:
                # If the required permission is not granted...
                - if !<player.has_permission[<[permission]>]>:
                    # ...then the current quest is unavailable
                    - determine false
    # Determine true if, logically, the conditions are met by a failure to fail
    - determine true

QuestsAvailableHandler:
    debug: true
    type: procedure
    definitions: npc_name
    # Returns whether any quest is available for an npc
    script:
    - define data <player.uuid>_quest_data
    - define quest_list:<yaml[quest_npc_list].read[<[npc_name]>]>
    - define inventory_list:<list[]>
    - foreach <[quest_list]>:
        - if <proc[QuestAvailabilityHandler].context[<[value]>]> && <yaml[<[data]>].contains[quests.active.<[value]>].not>:
            - determine true
        - else:
            - determine false

QuestInventoryGUIHandler:
    debug: true
    type: task
    speed: 0
    definitions: npc_name
    # Opens an inventory GUI with available quests
    script:
    - define data <player.uuid>_quest_data
    - define quest_list <yaml[quest_npc_list].read[<[npc_name]>]>
    - define inventory_list <element[air].repeat_as_list[18]>
    - foreach <[quest_list]>:
        - if <proc[QuestAvailabilityHandler].context[<[value]>]> && <yaml[<[data]>].contains[quests.active.<[value]>].not>:
            - define inventory_list <[inventory_list].include[<proc[QuestGUIItemBuilder].context[<[value]>]>]>
    - if <[inventory_list].size> > 0:
        - note <inventory[QuestInventoryGUIBase].include[<[inventory_list]>]> as:available_quest_inventory.<[npc_name]>.<player.uuid>
        - inventory open d:available_quest_inventory.<[npc_name]>.<player.uuid>
    - else:
        - narrate "<red>No quests available!"

QuestInventoryGUIBase:
    type: inventory
    debug: false
    inventory: chest
    title: <&6><&l>Quests
    gui: true
    size: 54
    slots:
    - [air] [air] [air] [air] [air] [air] [air] [air] [air]
    - [air] [air] [air] [air] [air] [air] [air] [air] [air]
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []

QuestInventorySelectionHandler:
    debug: true
    type: world
    # Handles a player choosing a quest from an inventory GUI
    events:
        on player clicks in available_quest_inventory*:
        - determine passively cancelled
        - wait 1t
        - if <context.item.has_flag[quest_internalname]>:
            - inventory close
            - run QuestAcceptHandler def:<context.item.flag[quest_internalname]>
        on player drags in available_quest_inventory*:
        - determine cancelled

QuestGUIItemBuilder:
    debug: false
    type: procedure
    definitions: quest_internalname
    # Constructs the item entries in an inventory GUI
    script:
    - define quest_name <yaml[<[quest_internalname]>].read[player_data.<[quest_internalname]>.name]>
    - define item_lore <list[]>
    # Description
    - define quest_description <yaml[<[quest_internalname]>].read[player_data.<[quest_internalname]>.description]>
    - define item_lore <[item_lore].include[<white><[quest_description]>]>
    - define item_lore <[item_lore].include[<&sp>]>
    # Rewards
    - define item_lore <[item_lore].include[<green>Rewards:]>
    - if <yaml[<[quest_internalname]>].read[config.rewards.money]||null> != null:
        - define lore_money "<gold>• <yaml[<[quest_internalname]>].read[config.rewards.money]> gold"
        - define item_lore <[item_lore].include[<[lore_money]>]>
    - if <yaml[<[quest_internalname]>].read[config.rewards.quest_points]||null> != null:
        - define lore_quest_points "<gold>• <yaml[<[quest_internalname]>].read[config.rewards.quest_points]> quest points"
        - define item_lore <[item_lore].include[<[lore_quest_points]>]>
    - if <yaml[<[quest_internalname]>].read[config.rewards.items]||null> != null:
        - define lore_items <list[]>
        - foreach <yaml[<[quest_internalname]>].parsed_key[config.rewards.items]>:
            - define lore_items "<[lore_items].include[<gold>• <[value].quantity||1>x <[value].display.if_null[<[value].material.name.replace_text[_].with[<&sp>].to_titlecase>]>]>"
            #- define lore_items <[lore_items].include[<[value]>]>
        - define item_lore <[item_lore].include[<[lore_items]>]>
    # Line wrapping time!
    - define item_lore <proc[lore_builder].context[<list[40].include_single[<[item_lore]>]>]>
    #- define item_lore <proc[lore_builder].context[40|<[item_lore].escaped>]>
    - if <item[<[quest_internalname]>_gui_item]||null> != null:
        - define base_item <item[<[quest_internalname]>_gui_item]>
        - if <[base_item].is_enchanted>:
            - define item_enchantments <[base_item].enchantment_map>
            - determine <[base_item].with[display_name=<reset><gold><[quest_name]>;enchantments=<[item_enchantments]>;hides=ALL].with_map[<map.with[lore].as[<[item_lore]>]>].with_flag[quest_internalname:<[quest_internalname]>]>
    - else:
        - define item_material <yaml[<[quest_internalname]>].read[config.material]>
        - determine <item[<[item_material]>].with[display_name=<reset><gold><[quest_name]>;hides=ALL].with_map[<map.with[lore].as[<[item_lore]>]>].with_flag[quest_internalname:<[quest_internalname]>]>

ResetQuestInteract:
    type: command
    debug: false
    name: questinteractreset
    description: Resets the interact script for the given NPC and player. Defaults to the current player if no player is specified.
    usage: /questinteractreset [NPC] [player]
    permission: quest.volatile
    tab completions:
        1: <yaml[quest_npc_list].list_keys[]>
        2: <server.online_players.parse[name]>
    script:
    - define interact <context.args.get[1]>Interact
    - define player <server.match_offline_player[<context.args.get[2].if_null[null]>].if_null[<player>]>
    - define data <[player].uuid>_quest_data
    - zap script:<[interact]> step:<script[<[interact]>].default_step> player:<[player]>
    - if <script[InteractReset_<context.args.get[1]>].exists>:
        - inject InteractReset_<context.args.get[1]>
    - narrate "Interact step for <[player].name> reset."

Full_Reset_Quest_Interact:
    type: command
    debug: true
    name: questinteractfullreset
    description: Resets the interact script for the given player across all quest NPCs. Defaults to the current player if no player is specified.
    usage: /questinteractfullreset [player]
    permission: quest.volatile
    tab completions:
        1: <server.online_players.parse[name]>
    script:
    - define player <server.match_offline_player[<context.args.get[1]>].if_null[<player>]>
    - define data <[player].uuid>_quest_data
    - foreach <yaml[Quest_NPC_List].list_keys[]> as:npc:
        - zap <[npc]>Interact <script[<[npc]>Interact].default_step> player:<[player]>
        - if <script[InteractReset_<[npc]>].exists>:
            - inject InteractReset_<[npc]>
    - narrate "Interact steps for <[player].name> reset."