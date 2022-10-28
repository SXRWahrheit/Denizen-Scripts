UnlockAvenfeldQuestDeliveryHandler:
    type: task
    debug: false
    script:
    - define stage:1
    - define quest_internalname:UnlockAvenfeld
    - choose <player.item_in_hand.material.name>:
        - case redstone:
            - define objective:1
        - case ghast_tear:
            - define objective:2
        - case ender_eye:
            - define objective:3
        - case slime_ball:
            - define objective:4
        - default:
            - narrate format:RoyalGeographerFormat "Whenever you've got the items I'm looking for, just hand them over."
            - run QuestProgressHandler def:UnlockAvenfeld
    - inject QuestItemDeliveryHandler
    - if <[InProgress]>:
        - choose <[delivery_item]>:
            - case redstone:
                - narrate format:RoyalGeographerFormat "Thanks for the redstone! As I'm sure you know, it's quite important for magical endeavors."
            - case ghast_tear:
                - narrate format:RoyalGeographerFormat "Those ghast tears are hard to come by. Be sure to wait until a ghast is over land before you shoot it out of the sky!"
            - case ender_eye:
                - narrate format:RoyalGeographerFormat "Ender eyes are some of the most unstable magical resources, but that just means they're all the more powerful."
            - case slime_ball:
                - narrate format:RoyalGeographerFormat "No one is quite sure what causes slimes to become animated, but the goo you can harvest from them is quite useful!"

UnlockAvenfeldSpellCastHandler:
    type: world
    debug: false
    events:
        on magicspells entity completes spell:
        - if <context.spell_name> != realmwarp-avenfeld:
            - stop
        - define data <player.uuid>_quest_data
        - define quest_internalname UnlockAvenfeld
        - if !<yaml[<[data]>].contains[quests.active.<[quest_internalname]>]>:
            - stop
        - if <yaml[<[data]>].read[quests.active.<[quest_internalname]>.current_stage]> == 2:
            - inject QuestCompletionHandler
            - run UnlockAvenfeldCompletion

UnlockAvenfeldCompletion:
    type: task
    debug: false
    script:
    - zap FindFireTempleOffer RoyalGeographerInteract