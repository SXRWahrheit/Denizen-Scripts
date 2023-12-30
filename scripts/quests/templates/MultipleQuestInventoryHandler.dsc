TemplateActiveQuests:
    type: inventory
    inventory: chest
    debug: false
    title: Active Quests
    size: 54
    gui: true
    slots:
    - [air] [air] [air] [air] [air] [air] [air] [air] [air]
    - [air] [air] [air] [air] [air] [air] [air] [air] [air]
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] [AvailableQuestsIcon]

TemplateAvailableQuests:
    type: inventory
    inventory: chest
    debug: false
    title: Available Quests
    size: 54
    gui: true
    slots:
    - [air] [air] [air] [air] [air] [air] [air] [air] [air]
    - [air] [air] [air] [air] [air] [air] [air] [air] [air]
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] [ActiveQuestsIcon]

ActiveQuestsCheck:
    type: procedure
    debug: false
    definitions: npcname
    script:
    # Pull the player data
    - define data <player.uuid>_quest_data
    # Pull the list of quests associated with the NPC from the master list
    # This list could be optimized or automated by flagging the NPC, or a flag named for the NPC, with the quest name using the quest script file. Stick a TODO here later
    - define AllQuestsList <yaml[quest_npc_list].read[<[NPCName]>]>
    # Pull the player's active quests from their data
    - define PlayerActiveQuests <yaml[<[data]>].list_keys[quests.active].if_null[<list[]>]>
    # Define a list of quests that the NPC has available from the player's overall active quest list
    - define NPCActiveQuests <[AllQuestsList].shared_contents[<[PlayerActiveQuests]>]>
    # If the player has no active quests from this NPC, determine an empty list
    - if <[NPCActiveQuests].size> == 0:
        - determine <list>
    # If the player has at least one active quest from this NPC, determine a list of those quests
    - else if <[NPCActiveQuests].size> >= 1:
        - determine <[NPCActiveQuests]>
    # If something goes wrong, determine null
    - else:
        - determine null

AvailableQuestsCheck:
    type: procedure
    debug: true
    definitions: npcname
    script:
    # Pull the player data
    - define data <player.uuid>_quest_data
    # Start with an empty list
    - define AvailableQuestsList <list>
    # Start by reading the NPC's quest list
    - define AllQuestsList <yaml[quest_npc_list].read[<[NPCName]>]>
    # Read player's active and completed quest lists
    - define PlayerActiveQuests <yaml[<[data]>].list_keys[quests.active].if_null[<empty>]>
    - define CompletedQuests <yaml[<[data]>].list_keys[quests.completed].if_null[<empty>]>
    # Filter out the player's active and completed quests
    - define PossibleQuestsList <[AllQuestsList].exclude[<[PlayerActiveQuests]>].exclude[<[CompletedQuests]>]>
    # If no quests, determine false
    - if <[PossibleQuestsList].size> == 0:
        - determine <list>
    # If the player has at least one available quest from this NPC, determine a list of those quests
    - else if <[PossibleQuestsList].size> >= 1:
        # For each of the available quests, check if the player has the quest's prerequisites
        - foreach <[PossibleQuestsList]>:
            # If the quest passes the availbility check, include it in the list
            - if <proc[QuestAvailabilityHandler].context[<[value]>]>:
                - define AvailableQuestsList <[AvailableQuestsList].include[<[value]>]>
        # If the list is empty, determine an empty list
        - if <[AvailableQuestsList].size> == 0:
            - determine <list>
        # If the list is not empty, determine the list
        - determine <[AvailableQuestsList]>
    # If something goes wrong, determine null
    - else:
        - determine null

