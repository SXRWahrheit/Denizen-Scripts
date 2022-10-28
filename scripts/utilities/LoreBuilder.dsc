# Usage:
# lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
# Lore should be stored like normal Denizen lore, but in lore_list rather than lore
lore_builder:
    type: procedure
    definitions: linesize|lore
    debug: false
    script:
    - determine <[lore].separated_by[<n>].parsed.split_lines[<[linesize]>].lines_to_colored_list>