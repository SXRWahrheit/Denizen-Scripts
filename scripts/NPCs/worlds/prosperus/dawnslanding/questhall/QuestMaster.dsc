# This thing handles the main quest line, at least for now
# @author Wahrheit
# @version 3.0
# @last-updated May 18 2019

QuestMasterAssignment:
    type: assignment
    debug: false
    interact scripts:
    - QuestMasterInteract
    actions:
        on assignment:
        - trigger name:proximity state:true
        - trigger name:chat state:true
        - trigger name:click state:true

QuestMasterFormat:
    type: format
    debug: false
    format: <dark_green>Quest Master<white><&co> <[text]>

FoundSomeDiamonds:
    type: task
    debug: false
    script:
    - narrate "<dark_green>Quest Master<white><&co> Not quite all the Treasure Hunters, but here's what you've earned!"
    - give diamond quantity:<player.flag[npccount]>
    - give emerald quantity:<player.flag[npccount]>
    - flag <player> npccount:0
FoundAllDiamonds:
    type: task
    debug: false
    script:
    - narrate "<dark_green>Quest Master<white><&co> Oh, I see you found all the Treasure Hunters! Here are your rewards!"
    - give diamond quantity:8
    - give emerald quantity:8
    - give diamond_helmet
    - give diamond_chestplate
    - give diamond_leggings
    - give diamond_boots
    - flag <player> npccount:0

InteractReset_QuestMaster:
    type: task
    debug: false
    definitions: player
    script:
    - flag <[player]> QuestMasterSeen:!

QuestMaster_Check_SwabbyDelivery_Active:
    type: task
    debug: false
    definitions: data
    script:
    # Swabby password quest active
    - if <yaml[<[data]>].contains[quests.active.SwabbyDelivery]>:
        - narrate format:QuestMasterFormat "Did Swabby send you?"
        - wait 0.5s
        - title "subtitle:<&a>Right-click the Quest Master!"
        - zap QuestMasterInteract SwabbyDeliveryActive
        - stop

QuestMaster_Dialogue_FirstQuestIntroduction:
    type: task
    debug: false
    definitions: data
    script:
    - narrate format:QuestMasterFormat "Say, I think you're ready for something more exciting. How about it?"
    - wait 0.7s
    - narrate format:QuestMasterFormat "I've got your first real get-out-in-the-world quest for you as soon as you're ready."
    - define data <player.uuid>_quest_data
    - if <yaml[<[data]>].contains[quests.active.SetHome].not> && <yaml[<[data]>].contains[quests.completed.SetHome].not>:
        - wait 0.7s
        - narrate format:QuestMasterFormat "I can also teach you how to set a home! It's an important skill for surviving out there."
        - wait 0.7s
    - zap QuestMasterInteract FirstQuests
    - narrate "<gray>Right-click the Quest Master!"

QuestMaster_Dialogue_FirstQuestOffers:
    type: task
    debug: false
    definitions: data
    script:
    - narrate format:QuestMasterFormat "I've got your first real get-out-in-the-world quest for you as soon as you're ready."
    - define data <player.uuid>_quest_data
    - if <yaml[<[data]>].contains[quests.active.SetHome].not> && <yaml[<[data]>].contains[quests.completed.SetHome].not>:
        - wait 0.7s
        - narrate format:QuestMasterFormat "I can also teach you how to set a home! It's an important skill for surviving out there."
    - zap QuestMasterInteract FirstQuests
    - narrate "<gray>Right-click the Quest Master!"

QuestMaster_Dialogue_FirstQuestsInteract:
    type: task
    debug: false
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.active.SetHome].not> && <yaml[<[data]>].contains[quests.completed.SetHome].not> && <yaml[<[data]>].contains[quests.active.WoodTools].not> && <yaml[<[data]>].contains[quests.completed.WoodTools].not>:
        - narrate format:QuestMasterFormat "Which quest do you want? Are you ready to get adventuring, or do you want to set your home first?"
        - wait 0.7s
        - inventory open d:QuestMaster_Choose_First_Quests_Inventory
        - zap QuestMasterInteract FirstQuests
        - stop
    - if <yaml[<[data]>].contains[quests.completed.SwabbyDelivery]> && <yaml[<[data]>].contains[quests.active.WoodTools].not> && <yaml[<[data]>].contains[quests.completed.WoodTools].not>:
        - narrate format:PlayerChatFormat "I'm ready for my first real adventure!"
        - run QuestAcceptHandler def:WoodTools instantly
        - zap QuestMasterInteract FirstQuestsActive
        - stop
    - else if <yaml[<[data]>].contains[quests.completed.SwabbyDelivery]> && <yaml[<[data]>].contains[quests.active.SetHome].not> && <yaml[<[data]>].contains[quests.completed.SetHome].not>:
        - narrate format:PlayerChatFormat "Learning how to set my home seems useful, please teach me!"
        - run QuestAcceptHandler def:SetHome instantly
        - zap QuestMasterInteract FirstQuestsActive
        - stop

