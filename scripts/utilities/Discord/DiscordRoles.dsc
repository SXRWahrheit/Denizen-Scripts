PatreonRoleSync:
    type: world
    debug: false
    events:
        on discord message received channel:191040977652285450:
        - if <context.new_message.text> != !rolesync && <context.new_message.text.split[<&sp>].get[1]> != !linkminecraft:
            - stop
        - if <context.new_message.text> == !rolesync:
            - discord id:sxr add_role user:<context.new_message.author.id> role:191040935633616896,458328476248965120 group:191040935633616896
            - wait 1s
            - discord id:sxr remove_role user:<context.new_message.author.id> role:191040935633616896,458328476248965120 group:191040935633616896
        - else if <context.new_message.text.split[<&sp>].get[1]> == !linkminecraft:
            - if <server.match_offline_player[<context.new_message.text.split[<&sp>].get[2]>].if_null[null]> != null:
                - flag server discord-user_<context.new_message.author.id>.minecraft-player:<server.match_offline_player[<context.new_message.text.split[<&sp>].get[2]>]>
                - discord id:sxr add_role user:<context.new_message.author.id> role:191040935633616896,458328476248965120 group:191040935633616896
                - wait 1s
                - discord id:sxr remove_role user:<context.new_message.author.id> role:191040935633616896,458328476248965120 group:191040935633616896
                - discord id:sxr message channel:191040977652285450 "<&lt>@<context.new_message.author.id><&gt>, you linked your Discord account to the Minecraft player <server.match_offline_player[<context.new_message.text.split[<&sp>].get[2]>].name>! If this is in error, please feel free to try again, or contact Wahrheit."
            - else:
                - discord id:sxr message channel:191040977652285450 "<&lt>@<context.new_message.author.id><&gt>, something went wrong! Please feel free to try again, or contact Wahrheit."
        on discord user role changes:
        - if <server.has_flag[discord-user_<context.user.id>.minecraft-player]>:
            - if <context.new_roles.parse_tag[<[parse_value].id>].contains[458328498608799774]>:
                - group add Patron player:<server.flag[discord-user_<context.user.id>.minecraft-player]>
                - group add GenerousPatron player:<server.flag[discord-user_<context.user.id>.minecraft-player]>
                - group add EsteemedPatron player:<server.flag[discord-user_<context.user.id>.minecraft-player]>
            - else if <context.new_roles.parse_tag[<[parse_value].id>].contains[458328312054546432]>:
                - group add Patron player:<server.flag[discord-user_<context.user.id>.minecraft-player]>
                - group add GenerousPatron player:<server.flag[discord-user_<context.user.id>.minecraft-player]>
            - else if <context.new_roles.parse_tag[<[parse_value].id>].contains[387095048015314956]>:
                - group add Patron player:<server.flag[discord-user_<context.user.id>.minecraft-player]>
            - else:
                - group remove Patron player:<server.flag[discord-user_<context.user.id>.minecraft-player]>
                - group remove GenerousPatron player:<server.flag[discord-user_<context.user.id>.minecraft-player]>
                - group remove EsteemedPatron player:<server.flag[discord-user_<context.user.id>.minecraft-player]>
                - group remove Duke player:<server.flag[discord-user_<context.user.id>.minecraft-player]>
                - group remove GenerousDuke player:<server.flag[discord-user_<context.user.id>.minecraft-player]>
                - group remove EsteemedDuke player:<server.flag[discord-user_<context.user.id>.minecraft-player]>
                - group remove Duchess player:<server.flag[discord-user_<context.user.id>.minecraft-player]>
                - group remove GenerousDuchess player:<server.flag[discord-user_<context.user.id>.minecraft-player]>
                - group remove EsteemedDuchess player:<server.flag[discord-user_<context.user.id>.minecraft-player]>