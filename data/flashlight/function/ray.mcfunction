# Recursive raycast. At each step: stop if out of range or blocked, otherwise drop a
# light block + a tracking marker, then step forward along the player's look direction.
scoreboard players remove @s fl.range 1
execute if score @s fl.range matches ..0 run return 0

# Stop at the first non-passable block (a wall)
execute unless block ~ ~ ~ #flashlight:passable run return 0

# Place a level-14 light block only if all 26 surrounding cells are free of redstone /
# interactive blocks (#flashlight:avoid), keeping a 1-block buffer from them. "keep" means
# we only ever place into AIR, so existing blocks - including manually-placed light blocks -
# are never overwritten. The beam may sit right next to other light blocks.
# fl.placed records whether THIS step actually placed a new light block (success of setblock).
execute store success score @s fl.placed unless block ~-1 ~-1 ~-1 #flashlight:avoid unless block ~ ~-1 ~-1 #flashlight:avoid unless block ~1 ~-1 ~-1 #flashlight:avoid unless block ~-1 ~-1 ~ #flashlight:avoid unless block ~ ~-1 ~ #flashlight:avoid unless block ~1 ~-1 ~ #flashlight:avoid unless block ~-1 ~-1 ~1 #flashlight:avoid unless block ~ ~-1 ~1 #flashlight:avoid unless block ~1 ~-1 ~1 #flashlight:avoid unless block ~-1 ~ ~-1 #flashlight:avoid unless block ~ ~ ~-1 #flashlight:avoid unless block ~1 ~ ~-1 #flashlight:avoid unless block ~-1 ~ ~ #flashlight:avoid unless block ~1 ~ ~ #flashlight:avoid unless block ~-1 ~ ~1 #flashlight:avoid unless block ~ ~ ~1 #flashlight:avoid unless block ~1 ~ ~1 #flashlight:avoid unless block ~-1 ~1 ~-1 #flashlight:avoid unless block ~ ~1 ~-1 #flashlight:avoid unless block ~1 ~1 ~-1 #flashlight:avoid unless block ~-1 ~1 ~ #flashlight:avoid unless block ~ ~1 ~ #flashlight:avoid unless block ~1 ~1 ~ #flashlight:avoid unless block ~-1 ~1 ~1 #flashlight:avoid unless block ~ ~1 ~1 #flashlight:avoid unless block ~1 ~1 ~1 #flashlight:avoid run setblock ~ ~ ~ minecraft:light[level=14] keep

# Track it ONLY if we actually placed a new light this step (never a pre-existing/manual light)
execute if score @s fl.placed matches 1 run summon minecraft:marker ~ ~ ~ {Tags:["fl.light"]}

# Step forward and continue
execute positioned ^ ^ ^0.5 run function flashlight:ray
