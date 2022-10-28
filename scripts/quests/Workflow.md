Need to implement multi-quest menus for handling the progress and objectives of multiple quests at once.

Currently I can get the list of active quests and select one, but I need to build a list of objectives represented by items and know what to do when a user clicks each objective.

This _could_ be achieved by writing out the handler code for each quest in that quest's corresponding handler scripts, but that would be a lot of code duplication.

Probably what I need to do is go back and update all of the quest files - again - and add data to each objective about its type so that a central type handler can handle the interaction.

I'm hesitant about doing this because it means essentially just recreating the prior quest plugin to some degree - there is a level of customization that gets sacrificed if you outsource all of the objectives to a central handler interface.

However, unlike the prior plugin, we are not limited to a single and non-expanding set of handlers. Tasks can be created on an ad-hoc basis in addition to the core concepts, so there is no explicit need to rely on only basic implementations.

---

Sep. 6, 2021

In the long-term I should go back and rework the objective system so that objectives are named sensibly, not just numbered.

As a result of this rework, the objectives could possibly be procedurally determined, but in any case the code will be more readable both in the data files and in the scripts.

Meanwhile!

I still need to properly design an interface for handling multiple quests simultaneously on a single NPC.

I began scripting a menu of active versus available quests, and I need to implement switching between those two menus. I also need to display the objectives so a player can get information about them.

---

Sep 11, 2021

Last time I got some display stuff fixed and implemented the injection of the available/active switcher. I need to hook up the actual switching functionality and make sure the available list is generated correctly.

---

Sep 11, 2021

Ha. I got the procedural inventories working. I am a god.

Now I need to add interactions for active quests.

---

Oct 14, 2021

I reset my caffeine tolerance to help kick my depressive spiral. I have ascended to the plane of the Gods. Let's write some code.

---

Jan 8, 2022

Yikes. It's been a while since I committed. But I did build out the objective display! Now I just need to make them interactive.