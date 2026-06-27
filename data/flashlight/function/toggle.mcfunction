# Runs as a player who right-clicked. Ignore clicks while not holding the flashlight.
execute unless items entity @s weapon.mainhand *[minecraft:custom_data~{flashlight:true}] run return fail

# Flip fl.on between 0 and 1:  (x * -1) + 1   maps 0->1 and 1->0
scoreboard players add @s fl.on 0
scoreboard players operation @s fl.on *= #neg1 fl.on
scoreboard players add @s fl.on 1

# Feedback
execute if score @s fl.on matches 1 run title @s actionbar {"text":"Flashlight: ON","color":"yellow"}
execute if score @s fl.on matches 0 run title @s actionbar {"text":"Flashlight: OFF","color":"gray"}
execute if score @s fl.on matches 1 run playsound minecraft:block.lever.click player @s ~ ~ ~ 0.6 1.4
execute if score @s fl.on matches 0 run playsound minecraft:block.lever.click player @s ~ ~ ~ 0.6 0.8
