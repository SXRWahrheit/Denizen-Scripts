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
                - if <player.inventory.map_slots.filter_tag[<[filter_value].nbt.exists>].filter_tag[<[filter_value].has_flag[nbt_converted].not>].is_truthy>:
                    - narrate format BlacksmithFormat "Say, looks like you have some items that could use some magical repairs. Let me take care of that for you!"
                    - inject Item_Tier_Fixer
                    - narrate format BlacksmithFormat "All fixed up!"