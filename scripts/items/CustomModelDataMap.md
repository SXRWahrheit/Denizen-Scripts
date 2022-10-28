CustomModelData Quicksheet
==========================

This file stores all custom model data references for items.

In general, variants start at `100001`.

For tiered gear, tiered base-versions start at:
* `101000` for Veteran (Imbued)
* `102000` for Elite (Burnished)
* `103000` for Champion (Emblazoned)
* With variants therein starting at `101001`, `102001`, etc

Mixology items start with `110000` temporarily -- this may change in the future.

Patreon skins (P) start at `200001`.

This is all subject to change to accommodate future features, etc.

## Held Items

### Arrow
* `100001`: Left Paging-Arrow for Menus
* `100002`: Right Paging-Arrow for Menus
* `100003`: Down Indicating-Arrow for Menus
* `100004`: Up Indicating-Arrow for Menus

### Bone
* `100001`: Phantasmal Bones

### Bow
* `101000`: Imbued Bow
* `102000`: Burnished Bow
* `102001`: Sharpshooter's Bow
* `103000`: Emblazoned Bow

### Bread
* `100001`: Cheese

### Diamond
* `100001`: Imbued Tools Button
* `100002`: Imbued Weapons Button
* `100003`: Burnished Tools Button
* `100004`: Burnished Weapons Button

### Diamond Axe
* `101000`: Imbued Diamond Axe
* `102000`: Burnished Diamond Axe
* `103000`: Emblazoned Diamond Axe

### Diamond Hoe
* `100001`: Diamond Dagger
* `101000`: Imbued Diamond Hoe
* `101001`: Imbued Diamond Dagger
* `102000`: Burnished Diamond Hoe
* `102001`: Burnished Diamond Dagger
* `103000`: Emblazoned Diamond Hoe
* `103001`: Emblazoned Diamond Dagger

### Diamond Pickaxe
* `100001`: Diamond Hammer
* `101000`: Imbued Diamond Pickaxe
* `101001`: Imbued Diamond Hammer
* `102000`: Burnished Diamond Pickaxe
* `102001`: Burnished Diamond Hammer
* `103000`: Emblazoned Diamond Pickaxe
* `103001`: Emblazoned Diamond Hammer

### Diamond Shovel
* `101000`: Imbued Diamond Shovel
* `102000`: Burnished Diamond Shovel
* `103000`: Emblazoned Diamond Shovel

### Diamond Sword
* `100001`: Diamond Chain
* `101000`: Imbued Diamond Sword
* `101001`: Imbued Diamond Chain
* `102000`: Burnished Diamond Sword
* `102001`: Burnished Diamond Chain
* `102002`: Skeletal Dark Knight's Blade
* `103000`: Emblazoned Diamond Sword
* `103001`: Emblazoned Diamond Chain
* `103002`: Blade of the Consuming Shadow

### Emerald
* `100001`: Gem of Attack
* `100002`: Gem of Defense
* `100003`: Gem of Utility
* `100004`: Sliver of Experience
* `100005`: Chunk of Experience
* `100006`: Billet of Experience
* `100007`: Bloom of Experience
* `100008`: Ingot of Experience

### Fishing Rod
* `101000`: Imbued Fishing Rod
* `102000`: Burnished Fishing Rod
* `103000`: Emblazoned Fishing Rod

### Glass Bottle
* `111100`: Empty Whiskey Bottle
* `111200`: Empty Vodka Bottle
* `111600`: Empty Tequila Bottle
* `111800`: Empty Generic Lager Bottle

### Gold Nugget
* `100001`: Tribute to the Gods

### Golden Hoe
* `100001`: Golden Dagger

### Golden Pickaxe
* `100001`: Golden Hammer

### Golden Sword
* `100001`: Golden Chain
* `102001`: Bountiful Blade
* `102002`: Withering Blade

### Honey Bottle
* `110100`: Whiskey Bottle
* `110200`: Vodka Bottle
* `110600`: Tequila Bottle
* `110800`: Generic Lager Bottle

### Iron Hoe
* `100001`: Iron Dagger

### Iron Pickaxe
* `100001`: Iron Hammer

### Iron Sword
* `100001`: Iron Chain

### Nether Star
* `100001`: Purified Dark Matter

### Netherite Axe
* `101000`: Imbued Netherite Axe
* `102000`: Burnished Netherite Axe
* `103000`: Emblazoned Netherite Axe