ActiveQuestInventoryGUIHandler:
    debug: true
    type: task
    speed: 0
    definitions: npc_name
    # Usage example:
    # /ex run ActiveQuestInventoryGUIHandler def:WiseWizard
    script:
    # Pull the player data
    - define data <player.uuid>_quest_data
    # Start by reading the NPC's quest list
    - define quest_list <yaml[quest_npc_list].read[<[npc_name]>]>
    # Create an empty list for the inventory
    - define inventory_list <list[]>
    # For each quest the NPC has...
    - foreach <[quest_list]>:
        # If the player has an active quest of that name...
        - if <yaml[<[data]>].contains[quests.active.<[value]>]>:
            # Add the quest to the inventory list by passing it through the ActiveQuestGUIItemBuilder
            - define inventory_list <[inventory_list].include[<proc[ActiveQuestGUIItemBuilder].context[<[value]>|<[npc_name]>]>]>
    # Once we parse all the quests, if the size is greater than zero...
    - if <[inventory_list].size> > 0:
        # Create the inventory using the base and the generated list
        - define inventory <inventory[QuestInventoryGUIBase]>
        - inventory set d:<[inventory]> o:<[inventory_list]> slot:10
        # Active quest title
        - define name Active<&chr[00A0]>Quests<&chr[00A0].repeat[1000]><white><&font[sxrmenus]><&chr[F801].repeat[68]><&chr[F801].repeat[4000]><&chr[F801].repeat[8]><&chr[E016]><&chr[F801].repeat[177]><&chr[E00B]><&chr[F801].repeat[177]><&chr[E00C]><&chr[F801].repeat[177]><&chr[E01F]>
        - adjust <[inventory]> title:<[name]>
        - inventory open d:<[inventory]>
        # Check if player has available quests
        - if <proc[AvailableQuestsCheck].context[<[npc_name]>].size> > 0:
            # It might be better to include this in the inventory construction above if possible
            - inventory set slot:54 d:<player.open_inventory> o:<item[AvailableQuestsIcon].with_flag[npc_name:<[npc_name]>]>
            - inventory update
        # Still need to add pagination
    - else:
        - narrate "<red>No active quests!"

AvailableQuestInventoryGUIHandler:
    debug: true
    type: task
    speed: 0
    definitions: npc_name
    # Opens an inventory GUI with available quests
    script:
    # Pull the player data
    - define data <player.uuid>_quest_data
    # Start by reading the NPC's quest list
    - define quest_list <yaml[quest_npc_list].read[<[npc_name]>]>
    # Create an empty list for the inventory
    - define inventory_list <list>
    # For each quest the NPC has...
    - foreach <[quest_list]>:
        # If the quest passes the QuestAvailabilityHandler
        - if <proc[QuestAvailabilityHandler].context[<[value]>]> && <yaml[<[data]>].contains[quests.active.<[value]>].not>:
            # Add the quest to the inventory list by passing it through the AvailableQuestGUIItemBuilder
            - define inventory_list <[inventory_list].include[<proc[AvailableQuestGUIItemBuilder].context[<[value]>|<[npc_name]>]>]>
    # Once we parse all the quests, if the size is greater than zero...
    - if <[inventory_list].size> > 0:
        # Create the inventory using the base and the generated list
        - define inventory <inventory[QuestInventoryGUIBase]>
        # Available quest title
        - define name Available<&chr[00A0]>Quests<&chr[00A0].repeat[1000]><white><&font[sxrmenus]><&chr[F801].repeat[82]><&chr[F801].repeat[4000]><&chr[F801].repeat[8]><&chr[E016]><&chr[F801].repeat[177]><&chr[E00B]><&chr[F801].repeat[177]><&chr[E00D]><&chr[F801].repeat[177]><&chr[E01F]>
        - adjust <[inventory]> title:<[name]>
        - inventory open d:<[inventory].include[<[inventory_list]>]>
        # Check if player has active quests
        - if <proc[ActiveQuestsCheck].context[<[npc_name]>].size> > 0:
            # It might be better to include this in the inventory construction above if possible
            - inventory set slot:54 d:<player.open_inventory> o:<item[ActiveQuestsIcon].with_flag[npc_name:<[npc_name]>]>
            - inventory update
    - else:
        - narrate "<red>No quests available!"

