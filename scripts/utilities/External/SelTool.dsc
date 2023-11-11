# +----------------------
# |
# | S e l e c t o r   T o o l
# |
# | Handy tool to make noted areas (cuboids, ellipsoids, polygons).
# |
# +----------------------
#
# @author mcmonkey
# @date 2022-04-08
# @denizen-build REL-1765
# @script-version 2.1
#
# Installation:
# Just put the script in your scripts folder and reload.
#
# Usage:
# Type command "/seltool" to get a cuboid selector tool.
# Or "/seltool ellipsoid" for ellipsoids, "sphere" for spheres, or "polygon" for polygons.
# Requires permission "selector_tool.seltool"
#
# While holding a cuboid, ellipsoid, or sphere tool, left click to start a selection and right click to expand the selection.
#
# While holding a polygon tool, left click to start a selection, and right click to add a corner.
# Corners must be in a consistent order (you can't go back and forth).
# Use "/selheight" to raise or lower the polygon height to your current player height, or "/selheight 100" to raise or lower the polygon height to Y=100 for example.
# Requires permission "selector_tool.selheight"
#
# Use "/selnote [name]" to note your selected area as the name. For example, "/selnote myshop" adds noted area 'myshop'.
# Requires permission "selector_tool.selnote"
#
# Use "/selshow" to show your current cuboid selection.
# Requirers permission "selector_tool.selshow"
#
# If you have Depenizen and WorldEdit, this will automatically send your selections to WorldEdit as well.
#
# In a script or "/ex" command, use "<player.has_flag[seltool_selection]>" to check if the player has a selection.
# and "<player.flag[seltool_selection]>" to get the selected area.
# Flag "seltool_type" defines the current selection type (cuboid, ellipsoid, sphere, polygon).
#
# ---------------------------- END HEADER ----------------------------

selector_tool_item:
    type: item
    debug: false
    material: blaze_rod
    display name: <&[item]>Unknown Selector Tool
    enchantments:
    - vanishing_curse:1
    mechanisms:
        hides: ENCHANTS
    lore:
    - <&[lore]>Left click to start a selection.
    - <&[lore]>Right click to expand the selection.

seltool_command:
    type: command
    debug: false
    name: seltool
    aliases:
    - ctool
    - cuboidtool
    - etool
    - elliptool
    - ellipsoidtool
    - spheretool
    - ptool
    - polygontool
    - wand
    # NOTE: Remove the below alias if you want the WorldEdit "//wand" command to give you a WorldEdit wand instead of a SelTool
    - /wand
    permission: selector_tool.seltool
    description: Gets a selector tool.
    usage: /seltool (type)
    tab completions:
        1: cuboid|ellipsoid|sphere|polygon
    data:
        polygon_lore:
        - <&[lore]>Left click to start a polygon selection.
        - <&[lore]>Right click to add a corner to the polygon.
        - <&[lore]>Use <&[emphasis]>/pheight <&[lore]>to expand the vertical height.
    script:
    - define type cuboid
    - if <context.args.size> >= 1:
        - define type <context.args.first>
        - if <[type]> not in cuboid|ellipsoid|sphere|polygon:
            - narrate "<&[error]>Invalid selector type. Choose one of: <&[emphasis]>cuboid, ellipsoid, sphere, polygon"
            - stop
    - else if <context.alias> in ptool|polygontool:
        - define type polygon
    - else if <context.alias> in etool|elliptool|ellipsoidtool:
        - define type ellipsoid
    - else if <context.alias> in spheretool:
        - define type sphere
    - definemap adjustments:
         display: <&[item]><[type].to_titlecase> Selector Tool
         flag: selector_type:<[type]>
    - if <[type]> == polygon:
        - define adjustments.lore:<script.parsed_key[data.polygon_lore]>
    - give <item[selector_tool_item].with_map[<[adjustments]>]>
    - narrate "<&[base]>Here's your <&[emphasis]><[type]><&[base]> selector tool!"

