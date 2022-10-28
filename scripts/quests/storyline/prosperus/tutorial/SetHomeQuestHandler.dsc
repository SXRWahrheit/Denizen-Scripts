SetHomeCompletion:
    type: task
    debug: false
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.active.WoodTools].not> && <yaml[<[data]>].contains[quests.completed.WoodTools].not>:
        - zap FirstQuestsActive QuestMasterInteract
    - else if <yaml[<[data]>].contains[quests.active.WoodTools]>:
        - zap WoodToolsActiveOnly QuestMasterInteract
    - else if <yaml[<[data]>].contains[quests.completed.WoodTools]>:
        - zap StoneToolsOffer QuestMasterInteract

SetHomeQuestHandler:
    type: world
    debug: false
    events:
        on sethome command:
        - define data <player.uuid>_quest_data
        - if <yaml[<[data]>].contains[quests.active.SetHome].not>:
            - stop
        - if <yaml[<[data]>].read[quests.active.SetHome.stages.1.objectives.1.progress]> == 0 && <yaml[<[data]>].read[quests.active.SetHome.current_stage]> == 1:
            - yaml id:<[data]> set quests.active.SetHome.stages.1.objectives.1.progress:1
            - run QuestStageProgressHandler def:SetHome|1 instantly
        on home command:
        - define data <player.uuid>_quest_data
        - if <yaml[<[data]>].contains[quests.active.SetHome].not>:
            - stop
        - else if <yaml[<[data]>].read[quests.active.SetHome.stages.1.objectives.1.progress]> == 0 && <yaml[<[data]>].read[quests.active.SetHome.current_stage]> == 1:
            - if <context.args.get[1]> == set:
                - yaml id:<[data]> set quests.active.SetHome.stages.1.objectives.1.progress:1
                - run QuestStageProgressHandler def:SetHome|1 instantly
        - else if <yaml[<[data]>].read[quests.active.SetHome.stages.3.objectives.1.progress]> == 0 && <yaml[<[data]>].read[quests.active.SetHome.current_stage]> == 3:
            - yaml id:<[data]> set quests.active.SetHome.stages.1.objectives.3.progress:1
            - run QuestStageProgressHandler def:SetHome|1 instantly
        on spawn command:
        - define data <player.uuid>_quest_data
        - if <yaml[<[data]>].contains[quests.active.SetHome].not>:
            - stop
        - if <yaml[<[data]>].read[quests.active.SetHome.stages.2.objectives.1.progress]> == 0 && <yaml[<[data]>].read[quests.active.SetHome.current_stage]> == 2:
            - yaml id:<[data]> set quests.active.SetHome.stages.2.objectives.1.progress:1
            - run QuestStageProgressHandler def:SetHome|1 instantly