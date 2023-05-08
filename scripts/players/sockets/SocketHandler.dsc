# Add flags to items for # of sockets available / total
# Use flags to manage sockets
# Use events to handle socket effects
# Numbered sockets on each item to handle types separately from current sockets
# Be sure to check each specific numbered slot to avoid exploits

### Relevant flag values:
## Item (weapon/armor) flags
# equipment_type (VALUE) | Whether equipment is a weapon or armor, e.g. "weapon"/"armor"
# item_tier (VALUE) | The item's tier, e.g. "veteran"/"elite"/"champion"
# sealed_potential (BOOLEAN) | Whether the item has Sealed Potential. Items with Sealed Potential should have no socket data; data will be wiped on unlock.
# sockets_current (INTEGER) | Number of sockets currently on the item, filled or unfilled
# sockets_max (INTEGER) | Maximum number of sockets possible to exist on the item, whether existing or not
# sockets_can_add (BOOLEAN) | Whether it is possible to add any more sockets to the item, to be removed when sockets_current equals sockets_max
# sockets_open (BOOLEAN) | Whether an item has sockets that are empty
# socket#_type (VALUE) | The type of a socket, e.g. socket1_type "attack"/"defense"/"utility"
# socket#_gem (VALUE) | The actual gem inserted into a socket e.g. "crit_chance"/"health_on_hit"/"speed_on_hit"
# socket#_empty (BOOLEAN) | True if the numbered socket is empty
## Gem flags
# gem_type (VALUE) | The type of a gem, e.g. "attack"/"defense"/"utility"
# gem_specific (VALUE) | The actual gem e.g. "crit_chance"/"health_on_hit"/"speed_on_hit"
# gem_attribute# (VALUE) | Attributes to be applied to item upon socketing






sockets_sword_max:
    type: item
    no_id: true
    material: diamond_sword
    display name: <&a>Empty Socket Sword of Extreme Testing
    lore:
    - <&f>It's a test sword!
    - <&6>Sockets
    - <&c>EMPTY<&co> ATTACK
    - <&c>EMPTY<&co> ATTACK
    - <&a>EMPTY<&co> UTILITY
    - <&9>EMPTY<&co> DEFENSE
    - <&a>EMPTY<&co> UTILITY
    enchantments:
    - MENDING:1
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt:
        - equipment_type/weapon
        - item_tier/champion
        - sockets_current/5
        - sockets_max/5
        - sockets_can_add/false
        - sockets_open/true
        - socket1_type/attack
        - socket1_empty/true
        - socket2_type/attack
        - socket2_empty/true
        - socket3_type/utility
        - socket3_empty/true
        - socket4_type/defense
        - socket4_empty/true
        - socket5_type/utility
        - socket5_empty/true

sockets_sword_locked:
    type: item
    no_id: true
    material: diamond_sword
    display name: <&a>Locked Socket Sword of Extreme Testing
    data:
        lore_list:
        - <&f>It's a test sword!
        - <&6>Sockets
        - <&8>LOCKED
        - <&8>LOCKED
        - <&8>LOCKED
        - <&8>LOCKED
        - <&8>LOCKED
    enchantments:
    - MENDING:1
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt:
        - equipment_type/weapon
        - item_tier/champion
        - sockets_current/0
        - sockets_max/5
        - sockets_can_add/true

sockets_sword_sealed_potential:
    type: item
    no_id: true
    material: diamond_sword
    display name: <&a>Sealed Socket Sword of Extreme Testing
    data:
        lore_list:
        - <&f>It's a test sword!
        - <&6>Sealed Potential
    enchantments:
    - MENDING:1
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt:
        - equipment_type/weapon
        - item_tier/champion
        - sealed_potential/true

prismatic_seer:
    type: assignment
    interact scripts:
    - sockets
    actions:
        on assignment:
        - teleport npc <npc.anchor[prismaticseer]>
        - trigger name:proximity toggle:true
        - trigger name:chat toggle:true

prismatic_seer_format:
    type: format
    format: <dark_green>Prismatic Seer<white><&co> <[text]>

