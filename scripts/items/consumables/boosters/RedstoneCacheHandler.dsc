RedstoneCacheHandler:
    type: command
    name: redstonecacheopen
    description: Opens a redstone cache
    usage: /redstonecacheopen
    permission: server.only
    script:
    - if !<context.server>:
        - stop
    - give player:<server.match_player[<context.args.get[1]>]> redstone quantity:64

SmallRedstoneCacheHandler:
    type: command
    name: smallredstonecacheopen
    description: Opens a small redstone cache
    usage: /smallredstonecacheopen
    permission: server.only
    script:
    - if !<context.server>:
        - stop
    - give player:<server.match_player[<context.args.get[1]>]> redstone quantity:32