QuestMaster_Choose_First_Quests_Inventory:
    type: inventory
    inventory: chest
    size: 45
    slots:
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [WoodTools_Quest_Offer_Menu_Item] [] [] [] [SetHome_Quest_Offer_Menu_Item] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []

WoodTools_Quest_Offer_Menu_Item:
    type: item
    material: <proc[QuestGUIItemBuilder].context[WoodTools]>

SetHome_Quest_Offer_Menu_Item:
    type: item
    material: <proc[QuestGUIItemBuilder].context[SetHome]>

QuestMaster_Choose_First_Quests_Handler:
    type: world
    debug: false
    events:
        on player clicks WoodTools_Quest_Offer_Menu_Item in QuestMaster_Choose_First_Quests_Inventory:
        - determine passively cancelled
        - wait 1t
        - inventory close
        - narrate format:PlayerChatFormat "It's time for me to get out and explore Prosperus. I'm ready for my first adventure!"
        - zap QuestMasterInteract FirstQuestsActive
        - run QuestAcceptHandler def:WoodTools instantly
        on player clicks SetHome_Quest_Offer_Menu_Item in QuestMaster_Choose_First_Quests_Inventory:
        - determine passively cancelled
        - wait 1t
        - inventory close
        - narrate format:PlayerChatFormat "I'd like to learn how to set my home."
        - zap QuestMasterInteract FirstQuestsActive
        - run QuestAcceptHandler def:SetHome instantly

QuestMaster_Check_Both_FirstQuests_Completed:
    type: task
    debug: false
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.active.WoodTools].not> && <yaml[<[data]>].contains[quests.completed.WoodTools].not> && <script[QuestMasterInteract].step[<player>]> != FirstQuestsActive:
        - zap FirstQuestsActive QuestMasterInteract
    - else if <yaml[<[data]>].contains[quests.active.WoodTools]> && <script[QuestMasterInteract].step[<player>]> != FirstQuestsActive:
        - zap FirstQuestsActive QuestMasterInteract
    - else if <yaml[<[data]>].contains[quests.completed.WoodTools]> && <script[QuestMasterInteract].step[<player>]> != StoneToolsOffer:
        - zap StoneToolsOffer QuestMasterInteract

QuestMaster_Check_Both_FirstQuests_Active:
    type: task
    debug: false
    definitions: data
    script:
    # If both SetHome and WoodTools are active
    - if <yaml[<[data]>].contains[quests.completed.SetHome].not> && <yaml[<[data]>].contains[quests.active.SetHome]> && <yaml[<[data]>].contains[quests.completed.WoodTools].not> && <yaml[<[data]>].contains[quests.active.WoodTools]>:
        # First we narrate based on the active status of SetHome
        - inject QuestMaster_Check_SetHome_Progress
        # Then we narrate based on the active status of WoodTools
        - inject QuestMaster_Check_WoodTools_Progress
        - stop
    # Neither SetHome nor WoodTools is active, somehow?
    - else if <yaml[<[data]>].contains[quests.completed.SetHome].not> && <yaml[<[data]>].contains[quests.active.SetHome].not> && <yaml[<[data]>].contains[quests.completed.WoodTools].not> && <yaml[<[data]>].contains[quests.active.WoodTools].not>:
        - inject QuestMaster_Dialogue_FirstQuestOffers

QuestMaster_Check_SetHome_Progress:
    type: task
    debug: false
    definitions: data
    script:
    - if <yaml[<[data]>].read[quests.active.SetHome.current_stage]> == 1:
        - narrate format:QuestMasterFormat "Still haven't set your home? It's easy, give it a try!"
        - narrate "<gray>Type /sethome in chat to set your home!"
    - else if <yaml[<[data]>].read[quests.active.SetHome.current_stage]> == 2:
        - narrate format:QuestMasterFormat "Well, you went and set your home, but you haven't practiced returning to spawn yet, either. Give that a try."
        - narrate "<gray>Type /spawn in chat to return to spawn!"
    - else if <yaml[<[data]>].read[quests.active.SetHome.current_stage]> == 3:
        - narrate format:QuestMasterFormat "Just one more step left for you, right? Practice returing to your home."
        - narrate "<gray>Type /home in chat to return to your home!"
    - wait 0.7s

