# This thing makes the maze marked as complete when you talk to the NPC at the end
# It was written by Wahrheit and you better believe it
# @author Wahrheit
# @version 1.0
# @last-updated December 16 2014

Bookkeeper_Assign:
    type: assignment
    interact scripts:
    - Bookkeeper
    actions:
        on assignment:
        - run Bookkeeper_Assigned instant
Bookkeeper_Format:
    type: format
    format: <gray>Bookkeeper<white><&co> <[text]>
Bookkeeper_Assigned:
    type: task
    script:
    - teleport npc location:<npc.anchor[bookkeeper]>
    - trigger name:proximity toggle:true radius:3
library_win:
    type: task
    script:
    - flag server mazeclear:1
    - announce "<green><player.name> has conquered The Grand Library! It is now clear."
    - flag server maze-challenger:!
    - flag server maze-challenger-name:!
Bookkeeper:
    type: interact
    steps:
        'Victory*':
            click trigger:
                script:
                - if <player.uuid> == <server.flag[maze-challenger]>:
                  - run library_win