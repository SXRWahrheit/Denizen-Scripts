QuestDataReset:
    type: task
    script:
    - flag <player> old_quests_data_converted:!
    - if <util.has_file[playerdata/<player.uuid>/quest_data.yml]>:
        - adjust system delete_file:playerdata/<player.uuid>/quest_data.yml