QuestMaster_Check_WoodTools_Progress:
    type: task
    debug: false
    definitions: data
    script:
    # Crafting
    - if <yaml[<[data]>].read[quests.active.WoodTools.current_stage]> == 1:
        - narrate format:QuestMasterFormat "Looks like you're still working on crafting those wooden tools. Don't forget that you've got to head outside of Dawn's Landing to start your adventure! I recommend grabbing a free boat from the docks and sailing down the river."
        - wait 0.7s
    # Bring to quest master
    - if <yaml[<[data]>].read[quests.active.WoodTools.current_stage]> == 2:
        - narrate format:QuestMasterFormat "You've crafted all of those wooden tools by now, right? Do you have them for me?"
        - wait 0.7s

QuestMaster_Check_NeitherFirstQuest_Active:
    type: task
    debug: false
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.completed.SetHome].not> && <yaml[<[data]>].contains[quests.active.SetHome].not> && <yaml[<[data]>].contains[quests.completed.WoodTools].not> && <yaml[<[data]>].contains[quests.active.WoodTools].not>:
        - inject QuestMaster_Dialogue_FirstQuestOffers
        - stop

QuestMaster_Check_NeitherFirstQuest_Active_Interact:
    type: task
    debug: false
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.completed.SetHome].not> && <yaml[<[data]>].contains[quests.active.SetHome].not> && <yaml[<[data]>].contains[quests.completed.WoodTools].not> && <yaml[<[data]>].contains[quests.active.WoodTools].not>:
        - zap QuestMasterInteract FirstQuests
        - inject QuestMaster_Dialogue_FirstQuestsInteract
        - stop

QuestMaster_Check_WoodTools_Available:
    type: task
    debug: true
    definitions: data
    script:
    # Wood tools quest offer
    - if <yaml[<[data]>].contains[quests.completed.SwabbyDelivery]> && <yaml[<[data]>].contains[quests.active.WoodTools].not> && <yaml[<[data]>].contains[quests.completed.WoodTools].not>:
        - narrate format:QuestMasterFormat "Thanks for running that errand for Swabby!"
        - wait 0.7s
        - narrate format:QuestMasterFormat "Say, I think you're ready for something more exciting. How about it?"
        - wait 0.7s
        - narrate format:QuestMasterFormat "I've got your first real get-out-in-the-world quest for you as soon as you're ready."
        - stop

QuestMaster_Check_WoodTools_Available_Interact:
    type: task
    debug: true
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.completed.SwabbyDelivery]> && <yaml[<[data]>].contains[quests.active.WoodTools].not> && <yaml[<[data]>].contains[quests.completed.WoodTools].not>:
        - narrate format:PlayerChatFormat "It's time for me to get out and explore Prosperus. I'm ready for my first adventure!"
        - zap QuestMasterInteract FirstQuestsActive
        - run QuestAcceptHandler def:WoodTools instantly

QuestMaster_Check_WoodTools_Active:
    type: task
    debug: true
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.active.WoodTools]>:
        - inject QuestMaster_Check_WoodTools_Progress
        - inject QuestMaster_Check_SetHome_Available
        - stop

QuestMaster_Check_SetHome_Available:
    type: task
    debug: false
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.completed.SetHome].not> && <yaml[<[data]>].contains[quests.active.SetHome].not>:
        - narrate format:QuestMasterFormat "You still need to learn to set your home! Are you ready to learn how?"
        - zap QuestMasterInteract SetHomeOffer duration:1m

QuestMaster_Check_SetHome_Active:
    type: task
    debug: false
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.completed.SetHome].not> && <yaml[<[data]>].contains[quests.active.SetHome]>:
        - inject QuestMaster_Check_SetHome_Progress

QuestMaster_Check_StoneTools_Available:
    type: task
    debug: false
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.completed.WoodTools]> && <yaml[<[data]>].contains[quests.active.StoneTools].not> && <yaml[<[data]>].contains[quests.completed.StoneTools].not>:
        - narrate format:QuestMasterFormat "You did a great job getting those wooden tools! Ready to put them to use?"
        - zap QuestMasterInteract StoneToolsOffer
        - stop

