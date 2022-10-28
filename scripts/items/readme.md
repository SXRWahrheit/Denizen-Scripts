# Item formatting and design guide

This folder contains various Denizen script files with items on Summa Crossroads. This readme is provided as a reference for style and functionality.

A sample armor piece looks like this:

```yaml
ImbuedChest_sealed_potential:
    type: item
    no_id: true
    material: Diamond_Chestplate
    display name: <&9>Imbued Diamond Chestplate
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>This chestplate has a mystic presence.
        - <&6>Sealed Potential
    enchantments:
    - PROTECTION_ENVIRONMENTAL:5
    - PROTECTION_EXPLOSIONS:2
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.maxHealth/chest/0/8.0
        - generic.armorToughness/chest/0/2.0
        - generic.armor/chest/0/8.0
        nbt:
        - equipment_type/armor
        - item_tier/veteran
        - sealed_potential/true
```

Be sure to separate `nbt_attributes` and `nbt` appropriately. 
* `nbt_attributes` uses the default Minecraft attributes (which must match exactly to be effective)
* `nbt` is custom data written to the item for use with Denizen scripts

## Some reference NBT keys and valid values

### Keys applicable to all equipment

#### General information

* `equipment_type` (VALUE) | Whether equipment is a weapon or armor, e.g. `armor` or `weapon`
* `item_tier` (VALUE) | The item's tier, e.g. `veteran`, `elite`, `champion`, `legendary`

#### Magic handlers

NOTE: Magic multipliers are not yet implemented.

The effect of each multiplier will vary per-spell; they could increase damage dealt, duration of CC, etc.

* `fire_magic_power` (FLOAT) | Fire magic power, to be used as a variable for calculating the strength of spells.
* `water_magic_power` (FLOAT) | Water magic power, to be used as a variable for calculating the strength of spells.
* `light_magic_power` (FLOAT) | Light magic power, to be used as a variable for calculating the strength of spells.
* `nature_magic_power` (FLOAT) | Nature magic power, to be used as a variable for calculating the strength of spells.

Magic power serves as a more easily understandable concept than a raw multiplier and allows that power to be used as a coefficient for scaling per-spell.

#### Sockets

* `sealed_potential` (BOOLEAN) | Whether the item has Sealed Potential e.g. `true`
  * Items with Sealed Potential should have no socket data; data will be wiped on unlock.
* `sockets_current` (INTEGER) | Number of sockets currently on the item, filled or unfilled e.g. `4`
* `sockets_max` (INTEGER) | Maximum number of sockets possible to exist on the item, whether existing or not, e.g. `5`
* `sockets_can_add` (BOOLEAN) | Whether it is possible to add any more sockets to the item, to be removed when sockets_current equals sockets_max e.g. `true`, `false`
* `sockets_open` (BOOLEAN) | Whether an item has sockets that are empty e.g. `true`, `false`
* `socket#_type` (VALUE) | The type of a socket, e.g. `socket1_type` `attack`, `defense`, `utility`
* `socket#_gem` (VALUE) | The actual gem inserted into a socket e.g. `socket1_gem` `crit_chance`, `health_on_hit`, `speed_on_hit`
* `socket#_empty` (BOOLEAN) | Whether the numbered socket is empty, e.g. `socket1_empty` `true`

### Gem functions

* `gem_type` (VALUE) | The type of a gem e.g. `attack`, `defense`, `utility`
* `gem_specific` (VALUE) | The actual gem e.g. `crit_chance`, `health_on_hit`, `speed_on_hit`
* `gem_attribute#` (VALUE) | NBT attributes to be applied to item upon socketing e.g. `gem_attribute1` `generic&dotarmor/chest/0/1.0`
  * Note that the value of this entry uses `&dot` instead of a period for the attribute name so it parses correctly when socketed

### Armor functions

* `armor_set` (VALUE) | Which armor set the item belongs to, formatted as `<TIER>_<NAME>` e.g. `veteran_flame`

### Combat functions

#### Backstab handling

* `backstab` (BOOLEAN) | Whether the item should trigger backstab damage, e.g. `true`
* `backstab_multiplier` (FLOAT) | Multiplies outgoing damage when attacking from behind if `backstab` is `true` e.g. `2.5`
