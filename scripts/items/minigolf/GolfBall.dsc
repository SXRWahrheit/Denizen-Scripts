GolfBall:
    type: item
    material: snowball
    display name: Golf ball
    enchantments:
    - Mending
    mechanisms:
        hides:
        - all
    flags:
        uncraftable: true

GolfBall_Toss_Only:
    type: world
    debug: false
    events:
        on player right clicks block with:golfball*:
        - if <context.item.flag[expiration].is_before[<util.time_now>]||false>:
            - take scriptname:<context.item.script.name>
            - narrate "<gray>Your mini-golf ball flies off into the distance..."
        - determine cancelled
        on player places player_head:
        - if <context.item_in_hand.has_flag[unplaceable]> && <context.item_in_hand.script.name.contains_any_text[golfball]||null>:
            - if <context.item_in_hand.flag[expiration].is_before[<util.time_now>]||false>:
                - take scriptname:<context.item_in_hand.script.name>
                - narrate "<gray>Your mini-golf ball flies off into the distance..."
            - determine cancelled

GolfBall_Go_Poof:
    type: world
    debug: false
    events:
        on player opens inventory:
        - if !<player.inventory.contains.flagged[expiration]>:
            - stop
        - foreach <player.inventory.list_contents.filter[has_flag[expiration]].filter_tag[<[filter_value].flag[expiration].is_before[<util.time_now>]>]>:
            - take slot:<player.inventory.list_contents.find[<[value]>]> quantity:<[value].quantity>
            - narrate "<gray>Your mini-golf ball flies off into the distance..."

GolfBall_Base:
    type: item
    debug: false
    material: player_head
    display name: <&a>Mini-golf ball
    data:
        lore_list:
        - <&6>Please return to the Golf Pro for a partial refund. Wayward balls will magically return on their own!
    flags:
        uncraftable: true
        unplaceable: true
        golfball: true
        expiration: <util.time_now.add[2h]>
    mechanisms:
        lore: <proc[lore_builder].context[<list[40].include_single[<script.data_key[data.lore_list]>]>]>
        hides:
        - all
        skull_skin: 12c992d2-2b21-48ce-82f5-687d5b660827|ewogICJ0aW1lc3RhbXAiIDogMTYxMjAyOTMxNTEzOSwKICAicHJvZmlsZUlkIiA6ICJiNzQ3OWJhZTI5YzQ0YjIzYmE1NjI4MzM3OGYwZTNjNiIsCiAgInByb2ZpbGVOYW1lIiA6ICJTeWxlZXgiLAogICJzaWduYXR1cmVSZXF1aXJlZCIgOiB0cnVlLAogICJ0ZXh0dXJlcyIgOiB7CiAgICAiU0tJTiIgOiB7CiAgICAgICJ1cmwiIDogImh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZGRiZmQyODEwOTkzZGZjYmEzMGE2MTNhMzM5YzY0MGEyYzg2NzIzZGMwZDYwMzczZmYyOGQ2OGE5OGYxZmIzNiIKICAgIH0KICB9Cn0=


GolfBall_White:
    type: item
    material: GolfBall_Base
    mechanisms:
        skull_skin: 12c992d2-2b21-48ce-82f5-687d5b660827|ewogICJ0aW1lc3RhbXAiIDogMTYxMjAyOTMxNTEzOSwKICAicHJvZmlsZUlkIiA6ICJiNzQ3OWJhZTI5YzQ0YjIzYmE1NjI4MzM3OGYwZTNjNiIsCiAgInByb2ZpbGVOYW1lIiA6ICJTeWxlZXgiLAogICJzaWduYXR1cmVSZXF1aXJlZCIgOiB0cnVlLAogICJ0ZXh0dXJlcyIgOiB7CiAgICAiU0tJTiIgOiB7CiAgICAgICJ1cmwiIDogImh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZGRiZmQyODEwOTkzZGZjYmEzMGE2MTNhMzM5YzY0MGEyYzg2NzIzZGMwZDYwMzczZmYyOGQ2OGE5OGYxZmIzNiIKICAgIH0KICB9Cn0=

