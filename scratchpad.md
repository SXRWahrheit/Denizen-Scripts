# Scratchpad

Stuff I come up with on lunch breaks.

## Utilities

### Chat rewrite

* Pronoun tags

### Daily roll rework

* Prizes spin around the player before landing on the final prize

### Schematic checker

* For a designated location, check the blocks of a schematic relative to the blocks in the area.
  * To be used for custom features like portals, shrines, etc.
* Prevent block changes in the area unless the core block is modified actively by a player, and require confirmation to disable the structure

## Economy

### Villager trades at spawn

* Centralized and reliable NPCs for trading with
  * Prices higher than those that can be found elsewhere
  * Gold sinks somehow
    * Pay gold to improve supplies? Reduce prices?
  * Reduces the need for villager spawners
  
### Material storage

* Store stacks of materials, up to some limit
  * Obviates the need for sorters

## Combat

### Item economy design

* Modular item construction
  * Build items from components
    * We sort of already do this with gems and sockets, and that system will remain, but it should be marginal
    * But you can also imagine different item components, or infusions, or whatever lore-based approach is useful to take
    * Importantly, the major function here is to let players choose stat combinations (and therefore playstyles)
  * Item archetypes determine stat universes, for example:
    * Crit damage
    * Crit chance
    * Attack speed
    * Magic power
  * Components can be traded
    * Rarity matters
    * Not permanent unlocks
  * Gold sinks
    * Cost for forging

## Mobs

### Champions
* Fix Toxus being passive during the day

### Elites

#### Spider
* Web shot 
  * Modifies some air blocks to cobwebs
* Leap
* Web grab
  * Pull players

#### Wind Cultist
* Gustlaunch players
* Shockwave players
* Summon air familiar

#### Water Cultist
* Heal mobs (regen)
* Rally & speed boost
* Summon water familiar
* Tidal wave

#### Fire Cultist
* Fire Aura
* Summon fire familiar
* Firestorm
* Flamesurge

#### Nature Cultist
* Heal mobs (burst)
* Rally & shield
* Rootsurge
* Summon nature familiar

## Skills and spells

### Super ideas

#### Sandstorm
* PBAOE
* Remains at cast location
* Applies slow pulse to entities within
  * Need logic for sand swirl particles; circling waves?
* Modify blocks in radius to sand temporarily?
* Draw towards middle?

#### Ice Storm
* Cone AOE
* Multi cast
* Increased damage and slow on successive casts
* Slow duration rather long
* Return energy for slowed target death?

#### Headshot
* Headshots deal 300% damage
* Restore energy on kill

#### Impenetrable
* No knockback, increased armor, decreased damage

#### Live Wire
* Explode after 10s
* Increased speed

#### Battle Soul
* Grant +dmg to ally
* Heal from % ally dmg

#### Swirl of blades
* Spin around dealing damage

#### Hundred blades
* Successive hits +dmg

#### Crashing wave
* Geyser up, wave outward
* Pushes mobs away + damages
Ice platform 10s

#### Fleet-footed
* Velocity on jump / right click
* Speed boost
* +dmg in air
* Hover while aiming

### Counter-attacks

* `on entity damaged by`
* * `<context.cause>` == `entity_attack`
* * `<context.damager>`

* Skill: Tie to off-hand items?
* Counter-attack spells?

### Attunement spells

* Mana is easy. What about redstone?
* Probably requires Denizen knowing what the costs of the spells are
  * Could do this via manually making a list in Denizen or maybe just wait for MagicSpells 4.0

### "Elite" spells

* If an Elite spell is on cooldown, no other Elite spell may be cast

### More magic stuff to flesh out later

* What is this element bad at?
* What is this element good at?
* What is this element the best at (i.e. better than any other element at)?

## Etc

* MobArena with MythicMobs that uses the players' equipped inventories so they can practice combat
  * Requires writing a Denizen script to cancel drops / money mobs in the arena
  
* Do this but better: https://www.spigotmc.org/resources/mobhunting.3582/

### Pocket realms for gold and redstone farming

#### Summary
  * Summoning scroll or whatever drops from elite mobs, activate to bring you and 2 others
  * Mobs that drop resources and a boss at the end
  * Maybe blocks to mine
  * Time limit - choose between mining and combat or work together and do both
#### Redstone progress
  * Tileset
    * Tileset design
    * Generation / implementation
  * Mobs
    * Veterans
    * Elites
    * Boss
  * Items
  * Scripts
    * Player teleportation
    * Timer

## Introduction rework

* Key concept - first ten minutes

* Hint at skill trainer locations

* Force user to open book

## Player pages

* Key concept - Shareable pages with player information and progress
 * Rank
 * VIP?
 * Statistics
 * Quest progress
 * A la Pokemon league cards

## PvP / PvE Gamemode to-be-named

* A dungeon, with monsters
* However, players can queue up as opposition monsters as well
* When the challenging players kill the boss at the end of the dungeon, the monster players get powered up and the challengers must escape the dungeon without dying
* Until the final boss is killed, the monster players get unlimited respawns
* Once the boss is killed and the monster players are powered up, it's their last life
* Choose between classes/builds for your final form
* Encourage thoughtful team comps through skill choices