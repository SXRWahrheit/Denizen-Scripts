Start_Discord_Bot:
    type: world
    debug: false
    events:
        on server start:
        - wait 80s
        - run Connect_Denizen_Bot
        - announce to_console "Denizen Bot has successfully loaded"
Discord_Startup_Test:
    type: task
    debug: false
    script:
    - wait 5s
    - run Connect_Denizen_Bot
    - announce to_console "Denizen Bot has successfully loaded via the test script"
New_Player_Alert:
    type: world
    debug: false
    events:
        on player logs in for the first time:
        - ~discordmessage id:sxr channel:343105813293826059 "<&lt><&at>&223441207341219840<&gt>, **<player.name>** has joined the server for the first time! Say hello in <&lt><&ns>191040977652285450<&gt>!"
        - announce "<red>The Gods speak<white>: <player.name> is new to the server, please welcome them!"
Death_Message_Repeater:
    type: world
    debug: false
    events:
        after player dies:
        - announce to_console <context.message>
        #- ~discordmessage id:sxr channel:191040977652285450 ":skull: <context.message>"
#Emoji format: "<&lt>:kappa:327884375410737153<&gt>"
