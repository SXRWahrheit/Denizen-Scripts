ImbuedFlameboltWand_sealed_potential:
    type: item
    debug: false
    no_id: true
    material: wooden_hoe
    display name: <&9>Imbued Wand of Embers
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>This wand has a mystic presence.
        - <&f>It's warm to the touch.
        - <&c>Casts flamebolt when charged
        - <&6>Sealed Potential
    enchantments:
    - MENDING:1
    flags:
        equipment_type: weapon
        weapon_type: wand
        spell: flamebolt
        spell_magic_type: fire
        item_tier: veteran
        sealed_potential: true
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.movementSpeed/mainhand/1/0.1
        - generic.attackSpeed/mainhand/1/-0.77
        - generic.attackDamage/mainhand/0/8.0
        nbt:
        - equipment_type/weapon
        - weapon_type/wand
        - spell/flamebolt
        - spell_magic_type/fire
        - item_tier/veteran
        - sealed_potential/true

BurnishedFlameboltWand_sealed_potential:
    type: item
    debug: false
    no_id: true
    material: wooden_hoe
    display name: <&d>Burnished Wand of Embers
    data:
        lore_list:
        - <&d><&o>Elite
        - <&f>This wand seeps magical energy and is warm to the touch.
        - <&c>Casts flamebolt when charged
        - <&6>Sealed Potential
    enchantments:
    - MENDING:1
    flags:
        equipment_type: weapon
        weapon_type: wand
        spell: flamebolt
        spell_magic_type: fire
        item_tier: elite
        sealed_potential: true
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.movementSpeed/mainhand/1/0.1
        - generic.attackSpeed/mainhand/1/-0.74
        - generic.attackDamage/mainhand/0/9.0
        nbt:
        - equipment_type/weapon
        - weapon_type/wand
        - spell/flamebolt
        - spell_magic_type/fire
        - item_tier/elite
        - sealed_potential/true

ImbuedFlameboltWand:
    type: item
    debug: false
    no_id: true
    material: wooden_hoe
    display name: <&9>Imbued Wand of Embers
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>This wand has a mystic presence.
        - <&f>It's warm to the touch.
        - <&c>Casts flamebolt when charged
    enchantments:
    - MENDING:1
    flags:
        equipment_type: weapon
        weapon_type: wand
        spell: flamebolt
        spell_magic_type: fire
        item_tier: veteran
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.movementSpeed/mainhand/1/0.1
        - generic.attackSpeed/mainhand/1/-0.77
        - generic.attackDamage/mainhand/0/8.0
        nbt:
        - equipment_type/weapon
        - weapon_type/wand
        - spell/flamebolt
        - spell_magic_type/fire
        - item_tier/veteran

BurnishedFlameboltWand:
    type: item
    debug: false
    no_id: true
    material: wooden_hoe
    display name: <&d>Burnished Wand of Embers
    data:
        lore_list:
        - <&d><&o>Elite
        - <&f>This wand seeps magical energy and is warm to the touch.
        - <&c>Casts flamebolt when charged
    enchantments:
    - MENDING:1
    flags:
        equipment_type: weapon
        weapon_type: wand
        spell: flamebolt
        spell_magic_type: fire
        item_tier: elite
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.movementSpeed/mainhand/1/0.1
        - generic.attackSpeed/mainhand/1/-0.74
        - generic.attackDamage/mainhand/0/9.0
        nbt:
        - equipment_type/weapon
        - weapon_type/wand
        - spell/flamebolt
        - spell_magic_type/fire
        - item_tier/elite

ImbuedWindboltWand_sealed_potential:
    type: item
    debug: false
    no_id: true
    material: wooden_hoe
    display name: <&9>Imbued Wand of Breezes
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>This wand has a mystic presence.
        - <&f>When you pick it up, it reminds you of a cool breeze.
        - <&c>Casts windbolt when charged
        - <&6>Sealed Potential
    enchantments:
    - MENDING:1
    flags:
        equipment_type: weapon
        weapon_type: wand
        spell: windbolt
        spell_magic_type: wind
        item_tier: veteran
        sealed_potential: true
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.movementSpeed/mainhand/1/0.1
        - generic.attackSpeed/mainhand/1/-0.77
        - generic.attackDamage/mainhand/0/8.0
        nbt:
        - equipment_type/weapon
        - weapon_type/wand
        - spell/windbolt
        - spell_magic_type/wind
        - item_tier/veteran
        - sealed_potential/true

