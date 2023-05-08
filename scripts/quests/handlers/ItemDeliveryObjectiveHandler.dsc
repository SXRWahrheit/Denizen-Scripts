# Generate an item for a quest objective that requires item delivery

Quest_Objective_Item_Delivery_Handler:
    type: procedure
    definitions: quest|objective
    debug: true
    script:
    - define quest_name <[quest].get[name]>
    - define quest_description <[quest].get[description]>
    - define current_stage <[quest].get[current_stage]>
    - define objective_name <[objective].get[name]>
    - define objective_progress <[objective].get[progress]>
    - define objective_total <[objective].get[total]>
    - define material <[objective].deep_get[data.material].if_null[stone]>
    - define item <item[<[material]>]>
    - define lore <list>
    - define lore <[lore].include[Progress: <[objective_progress]>/<[objective_total]>]>
    - define item <[item].with[lore=<[lore]>]>

    - determine <[item]>