ActiveQuestGUIItemBuilder:
    debug: false
    type: procedure
    definitions: quest_internalname|npc_name
    # Constructs the item entries in an inventory GUI
    script:
    # Quest data map
    - define data <player.uuid>_quest_data
    - define quest <yaml[<[data]>].read[quests.active.<[quest_internalname]>]>
    - define current_stage <[quest].get[current_stage]>
    # Name
    - define quest_name <yaml[<[quest_internalname]>].read[player_data.<[quest_internalname]>.name]>
    # Lore
    - define item_lore <list[]>
    # Description
    - define quest_description <yaml[<[quest_internalname]>].read[player_data.<[quest_internalname]>.description]>
    - define item_lore <[item_lore].include[<white><[quest_description]>]>
    - define item_lore <[item_lore].include[<&sp>]>
    # Stage
    - define item_lore <[item_lore].include[<aqua>Stage <[current_stage]>:]>
    - foreach <[quest].get[stages].get[<[current_stage]>].get[objectives]>:
        # Green if complete, aqua if not
        - if <[value].get[progress]> == <[value].get[total]>:
            - define item_lore <[item_lore].include[<reset><green>• <[value].get[name]>: <[value].get[progress]>/<[value].get[total]>]>
        - else:
            - define item_lore <[item_lore].include[<reset><aqua>• <[value].get[name]>: <[value].get[progress]>/<[value].get[total]>]>
    # Line wrapping time!
    - define item_lore <proc[lore_builder].context[<list[40].include_single[<[item_lore]>]>]>
    # Build the item
    - if <item[<[quest_internalname]>_gui_item].if_null[null]> != null:
        - define base_item <item[<[quest_internalname]>_gui_item]>
        - if <[base_item].is_enchanted>:
            - define item_enchantments <[base_item].enchantment_map>
            - determine <[base_item].with[display_name=<reset><gold><[quest_name]>;enchantments=<[item_enchantments]>;hides=ALL].with_map[<map.with[lore].as[<[item_lore]>]>].with_flag[quest_internalname:<[quest_internalname]>].with_flag[active_quest:true].with_flag[npc:<[npc_name]>]>
    - else:
        - define item_material <yaml[<[quest_internalname]>].read[config.material]>
        - determine <item[<[item_material]>].with[display_name=<reset><gold><[quest_name]>;hides=ALL].with_map[<map.with[lore].as[<[item_lore]>]>].with_flag[quest_internalname:<[quest_internalname]>].with_flag[active_quest:true].with_flag[npc_name:<[npc_name]>]>

AvailableQuestGUIItemBuilder:
    debug: false
    type: procedure
    definitions: quest_internalname|npc_name
    # Constructs the item entries in an inventory GUI
    script:
    # Quest data map
    - define data <player.uuid>_quest_data
    - define quest <yaml[<[quest_internalname]>].read[player_data.<[quest_internalname]>]>
    # Name
    - define quest_name <yaml[<[quest_internalname]>].read[player_data.<[quest_internalname]>.name]>
    # Lore
    - define item_lore <list[]>
    # Description
    - define quest_description <yaml[<[quest_internalname]>].read[player_data.<[quest_internalname]>.description]>
    - define item_lore <[item_lore].include[<white><[quest_description]>]>
    - define item_lore <[item_lore].include[<&sp>]>
    # Line wrapping time!
    - define item_lore <proc[lore_builder].context[<list[40].include_single[<[item_lore]>]>]>
    # Build the item
    - if <item[<[quest_internalname]>_gui_item].if_null[null]> != null:
        - define base_item <item[<[quest_internalname]>_gui_item]>
        - if <[base_item].is_enchanted>:
            - define item_enchantments <[base_item].enchantment_map>
            - determine <[base_item].with[display_name=<reset><gold><[quest_name]>;enchantments=<[item_enchantments]>;hides=ALL].with_map[<map.with[lore].as[<[item_lore]>]>].with_flag[quest_internalname:<[quest_internalname]>].with_flag[available_quest:true].with_flag[npc:<[npc_name]>]>
    - else:
        - define item_material <yaml[<[quest_internalname]>].read[config.material]>
        - determine <item[<[item_material]>].with[display_name=<reset><gold><[quest_name]>;hides=ALL].with_map[<map.with[lore].as[<[item_lore]>]>].with_flag[quest_internalname:<[quest_internalname]>].with_flag[available_quest:true].with_flag[npc_name:<[npc_name]>]>

