FireStorm_Power_Handler:
    type: world
    debug: false
    events:
        on magicspells player casts firestorm:
        - define fire_power <proc[Magic_Power_Handler].context[fire]>
        - determine power:<element[1].add[<[fire_power].sub[100].div[100].mul[0.5]>]>