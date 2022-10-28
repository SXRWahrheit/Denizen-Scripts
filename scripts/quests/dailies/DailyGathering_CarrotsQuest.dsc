DailyGathering_Carrots_gui_item:
    type: item
    material: carrot
    display name: <&a><yaml[<script.data_key[quest_name]>].read[player_data.<script.data_key[quest_name]>.name]>
    data:
        quest_name: DailyGathering_Carrots
        lore_list:
        - <yaml[<script.data_key[quest_name]>].read[player_data.<script.data_key[quest_name]>.description]>
        - <&6>Rewards<&co>
        - <yaml[<script.data_key[quest_name]>].read[config.rewards.money]> gold
        - <yaml[<script.data_key[quest_name]>].read[config.rewards.quest_points]> quest points
    mechanisms:
        hides:
        - enchants
        lore: <proc[lore_builder].context[40|<script.data_key[lore_list].escaped>]>