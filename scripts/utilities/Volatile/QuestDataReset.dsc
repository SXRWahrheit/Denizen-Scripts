QuestDataReset:
    type: task
    script:
    - flag <player> old_quests_data_converted:!
    - if <server.has_file[playerdata/<player.uuid>/quest_data.yml]>:
        - adjust server delete_file:playerdata/<player.uuid>/quest_data.yml