sockets:
    type: interact
    steps:
        Player_Seen*:
            proximity trigger:
                entry:
                    script:
                    - narrate format:prismatic_seer_format "Hello, adventurer. Have you come to unlock the potential of your items?"
                    - narrate format:prismatic_seer_format "With the right materials, I can help you manifest the latent powers of your items. Right click me to see my services."
                exit:
                    script:
                    - narrate format:prismatic_seer_format "Good luck, adventurer. I'll be here if you need me again."
            click trigger:
                script:
                - narrate format:prismatic_seer_format "Okay, here's what I have to offer."
                - wait 1s
                - inventory open d:prismatic_seer_menu
prismatic_seer_menu:
    type: inventory
    inventory: chest
#   title: <white><&font[sxrmenus]><&chr[F808]><&chr[E002]><&chr[F801].repeat[177]><&chr[E006]><&chr[F801].repeat[151]><gold><&font[sxrmenus]><&chr[E004]><&chr[F801].repeat[17]><white><&font[sxrmenus]><&chr[E005]><&chr[F801].repeat[17]><aqua><&font[sxrmenus]><&chr[E004]>
#   temporary title until hiding player inventory works:
    title: <white><&font[sxrmenus]><&chr[F808]><&chr[E002]><&chr[F801].repeat[177]><&chr[E006]><&chr[F801].repeat[177]><&chr[E01E]><&chr[F801].repeat[151]><gold><&font[sxrmenus]><&chr[E004]><&chr[F801].repeat[17]><white><&font[sxrmenus]><&chr[E005]><&chr[F801].repeat[17]><aqua><&font[sxrmenus]><&chr[E004]>
    size: 45
    slots:
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [socket_potential] [] [socket_add] [] [gem_add] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
socket_add:
    type: item
    material: nether_star
    display name: <&a>Unlock a socket on an item
    data:
        lore_list:
        - <&f>Requires <server.flag[SocketAddCost]> Purified Dark Matter and 1 Ingot of Crystallized Experience.
    enchantments:
    - MENDING:1
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        hides:
        - enchants
        - attributes
        custom_model_data: 100001
gem_add:
    type: item
    material: emerald
    display name: <&a>Add a gem to a socket
    data:
        lore_list:
        - <&f>Requires an item with an open socket and a gem of the appropriate type.
    enchantments:
    - MENDING:1
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        hides:
        - enchants
        - attributes
        custom_model_data: 100002
socket_potential:
    type: item
    material: diamond_sword
    display name: <&a>Unlock the <&6>Sealed Potential<&a> of an item
    data:
        lore_list:
        - <&f>Requires an item with <&6>Sealed Potential<&f>, <server.flag[SealedPotentialCost]> Purified Dark Matter, and 1 Ingot of Crystallized Experience.
    enchantments:
    - MENDING:1
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        hides:
        - attributes
        - enchants
        custom_model_data: 101000

prismatic_seer_inventory_handler:
    type: world
    debug: false
    events:
        on server start:
        - wait 30s
        - flag server SocketAddCost:32
        - flag server SealedPotentialCost:64
        on player clicks in prismatic_seer_menu priority:100:
        - determine cancelled
        on player drags in prismatic_seer_menu priority:100:
        - determine cancelled
        on player clicks socket_add in prismatic_seer_menu:
        - determine passively cancelled
        - wait 1t
        - inventory close