QuestMaster_Check_StoneTools_Active:
    type: task
    debug: false
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.active.StoneTools]>:
        - narrate format:QuestMasterFormat "You putting those wooden tools to work yet?"
        - zap QuestMasterInteract StoneToolsActive
        - stop

QuestMaster_Check_LeatherArmor_Available:
    type: task
    debug: false
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.completed.StoneTools]> && <yaml[<[data]>].contains[quests.active.LeatherArmor].not> && <yaml[<[data]>].contains[quests.completed.LeatherArmor].not>:
        - narrate format:QuestMasterFormat "Nice job on that last quest. Now you've got some basic tools, but you're still missing an adventurer's essential. Talk to me for the next quest when you're ready."
        - zap QuestMasterInteract LeatherArmorOffer
        - stop

QuestMaster_Check_LeatherArmor_Active:
    type: task
    debug: false
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.active.LeatherArmor]>:
        - narrate format:QuestMasterFormat "Everything MOOving along?"
        - wait 0.7s
        - narrate format:QuestMasterFormat "You can find cows both around Dawn's Landing and all over the world."
        - wait 0.7s
        - narrate format:QuestMasterFormat "Just make sure there's some grass around so they show up to munch on it."
        - zap QuestMasterInteract LeatherArmorActive
        - stop

QuestMaster_Check_FindReinwald_Available:
    type: task
    debug: false
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.completed.LeatherArmor]> && <yaml[<[data]>].contains[quests.active.FindReinwald].not> && <yaml[<[data]>].contains[quests.completed.FindReinwald].not>:
        - narrate format:QuestMasterFormat "I'm not the only one with quests for you! Why don't you go meet a friend of mine?"
        - zap QuestMasterInteract FindReinwaldOffer
        - stop

QuestMaster_Check_FindReinwald_Active:
    type: task
    debug: false
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.active.FindReinwald]>:
        - narrate format:QuestMasterFormat "Having a hard time finding Warmaster Reinwald? He's just over in the castle, but maybe you can ask another adventurer for help."
        - zap QuestMasterInteract FindReinwaldActive
        - stop

QuestMaster_Check_IronToolsArmor_Available:
    type: task
    debug: false
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.completed.LeatherArmor]> && <yaml[<[data]>].contains[quests.active.IronToolsArmor].not> && <yaml[<[data]>].contains[quests.completed.IronToolsArmor].not>:
        - narrate format:QuestMasterFormat "You found Reinwald! Nice work."
        - wait 0.7s
        - narrate format:QuestMasterFormat "I think you're ready to work on another gear upgrade."
        - zap QuestMasterInteract IronToolsArmorOffer
        - stop

QuestMaster_Check_IronToolsArmor_Active:
    type: task
    debug: false
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.active.IronToolsArmor]>:
        - narrate format:QuestMasterFormat "How's that hunt for iron going?"
        - wait 0.7s
        - narrate format:QuestMasterFormat "If you're having a rough time finding it just outside the valley, try going further out."
        - wait 0.7s
        - narrate format:QuestMasterFormat "Many adventurers have been through these parts! Not so many are brave enough to cross the oceans to the other continents, though. I reckon you've got what it takes."
        - zap QuestMasterInteract IronToolsArmorActive
        - stop

QuestMaster_Check_FindFishingNewbie_Available:
    type: task
    debug: false
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.completed.IronToolsArmor]> && <yaml[<[data]>].contains[quests.active.FindFishingNewbie].not> && <yaml[<[data]>].contains[quests.completed.FindFishingNewbie].not>:
        - narrate format:QuestMasterFormat "You've been hard at work. Why don't you go find that kid on the docks and teach him how to fish?"
        - zap QuestMasterInteract FindFishingNewbieOffer
        - stop

QuestMaster_Check_FindFishingNewbie_Active:
    type: task
    debug: false
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.active.FindFishingNewbie]>:
        - narrate format:QuestMasterFormat "Did you find that kid yet? He's just down by the docks."
        - zap QuestMasterInteract FindFishingNewbieActive
        - stop