GolfBall_Red:
    type: item
    material: GolfBall_Base
    mechanisms:
        skull_skin: d1388d3b-4dc8-4f56-af10-b8d0bbdfa60b|ewogICJ0aW1lc3RhbXAiIDogMTYxMjAyOTE2NzQyNywKICAicHJvZmlsZUlkIiA6ICI1NjY3NWIyMjMyZjA0ZWUwODkxNzllOWM5MjA2Y2ZlOCIsCiAgInByb2ZpbGVOYW1lIiA6ICJUaGVJbmRyYSIsCiAgInNpZ25hdHVyZVJlcXVpcmVkIiA6IHRydWUsCiAgInRleHR1cmVzIiA6IHsKICAgICJTS0lOIiA6IHsKICAgICAgInVybCIgOiAiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS82MzJkZWZiYmM1ZDU1YjI3YWU3MTliN2I3ZDZkZjA2NDFlMTE0NWFiNzE4YjBhMjVjNDJiZWQzNTEzMDg5YzYwIgogICAgfQogIH0KfQ==

GolfBall_Orange:
    type: item
    material: GolfBall_Base
    mechanisms:
        skull_skin: 8bbd4de9-7065-432a-856a-377d0cf94e37|ewogICJ0aW1lc3RhbXAiIDogMTYxMjAyOTEwMjYwMywKICAicHJvZmlsZUlkIiA6ICJiYzRlZGZiNWYzNmM0OGE3YWM5ZjFhMzlkYzIzZjRmOCIsCiAgInByb2ZpbGVOYW1lIiA6ICI4YWNhNjgwYjIyNDYxMzQwIiwKICAic2lnbmF0dXJlUmVxdWlyZWQiIDogdHJ1ZSwKICAidGV4dHVyZXMiIDogewogICAgIlNLSU4iIDogewogICAgICAidXJsIiA6ICJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2NhNjdjMjJiMDUyZWE5OGRhZWM0MjllNWQ3MWNkNGNjNTY2MmQ3ZWZlNTZkOWJlNTBkMDcyOGZjNjZjYjFkYTQiCiAgICB9CiAgfQp9

GollfBall_Yellow:
    type: item
    material: GolfBall_Base
    mechanisms:
        skull_skin: 4cb20221-b5f2-4217-8a4e-e0951546424d|ewogICJ0aW1lc3RhbXAiIDogMTYxMjAyOTQzNTIwNSwKICAicHJvZmlsZUlkIiA6ICI3NzI3ZDM1NjY5Zjk0MTUxODAyM2Q2MmM2ODE3NTkxOCIsCiAgInByb2ZpbGVOYW1lIiA6ICJsaWJyYXJ5ZnJlYWsiLAogICJzaWduYXR1cmVSZXF1aXJlZCIgOiB0cnVlLAogICJ0ZXh0dXJlcyIgOiB7CiAgICAiU0tJTiIgOiB7CiAgICAgICJ1cmwiIDogImh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMmE0Mzg3OWU2MzQ1NjIwYmM2ODExZjdhMjhmMzFmYmRhOTg2ZDJhYjc2ZTQyM2UwYTE2MTMyMWVmYjI1OGI5NSIKICAgIH0KICB9Cn0=

GolfBall_Green:
    type: item
    material: GolfBall_Base
    mechanisms:
        skull_skin: f5a25d87-bbee-45b7-8d8c-a1e8f3371d1a|ewogICJ0aW1lc3RhbXAiIDogMTYxMjAyODY5NDEyMCwKICAicHJvZmlsZUlkIiA6ICI3NTE0NDQ4MTkxZTY0NTQ2OGM5NzM5YTZlMzk1N2JlYiIsCiAgInByb2ZpbGVOYW1lIiA6ICJUaGFua3NNb2phbmciLAogICJzaWduYXR1cmVSZXF1aXJlZCIgOiB0cnVlLAogICJ0ZXh0dXJlcyIgOiB7CiAgICAiU0tJTiIgOiB7CiAgICAgICJ1cmwiIDogImh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNzE4NTBjMjVlOGEwZTA0NzA2Yzk1M2I2Yjg3ZWIyYzE5ZGU2Y2M0MjE0OGM3YTYwNWQ4MGZhOWZlNjMxM2ZhMyIKICAgIH0KICB9Cn0=