#        - narrate format:prismatic_seer_format "You clicked the Add a socket option!"
        - announce to_console <player.inventory.list_contents>
        - if !<player.inventory.contains_item[SocketMaker].quantity[<server.flag[SocketAddCost]>]> || !<player.inventory.contains_item[CrystallizedExperienceIngot].quantity[1]>:
            - inventory close
            - narrate format:prismatic_seer_format "Sorry, you don't have enough materials for that!"
            - stop
        - if <player.inventory.list_contents.filter[flag[sockets_can_add]].size.if_null[null]> >= 1:
            - narrate format:prismatic_seer_format "Okay, now select which of your valid items you'd like to add a socket to."
            - note <inventory[sockets_can_add_inventory]> as:sockets_can_add.<player.uuid>
            - inventory open d:sockets_can_add.<player.uuid>
        - else:
            - narrate format:prismatic_seer_format "Sorry, it looks like you don't have any items I can add a socket to!"
        - narrate format:prismatic_seer_format "Right click me again if you'd like to choose another option!"

        on player clicks gem_add in prismatic_seer_menu:
        - determine passively cancelled
        - wait 1t
        - inventory close
        - announce to_console <player.inventory.list_contents>
        # Add a check to ensure that there is a gem matching the available sockets before opening the inventory?
        # We're not stopping them from closing it so it might just not matter
        - if <player.inventory.list_contents.filter[flag[sockets_open]].size.if_null[null]> >= 1:
            - narrate format:prismatic_seer_format "Okay, now select which of your valid items you'd like to add a gem to."
            - flag <player> sockets_gem_add_item:!
            - flag <player> sockets_gem_add_item_empty:!
            - flag <player> sockets_gem_add_item_types:!
            - flag <player> sockets_gem_add_item_slot_type_list:!
            - note <inventory[sockets_open_inventory]> as:sockets_open.<player.uuid>
            - inventory open d:sockets_open.<player.uuid>
        - else:
            - inventory close
            - narrate format:prismatic_seer_format "Sorry, you don't have any items I can add a gem to!"
        on player clicks socket_potential in prismatic_seer_menu:
        - determine passively cancelled
        - wait 1t
        - inventory close
        - announce to_console <player.inventory.list_contents>
        - if <player.inventory.list_contents.filter[flag[sealed_potential]].size.if_null[null]> >= 1:
            - narrate format:prismatic_seer_format "Okay, now select which of your valid items you'd like to unlock the potential of."
            - note <inventory[potential_inventory]> as:sealed_potential.<player.uuid>
            - inventory open d:sealed_potential.<player.uuid>
        - else:
            - narrate format:prismatic_seer_format "Sorry, it looks like you don't have any items with <&6>Sealed Potential<&f>!"

sockets_can_add_inventory:
    type: inventory
    inventory: chest
    title: <white><&font[sxrmenus]><&chr[F808]><&chr[E002]><&chr[F801].repeat[177]><&chr[E006]>
    size: 45
    slots:
    - [air] [air] [air] [air] [air] [air] [air] [air] [air]
    - [air] [air] [air] [air] [air] [air] [air] [air] [air]
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    procedural items:
    - determine <player.inventory.list_contents.filter[flag[sockets_can_add]]>

sockets_open_inventory:
    type: inventory
    inventory: chest
    title: <white><&font[sxrmenus]><&chr[F808]><&chr[E002]><&chr[F801].repeat[177]><&chr[E006]>
    size: 45
    slots:
    - [air] [air] [air] [air] [air] [air] [air] [air] [air]
    - [air] [air] [air] [air] [air] [air] [air] [air] [air]
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    procedural items:
    - determine <player.inventory.list_contents.filter[flag[sockets_open]]||air>

potential_inventory:
    type: inventory
    inventory: chest
    title: <white><&font[sxrmenus]><&chr[F808]><&chr[E002]><&chr[F801].repeat[177]><&chr[E006]>
    size: 45
    slots:
    - [air] [air] [air] [air] [air] [air] [air] [air] [air]
    - [air] [air] [air] [air] [air] [air] [air] [air] [air]
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    procedural items:
    - determine <player.inventory.list_contents.filter[flag[sealed_potential]]||air>