### Netherite Hoe
* `100001`: Netherite Dagger
* `101000`: Imbued Netherite Hoe
* `101001`: Imbued Netherite Dagger
* `102000`: Burnished Netherite Hoe
* `102001`: Burnished Netherite Dagger
* `103000`: Emblazoned Netherite Hoe
* `103001`: Emblazoned Netherite Dagger

### Netherite Pickaxe
* `100001`: Netherite Hammer
* `101000`: Imbued Netherite Pickaxe
* `101001`: Imbued Netherite Hammer
* `102000`: Burnished Netherite Pickaxe
* `102001`: Burnished Netherite Hammer
* `103000`: Emblazoned Netherite Pickaxe
* `103001`: Emblazoned Netherite Hammer

### Netherite Shovel
* `101000`: Imbued Netherite Shovel
* `102000`: Burnished Netherite Shovel
* `103000`: Emblazoned Netherite Shovel

### Netherite Sword
* `100001`: Netherite Chain
* `101000`: Imbued Netherite Sword
* `101001`: Imbued Netherite Chain
* `102000`: Burnished Netherite Sword
* `102001`: Burnished Netherite Chain
* `102002`: Skeletal Dark Knight's Blade
* `103000`: Emblazoned Netherite Sword
* `103001`: Emblazoned Netherite Chain
* `103002`: Blade of the Consuming Shadow

### Paper
* `100001`: Snowflake (icon152.png)
* `100002`: Blue present (icon262.png)
* `100003`: Red present (icon263.png)
* `100004`: Green present (icon264.png)
* `200001`: (P) Arrakis Waypoint

### Prismarine Crystals
* `100001`: Adventurer's Crystal

### Shield
* `101000`: Imbued Shield
* `102000`: Burnished Shield
* `103000`: Emblazoned Shield
* `200001`: (P) Charge-N-Targe

### Stone Hoe
* `100001`: Stone Dagger

### Stone Pickaxe
* `100001`: Stone Hammer

### Stone Sword
* `100001`: Stone Chain

### Wooden Hoe
* `100001`: Wooden Dagger

### Wooden Pickaxe
* `100001`: Wooden Hammer

### Wooden Sword
* `100001`: Wooden Chain

### Written Book
* `100001`: New Player's Guide

## Armor Models

Armor is implemented specially since Custom Model Data can apply to the item textures in vanilla,
but applying it to armor-model textures requires a mod.

This pack supports Optifine and Chime (for Fabric) for applying Custom Model Data to Armor Models.

The item textures are also split out from Vanilla to avoid confusion for people not using Optifine nor Chime.
Whereas in Optifine or Chime the item texture will reflect the model texture, in vanilla the items will just
have tier-colored outlines to denote tier at-a-glance.

Minimal armor variants start at `110000`.

| Leather Armor    | Optifine/Chime      | Vanilla      |
| ---------------- | ------------------- | ------------ |
| `101001`         | Smoldering          | Blue Outline |
| `110000`         | Minimal             | --           |
| `111001`         | Minimal Smoldering  | Blue Outline |


| Diamond Armor    | Optifine/Chime     | Vanilla        |
| ---------------- | ------------------ | -------------- |
| `101000`         | Imbued             | Blue Outline   |
| `102000`         | Burnished          | Pink Outline   |
| `102001`         | SDK Helm           | Pink Outline   |
| `103000`         | Emblazoned         | Yellow Outline |
| `110000`         | Minimal            | --             |
| `111000`         | Minimal Imbued     | Blue Outline   |
| `112000`         | Minimal Burnished  | Pink Outline   |
| `112001`         | Minimal SDK Helm   | Pink Outline   |
| `113000`         | Minimal Emblazoned | Yellow Outline |


| Netherite Armor    | Optifine/Chime     | Vanilla        |
| ------------------ | ------------------ | -------------- |
| `101000`           | Imbued             | Blue Outline   |
| `102000`           | Burnished          | Pink Outline   |
| `102001`           | SDK Helm           | Pink Outline   |
| `103000`           | Emblazoned         | Yellow Outline |
| `110000`           | Minimal            | --             |
| `111000`           | Minimal Imbued     | Blue Outline   |
| `112000`           | Minimal Burnished  | Pink Outline   |
| `112001`           | Minimal SDK Helm   | Pink Outline   |
| `113000`           | Minimal Emblazoned | Yellow Outline |


| Elytra    | Optifine           | Vanilla/Chime  |
| --------- | ------------------ | -------------- |
| `102001`  | Wind Mage's Elytra | Pink Outline   |

*At time of writing, Chime does not support elytra.*