GolfBall_Sky:
    type: item
    material: GolfBall_Base
    mechanisms:
        skull_skin: 2a7a96b3-b0b6-4838-8f65-cb2c04cf182c|ewogICJ0aW1lc3RhbXAiIDogMTYxMjAyODc2MTM4MywKICAicHJvZmlsZUlkIiA6ICIyMWUzNjdkNzI1Y2Y0ZTNiYjI2OTJjNGEzMDBhNGRlYiIsCiAgInByb2ZpbGVOYW1lIiA6ICJHZXlzZXJNQyIsCiAgInNpZ25hdHVyZVJlcXVpcmVkIiA6IHRydWUsCiAgInRleHR1cmVzIiA6IHsKICAgICJTS0lOIiA6IHsKICAgICAgInVybCIgOiAiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS8zOTYyMzE0OTg4NWQ4ZGU5ZDcxZDY4ZmY2NjEyZmNhZjk4MWY5NGI5ZWIwYTZiMzg4ZGQ0ZGYzYWQyYmYxMDUxIgogICAgfQogIH0KfQ==

GolfBall_Blue:
    type: item
    material: GolfBall_Base
    mechanisms:
        skull_skin: 40f4087c-1eef-4294-8a11-ef84052764ab|ewogICJ0aW1lc3RhbXAiIDogMTYxMjAyNzEyNzMyMiwKICAicHJvZmlsZUlkIiA6ICJhMjk1ODZmYmU1ZDk0Nzk2OWZjOGQ4ZGE0NzlhNDNlZSIsCiAgInByb2ZpbGVOYW1lIiA6ICJWaWVydGVsdG9hc3RpaWUiLAogICJzaWduYXR1cmVSZXF1aXJlZCIgOiB0cnVlLAogICJ0ZXh0dXJlcyIgOiB7CiAgICAiU0tJTiIgOiB7CiAgICAgICJ1cmwiIDogImh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvN2RhYWRmODJiYjY3ODI2ZDZkMzNjZTdkODY2ZDU0M2FlMzUxZWFmYWQ3Y2IzOWFhMzhlOTU4YTA1ZDY4OTI4NCIKICAgIH0KICB9Cn0=

GolfBall_Violet:
    type: item
    material: GolfBall_Base
    mechanisms:
        skull_skin: 78ae1f27-90e4-4672-a094-03121df5789d|ewogICJ0aW1lc3RhbXAiIDogMTYxMjAyOTI1MzEzMCwKICAicHJvZmlsZUlkIiA6ICJiMGQ0YjI4YmMxZDc0ODg5YWYwZTg2NjFjZWU5NmFhYiIsCiAgInByb2ZpbGVOYW1lIiA6ICJNaW5lU2tpbl9vcmciLAogICJzaWduYXR1cmVSZXF1aXJlZCIgOiB0cnVlLAogICJ0ZXh0dXJlcyIgOiB7CiAgICAiU0tJTiIgOiB7CiAgICAgICJ1cmwiIDogImh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYmU1NTZkNDUyNzkxMjNiOTY4MmYxMGJhM2YyNzFjMGU0YTM2Y2JmMWQxNDkzY2M5ODRlMDJmMjhkNGE5NWQ5NCIKICAgIH0KICB9Cn0=

GolfBall_Purple:
    type: item
    material: GolfBall_Base
    mechanisms:
        skull_skin: f091e881-95a6-4bc1-b6ae-a38f7a880e07|ewogICJ0aW1lc3RhbXAiIDogMTYxMjAyOTI3OTExOCwKICAicHJvZmlsZUlkIiA6ICI5OTdjZjFlMmY1NGQ0YzEyOWY2ZjU5ZTVlNjU1YjZmNyIsCiAgInByb2ZpbGVOYW1lIiA6ICJpbzEyIiwKICAic2lnbmF0dXJlUmVxdWlyZWQiIDogdHJ1ZSwKICAidGV4dHVyZXMiIDogewogICAgIlNLSU4iIDogewogICAgICAidXJsIiA6ICJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2E4YmUxZGZjOWI3NDNlYTgzOGQ1MzgzYzMwNWE5YWE1YzVhNDAzZmI2NzBmYmI1MjEwZDRjMTQzYmM5YmYwMjYiCiAgICB9CiAgfQp9

GolfBall_Gray:
    type: item
    material: GolfBall_Base
    mechanisms:
        skull_skin: bfd51f05-552a-42a1-b308-b24228a6177e|ewogICJ0aW1lc3RhbXAiIDogMTYxMjAyODQ1NjMxOCwKICAicHJvZmlsZUlkIiA6ICJkZTU3MWExMDJjYjg0ODgwOGZlN2M5ZjQ0OTZlY2RhZCIsCiAgInByb2ZpbGVOYW1lIiA6ICJNSEZfTWluZXNraW4iLAogICJzaWduYXR1cmVSZXF1aXJlZCIgOiB0cnVlLAogICJ0ZXh0dXJlcyIgOiB7CiAgICAiU0tJTiIgOiB7CiAgICAgICJ1cmwiIDogImh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYzQ5MzBmNzQwMDRkODMzNWI0NDc4M2VkNmJhM2VhMmVjMzE3ZWU5NDc1MWVjZDgzZTY3NzM1YjVkODdlODRmMiIKICAgIH0KICB9Cn0=

