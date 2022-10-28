NPC_Assignment_Reset:
    type: task
    script:
    - foreach <server.npcs> as:npc:
        - assignment remove npc:<[npc]>