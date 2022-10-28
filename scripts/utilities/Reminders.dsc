InformationRotation:
    type: world
    debug: false
    events:
        on system time minutely:
        - if <context.minute.mod[20]> == 0:
            #- execute as_server save-all
            - random:
                - repeat 1:
                    - announce "<&a>Support the server and get cosmetic perks by backing us on <&b>Patreon<&a>! <&a>Type <&b>/patreon<&a> for more information!"
                - repeat 1:
                    - announce "<&a>Get new ranks and powers by ranking up! For more info, visit <&b>http://summaxr.com/mcranks<&a> to see requirements!"
                - repeat 1:
                    - announce "<&a>Fight your friends and slaughter your enemies in our PVP arenas! Type <&b>/pa list<&a> to find an arena! Use <&b>/pa <&lt>arenaname<&gt><&a> to join or start a match, then punch the Gladiator sign and the lapis block in order to get into the fray!"
                - repeat 1:
                    - announce "<&a>Don't forget to give us a like on Facebook to stay updated on current events! We also regularly feature the coolest stuff players do and build on the server! <&b>https://facebook.com/SummaCrossroads"
                - repeat 1:
                    - announce "<&a>Check out the awesome online map, type <&b>/map<&a> for details!"
                - repeat 1:
                    - announce "<&a>Test your combat skills in the Mob Arenas! We provide the gear, you just bring your battle! Type <&b>/ma arenas<&a>, pick one with <&b>/ma j <&lt>arenaname<&gt><&a>, then punch your class sign of choice, and punch the iron block to ready up! It's a cooperative game mode, so bring your friends to win fabulous prizes!"
                - repeat 1:
                    - announce "<&a>Contribute to the C.A.S.H. Program for Mob Design! Your designs for new mobs will be added to the server, and you'll be compensated for your efforts! <&b>http://bit.ly/2jZsKqE"
                - repeat 1:
                    - announce "<&a>Contribute to the C.A.S.H. Program for Creative Building! Your builds will be used on the server, and you'll be compensated for your efforts! <&b>http://bit.ly/2lliDxv"
                - repeat 1:
                    - announce "<&a>You can discover and travel to magical warp points throughout the server! View your unlocked warps with <&b>/ftw<&a> and travel to any of them for the listed price in gold with <&b>/ftw <&lt>warpname<&gt>"
#                - repeat 1:
#                    -

