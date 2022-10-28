DropMultiplierHandler:
    type: procedure
    debug: false
    script:
    - define multiplier:1
    - if <yaml[rates].read[drops.active]>:
        - define multiplier:<[multiplier].mul[<yaml[rates].read[drops.multiplier]>]>
    - if <player.has_flag[player_drop_rate]>:
        - define multiplier:<[multiplier].mul[<player.flag[player_drop_rate]>]>
    - determine <[multiplier]>