prismatic_seer_socket_add_handler:
    type: world
    debug: false
    events:
        on player clicks in inventory:
        - if <context.inventory.note_name.if_null[null]> != sockets_can_add.<player.uuid>:
            - stop
        - determine passively cancelled
        - wait 1t
        # Checks if item has locked sockets that can be opened
        - if <context.item.has_flag[sockets_can_add]>:
            - define item <context.item>
            - take raw_exact:<context.item> from:<player.inventory>
            - take scriptname:SocketMaker quantity:<server.flag[SocketAddCost]>
            - take scriptname:CrystallizedExperienceIngot quantity:1
            # Add 1 to the number of sockets currently on the item
            - define item:<[item].with_flag[sockets_current:<[item].flag[sockets_current].if_null[0].add[1]>]>
            # If the item already has sockets...
            - if <[item].list_flags.filter[matches[socket[0-9]+_type]].alphanumeric.size> > 0:
                # Find the last existing socket#_type line
                - define sockets_last_type <[item].list_flags.filter[matches[socket[0-9]+_type]].alphanumeric.last>
                # Set the socket# target as the number from the last socket#_type plus one
                - define socket_target <[sockets_last_type].replace[regex:socket([0-9]+)_type].with[$1].add[1]>
            - else:
                - define socket_target 1
            # Add a new empty socket at the targeted number
            - define item:<[item].with_flag[socket<[socket_target]>_empty:true]>
            # Different socket rolls for weapons and armor
            # In the future, use additional if checks within this section to differentiate classes of weapons or armor for use with Potential
            # Note that this is only for locked sockets - can also just drop weapons and armor with all-unlocked sockets
            - if <[item].flag[equipment_type]> == weapon:
                - define type <tern[<util.random_decimal.is[less].than[0.7]>].pass[attack].fail[utility]>
                - define item:<[item].with_flag[socket<[socket_target]>_type:<[type]>]>
            - if <[item].flag[equipment_type]> == armor:
                - define type <tern[<util.random_decimal.is[less].than[0.7]>].pass[defense].fail[utility]>
                - define item:<[item].with_flag[socket<[socket_target]>_type:<[type]>]>
            - define item:<[item].with_flag[sockets_open:true]>
            - if <[item].flag[sockets_current].if_null[0]> == <[item].flag[sockets_max]>:
                - define item <[item].with_flag[sockets_can_add:!]>
            ## Let's do the lore now y'all
            # Find the locked socket line
            - define locked_socket_line <[item].lore.find_partial[LOCKED]>
            # Define the appropriate line based on socket type
            - if <[item].flag[socket<[socket_target]>_type]> == attack:
                - define "socket_new_lore:<&c>EMPTY<&co> ATTACK"
            - if <[item].flag[socket<[socket_target]>_type]> == defense:
                - define "socket_new_lore:<&9>EMPTY<&co> DEFENSE"
            - if <[item].flag[socket<[socket_target]>_type]> == utility:
                - define "socket_new_lore:<&a>EMPTY<&co> UTILITY"
            - define item <[item].with[lore=<[item].lore.set[<[socket_new_lore]>].at[<[locked_socket_line]>]>]>
            # Finally, give the new item
            - give <[item]> to:<player.inventory>
            - inventory close
            - note remove as:sockets_can_add.<player.uuid>
            - narrate format:prismatic_seer_format "Congratulations, a socket has been added to your <[item].display><&f>!"
        - else if <context.item.material.name> == air:
            - determine cancelled
        - else:
            - narrate format:prismatic_seer_format "Something went wrong! It doesn't look like I can add a socket to that item."
