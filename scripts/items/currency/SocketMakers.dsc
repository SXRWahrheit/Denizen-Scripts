SocketMaker:
    type: item
    material: nether_star
    debug: false
    display name: <&a>Purified Dark Matter
    data:
        lore_list:
        - <&6>This coalesced energy has been purged of the darkness inside. It now pulses and radiates in an unstoppable splendor.
    enchantments:
    - MENDING:1
    flags:
        uncraftable: true
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        hides:
        - enchants
        custom_model_data: 100001

SocketMakerExplanation:
    type: world
    debug: false
    events:
        on player right clicks block with:SocketMaker:
        - determine passively cancelled
        - adjust <player> show_book:SocketMakerExplanationBook

SocketMakerExplanationBook:
    type: book
    title: Purified Dark Matter
    author: Wahrheit
    signed: true
    text:
    - You found some <&a>Purified Dark Matter<reset>, huh? You must be either quite rich or quite skilled in combat. Hard to come by it otherwise. But what can you do with it?
    - <bold>First,<reset> <&a>Purified Dark Matter<reset> is used to unlock the <gold>Sealed Potential<reset> of rare items. Only some items are brimming with potential, and you'll need to either fight on or pay up until you get one.
    - <bold>Second,<reset> you'll need to accrue quite a bit of <&a>Purified Dark Matter<reset>, and you'll need an <green>Ingot of Crystallized Experience<reset>, too. Head to the top of the Magic Tower in Dawn's Landing and speak to the Prismatic Seer.
    - Unlock your item's <gold>Sealed Potential<reset> will add <bold>locked sockets<reset> to it. This magical process is unstable, so the number of <bold>sockets<reset> is random. But the rarer the item, the more sockets it can get.
    - <bold>Third,<reset> once you've unlocked your item's <gold>Sealed Potential<reset>, you'll need even more <&a>Purified Dark Matter<reset> and <green>Crystallized Experience<reset> to unlock its new <bold>sockets<reset>.
    - <bold>Finally,<reset> after you've unlocked a socket, you can slot a <bold>gem<reset> of a corresponding type into that socket to upgrade your item. Gems can't be removed once slotted, so choose carefully!