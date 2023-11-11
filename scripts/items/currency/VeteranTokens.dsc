VeteranToken:
    type: item
    debug: false
    material: bone
    display name: <&9>Phantasmal Bones
    data:
        lore_list:
        - <&6>The bones of a powerful monster, slain by a hero. When held, you can still feel energy pouring out of them.
    enchantments:
    - MENDING:1
    flags:
        badlucktoken: veteran
        uncraftable: true
    mechanisms:
        hides:
        - enchants
        flags:
            badlucktoken: veteran
            uncraftable: true
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        custom_model_data: 100001

VeteranTokenExplanation:
    type: world
    debug: false
    events:
        on player right clicks block with:VeteranToken:
        - adjust <player> show_book:BonesExplanation

BonesExplanation:
    type: book
    title: Phantasmal Bones
    author: Wahrheit
    signed: true
    text:
    - Found some <blue>Phantasmal Bones<reset>, have you? Lucky you! <&nl>These rare artifacts are absolutely brimmming with magical energy. There are several ways that you can harness that energy for your benefit!
    - <bold>First, <reset> you can trade a large number of <blue>Phantasmal Bones<reset> and some <green>Crystallized Experience <reset>for powerful tools, weapons, and armor.
    - Go and find the Arcane Forger in Dawn's Landing - he's in the red parapet of the Magic Tower in the castle. You'll need to visit the Arch Artificer to get your experience crystallized, too.
    - <bold>Second, <reset> you can visit Veriana at the top of the Magic Tower. Her magic powers can be used to channel the energy from <blue>Phantasmal Bones<reset>, opening a portal to the magical realm of Avenfeld! But be careful - Avenfeld is filled with the armies of the darkness.
    - Avenfeld is also full of resources to be brought back to Prosperus - you can reap them to your heart's content. It's a high-risk, high-reward realm, suitable for the bravest of adventurers!
    - You can earn more <blue>Phantasmal Bones<reset> by slaying the hordes of the darkness. <&d>Elite<reset> monsters drop them more often and in higher quantities than <blue>Veteran<reset> monsters, but of course they are tougher to take down.
    - Stay on your guard, horde your <blue>Phantasmal Bones<reset>, and cash them in for either some new loot or a trip to Avenfeld!