ActiveQuestInventorySelectionHandler:
    type: world
    debug: true
    events:
        on player clicks item_flagged:active_quest in QuestInventoryGUIBase:
        # Opens a GUI of objectives for the quest's current stage when an active quest item is clicked
        - define data <player.uuid>_quest_data
        - define quest_internalname <context.item.flag[quest_internalname]>
        - define quest <yaml[<[data]>].read[quests.active.<[quest_internalname]>]>
        # Active quest title
        - define name Active<&chr[00A0]>Quests<&chr[00A0].repeat[1000]><white><&font[sxrmenus]><&chr[F801].repeat[68]><&chr[F801].repeat[4000]><&chr[F801].repeat[8]><&chr[E016]><&chr[F801].repeat[177]><&chr[E00B]><&chr[F801].repeat[177]><&chr[E00C]><&chr[F801].repeat[177]><&chr[E01F]>
        - define stage <[quest].get[current_stage]>
        - flag <player> npc_interact_active_quest:<context.item.flag[quest_internalname]>
        #- zap <context.item.flag[npc_name]>Interact ActiveQuestManagement
        - define ActiveQuestInventory <inventory[QuestInventoryGUIBase]>
        # Make the title
        - adjust <[ActiveQuestInventory]> title:<[Name]>
        # Build the contents
        # Start with the stage description
        - define stage_progress <[quest].deep_get[stages.<[stage]>.progress]>
        - define stage_total <[quest].deep_get[stages.<[stage]>.total]>
        - define stage_item <item[book].with[display_name=<reset><gold><[quest].get[name]>;lore=<list[<reset><aqua>Stage <[Stage]> Objectives|<reset><aqua>Progress: <[stage_progress]>/<[stage_total]>]>;hides=all]>
        - inventory set d:<[ActiveQuestInventory]> o:<[stage_item]> slot:10
        # Then add the stage requirements
        - foreach <[quest].deep_get[stages.<[stage]>.objectives]>:
            - define slot <[loop_index].add[18]>
            - define name <[value].get[name]>
            - define progress <[value].get[progress]>
            - define total <[value].get[total]>
            - define material <[value].deep_get[data.material]>
            # If the objective is complete, make the item enchanted and green text
            - if <[progress]> >= <[total]>:
                - define lore_list <list[].include[<reset><green>Progress: <[progress]>/<[total]>]>
                - define item <item[<[material]>].with[display_name=<reset><green><[name]>;lore=<[lore_list]>;hides=all;enchantments=mending=1]>
            # Else, aqua text
            - else:
                - define lore_list <list[].include[<reset><aqua>Progress: <[progress]>/<[total]>]>
                - define item <item[<[material]>].with[display_name=<reset><aqua><[name]>;lore=<[lore_list]>;hides=all].with_flag[active_objective:true].with_flag[quest_internalname:<[quest_internalname]>].with_flag[objective:<[loop_index]>].with_flag[stage:<[stage]>]>
            - inventory set d:<[ActiveQuestInventory]> o:<[item]> slot:<[slot]>
        - inventory open d:<[ActiveQuestInventory]>



ActiveQuestObjectiveHandler:
    type: procedure
    debug: true
    definitions: data|quest_internalname|npc_name
    script:
    - define quest <yaml[<[data]>].read[quests.active.<[quest_internalname]>]>
    - define current_stage <[quest].get[current_stage]>
    - define item_lore <list>
    - foreach <[quest].deep_get[stages.<[current_stage]>.objectives]>:
        - define target objective_<[loop_index]>
        - define obj_name <[value].get[name]>
        - define obj_progress <[value].get[progress]>
        - define obj_total <[value].get[total]>
        - define item_lore <[item_lore].include[Progress: <[obj_progress]>/<[obj_total]>]>
    - define item_material <yaml[<[quest_internalname]>].read[config.material].if_null[paper]>
    - determine <item[<[item_material]>].with[display_name=<reset><gold><[obj_name]>;hides=ALL].with_map[<map.with[lore].as[<[item_lore]>]>].with_flag[quest_internalname:<[quest_internalname]>].with_flag[active_quest:true].with_flag[npc_name:<[npc_name]>]>

AvailableQuestsIcon:
    type: item
    material: book
    debug: false
    display name: <green><bold>Available quests
    data:
        lore_list:
        - <gold>Click to view available quests!
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>

ActiveQuestsIcon:
    type: item
    material: book
    debug: false
    display name: <green><bold>Active quests
    data:
        lore_list:
        - <gold>Click to view active quests!
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>