BurnishedWindboltWand_sealed_potential:
    type: item
    debug: false
    no_id: true
    material: wooden_hoe
    display name: <&d>Burnished Wand of Breezes
    data:
        lore_list:
        - <&d><&o>Elite
        - <&f>This wand seeps magical energy.
        - <&f>When you pick it up, it reminds you of a cool breeze.
        - <&c>Casts windbolt when charged
        - <&6>Sealed Potential
    enchantments:
    - MENDING:1
    flags:
        equipment_type: weapon
        weapon_type: wand
        spell: windbolt
        spell_magic_type: wind
        item_tier: elite
        sealed_potential: true
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.movementSpeed/mainhand/1/0.1
        - generic.attackSpeed/mainhand/1/-0.74
        - generic.attackDamage/mainhand/0/9.0
        nbt:
        - equipment_type/weapon
        - weapon_type/wand
        - spell/windbolt
        - spell_magic_type/wind
        - item_tier/elite
        - sealed_potential/true

ImbuedAquaboltWand_sealed_potential:
    type: item
    debug: false
    no_id: true
    material: wooden_hoe
    display name: <&9>Imbued Wand of Streams
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>This wand has a mystic presence.
        - <&f>When you pick it up, you hear the faint sound of a forest stream.
        - <&c>Casts aquabolt when charged
        - <&6>Sealed Potential
    enchantments:
    - MENDING:1
    flags:
        equipment_type: weapon
        weapon_type: wand
        spell: aquabolt
        spell_magic_type: water
        item_tier: veteran
        sealed_potential: true
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.movementSpeed/mainhand/1/0.1
        - generic.attackSpeed/mainhand/1/-0.77
        - generic.attackDamage/mainhand/0/8.0
        nbt:
        - equipment_type/weapon
        - weapon_type/wand
        - spell/aquabolt
        - spell_magic_type/water
        - item_tier/veteran
        - sealed_potential/true

BurnishedAquaboltWand_sealed_potential:
    type: item
    debug: false
    no_id: true
    material: wooden_hoe
    display name: <&d>Burnished Wand of Streams
    data:
        lore_list:
        - <&d><&o>Elite
        - <&f>This wand seeps magical energy and is warm to the touch.
        - <&f>When you pick it up, you hear the faint sound of a forest stream.
        - <&c>Casts aquabolt when charged
        - <&6>Sealed Potential
    enchantments:
    - MENDING:1
    flags:
        equipment_type: weapon
        weapon_type: wand
        spell: aquabolt
        spell_magic_type: water
        item_tier: elite
        sealed_potential: true
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.movementSpeed/mainhand/1/0.1
        - generic.attackSpeed/mainhand/1/-0.74
        - generic.attackDamage/mainhand/0/9.0
        nbt:
        - equipment_type/weapon
        - weapon_type/wand
        - spell/aquabolt
        - spell_magic_type/water
        - item_tier/elite
        - sealed_potential/true

ImbuedNatureboltWand_sealed_potential:
    type: item
    debug: false
    no_id: true
    material: wooden_hoe
    display name: <&9>Imbued Wand of Sprouting
    data:
        lore_list:
        - <&9><&o>Veteran
        - <&f>This wand has a mystic presence.
        - <&f>Touching it reminds you of spring flowers.
        - <&c>Casts naturebolt when charged
        - <&6>Sealed Potential
    enchantments:
    - MENDING:1
    flags:
        equipment_type: weapon
        weapon_type: wand
        spell: naturebolt
        spell_magic_type: nature
        item_tier: veteran
        sealed_potential: true
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.movementSpeed/mainhand/1/0.1
        - generic.attackSpeed/mainhand/1/-0.77
        - generic.attackDamage/mainhand/0/8.0
        nbt:
        - equipment_type/weapon
        - weapon_type/wand
        - spell/naturebolt
        - spell_magic_type/nature
        - item_tier/veteran
        - sealed_potential/true

BurnishedNatureboltWand_sealed_potential:
    type: item
    debug: false
    no_id: true
    material: wooden_hoe
    display name: <&d>Burnished Wand of Sprouting
    data:
        lore_list:
        - <&d><&o>Elite
        - <&f>This wand seeps magical energy.
        - <&f>Touching it reminds you of spring flowers.
        - <&c>Casts naturebolt when charged
        - <&6>Sealed Potential
    enchantments:
    - MENDING:1
    flags:
        equipment_type: weapon
        weapon_type: wand
        spell: naturebolt
        spell_magic_type: nature
        item_tier: elite
        sealed_potential: true
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.movementSpeed/mainhand/1/0.1
        - generic.attackSpeed/mainhand/1/-0.74
        - generic.attackDamage/mainhand/0/9.0
        nbt:
        - equipment_type/weapon
        - weapon_type/wand
        - spell/naturebolt
        - spell_magic_type/nature
        - item_tier/elite
        - sealed_potential/true