GolfBall_Brown:
    type: item
    material: GolfBall_Base
    mechanisms:
        skull_skin: 0ffeb03f-7724-4773-91d6-d4bd7a32f303|ewogICJ0aW1lc3RhbXAiIDogMTYxMjAyODAxNDg0NSwKICAicHJvZmlsZUlkIiA6ICI3NTE0NDQ4MTkxZTY0NTQ2OGM5NzM5YTZlMzk1N2JlYiIsCiAgInByb2ZpbGVOYW1lIiA6ICJUaGFua3NNb2phbmciLAogICJzaWduYXR1cmVSZXF1aXJlZCIgOiB0cnVlLAogICJ0ZXh0dXJlcyIgOiB7CiAgICAiU0tJTiIgOiB7CiAgICAgICJ1cmwiIDogImh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNzYyZDAyMzYxYmJhZjY4YjMwMzQ2N2NjM2E3NzFkMDIyYjg5YzE0YWRiY2UxZTBlNjg4NWY2MjI2MDI3NDE4ZiIKICAgIH0KICB9Cn0=

GolfBall_Goldenrod:
    type: item
    material: GolfBall_Base
    mechanisms:
        skull_skin: 4a2bcef1-d7b2-4fc8-a114-f180523d84b8|ewogICJ0aW1lc3RhbXAiIDogMTYxMjAyODM5OTk5MSwKICAicHJvZmlsZUlkIiA6ICI5MWZlMTk2ODdjOTA0NjU2YWExZmMwNTk4NmRkM2ZlNyIsCiAgInByb2ZpbGVOYW1lIiA6ICJoaGphYnJpcyIsCiAgInNpZ25hdHVyZVJlcXVpcmVkIiA6IHRydWUsCiAgInRleHR1cmVzIiA6IHsKICAgICJTS0lOIiA6IHsKICAgICAgInVybCIgOiAiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS8zMmIzNmQ0MDI1NTBhNmViOTdkMWIyZDU0Zjk4YTM2MzFlZDM2MmVjOGM5YjJlMGJkMWUyOTExNGVhMDA1OTFlIgogICAgfQogIH0KfQ==

GolfBall_Lime:
    type: item
    material: GolfBall_Base
    mechanisms:
        skull_skin: fe947ead-f5b9-4757-be8f-bf88b8415b0f|ewogICJ0aW1lc3RhbXAiIDogMTYxMjAyOTAyNDAzMywKICAicHJvZmlsZUlkIiA6ICI2MWVhMDkyM2FhNDQ0OTEwYmNlZjViZmQ2ZDNjMGQ1NyIsCiAgInByb2ZpbGVOYW1lIiA6ICJUaGVEYXJ0aEZhdGhlciIsCiAgInNpZ25hdHVyZVJlcXVpcmVkIiA6IHRydWUsCiAgInRleHR1cmVzIiA6IHsKICAgICJTS0lOIiA6IHsKICAgICAgInVybCIgOiAiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS9lZWMxM2NmMGU3ZGJkOGIwOTU1ZTU1MzE5ZjllOWIxODRhY2JkZDYwNzlkNWQ4Mjk2MjgxNmFkYmRkZTA3MjQ1IgogICAgfQogIH0KfQ==

GolfBall_Olive:
    type: item
    material: GolfBall_Base
    mechanisms:
        skull_skin: 3f936287-a3ca-4daa-af96-3f04c23a8357|ewogICJ0aW1lc3RhbXAiIDogMTYxMjAyOTA1MDAzOCwKICAicHJvZmlsZUlkIiA6ICI4MmM2MDZjNWM2NTI0Yjc5OGI5MWExMmQzYTYxNjk3NyIsCiAgInByb2ZpbGVOYW1lIiA6ICJOb3ROb3RvcmlvdXNOZW1vIiwKICAic2lnbmF0dXJlUmVxdWlyZWQiIDogdHJ1ZSwKICAidGV4dHVyZXMiIDogewogICAgIlNLSU4iIDogewogICAgICAidXJsIiA6ICJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzgzZmJhY2Q1Mjg2Mjg5MmYyYzYwNzdhYWY3N2YzZDNmNTA4M2ZiMDMwZDdlZDc5ZjFhNjdiNGE3NjgxMjBiZDciCiAgICB9CiAgfQp9

