QuestsCommand:
    debug: false
    type: command
    name: quests
    description: Show active quests and their progress
    usage: /quests [page number]
    script:
    - define data <player.uuid>_quest_data
    - if <yaml[<[data]>].read[quests.active].size||0> == 0:
        - narrate "<red>You have no active quests!"
        - stop
    - narrate " "
    - narrate "<green><bold><underline>Active Quests<&r> <italic><gray>(Click quest name for details)"
    - narrate " "
    - foreach <yaml[<[data]>].read[quests.active]> as:quest:
        - clickable questdetail save:quest_detail for:<player> def.quest:<[quest]>
        - narrate "• <gold><[quest].get[name].on_click[<entry[quest_detail].command>]>"
        #- narrate format:QuestDescriptionFormat <[quest].get[description].on_click[<entry[quest_detail].command>]>

QuestDetail:
    type: task
    debug: false
    speed: 0
    definitions: quest
    script:
    - define data <player.uuid>_quest_data
    - define current_stage <[quest].get[current_stage]>
    - narrate " "
    - narrate "<green><bold><underline>Quest Details"
    - narrate " "
    - narrate format:QuestNameFormat <[quest].get[name]>
    - narrate format:QuestDescriptionFormat <[quest].get[description]>
    - narrate "<aqua>Stage <[current_stage]>: <&r><[quest].get[stages].get[<[current_stage]>].get[description]>"
    - foreach <[quest].get[stages].get[<[current_stage]>].get[objectives]>:
        # If the objective is complete, it should be green, else aqua
        - if <[value].get[progress]> == <[value].get[total]>:
            - narrate "<green>• <[value].get[name]>: <[value].get[progress]>/<[value].get[total]> (COMPLETE)"
        - else:
            - narrate "<aqua>• <[value].get[name]>: <[value].get[progress]>/<[value].get[total]>"

QuestQuitCommand:
    debug: true
    type: command
    name: questquit
    description: Quit a specified quest
    usage: /questquit [quest]
    script:
    - define data <player.uuid>_quest_data
    - if <yaml[<[data]>].read[quests.active].size||0> == 0:
        - narrate "<red>You have no active quests!"
        - stop
    - if <yaml[<[data]>].read[quests.active].size> == 1:
        - define quest_internalname <yaml[<[data]>].read[quests.active].keys.first>
        - define quest <yaml[<[data]>].read[quests.active.<[quest_internalname]>]>
        - inject QuestQuitHandler
    - else if <context.args.get[1].if_null[null]>:
        - foreach <yaml[<[data]>].read[quests.active]> as:quest:
            - if <[quest].get[name].contains_text[<context.args.get[1]>]>:
                - define match_list:->:<[quest]>
        - if <[match_list].size> > 1:
            - narrate "Please select a quest to quit:"
            - foreach <[match_list]> as:match:
                - define quest <yaml[<[data]>].read[quests.active].get[match]>
                - clickable questquitdetail save:quest_quit_detail for:<player> def:<[quest]>|<[match]>
                - narrate format:QuestNameFormat <[quest].get[name].on_click[<entry[quest_quit_detail]>]>
        - else:
            - define match <[match_list].get[1]>
            - define quest <yaml[<[data]>].read[quests.active].get[match]>
            - inject QuestQuitHandler
    - else:
        - narrate " "
        - narrate "<green><bold><underline>Active Quests<&r> <italic><gray>(Click quest name to quit)"
        - narrate " "
        - foreach <yaml[<[data]>].read[quests.active]> key:quest_internalname as:quest:
            - clickable quest_quit_detail save:quest_quit_detail for:<player> def:<[quest_internalname]>
            - narrate "• <gold><[quest].get[name].on_click[<entry[quest_quit_detail].command>]>"

Quest_Quit_Detail:
    type: task
    debug: false
    speed: 0
    definitions: quest_internalname|quest
    script:
    - define data <player.uuid>_quest_data
    - define quest <yaml[<[data]>].read[quests.active.<[quest_internalname]>]>
    - inject QuestQuitHandler

QuestAdmin_Command:
    type: command
    name: questadmin
    description: View admin details about a player's quests
    usage: /questadmin [player]
    permission: god.homeother
    permission message: <red>YOU DARE TRY TO WIELD THE POWERS OF THE GODS?
    script:
    - if <context.args.size> != 1:
        - narrate "<red>Invalid command usage; proper usage is <green>/questadmin [player]"
        - stop
    - define target <server.match_offline_player[<context.args.get[1]>].if_null[null]>
    - if <[target]> == null:
        - narrate "<red>Invalid target specified; <bold><context.args.get[1]><red> did not match any player"
        - stop
    - define data <[target].uuid>_quest_data
    - if !<yaml.list.contains[<[data]>]> && <util.has_file[playerdata/<[target].uuid>/quest_data.yml]>:
        - ~yaml load:playerdata/<player.uuid>/quest_data.yml id:<[data]>
    - else if !<util.has_file[playerdata/<player.uuid>/quest_data.yml]>:
        - narrate "<red>Player does not have quest data file!"
        - stop
    - narrate "<green><bold><context.args.get[1]> quests"
    - narrate "<green><bold><underline>Active Quests<&r> <italic><gray>(Click quest name for details)"
    - narrate " "
    - if <yaml[<[data]>].read[quests.active].size||0> == 0:
        - narrate "<red>Player <[target].name> has no active quests!"
        - stop
    - foreach <yaml[<[data]>].read[quests.active]> as:quest:
        - clickable other_questdetail save:other_quest_detail for:<player> def.target:<[target]> def.quest:<[quest]>
        - narrate "• <gold><[quest].get[name].on_click[<entry[other_quest_detail].command>]>"

Other_QuestDetail:
    type: task
    debug: true
    speed: 0
    definitions: target|quest
    script:
    - define data <[target].uuid>_quest_data
    - define current_stage <[quest].get[current_stage]>
    - narrate " "
    - narrate "<green><bold><underline>Quest Details"
    - narrate " "
    - narrate format:QuestNameFormat <[quest].get[name]>
    - narrate format:QuestDescriptionFormat <[quest].get[description]>
    - narrate "<aqua>Stage <[current_stage]>: <&r><[quest].get[stages].get[<[current_stage]>].get[description]>"
    - foreach <[quest].get[stages].get[<[current_stage]>].get[objectives]>:
        # If the objective is complete, it should be green, else aqua
        - if <[value].get[progress]> == <[value].get[total]>:
            - narrate "<green>• <[value].get[name]>: <[value].get[progress]>/<[value].get[total]> (COMPLETE)"
        - else:
            - narrate "<aqua>• <[value].get[name]>: <[value].get[progress]>/<[value].get[total]>"