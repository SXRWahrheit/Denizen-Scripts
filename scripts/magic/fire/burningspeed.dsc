BurningSpeed_Power_Handler:
    type: world
    debug: false
    events:
        on magicspells player casts burningspeed:
        - define fire_power <proc[Magic_Power_Handler].context[fire]>
        - determine power:<[fire_power].div[100]>