# 1) Handle right-clicks this tick (toggle each flashlight ON/OFF)
execute as @a[scores={fl.used=1..}] run function flashlight:toggle
# Reset the right-click counter so we only react to *new* clicks next tick
scoreboard players set @a fl.used 0

# 2) Auto-OFF: if the flashlight is no longer held in the main hand, it is not ON
execute as @a[scores={fl.on=1}] unless items entity @s weapon.mainhand *[minecraft:custom_data~{flashlight:true}] run scoreboard players set @s fl.on 0

# 3) Remove the previous tick's beam: every tracked light block + its marker.
#    Only ever clears LEVEL-14 lights (the beam's own), so any other light block - e.g. a
#    manually-placed level-15 light - is never removed, even if a marker lands on its cell.
execute as @e[type=marker,tag=fl.light] at @s if block ~ ~ ~ minecraft:light[level=14] run setblock ~ ~ ~ air
kill @e[type=marker,tag=fl.light]

# 4) Cast a fresh beam for every player whose flashlight is ON and held in main hand
execute as @a[scores={fl.on=1}] at @s if items entity @s weapon.mainhand *[minecraft:custom_data~{flashlight:true}] run function flashlight:beam
