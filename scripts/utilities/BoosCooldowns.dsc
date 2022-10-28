Set_BCD_Reset_Timer:
  type: world
  events:
    on system time 19:00:
      - if <util.time_now.day_of_week> == 5:
        - execute as_server "bcd startglobalreset"
#        - discord id:sxr message channel:343105813293826059 "<&lt>@&223441207341219840<&gt>, the global reset has been set for Fridays at 7pm Chicago time! You can disable that script now."