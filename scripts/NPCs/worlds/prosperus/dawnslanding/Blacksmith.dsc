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