selheight_command:
    type: command
    debug: false
    name: selheight
    aliases:
    - pheight
    - polygonheight
    permission: selector_tool.selheight
    description: Sets the vertical range of your area selection to include the specified Y-height (or your own height) (meant for use with polygons).
    usage: /selheight (y)
    script:
    - if !<player.has_flag[seltool_selection]>:
        - narrate "<&[error]>You don't have any area selected."
        - stop
    - define y <context.args.get[1]||<player.location.y>>
    - if !<[y].is_decimal>:
        - narrate "<&[error]>Y value must be a number."
        - stop
    - choose <player.flag[seltool_type]>:
        - case polygon:
            - flag player seltool_selection:<player.flag[seltool_selection].include_y[<[y]>]>
        - case cuboid ellipsoid:
            - define new_loc <player.flag[seltool_selection].bounding_box.center.with_y[<[y]>]>
            - flag player seltool_selection:<player.flag[seltool_selection].include[<[new_loc]>]>
        - case sphere:
            - define cur_size <player.flag[seltool_selection].size.x>
            - define new_size <player.flag[seltool_selection].location.y.sub[<[y]>].abs>
            - if <[new_size]> < <[cur_size]>:
                - define new_size <[cur_size]>
            - flag player seltool_selection:<player.flag[seltool_selection].with_size[<[new_size]>,<[new_size]>,<[new_size]>]>
    - inject selector_tool_status_task path:<player.flag[seltool_type]>
    - if <player.flag[seltool_type]> == polygon:
        - define min_y <player.flag[seltool_selection].min_y.round_to[2]>
        - define max_y <player.flag[seltool_selection].max_y.round_to[2]>
    - else:
        - define min_y <player.flag[seltool_selection].bounding_box.min.y>
        - define max_y <player.flag[seltool_selection].bounding_box.max.y>
    - narrate "<&[base]>Selected area heights updated to min <&[emphasis]><[min_y]> <&[base]>max <&[emphasis]><[max_y]><&[base]>."

selnote_command:
    type: command
    debug: false
    name: selnote
    aliases:
    - cnote
    - cuboidnote
    - enote
    - pnote
    - polygonnote
    permission: selector_tool.selnote
    description: Notes your selected area.
    usage: /selnote [name]
    script:
    - if !<player.has_flag[seltool_selection]>:
        - narrate "<&[error]>You don't have any area selected."
        - stop
    - if <context.args.size> != 1:
        - narrate "/selnote [name]"
        - stop
    - note <player.flag[seltool_selection]> as:<context.args.get[1]>
    - inject selector_tool_status_task path:<player.flag[seltool_type]>
    - narrate "<&[base]><[message]><&[base]> noted as <&[emphasis]><context.args.get[1]><&[base]>."

selshow_command:
    type: command
    debug: false
    name: selshow
    aliases:
    - cshow
    - cuboidshow
    - eshow
    - pshow
    permission: selector_tool.selshow
    description: Shows your selected area.
    usage: /selshow
    script:
    - if !<player.has_flag[seltool_selection]>:
        - narrate "<&[error]>You don't have any area selected."
        - stop
    - inject selector_tool_status_task path:<player.flag[seltool_type]>
    - narrate <[message]>

