QuestDataConverter:
    debug: false
    type: world
    events:
        on player joins:
        - wait 2s
        - define data <player.uuid>_quest_data
        - define olddata <player.uuid>_quest_data_old
        - if <util.has_file[../Quests/data/<player.uuid>.yml]> && !<player.has_flag[old_quests_data_converted]>:
            - yaml load:../Quests/data/<player.uuid>.yml id:<[olddata]>
            - yaml set id:<[data]> career.quest_points:<yaml[<[olddata]>].read[quest-points]>
            - foreach <yaml[<[olddata]>].read[completed-Quests]> as:CompletedQuest:
                - yaml set id:<[data]> quests.completed.<yaml[QuestsConversionMap].read[<[CompletedQuest]>]>.completion_count:1
            - foreach <yaml[<[olddata]>].read[amountsCompletedQuests]> as:RedoableQuest:
                - if <yaml[<[olddata]>].read[amountsCompleted].get[<[loop_index]>]||0> >= 1:
                    - yaml set id:<[data]> quests.completed.<yaml[QuestsConversionMap].read[<[RedoableQuest]>]>.completion_count:<yaml[<[olddata]>].read[amountsCompleted].get[<[loop_index]>]||1>
            - foreach <yaml[<[olddata]>].read[currentQuests]> as:CurrentQuest:
                - define cqinternalname <yaml[QuestsConversionMap].read[<[CurrentQuest]>]>
                - yaml id:<[cqinternalname]> copykey:player_data.<[cqinternalname]> quests.active.<[cqinternalname]> to_id:<[data]>
            - flag <player> old_quests_data_converted:true
        on server start:
        - yaml load:scriptdata/quests/ConversionMap.yml id:QuestsConversionMap

QuestsDataConverterTaskUnsafe:
    type: task
    debug: false
    script:
    - define data <player.uuid>_quest_data
    - define olddata <player.uuid>_quest_data_old
    - if <util.has_file[../Quests/data/<player.uuid>.yml]>:
        - yaml load:../Quests/data/<player.uuid>.yml id:<[olddata]>
        - yaml set id:<[data]> career.quest_points:<yaml[<[olddata]>].read[quest-points]>
        - foreach <yaml[<[olddata]>].read[completed-Quests]> as:CompletedQuest:
            - yaml set id:<[data]> quests.completed.<yaml[QuestsConversionMap].read[<[CompletedQuest]>]>.completion_count:1
        - foreach <yaml[<[olddata]>].read[amountsCompletedQuests]> as:RedoableQuest:
            - if <yaml[<[olddata]>].read[amountsCompleted].get[<[loop_index]>]||0> >= 1:
                - yaml set id:<[data]> quests.completed.<yaml[QuestsConversionMap].read[<[RedoableQuest]>]>.completion_count:<yaml[<[olddata]>].read[amountsCompleted].get[<[loop_index]>]||1>
        - foreach <yaml[<[olddata]>].read[currentQuests]> as:CurrentQuest:
            - define cqinternalname <yaml[QuestsConversionMap].read[<[CurrentQuest]>]>
            - yaml id:<[cqinternalname]> copykey:player_data.<[cqinternalname]> quests.active.<[cqinternalname]> to_id:<[data]>
        - flag <player> old_quests_data_converted:true

QuestsDataConverterTask:
    type: task
    debug: false
    script:
    - define data <player.uuid>_quest_data
    - define olddata <player.uuid>_quest_data_old
    - if <util.has_file[../Quests/data/<player.uuid>.yml]> && !<player.has_flag[old_quests_data_converted]>:
        - yaml load:../Quests/data/<player.uuid>.yml id:<[olddata]>
        - yaml set id:<[data]> career.quest_points:<yaml[<[olddata]>].read[quest-points]>
        - foreach <yaml[<[olddata]>].read[completed-Quests]> as:CompletedQuest:
            - yaml set id:<[data]> quests.completed.<yaml[QuestsConversionMap].read[<[CompletedQuest]>]>.completion_count:1
        - foreach <yaml[<[olddata]>].read[amountsCompletedQuests]> as:RedoableQuest:
            - if <yaml[<[olddata]>].read[amountsCompleted].get[<[loop_index]>]||0> >= 1:
                - yaml set id:<[data]> quests.completed.<yaml[QuestsConversionMap].read[<[RedoableQuest]>]>.completion_count:<yaml[<[olddata]>].read[amountsCompleted].get[<[loop_index]>]||1>
        - foreach <yaml[<[olddata]>].read[currentQuests]> as:CurrentQuest:
            - define cqinternalname <yaml[QuestsConversionMap].read[<[CurrentQuest]>]>
            - yaml id:<[cqinternalname]> copykey:player_data.<[cqinternalname]> quests.active.<[cqinternalname]> to_id:<[data]>
        - flag <player> old_quests_data_converted:true

Converter_Flag_Clear:
    type: task
    debug: false
    script:
    - foreach <server.players_flagged[old_quests_data_converted]>:
        - flag <[value]> old_quests_data_converted:!

Quest_Data_Clear:
    type: command
    name: questdataclear
    description: Deletes quest data for the specified player, or the user if no player is specified
    usage: /questdataclear [player]
    permission: quest.volatile
    permission message: No.
    tab completion:
        1: <server.online_players.parse[name]>
    debug: false
    script:
    - define player <server.match_offline_player[<context.args.get[1]>]>
    - define data <[player].uuid>_quest_data
    - yaml set id:<[data]> quests.completed:!
    - narrate "Data for <[player].name> cleared."