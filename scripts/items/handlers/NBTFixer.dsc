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
    - foreach <player.inventory.map_slots> key:slot as:item:
        - foreach next if:<[item].has_flag[item_tier]>
        - if <[item].lore.contains_match[*Veteran*].if_null[false]>:
            - inventory flag slot:<[slot]> item_tier:Veteran
        - else if <[value].lore.contains_match[*Elite*].if_null[false]>:
            - inventory flag slot:<[slot]> item_tier:Elite
        - else if <[value].lore.contains_match[*Champion*].if_null[false]>:
            - inventory flag slot:<[slot]> item_tier:Champion
    - foreach <player.inventory.map_slots.filter_tag[<[filter_value].all_raw_nbt.contains[Denizen NBT]>]> key:slot as:item:
        - foreach <[item].all_raw_nbt.get[Denizen NBT].parse_value_tag[<[parse_value].after[string:]>]> as:nbt:
            - inventory flag slot:<[slot]> <[key]>:<[nbt]>
        - inventory adjust slot:<[slot]> remove_nbt
    - foreach <player.inventory.map_slots.filter_tag[<[filter_value].has_flag[item_tier]>]> key:slot as:item:
        - if <[item].lore.exists.not>:
            - inventory flag slot:<[slot]> item_tier:!