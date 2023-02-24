Item_Tier_Fixer_Join:
    type: world
    debug: false
    events:
        after player joins:
        - inject Item_Tier_Fixer

Item_Tier_Fixer:
    type: task
    debug: false
    script:
    - foreach <player.inventory.list_contents.filter_tag[<[filter_value].lore.contains_any_text[Veteran|Elite|Champion].if_null[false]>].filter_tag[<[filter_value].has_flag[item_tier].not>]>:
        - if <[value].lore.contains_text[Veteran]>:
            - inventory flag slot:<player.inventory.find_item[<[value]>]> item_tier:Veteran
        - else if <[value].lore.contains_text[Elite]>:
            - inventory flag slot:<player.inventory.find_item[<[value]>]> item_tier:Elite
        - else if <[value].lore.contains_text[Champion]>:
            - inventory flag slot:<player.inventory.find_item[<[value]>]> item_tier:Champion
    - foreach <player.inventory.list_contents.filter_tag[<[filter_value].nbt.exists>].filter_tag[<[filter_value].has_flag[nbt_converted].not>]> as:item:
        - foreach <[item].nbt> as:nbt:
            - define slot <player.inventory.find_item[<[item]>]>
            - inventory flag slot:<[slot]> <[item].nbt.get[<[loop_index]>].before[/]>:<[item].nbt.get[<[loop_index]>].after[/]>
            - inventory adjust slot:<[slot]> remove_nbt
            - inventory flag slot:<[slot]> nbt_converted