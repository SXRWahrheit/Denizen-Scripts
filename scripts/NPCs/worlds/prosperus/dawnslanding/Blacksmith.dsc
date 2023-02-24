BlacksmithAssignment:
    type: assignment
    interact scripts:
    - BlacksmithInteract
    actions:
        on assignment:
        - trigger name:proximity state:true
        - trigger name:chat state:true

BlacksmithFormat:
    type: format
    format: <dark_green>Blacksmith<white><&co> <[text]>

BlacksmithInteract:
    type: interact
    steps:
        Greeting*:
            proximity trigger:
                entry:
                    script:
                    - narrate format:BlacksmithFormat "Welcome to my forge, <player.name>!"
            click trigger:
                script:
                - if <player.inventory.list_contents.filter_tag[<[filter_value].lore.contains_any_text[Veteran|Elite|Champion]>].filter_tag[<[filter_value].has_nbt[item_tier].not>].size> > 0:
                    - narrate format BlacksmithFormat "Say, looks like you have some items that could use some updates. Let me take care of that for you!"
                    - inject Item_Tier_Fixer