selector_tool_status_task:
    type: task
    debug: false
    script:
    - debug error "Improperly called"
    cuboid:
    - define cuboid <player.flag[seltool_selection]>
    - define min <&[emphasis]><[cuboid].min.xyz.replace_text[,].with[<&[base]>, <&[emphasis]>]><&[base]>
    - define max <&[emphasis]><[cuboid].max.xyz.replace_text[,].with[<&[base]>, <&[emphasis]>]><&[base]>
    - define size <&[emphasis]><[cuboid].size.xyz.replace_text[,].with[<&[base]>, <&[emphasis]>]><&[base]>
    - define volume <&[emphasis]><[cuboid].volume><&[base]>
    - define message "<&[base]>Cuboid selection: from <[min]> to <[max]> (size <[size]>, volume <[volume]>)"
    - actionbar <[message]>
    # Loose approximation of the cuboid's scale to prevent trying to spawn a trillion particles
    - define approx_scale <[cuboid].size.vector_length>
    - if <[approx_scale]> < 200:
        - playeffect effect:flame at:<[cuboid].shell.parse[center]> offset:0 targets:<player> visibility:32
    - if <[approx_scale]> < 1000:
        - playeffect effect:block_marker special_data:barrier at:<[cuboid].outline.parse[center]> offset:0 targets:<player> visibility:64
        - define center <[cuboid].center>
        - playeffect effect:block_marker special_data:glass at:<[cuboid].with_min[<[cuboid].min.with_x[<[center].x>]>].with_max[<[cuboid].max.with_x[<[center].x>]>].outline.parse[center]> offset:0 targets:<player> visibility:64
        - playeffect effect:block_marker special_data:glass at:<[cuboid].with_min[<[cuboid].min.with_y[<[center].y>]>].with_max[<[cuboid].max.with_y[<[center].y>]>].outline.parse[center]> offset:0 targets:<player> visibility:64
        - playeffect effect:block_marker special_data:glass at:<[cuboid].with_min[<[cuboid].min.with_z[<[center].z>]>].with_max[<[cuboid].max.with_z[<[center].z>]>].outline.parse[center]> offset:0 targets:<player> visibility:64
    ellipsoid:
    - define ellipsoid <player.flag[seltool_selection]>
    - define loc <&[emphasis]><[ellipsoid].location.block.xyz.replace_text[.0].replace_text[,].with[<&[base]>, <&[emphasis]>]><&[base]>
    - define size_text <&[emphasis]><[ellipsoid].size.block.xyz.replace_text[.0].replace_text[,].with[<&[base]>, <&[emphasis]>]><&[base]>
    - define message "<&[base]>Ellipsoid selection: at <[loc]>, size <[size_text]>"
    - actionbar <[message]>
    - playeffect effect:flame at:<[ellipsoid].shell> offset:0 targets:<player>
    - define size <[ellipsoid].size>
    - define y_subellipse <[ellipsoid].with_size[<[size].with_y[0.5]>]>
    - define y_shrunkellipse <[ellipsoid].with_size[<[size].x.sub[1]>,1,<[size].z.sub[1]>]>
    - playeffect effect:block_marker special_data:barrier at:<[y_subellipse].shell.exclude[<[y_shrunkellipse].shell>]> offset:0 targets:<player>
    - define x_subellipse <[ellipsoid].with_size[<[size].with_x[0.5]>]>
    - define x_shrunkellipse <[ellipsoid].with_size[1,<[size].y.sub[1]>,<[size].z.sub[1]>]>
    - playeffect effect:block_marker special_data:barrier at:<[x_subellipse].shell.exclude[<[x_shrunkellipse].shell>]> offset:0 targets:<player>
    - define z_subellipse <[ellipsoid].with_size[<[size].with_z[0.5]>]>
    - define z_shrunkellipse <[ellipsoid].with_size[<[size].x.sub[1]>,<[size].y.sub[1]>,1]>
    - playeffect effect:block_marker special_data:barrier at:<[z_subellipse].shell.exclude[<[z_shrunkellipse].shell>]> offset:0 targets:<player>
    sphere:
    - inject <script> path:ellipsoid
    polygon:
    - define polygon <player.flag[seltool_selection]>
    - define message "<&[base]>Polygon selection: in <&[emphasis]><[polygon].world.name> <&[base]>from Y <&[emphasis]><[polygon].min_y.round_to[2]> <&[base]>to <&[emphasis]><[polygon].max_y.round_to[2]> <&[base]>with <&[emphasis]><[polygon].corners.size> <&[base]>corners"
    - actionbar <[message]>
    - if <[polygon].corners.size> >= 3:
        # Loose approximation of the polygon's scale to prevent trying to spawn a trillion particles
        - define approx_scale <[polygon].bounding_box.max.sub[<[polygon].bounding_box.min>].vector_length>
        - if <[approx_scale]> < 200:
            - playeffect effect:flame at:<[polygon].shell> offset:0 targets:<player> visibility:32
        - if <[approx_scale]> < 1000:
            - playeffect effect:block_marker special_data:barrier at:<[polygon].outline> offset:0 targets:<player> visibility:32

