BurnishedSword_sealed_potential:
    material: Diamond_Sword
    type: item
    no_id: true
    display name: <&d>Burnished Diamond Sword
    data:
        lore_list:
        - <&d><&o>Elite
        - <&f>This blade seeps magical energy.
        - <&6>Sealed Potential
    enchantments:
    - DAMAGE_ALL:7
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.movementSpeed/mainhand/1/0.1
        - generic.attackSpeed/mainhand/1/-0.54
        - generic.attackDamage/mainhand/0/13.0
        nbt:
        - equipment_type/weapon
        - item_tier/elite
        - sealed_potential/true

SkeletalDarkKnightSword_sealed_potential:
    material: diamond_sword
    type: item
    no_id: true
    display name: <&d>Skeletal Dark Knight's Blade
    data:
        lore_list:
        - <&d><&o>Elite
        - <&f>A shimmering blade used by dark knights.
        - <&6>Sealed Potential
    enchantments:
    - DAMAGE_ALL:7
    - KNOCKBACK:1
    - FIRE_ASPECT:2
    - LOOT_BONUS_MOBS:3
    - DURABILITY:2
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.attackSpeed/mainhand/1/-0.6
        - generic.attackDamage/mainhand/0/13.0
        - generic.armor/mainhand/0/4.0
        nbt:
        - equipment_type/weapon
        - item_tier/elite
        - sealed_potential/true

SkeletalDarkKnightHelm_sealed_potential:
    material: diamond_helmet
    type: item
    no_id: true
    display name: <&d>Skeletal Dark Knight's Helm
    data:
        lore_list:
        - <&d><&o>Elite
        - <&f>A corrupted helm offering protection, but at what cost?
        - <&6>Sealed Potential
    enchantments:
    - PROTECTION_ENVIRONMENTAL:4
    - PROTECTION_PROJECTILE:3
    - PROTECTION_FIRE:3
    - PROTECTION_EXPLOSIONS:3
    - DURABILITY:2
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.maxHealth/head/0/4.0
        - generic.armorToughness/head/0/2.0
        - generic.armor/head/0/4.0
        nbt:
        - equipment_type/armor
        - item_tier/elite
        - sealed_potential/true

SharpshooterBow_sealed_potential:
    material: bow
    type: item
    no_id: true
    display name: <&d>Sharpshooter's Bow
    data:
        lore_list:
        - <&d><&o>Elite
        - <&f>This bow belonged to a distinguished shooter.
        - <&6>Sealed Potential
    enchantments:
    - ARROW_DAMAGE:7
    - ARROW_KNOCKBACK:3
    - LOOT_BONUS_MOBS:3
    - DURABILITY:2
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.movementSpeed/mainhand/1/0.01
        - generic.armor/mainhand/0/6.0
        nbt:
        - equipment_type/weapon
        - item_tier/elite
        - sealed_potential/true

BountifulBlade_sealed_potential:
    material: gold_sword
    type: item
    no_id: true
    display name: <&d>Bountiful Blade
    data:
        lore_list:
        - <&d><&o>Elite
        - <&f>This blade brings good fortune to its holder.
        - <&6>Sealed Potential
    enchantments:
    - LOOT_BONUS_MOBS:5
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.movementSpeed/mainhand/1/0.05
        - generic.attackSpeed/mainhand/1/-0.8
        - generic.attackDamage/mainhand/0/4.0
        nbt:
        - equipment_type/weapon
        - item_tier/elite
        - sealed_potential/true

WitheringBlade_sealed_potential:
    material: gold_sword
    type: item
    no_id: true
    display name: <&d>Withering Blade
    data:
        lore_list:
        - <&d><&o>Elite
        - <&f>A shadowy presence emanates from this blade.
        - <&6>Sealed Potential
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.attackSpeed/mainhand/1/-0.9
        - generic.attackDamage/mainhand/0/4.0
        nbt:
        - equipment_type/weapon
        - item_tier/elite
        - sealed_potential/true


