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
        - if <[item].lore.filter[contains_text[Veteran]].is_truthy>:
            - inventory flag slot:<[slot]> item_tier:Veteran
        - else if <[value].lore.filter[contains_text[Elite]].is_truthy>:
            - inventory flag slot:<[slot]> item_tier:Elite
        - else if <[value].lore.filter[contains_text[Champion]].is_truthy>:
            - inventory flag slot:<[slot]> item_tier:Champion
    - foreach <player.inventory.map_slots.filter_tag[<[filter_value].nbt.exists>].filter_tag[<[filter_value].has_flag[nbt_converted].not>]> key:slot as:item:
        - foreach <[item].nbt.to_map> as:nbt:
            - inventory flag slot:<[slot]> <[key]>:<[nbt]>
        - inventory adjust slot:<[slot]> remove_nbt
        - inventory flag slot:<[slot]> nbt_converted