QuestMaster_Check_MeetSkillTrainers_Available:
    type: task
    debug: false
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.completed.FindFishingNewbie]> && <yaml[<[data]>].contains[quests.active.MeetSkillTrainers].not> && <yaml[<[data]>].contains[quests.completed.MeetSkillTrainers].not>:
        - narrate format:QuestMasterFormat "Did you know there are skill trainers around Dawn's Landing?"
        - zap QuestMasterInteract MeetSkillTrainersOffer
        - stop

QuestMaster_Check_MeetSkillTrainers_Active:
    type: task
    debug: false
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.active.MeetSkillTrainers]>:
        - narrate format:QuestMasterFormat "Having trouble finding those skill trainers?"
        - wait 0.7s
        - narrate format:QuestMasterFormat "Lucky for you, I wrote a little book with directions."
        - wait 0.7s
        - adjust <player> show_book:SkillTrainerBook
        - zap QuestMasterInteract MeetSkillTrainersActive
        - stop

QuestMaster_Check_MeetPostmaster_Available:
    type: task
    debug: false
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.completed.MeetSkillTrainers]> && <yaml[<[data]>].contains[quests.active.MeetPostmaster].not> && <yaml[<[data]>].contains[quests.completed.MeetPostmaster].not>:
        - narrate format:QuestMasterFormat "Did you know we have a post office?"
        - zap QuestMasterInteract MeetPostmasterOffer
        - stop

QuestMaster_Check_MeetPostmaster_Active:
    type: task
    debug: false
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.active.MeetPostmaster]>:
        - narrate format:QuestMasterFormat "The post office is just around the corner from here."
        - zap QuestMasterInteract MeetPostmasterActive
        - stop

QuestMaster_Check_ReinwaldFirstQuest_Available:
    type: task
    debug: false
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.completed.MeetPostmaster]> && <yaml[<[data]>].contains[quests.active.FirstMobHunting].not> && <yaml[<[data]>].contains[quests.completed.FirstMobHunting].not>:
        - narrate format:QuestMasterFormat "You know, I reckon Reinwald has a quest for you."
        - zap QuestMasterInteract FirstMobHuntingOffer_QM
        - stop

QuestMaster_Check_ReinwaldFirstQuest_Active:
    type: task
    debug: false
    definitions: data
    script:
    - if <yaml[<[data]>].contains[quests.active.FirstMobHunting]>:
        - narrate format:QuestMasterFormat "You picked up that quest from Reinwald, eh? Don't forget to wear armor!"
        - zap QuestMasterInteract FirstMobHuntingActive_QM
        - stop

QuestMaster_Check_NoActiveQuest:
    type: task
    debug: false
    definitions: data
    script:
    - narrate format:QuestMasterFormat "Look at you, making your way in the world! I'm very proud."
    - wait 0.7s
    - narrate format:QuestMasterFormat "There are some quests around here that we could use your help with every so often, so check back regularly."
    - wait 0.7s
    - narrate format:QuestMasterFormat "Reinwald and his troops have some similar tasks for you, too, I'm sure."
    - zap QuestMasterInteract NoActiveQuest
    - stop

QuestMaster_GeneralDialogue:
    type: task
    debug: false
    script:
    - define data <player.uuid>_quest_data
    - if <player.has_flag[QuestMasterSeen].not>:
        - narrate format:QuestMasterFormat "Well hello there, <player.name>! Nice to meet you."
        - flag <player> QuestMasterSeen:true
    - else:
        - narrate format:QuestMasterFormat "Good to see you, <player.name>!"
        - wait 0.7s
    # Swabby password quest active
    - inject QuestMaster_Check_SwabbyDelivery_Active
    # Wood tools quest offer
    - inject QuestMaster_Check_WoodTools_Available
    # Wood tools quest active
    - inject QuestMaster_Check_WoodTools_Active
    # Mining quest offer
    - inject QuestMaster_Check_StoneTools_Available
    # Mining quest active
    - inject QuestMaster_Check_StoneTools_Active
    # Leather quest offer
    - inject QuestMaster_Check_LeatherArmor_Available
    # Leather quest active
    - inject QuestMaster_Check_LeatherArmor_Active
    # Meet Reinwald offer
    - inject QuestMaster_Check_FindReinwald_Available
    # Meet Reinwald active
    - inject QuestMaster_Check_FindReinwald_Active
    # Iron quest offer
    - inject QuestMaster_Check_IronToolsArmor_Available
    # Iron quest active
    - inject QuestMaster_Check_IronToolsArmor_Active
    # Fishing newbie quest offer
    - inject QuestMaster_Check_FindFishingNewbie_Available
    # Fishing newbie quest active
    - inject QuestMaster_Check_FindFishingNewbie_Active
    # Skill trainer offer
    - inject QuestMaster_Check_MeetSkillTrainers_Available
    # Skill trainer active
    - inject QuestMaster_Check_MeetSkillTrainers_Active
    # Meet Postmaster offer
    - inject QuestMaster_Check_MeetPostmaster_Available
    # Meet Postmaster active
    - inject QuestMaster_Check_MeetPostmaster_Active
    # Go talk to Reinwald for first mob hunting quest
    - inject QuestMaster_Check_ReinwaldFirstQuest_Available
    # Player has Reinwald mob hunting quest
    - inject QuestMaster_Check_ReinwaldFirstQuest_Active
    # No active quest
    - inject QuestMaster_Check_NoActiveQuest



