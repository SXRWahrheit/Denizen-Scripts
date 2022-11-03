Data_Loader:
    type: world
    debug: false
    events:
        on server start:
        - inject Yaml_Loader_Task

Yaml_Loader_Task:
    type: task
    debug: true
    speed: 0
    script:
    - yaml load:scriptdata/Events.yml id:events
    - yaml load:scriptdata/Rates.yml id:rates
    - yaml load:scriptdata/DropTables.yml id:droptables
    - yaml load:scriptdata/quests/QuestNPCList.yml id:quest_npc_list
    # Daily quests
    - foreach <util.list_files[scriptdata/quests/dailies]> as:file:
        - yaml load:scriptdata/quests/dailies/<[file]> id:<[file].before[.yml]>
    # Weekly quests
    ## Mob hunting
    #- foreach <util.list_files[scriptdata/quests/weeklies]> as:file:
    #    - yaml load:scriptdata/quests/weeklies/<[file]> id:<[file].before[.yml]>
    - foreach <util.list_files[scriptdata/quests/weeklies/mob_hunting]> as:file:
        - yaml load:scriptdata/quests/weeklies/mob_hunting/<[file]> id:<[file].before[.yml]>
    # Magic Tower
    ## Youngling
    - foreach <util.list_files[scriptdata/quests/spells/magic_tower/youngling]> as:file:
        - yaml load:scriptdata/quests/spells/magic_tower/youngling/<[file]> id:<[file].before[.yml]>
    ## Page
    - foreach <util.list_files[scriptdata/quests/spells/magic_tower/page]> as:file:
        - yaml load:scriptdata/quests/spells/magic_tower/page/<[file]> id:<[file].before[.yml]>
    ## Squire
    - foreach <util.list_files[scriptdata/quests/spells/magic_tower/squire]> as:file:
        - yaml load:scriptdata/quests/spells/magic_tower/squire/<[file]> id:<[file].before[.yml]>
    ## Apprentice
    - foreach <util.list_files[scriptdata/quests/spells/magic_tower/apprentice]> as:file:
        - yaml load:scriptdata/quests/spells/magic_tower/apprentice/<[file]> id:<[file].before[.yml]>
    # Storyline
    ## Prosperus
    ### Geographer
    - foreach <util.list_files[scriptdata/quests/storyline/prosperus/geographer]> as:file:
        - yaml load:scriptdata/quests/storyline/prosperus/geographer/<[file]> id:<[file].before[.yml]>
    ### Reinwald
    - foreach <util.list_files[scriptdata/quests/storyline/prosperus/reinwald]> as:file:
        - yaml load:scriptdata/quests/storyline/prosperus/reinwald/<[file]> id:<[file].before[.yml]>
    ### Tutorial
    - foreach <util.list_files[scriptdata/quests/storyline/prosperus/tutorial]> as:file:
        - yaml load:scriptdata/quests/storyline/prosperus/tutorial/<[file]> id:<[file].before[.yml]>
    ## Avenfeld
    - foreach <util.list_files[scriptdata/quests/storyline/prosperus]> as:file:
        - yaml load:scriptdata/quests/storyline/prosperus/<[file]> id:<[file].before[.yml]>
    # Professions
    - yaml load:scriptdata/professions/Mining.yml id:Mining
    - yaml load:scriptdata/professions/Harvesting.yml id:Harvesting
    - yaml load:scriptdata/professions/Foraging.yml id:Foraging
    - yaml load:scriptdata/professions/Lumberjacking.yml id:Lumberjacking