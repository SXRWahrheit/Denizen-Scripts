# Avenfeld warp NPC
# I did not start writing her as an ara ara character but uhhh that's where she took it

VerianaAssignment:
    type: assignment
    debug: false
    interact scripts:
    - VerianaInteract
    actions:
        on assignment:
        - trigger name:proximity state:true
        - trigger name:chat state:true

VerianaFormat:
    type: format
    debug: false
    format: "<dark_green>Veriana<white><&co> <[text]>"

VerianaInteract:
    type: interact
    debug: false
    steps:
        Greeting*:
            proximity trigger:
                entry:
                    script:
                    - narrate format:VerianaFormat "Hail, fellow traveler! Pleased to meet you - my name is Veriana."
                    - wait 2.5s
                    - narrate format:VerianaFormat "Who are you, and what brings you up here?"
                    - wait 2.5s
                    - narrate format:PlayerChatFormat "I'm <player.name>, and I'm looking for some new adventures. I want to face all the challenges this world has to offer!"
                    - wait 2.5s
                    - narrate format:VerianaFormat "All this world has to offer, huh? What a brave adventurer you are! Well then. What if I were to tell you... there exist more worlds than just Prosperus?"
                    - wait 2.5s
                    - narrate format:PlayerChatFormat "Oh, I know that. There's the Nether, and the End, and even the Heavens!"
                    - wait 2.5s
                    - narrate format:VerianaFormat "Ah, true enough. You're so smart! But I know of a land even stranger than our own. It is overflowing with the enemies of the Gods, and full of nature that must be seen to be believed."
                    - wait 2.5s
                    - narrate format:PlayerChatFormat "Wow, that sounds incredible! Where is it? How do I get there?"
                    - wait 2.5s
                    - narrate format:VerianaFormat "Hm... eager, aren't you? This land is called Avenfeld. Only brave adventurers skilled of magic have traditionally been able to reach it. With enough skill, and by making an offering to the Gods, they can travel there as often as they like."
                    - wait 2.5s
                    - narrate format:VerianaFormat "But those offerings are expensive, and many have sought other ways to make the journey. So far, I have been the only one to succeed."
                    - wait 2.5s
                    - narrate format:PlayerChatFormat "W-wow... you must be truly skilled with magic!"
                    - wait 2.5s
                    - narrate format:VerianaFormat "Indeed. But I'd like a little more practice, and I think this is where we can make a deal. I'd like to practice sending others to Avenfeld, not just myself. Do you think you can handle such an... untamed realm?"
                    - wait 2.5s
                    - narrate format:PlayerChatFormat "I-...I'm sure I can handle it. What's the deal?"
                    - wait 2.5s
                    - narrate format:VerianaFormat "Well, the way I found to Avenfeld requires manipulating and repurposing the dark energies used by the foes of the Gods."
                    - wait 2.5s
                    - narrate format:VerianaFormat "I need <item[VeteranToken].display><&f> to extract the energy and open a portal. Two stacks of them should be enough."
                    - wait 2.5s
                    - narrate format:PlayerChatFormat "Wow, that still seems pretty expensive!"
                    - wait 2.5s
                    - narrate format:VerianaFormat "Perhaps. But the sacrifice will benefit us both, no? As I gain more practice manipulating this energy, my powers will grow, and we might both discover new opportunities to... <italic>work together<reset><white>."
                    - wait 2.5s
                    - narrate format:VerianaFormat "Besides, I'm sure it's no trouble for a <italic>big, strong<reset><white> adventurer such as yourself. I'm sure you can... <italic>impress me."
                    - wait 2.5s
                    - narrate format:PlayerChatFormat "Um. Fair enough. Yes, yes, I'm sure I can."
                    - if <player.inventory.contains_item[VeteranToken].quantity[128]>:
                        - narrate format:PlayerChatFormat "I've, uh, got two stacks of <item[VeteranToken].display><&f> with me right now, in fact."
                        - wait 2.5s
                        - narrate format:VerianaFormat "Well, would you look at that! <italic>Very<reset> impressive. Shall I open a portal?"
                    - else:
                        - narrate format:VerianaFormat "Come on back when you've got 128 <item[VeteranToken].display><&f> and I'll open a portal to Avenfeld for you. You're brave enough, aren't you?"
                        - wait 2.5s
                        - narrate format:PlayerChatFormat "Y-...yes! I'm very brave! I'll bring you what you need. Th-...thanks, Veriana!"
                    - zap Returning
        Returning:
            proximity trigger:
                entry:
                    script:
                    - narrate format:VerianaFormat "Come all the way up here again, have you <player.name>?"
                    - wait 2.5s
                    - if <player.inventory.contains_item[VeteranToken].quantity[128]>:
                        - narrate format:PlayerChatFormat "Yep, and I've brought you the <item[VeteranToken].display><&f>!"
                        - wait 2.5s
                        - narrate format:VerianaFormat "Delightful. What a big, strong adventurer you are!"
                        - narrate "<gray>Right-click Veriana when you're ready to travel!"
                        - zap Warp
                    - else:
                        - narrate format:VerianaFormat "Tsk tsk... looks like you don't have 128 <item[VeteranToken].display><&f> with you. What a let-down!"
                        - wait 2.5s
                        - narrate format:VerianaFormat "Go out and collect some, and come back when you've got them. I'm sure you'll make me <italic>very proud<reset><&f>."
                exit:
                    script:
                    - if <player.world.name> != prosperus:
                        - stop
                    - narrate format:VerianaFormat "Ta-ta for now, traveler! <italic>Do<reset><white> take care of yourself, won't you? I'll be here when you're good and ready."
        Warp:
            click trigger:
                script:
                - if <player.inventory.contains_item[VeteranToken].quantity[128]>:
                    - narrate format:VerianaFormat "Aha, look at all these lovely <item[VeteranToken].display><&f>. How delightful! Let's begin."
                    - wait 0.5s
                    - narrate "<gray>Veriana channels her magic..."
                    - wait 0.5s
                    - take scriptname:VeteranToken quantity:128
                    - narrate "<gray>The <item[VeteranToken].display><gray> disintegrate!"
                    - wait 0.5s
                    - narrate format:VerianaFormat "Off you go, <italic>adventurer<reset><white>!"
                    - playeffect effect:portal at:<player.eye_location.sub[0,0.5,0]> visibility:200 quantity:1000 offset:0.5 data:2.0
                    - playeffect effect:end_rod at:<player.eye_location> visibility:200 quantity:100 offset:2.0 data:1.0
                    - wait 1s
                    - teleport <player> AvenfeldVerianaWarp
                    - cast slow_falling d:30 a:0 <player>
                    - playeffect effect:end_rod at:<player.eye_location> visibility:200 quantity:1000 offset:2.0 data:1.0
                - zap Returning