QuestMasterInteract:
    type: interact
    debug: true
    speed: 0
    steps:
        Greeting*:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - if <player.has_flag[QuestMasterSeen]>:
                        - zap GeneralDialogue
                        - inject QuestMaster_GeneralDialogue
                        - stop
                    - narrate format:QuestMasterFormat "Welcome to the Questing Hall, <player.name>! The folks here have a variety of quests that you can complete to help out our citizens."
                    - wait 0.7s
                    - narrate format:QuestMasterFormat "I've got a series of quests, too, that will help ease you into your adventure. I'll even toss you a little coin for your efforts, as well as a few other surprise bonuses."
                    - if <player.flag[npccount]||0>  == 8:
                        - inject FoundAllDiamonds instantly
                    - if <player.flag[npccount]||0> < 8 && <player.flag[npccount]||0> > 0:
                        - inject FoundSomeDiamonds instantly
                    - inject QuestMaster_Check_SwabbyDelivery_Active
                    - zap GeneralDialogue
        GeneralDialogue:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - inject QuestMaster_GeneralDialogue
        SwabbyDeliveryActive:
            proximity trigger:
                entry:
                    script:
                    - inject QuestMaster_Check_SwabbyDelivery_Active
            click trigger:
                script:
                - define quest_internalname SwabbyDelivery
                - narrate format:PlayerChatFormat "Swabby sent me! He asked me to tell you that the password is <player.flag[swabby_password]>."
                - inject QuestCompletionHandler instantly
                - inject QuestMaster_Dialogue_FirstQuestIntroduction
                - zap FirstQuests
        FirstQuests:
            proximity trigger:
                entry:
                    script:
                    - inject QuestMaster_Dialogue_FirstQuestOffers
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                - inject QuestMaster_Dialogue_FirstQuestsInteract
        FirstQuestsActive:
            proximity trigger:
                entry:
                    script:
                    - define data <player.uuid>_quest_data
                    - inject QuestMaster_Check_Both_FirstQuests_Completed
                    - inject QuestMaster_Check_NeitherFirstQuest_Active
                    - inject QuestMaster_Check_Both_FirstQuests_Active
                    - inject QuestMaster_Check_WoodTools_Active
                    - inject QuestMaster_Check_WoodTools_Available
                    - inject QuestMaster_Check_SetHome_Active
                    - inject Questmaster_Check_SetHome_Available
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                - inject QuestMaster_Check_NeitherFirstQuest_Active_Interact
                - inject QuestMaster_Check_WoodTools_Available_Interact
                - if <player.item_in_hand.material.name.starts_with[wooden]||>:
                    - if <yaml[<[data]>].contains[quests.active.WoodTools]> && <yaml[<[data]>].read[quests.active.WoodTools.current_stage]||0> == 2:
                        - inject WoodToolsQuestDeliveryHandler
                - else:
                    - inject QuestMaster_Check_SetHome_Active
        SetHomeOffer:
            proximity trigger:
                entry:
                    script:
                    - narrate format:QuestMasterFormat "I've got one quick skill to teach you - it's how to set your home! You'll be able to use magic to jump between Dawn's Landing and wherever you set your home once you learn. Are you ready?"
            click trigger:
                script:
                - narrate format:PlayerChatFormat "That sounds useful, please teach me!"
                - run QuestAccepthandler def:SetHome instantly
                - zap FirstQuestsActive
            chat trigger:
                SetHomeAcceptance:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - narrate format:PlayerChatFormat "That sounds useful, please teach me!"
                    - run QuestAccepthandler def:SetHome instantly
                    - zap FirstQuestsActive
        StoneToolsOffer:
            proximity trigger:
                entry:
                    script:
                    - narrate format:QuestMasterFormat "You did a great job getting those wooden tools! Ready to put them to use?"
            click trigger:
                script:
                - narrate format:PlayerChatFormat "I'm ready!"
                - run QuestAcceptHandler def:StoneTools instantly
                - zap StoneToolsActive
            chat trigger:
                StoneToolsAcceptance:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - narrate format:PlayerChatFormat "I'm ready!"
                    - run QuestAcceptHandler def:StoneTools instantly
                    - zap StoneToolsActive
        StoneToolsActive:
            proximity trigger:
                entry:
                    script:
                    - narrate format:QuestMasterFormat "You putting those wooden tools to work yet?"
                    - run QuestProgressHandler def:StoneTools instantly
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                - if <yaml[<[data]>].contains[quests.active.StoneTools]> && <yaml[<[data]>].read[quests.active.StoneTools.current_stage]||0> == 2:
                    - inject StoneToolsQuestDeliveryHandler
        LeatherArmorOffer:
            proximity trigger:
                entry:
                    script:
                    - narrate format:QuestMasterFormat "Nice job on that last quest. Now you've got some basic tools, but you're still missing an adventurer's essential. Talk to me for the next quest when you're ready."
            click trigger:
                script:
                - narrate format:PlayerChatFormat "I'm ready!"
                - run QuestAcceptHandler def:LeatherArmor
                - zap LeatherArmorActive
            chat trigger:
                LeatherArmorAcceptance:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - narrate format:PlayerChatFormat "I'm ready!"
                    - run QuestAcceptHandler def:LeatherArmor
                    - zap LeatherArmorActive
        LeatherArmorActive:
            proximity trigger:
                entry:
                    script:
                    - narrate format:QuestMasterFormat "Everything MOOving along?"
                    - wait 0.7s
                    - narrate format:QuestMasterFormat "You can find cows both around Dawn's Landing and all over the world."
                    - wait 0.7s
                    - narrate format:QuestMasterFormat "Just make sure there's some grass around so they show up to munch on it."
                    - run QuestProgressHandler def:LeatherArmor
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                - if <yaml[<[data]>].contains[quests.active.LeatherArmor]> && <yaml[<[data]>].read[quests.active.LeatherArmor.current_stage]||0> == 2:
                    - inject LeatherArmorQuestDeliveryHandler
        FindReinwaldOffer:
            proximity trigger:
                entry:
                    script:
                    - narrate format:QuestMasterFormat "I'm not the only one with quests for you! Why don't you go meet a friend of mine?"
            click trigger:
                script:
                - narrate format:PlayerChatFormat "Who should I go meet?"
                - run QuestAcceptHandler def:FindReinwald
                - zap FindReinwaldActive
            chat trigger:
                FindReinwaldAcceptance:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - narrate format:PlayerChatFormat "Sure, who should I go meet?"
                    - run QuestAcceptHandler def:FindReinwald
                    - zap FindReinwaldActive
        FindReinwaldActive:
            proximity trigger:
                entry:
                    script:
                    - narrate format:QuestMasterFormat "Having a hard time finding Warmaster Reinwald? he's just over in the castle, but maybe you can ask another adventurer for help."
                    - run QuestProgressHandler def:FindReinwald
        IronToolsArmorOffer:
            proximity trigger:
                entry:
                    script:
                    - narrate format:QuestMasterFormat "You found Reinwald! Nice work."
                    - wait 0.7s
                    - narrate format:QuestMasterFormat "I think you're ready for another gear upgrade. What do you think?"
            click trigger:
                script:
                - narrate format:PlayerChatFormat "Sure am!"
                - run QuestAcceptHandler def:IronToolsArmor instantly
                - zap IronToolsArmorActive
            chat trigger:
                IronToolsArmorAcceptance:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - narrate format:PlayerChatFormat "Sure am!"
                    - run QuestAcceptHandler def:IronToolsArmor instantly
                    - zap IronToolsArmorActive
        IronToolsArmorActive:
            proximity trigger:
                entry:
                    script:
                    - narrate format:QuestMasterFormat "How's that hunt for iron going?"
                    - wait 0.7s
                    - narrate format:QuestMasterFormat "If you're having a rough time finding it just outside the valley, try going further out."
                    - wait 0.7s
                    - narrate format:QuestMasterFormat "Many adventurers have been through these parts! Not so many are brave enough to cross the oceans to other continents, though. I reckon you've got what it takes."
                    - run QuestProgressHandler def:IronToolsArmor
            click trigger:
                script:
                - define data <player.uuid>_quest_data
                - if <yaml[<[data]>].contains[quests.active.IronToolsArmor]> && <yaml[<[data]>].read[quests.active.IronToolsArmor.current_stage]||0> == 2:
                    - inject IronToolsArmorQuestDeliveryHandler
        FindFishingNewbieOffer:
            proximity trigger:
                entry:
                    script:
                    - narrate format:QuestMasterFormat "You've been hard at work. Why don't you go find that kid on the docks and teach him how to fish?"
            click trigger:
                script:
                - narrate format:PlayerChatFormat "Sure, that sounds nice."
                - run QuestAcceptHandler def:FindFishingNewbie
                - zap FindFishingNewbieActive
            chat trigger:
                FindFishingNewbieAcceptance:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - narrate format:PlayerChatFormat "Sure, that sounds nice."
                    - run QuestAcceptHandler def:FindFishingNewbie
                    - zap FindFishingNewbieActive
        FindFishingNewbieActive:
            proximity trigger:
                entry:
                    script:
                    - narrate format:QuestMasterFormat "Did you find that kid yet? He's just down by the docks."
                    - run QuestProgressHandler def:FindFishingNewbie
        MeetSkillTrainersOffer:
            proximity trigger:
                entry:
                    script:
                    - narrate format:QuestMasterFormat "Did you know there are skill trainers around Dawn's Landing? Why don't you go meet them?"
            click trigger:
                script:
                - narrate format:PlayerChatFormat "Okay, that sounds interesting!"
                - run QuestAcceptHandler def:MeetSkillTrainers
                - zap MeetSkillTrainersActive
            chat trigger:
                MeetSkillTrainersAcceptance:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - narrate format:PlayerChatFormat "Okay, that sounds interesting!"
                    - run QuestAcceptHandler def:MeetSkillTrainers
                    - zap MeetSkillTrainersActive
        MeetSkillTrainersActive:
            proximity trigger:
                entry:
                    script:
                    - narrate format:QuestMasterFormat "Having trouble finding those skill trainers?"
                    - wait 0.7s
                    - narrate format:QuestMasterFormat "Lucky for you, I wrote a little book with directions."
                    - wait 0.7s
                    - adjust <player> show_book:SkillTrainerBook
                    - run QuestProgressHandler def:MeetSkillTrainers
        MeetPostmasterOffer:
            proximity trigger:
                entry:
                    script:
                    - narrate format:QuestMasterFormat "Did you know we have a post office? Why don't you go meet the Postmaster?"
            click trigger:
                script:
                - narrate format:PlayerChatFormat "Sounds easy enough."
                - run QuestAcceptHandler def:MeetPostmaster
                - zap MeetPostmasterActive
            chat trigger:
                MeetPostmasterAcceptance:
                    trigger: /yes|sure|okay|great|yeah/
                    hide trigger message: true
                    script:
                    - narrate format:PlayerChatFormat "Sounds easy enough."
                    - run QuestAcceptHandler def:MeetPostmaster
                    - zap MeetPostmasterActive
        MeetPostmasterActive:
            proximity trigger:
                entry:
                    script:
                    - narrate format:QuestMasterFormat "The post office is just around the corner from here."
                    - run QuestProgressHandler def:MeetPostmaster
        FirstMobHuntingOffer_QM:
            proximity trigger:
                entry:
                    script:
                    - narrate format:QuestMasterFormat "You know, I reckon Reinwald has a quest for you."
        FirstMobHuntingActive_QM:
            proximity trigger:
                entry:
                    script:
                    - narrate format:QuestMasterFormat "You picked up that quest from Reinwald, eh? Don't forget to wear armor!"
        NoActiveQuest:
            proximity trigger:
                entry:
                    script:
                    - narrate format:QuestMasterFormat "Look at you, making your way in the world! I'm very proud."
                    - wait 0.7s
                    - narrate format:QuestMasterFormat "There are some quests around here that we could use your help with every so often, so check back regularly."
                    - wait 0.7s
                    - narrate format:QuestMasterFormat "Reinwald and his troops have some similar tasks for you, too, I'm sure."