MultipleQuestsHandler:
    type: world
    debug: false
    events:
        on player clicks AvailableQuestsIcon in QuestInventoryGUIBase:
        - determine passively cancelled
        - wait 1t
        - define npc_name <context.item.flag[npc_name]>
        - inject AvailableQuestInventoryGUIHandler
        on player clicks ActiveQuestsIcon in QuestInventoryGUIBase:
        - determine passively cancelled
        - wait 1t
        - define npc_name <context.item.flag[npc_name]>
        - inject ActiveQuestInventoryGUIHandler
        on player clicks in QuestInventoryGUIBase priority:100:
        - determine passively cancelled
        - wait 1t
        - if <context.item.has_flag[quest_internalname]> && <context.item.has_flag[available_quest]>:
            - inventory close
            - run QuestAcceptHandler def:<context.item.flag[quest_internalname]>
        on player drags in QuestInventoryGUIBase priority:100:
        - determine cancelled

Objective_Interaction_Handler:
    type: world
    debug: true
    events:
        on player clicks item_flagged:active_objective in QuestInventoryGUIBase:
        - determine passively cancelled
        - wait 1t
        - define data <player.uuid>_quest_data
        - define quest_internalname <context.item.flag[quest_internalname]>
        - define quest <yaml[<[data]>].read[quests.active.<[quest_internalname]>]>
        - define objective <context.item.flag[objective]>
        - define stage <context.item.flag[stage]>
        - define progress <[quest].deep_get[stages.<[stage]>.objectives.<[objective]>.progress]>
        - define total <[quest].deep_get[stages.<[stage]>.objectives.<[objective]>.total]>
        - define material <[quest].deep_get[stages.<[stage]>.objectives.<[objective]>.data.material]>
        - choose <[quest].deep_get[stages.<[stage]>.objectives.<[objective]>.data.type]>:
            - case deliver_item:
                - define item_name <item[<[material]>].display.if_null[<item[<[material]>].with[quantity=2].formatted>]>
                - define required <[total].sub[<[progress]>]>
                - inventory close
                - if <player.inventory.contains_item[raw_exact:<[material]>]>:
                    - if <player.inventory.quantity_item[raw_exact:<[material]>]> >= <[required]>:
                        - take raw_exact:<[material]> quantity:<[required]>
                        - narrate "<italic><green><[required]> <[item_name]> delivered!"
                        - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:<[total]>
                        - run QuestObjectiveProgressHandler def:<[quest_internalname]>|<[objective]>
                    - else:
                        - define delivered <player.inventory.quantity_item[raw_exact:<[material]>]>
                        - take raw_exact:<[material]> quantity:<[delivered]>
                        - yaml id:<[data]> set quests.active.<[quest_internalname]>.stages.<[stage]>.objectives.<[objective]>.progress:<[delivered].add[<[progress]>]>
                        - define required <[required].sub[<[delivered]>]>
                        - narrate "<green><[delivered]> <[item_name]> delivered!<reset> You need <italic><green><[required]> more!"
                - else:
                    - narrate "<red>You don't have any <[item_name]>!"
            - case quest_weeklyveteranhunt:
                - inventory close
                - narrate <aqua><[quest].deep_get[stages.<[stage]>.description]>
                - narrate "<aqua>Progress: <[progress]>/<[total]>"
            - case quest_weeklyelitehunt:
                - inventory close
                - narrate <aqua><[quest].deep_get[stages.<[stage]>.description]>
                - narrate "<aqua>Progress: <[progress]>/<[total]>"
            - case kill_mobs:
                - inventory close
                - narrate <aqua><[quest].deep_get[stages.<[stage]>.description]>
                - narrate "<aqua>Progress: <[progress]>/<[total]>"
            - default:
                - inventory close
                - narrate "<red>This objective type is not supported yet! This distortion in reality has been reported to the Gods!"
                - discord id:sxr message channel:343105813293826059 "<&lt><&at>&223441207341210840<&gt>, an unmatched quest objective has been identified by <player.name>! The quest was **<[quest].get[name]>** and the objective was **<[quest].deep_get[stages.<[stage]>.objectives.<[objective]>.name]>**! The objective type was **<[quest].deep_get[stages.<[stage]>.objectives.<[objective]>.data.type]>**!"