GolfBall_Cyan:
    type: item
    material: GolfBall_Base
    mechanisms:
        skull_skin: b7f30b47-d5b3-4d9e-806c-882e3895abde|ewogICJ0aW1lc3RhbXAiIDogMTYxMjAyODA3MjI2MSwKICAicHJvZmlsZUlkIiA6ICJhMjk1ODZmYmU1ZDk0Nzk2OWZjOGQ4ZGE0NzlhNDNlZSIsCiAgInByb2ZpbGVOYW1lIiA6ICJWaWVydGVsdG9hc3RpaWUiLAogICJzaWduYXR1cmVSZXF1aXJlZCIgOiB0cnVlLAogICJ0ZXh0dXJlcyIgOiB7CiAgICAiU0tJTiIgOiB7CiAgICAgICJ1cmwiIDogImh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvY2NiNmE3NjhmNmU3OGZmODJlMjg5ZjUxZGY4NTk0N2IxMjNkY2UyZDA0N2U5MDgxNmU4Y2QxYTI1NWJmYTUyZiIKICAgIH0KICB9Cn0=

GolfBall_Black:
    type: item
    material: GolfBall_Base
    mechanisms:
        skull_skin: c8c7887d-0c36-4d28-84e0-9ecaae5277d5|ewogICJ0aW1lc3RhbXAiIDogMTYxMjAyNjc3NDIxOCwKICAicHJvZmlsZUlkIiA6ICJmMjc0YzRkNjI1MDQ0ZTQxOGVmYmYwNmM3NWIyMDIxMyIsCiAgInByb2ZpbGVOYW1lIiA6ICJIeXBpZ3NlbCIsCiAgInNpZ25hdHVyZVJlcXVpcmVkIiA6IHRydWUsCiAgInRleHR1cmVzIiA6IHsKICAgICJTS0lOIiA6IHsKICAgICAgInVybCIgOiAiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS85YTUyYWY5NGRlZWQ3YmIzMmFiNjJiYmQwYjJhZmI5N2U5MzU4NTg2NTkxNTU4N2NiNjQxODNlYjcxMjkzMWVjIgogICAgfQogIH0KfQ==

GolfBall_Beige:
    type: item
    material: GolfBall_Base
    mechanisms:
        skull_skin: 6e5fe3c6-b088-4d7e-a45e-28f1acbfc381|ewogICJ0aW1lc3RhbXAiIDogMTYxMjAyODMxNzI5NCwKICAicHJvZmlsZUlkIiA6ICJhNzdkNmQ2YmFjOWE0NzY3YTFhNzU1NjYxOTllYmY5MiIsCiAgInByb2ZpbGVOYW1lIiA6ICIwOEJFRDUiLAogICJzaWduYXR1cmVSZXF1aXJlZCIgOiB0cnVlLAogICJ0ZXh0dXJlcyIgOiB7CiAgICAiU0tJTiIgOiB7CiAgICAgICJ1cmwiIDogImh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNjU2OTA1MmZmZWM1Y2E0Y2RkZGZmMjUyYTUzYTI1ZTI4MjFjN2QzNTA3MDExYjkwODY0OWVhZTBmM2I4ZWQ1MCIKICAgIH0KICB9Cn0=

GolfBall_Pink:
    type: item
    material: GolfBall_Base
    mechanisms:
        skull_skin: 60f40cd3-69fd-4e54-9ad7-a2a81b793417|ewogICJ0aW1lc3RhbXAiIDogMTYxMjAyOTEzMDA3MywKICAicHJvZmlsZUlkIiA6ICIzM2ViZDMyYmIzMzk0YWQ5YWM2NzBjOTZjNTQ5YmE3ZSIsCiAgInByb2ZpbGVOYW1lIiA6ICJEYW5ub0JhbmFubm9YRCIsCiAgInNpZ25hdHVyZVJlcXVpcmVkIiA6IHRydWUsCiAgInRleHR1cmVzIiA6IHsKICAgICJTS0lOIiA6IHsKICAgICAgInVybCIgOiAiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS9kMWJmZjEwMzE2NWRkNDk0MDg5MTAyNjQ1NTI0OTNiMjA5MWIwYjBiZTlkY2RjMmY5YjFlM2M0MTI1ZTU0YjNjIgogICAgfQogIH0KfQ==
