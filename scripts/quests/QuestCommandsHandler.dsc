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
        - clickable questdetail save:quest_detail for:<player> def:<[quest]>
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
    - narrate "<green>Stage <[current_stage]>: <&r><[quest].get[stages].get[<[current_stage]>].get[description]>"
    - foreach <[quest].get[stages].get[<[current_stage]>].get[objectives]>:
        - narrate "• <[value].get[name]>: <[value].get[progress]>/<[value].get[total]>"


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
    - else if <context.args.get[1]||null>:
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