prismatic_seer_socket_potential_handler:
    type: world
    debug: false
    max_sockets:
        veteran: 3
        elite: 4
        champion: 5
    events:
        on player clicks in inventory:
        - if <context.inventory.note_name.if_null[null]> != sealed_potential.<player.uuid>:
            - stop
        - determine passively cancelled
        - wait 1t
        - if !<player.inventory.contains_item[SocketMaker].quantity[<server.flag[SealedPotentialCost]>]> || !<player.inventory.contains_item[CrystallizedExperienceIngot].quantity[1]>:
            - inventory close
            - narrate format:prismatic_seer_format "Sorry, you don't have enough materials for that!"
            - stop
        - if <context.item.has_Flag[sealed_potential]>:
            - define item <context.item>
            - take raw_exact:<context.item> from:<player.inventory>
            - define max_sockets <script.data_key[max_sockets.<context.item.flag[item_tier]>]>
            - define item <[item].with_flag[sealed_potential:!]>
            - foreach <[item].list_flags.filter[matches[socket[0-9]+_empty]].alphanumeric>:
                - define item <[item].with_flag[<[value]>:!]>
            - foreach <[item].list_flags.filter[matches[socket[0-9]+_type]].alphanumeric>:
                - define item <[item].with_flag[<[value]>:!]>
            - foreach <[item].list_flags.filter[matches[socket[0-9]+_gem]].alphanumeric>:
                - define item <[item].with_flag[<[value]>:!]>
            - define item <[item].with_flag[sockets_open:!]>
            - define item <[item].with_flag[sockets_can_add]>
            - define item <[item].with_flag[sockets_current:0]>
            - define item <[item].with_flag[sockets_max:<util.random.int[1].to[<[max_sockets]>]>]>
            - define potential_line <[item].lore.find_partial[Sealed Potential]>
            - define item <[item].with[lore=<[item].lore.set[<&6>Sockets].at[<[potential_line]>]>]>
            - define item <[item].with[lore=<[item].lore.pad_right[<[item].flag[sockets_max].add[<[potential_line]>]>].with[<&8>LOCKED]>]>
            - inventory close
            - note remove as:sealed_potential.<player.uuid>
            - give <[item]>
            - take scriptname:SocketMaker quantity:<server.flag[SealedPotentialCost]>
            - take scriptname:CrystallizedExperienceIngot quantity:1
            - narrate format:prismatic_seer_format "Congratulations, your <[item].display><&r>'s potential has been unlocked!"
        - else if <context.item.material.name> == air:
            - determine cancelled
        - else:
            - narrate format:prismatic_seer_format "Something went wrong! It doesn't look like I can unlock the <&6>Sealed Potential<&f> of that item."
        - narrate format:prismatic_seer_format "Right click me again if you'd like to choose another option!"
prismatic_seer_gem_add_item_handler:
    type: world
    debug: false
    events:
        # Inventory manager for list of items with open sockets to add a gem to
        on player clicks in inventory:
        - if <context.inventory.note_name.if_null[null]> != sockets_open.<player.uuid>:
            - stop
        - determine passively cancelled
        - wait 1t
        - inventory close d:sockets_open.<player.uuid>
        - note remove as:sockets_open.<player.uuid>
        - if <context.item.has_flag[sockets_open]>:
            - define item_sockets_type_list <list[]>
            - define item_sockets_empty <list[]>
            - define valid_gems <list[]>
            - define item_sockets_types <list[]>
            - flag <player> sockets_gem_add_item:<context.item>
            # Should save a list of empty sockets e.g. "li@socket1_empty|socket2_empty" etc.
            - flag <player> sockets_gem_add_item_empty:!|:<context.item.list_flags.filter[matches[socket[0-9]+_empty]].alphanumeric>
            - define item_sockets_empty <context.item.list_flags.filter[matches[socket[0-9]+_empty]].alphanumeric>
            # Returns the empty socket flags, swapped to "type" e.g. "li@socket1_type|socket2_type" etc.
            - define item_sockets_type_list <[item_sockets_empty].parse[replace[empty].with[type]]>
            # Should save a list of empty socket type keys e.g. "li@socket1_type|socket2_type" etc.
            - flag <player> sockets_gem_add_item_slot_type_list:<[item_sockets_type_list]>
            - define item_sockets_type_list <[item_sockets_type_list].deduplicate>
            - foreach <[item_sockets_type_list]>:
                - define valid_gems <[valid_gems].include[<player.inventory.list_contents.filter[flag[gem_type].is[==].to[<context.item.flag[<[value]>]>]].if_null[null]>]>
                - define item_sockets_types <[item_sockets_types].include[<context.item.flag[<[value]>]>]>
            - flag <player> sockets_gem_add_item_types:!|:<[item_sockets_types]>
            - define valid_gems <[valid_gems].deduplicate>
            - if <[valid_gems].size> >= 1:
                - narrate format:prismatic_seer_format "Okay, here are the gems you can add to that item."
                - note <inventory[sockets_gem_add_inventory].include[<[valid_gems]>]> as:sockets_gem_add.<player.uuid>
                - inventory open d:sockets_gem_add.<player.uuid>
            - else:
                - narrate format:prismatic_seer_format "Sorry, you don't have any valid gems for that item."
        - else if <context.item.material.name> == air:
            - determine cancelled
        - else:
            - narrate format:prismatic_seer_format "Something went wrong! It doesn't look like I can add a gem to that item."

