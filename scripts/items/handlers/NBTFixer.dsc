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
    - foreach <player.inventory.list_contents.filter_tag[<[filter_value].lore.contains_any_text[Veteran|Elite|Champion]||null>].filter_tag[<[filter_value].has_nbt[item_tier].not>]>:
        - if <[value].lore.contains_text[Veteran]>:
            - if <[value].nbt||null>:
                - inventory adjust slot:<player.inventory.find[<[value]>]> nbt:<[value].nbt.include[item_tier/Veteran]>
            - else:
                - inventory adjust slot:<player.inventory.find[<[value]>]> nbt:item_tier/Veteran
        - else if <[value].lore.contains_text[Elite]>:
            - if <[value].nbt||null>:
                - inventory adjust slot:<player.inventory.find[<[value]>]> nbt:<[value].nbt.include[item_tier/Elite]>
            - else:
                - inventory adjust slot:<player.inventory.find[<[value]>]> nbt:item_tier/Elite
        - else if <[value].lore.contains_text[Champion]>:
            - if <[value].nbt||null>:
                - inventory adjust slot:<player.inventory.find[<[value]>]> nbt:<[value].nbt.include[item_tier/Champion]>
            - else:
                - inventory adjust slot:<player.inventory.find[<[value]>]> nbt:item_tier/Champion