selector_tool_leftclick_task:
    type: task
    debug: false
    script:
    - define location <context.location||null>
    - if <[location].material.name||air> == air:
        - define location <player.cursor_on[30]||null>
        - if <[location].material.name||air> == air:
            - stop
    - define type <player.item_in_hand.flag[selector_type]>
    - flag player seltool_type:<[type]>
    - choose <[type]>:
        - case cuboid:
            - flag player seltool_selection:<[location].to_cuboid[<[location]>]>
        - case ellipsoid sphere:
            - flag player seltool_selection:<[location].to_ellipsoid[1,1,1]>
        - case polygon:
            - flag player seltool_selection:<list[<[location]>].to_polygon.include_y[<[location].y.add[2]>]>
    - inject selector_tool_status_task path:<[type]>
    - if <plugin[Depenizen].exists> && <plugin[WorldEdit].exists>:
        - adjust <player> we_selection:<player.flag[seltool_selection]>
    - determine cancelled

selector_tool_world:
    type: world
    debug: false
    events:
        # Basic usage logic
        on player left clicks block with:selector_tool_item:
        - inject selector_tool_leftclick_task
        on player right clicks block with:selector_tool_item:
        - define location <context.location||null>
        - if <[location].material.name||air> == air:
            - define location <player.cursor_on[30]||null>
            - if <[location].material.name||air> == air:
                - stop
        - if !<player.has_flag[seltool_selection]>:
            - inject selector_tool_leftclick_task
            - stop
        - define type <player.item_in_hand.flag[selector_type]>
        - if <player.flag[seltool_selection].world.name> != <[location].world.name> || <player.flag[seltool_type]> != <[type]>:
            - narrate "<&[error]>You must restart your selection by left clicking."
            - stop
        - choose <[type]>:
            - case cuboid ellipsoid:
                - flag player seltool_selection:<player.flag[seltool_selection].include[<[location]>]>
            - case sphere:
                - define cur_size <player.flag[seltool_selection].size.x>
                - define new_size <player.flag[seltool_selection].location.distance[<[location]>]>
                - if <[new_size]> < <[cur_size]>:
                    - define new_size <[cur_size]>
                - flag player seltool_selection:<player.flag[seltool_selection].with_size[<[new_size]>,<[new_size]>,<[new_size]>]>
            - case polygon:
                - flag player seltool_selection:<player.flag[seltool_selection].with_corner[<[location]>].include_y[<[location].y>]>
        - inject selector_tool_status_task path:<[type]>
        - if <plugin[Depenizen].exists> && <plugin[WorldEdit].exists>:
            - adjust <player> we_selection:<player.flag[seltool_selection]>
        - determine cancelled
        # Prevent misuse
        after player drops selector_tool_item:
        - remove <context.entity>
        on player clicks in inventory with:selector_tool_item:
        - inject selector_tool_world.abuse_prevention_click
        on player drags selector_tool_item in inventory:
        - inject selector_tool_world.abuse_prevention_click
    abuse_prevention_click:
    - if <context.inventory.inventory_type> == player:
        - stop
    - if <context.inventory.inventory_type> == crafting:
        - if <context.raw_slot||<context.raw_slots.numerical.first>> >= 6:
            - stop
    - determine passively cancelled
    - inventory update