sockets_gem_add_inventory:
    type: inventory
    inventory: chest
    title: <white><&font[sxrmenus]><&chr[F808]><&chr[E002]><&chr[F801].repeat[177]><&chr[E006]>
    size: 45
    slots:
    - [air] [air] [air] [air] [air] [air] [air] [air] [air]
    - [air] [air] [air] [air] [air] [air] [air] [air] [air]
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []

prismatic_seer_gem_add_gem_handler:
    type: world
    debug: false
    events:
        # Inventory manager for list of gems that can be added to the item in question
        on player clicks in inventory:
        - if <context.inventory.note_name.if_null[null]> != sockets_gem_add.<player.uuid>:
            - stop
        - determine passively cancelled
        - wait 1t
        - if <player.flag[sockets_gem_add_item_types].contains[<context.item.flag[gem_type].if_null[null]>]>:
            # Returns "li@socket1_empty|socket2_empty" etc
            - define former_item <player.flag[sockets_gem_add_item].as[item]>
            - define item <player.flag[sockets_gem_add_item].as[item]>
            - foreach <player.flag[sockets_gem_add_item_empty].as[list]>:
                ## We're finally adding the gem to the item!
                # <[value-empty]> is socket1_empty etc
                # <[value-type]> is socket1_type etc
                # <[item]> is the selected item
                # Get the flag value of the item's socket with <player.flag[sockets_gem_add_item].flag[<[value-type]>]>
                - define value-empty <[value]>
                - define value-type <[value].replace[empty].with[type]>
                - if <[item].flag[<[value-type]>]> == <context.item.flag[gem_type].if_null[null]>:
                    - inventory close
                    - note remove as:sockets_gem_add.<player.uuid>
                    # Take the item and gem
                    - take raw_exact:<[item]> from:<player.inventory>
                    - take raw_exact:<context.item> from:<player.inventory>
                    ## Adjust the flag data
                    # Delete the flag for the empty socket being filled
                    - define item <[item].with_flag[<[value]>:!]>
                    # Add flag to indicate the gem being added
                    - define item <[item].with_flag[<[value].replace[empty].with[gem]>:<context.item.flag[gem_specific]>]>
                    ## Handle any attributes, if they exist
                    - define attributes_list <context.item.flag[gem_attributes]>
                    - foreach <[attributes_list]> as:attribute:
                        - define item <[item].with[add_attribute_modifiers:<[attribute]>]>
                    ## Adjust the lore
                    # First line after "<&6>Sockets"
                    - define first_socket_line <[item].lore.find_partial[Sockets]>
                    # Line where our targeted socket is
                    - define socket_target <[value-empty].replace[regex:socket([0-9]+)_empty].with[$1].add[<[first_socket_line]>]>
                    # Set up the lore line for the socket
                    # Can probably eliminate this if chain if gems have standardized colors for their names
                    - if <context.item.flag[gem_type]> == attack:
                        - define socket_new_line:<&c><context.item.display.strip_color>
                    - else if <context.item.flag[gem_type]> == defense:
                        - define socket_new_line:<&9><context.item.display.strip_color>
                    - else if <context.item.flag[gem_type]> == utility:
                        - define socket_new_line:<&a><context.item.display.strip_color>
                    - define item <[item].with[lore=<[item].lore.set[<[socket_new_line]>].at[<[socket_target]>]>]>
                    # Check whether any open sockets remain; if not, remove sockets_open
                    - if <[item].list_flags.filter[matches[socket[0-9]+_empty]].alphanumeric.size> == 0:
                        - define item <[item].with_flag[sockets_open:!]>
                    # Give the new item
                    - give <[item]>
                        #- narrate format:prismatic_seer_format "This is where I tell you that I added the gem to the socket!"
                        #- announce to_console "Hooray!"
                    #- else:
                    #    - narrate format:prismatic_seer_format "Something went wrong! Here are your items back."
                    #    - give <context.item>
                    #    - give <[former_item]>
                    - foreach stop
        - else if <context.item.material.name> == air:
            - determine cancelled
        - else:
            - inventory close
            - note remove as:sockets_gem_add.<player.uuid>
            - narrate format:prismatic_seer_format "Sorry, I can't add that gem to that item!"
