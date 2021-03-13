# Determines a ListTag with a random number of words from the dictionary list
# Usage e.g. <proc[dictionary_generator].context[4].space_separated>
dictionary_generator:
    type: procedure
    definitions: number
    script:
    - determine <script[dictionary_list].data_key[word_list].random[<[number]>]>