BurnishedHelm_sealed_potential:
    material: Diamond_Helmet
    type: item
    no_id: true
    display name: <&d>Burnished Diamond Helm
    data:
        lore_list:
        - <&d><&o>Elite
        - <&f>This helm seeps magical energy.
        - <&6>Sealed Potential
    enchantments:
    - PROTECTION_ENVIRONMENTAL:6
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.maxHealth/head/0/5.0
        - generic.armorToughness/head/0/2.0
        - generic.armor/head/0/3.0
        nbt:
        - equipment_type/armor
        - item_tier/elite
        - sealed_potential/true

BurnishedChest_sealed_potential:
    material: Diamond_Chestplate
    type: item
    no_id: true
    display name: <&d>Burnished Diamond Chestplate
    data:
        lore_list:
        - <&d><&o>Elite
        - <&f>This chestplate seeps magical energy.
        - <&6>Sealed Potential
    enchantments:
    - PROTECTION_ENVIRONMENTAL:6
    - PROTECTION_EXPLOSIONS:4
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.maxHealth/chest/0/9.0
        - generic.armorToughness/chest/0/2.0
        - generic.armor/chest/0/9.0
        nbt:
        - equipment_type/armor
        - item_tier/elite
        - sealed_potential/true

BurnishedLegs_sealed_potential:
    material: Diamond_Leggings
    type: item
    no_id: true
    display name: <&d>Burnished Diamond Leggings
    data:
        lore_list:
        - <&d><&o>Elite
        - <&f>These leggings seep magical energy.
        - <&6>Sealed Potential
    enchantments:
    - PROTECTION_ENVIRONMENTAL:6
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.maxHealth/legs/0/7.0
        - generic.armorToughness/legs/0/2.0
        - generic.armor/legs/0/7.0
        nbt:
        - equipment_type/armor
        - item_tier/elite
        - sealed_potential/true

BurnishedBoots_sealed_potential:
    material: Diamond_Boots
    type: item
    no_id: true
    display name: <&d>Burnished Diamond Boots
    data:
        lore_list:
        - <&d><&o>Elite
        - <&f>These boots seep magical energy.
        - <&6>Sealed Potential
    enchantments:
    - PROTECTION_ENVIRONMENTAL:6
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.maxHealth/feet/0/3.0
        - generic.armorToughness/feet/0/2.0
        - generic.armor/feet/0/4.0
        nbt:
        - equipment_type/armor
        - item_tier/elite
        - sealed_potential/true

BurnishedBow_sealed_potential:
    material: bow
    type: item
    no_id: true
    display name: <&d>Burnished Bow
    data:
        lore_list:
        - <&d><&o>Elite
        - <&f>This bow seeps magical energy.
        - <&6>Sealed Potential
    enchantments:
    - ARROW_DAMAGE:7
    - ARROW_KNOCKBACK:3
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt:
        - equipment_type/weapon
        - item_tier/elite
        - sealed_potential/true

BurnishedShield_sealed_potential:
    material: Shield
    type: item
    no_id: true
    display name: <&d>Burnished Shield
    data:
        lore_list:
        - <&d><&o>Elite
        - <&f>This shield seeps magical energy.
        - <&6>Sealed Potential
    enchantments:
    - DURABILITY:4
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.maxHealth/offhand/0/6.0
        - generic.armorToughness/offhand/0/3.0
        nbt:
        - equipment_type/armor
        - item_tier/elite
        - sealed_potential/true

BurnishedAxe_sealed_potential:
    material: Diamond_Axe
    type: item
    no_id: true
    display name: <&d>Burnished Axe
    data:
        lore_list:
        - <&d><&o>Elite
        - <&f>This axe seeps magical energy.
        - <&6>Sealed Potential
    enchantments:
    - DAMAGE_ALL:7
    - DIG_SPEED:7
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        nbt_attributes:
        - generic.attackSpeed/mainhand/1/-0.7
        - generic.attackDamage/mainhand/0/14.0
        - generic.armorToughness/mainhand/0/3.0
        nbt:
        - equipment_type/weapon
        - item_tier/elite
        - sealed_potential/true
