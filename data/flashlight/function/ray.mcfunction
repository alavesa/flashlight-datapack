# Recursive raycast. At each step: stop if out of range or blocked, otherwise drop a
# light block + a tracking marker, then step forward along the player's look direction.
scoreboard players remove @s fl.range 1
execute if score @s fl.range matches ..0 run return 0

# Stop at the first non-passable block (a wall)
execute unless block ~ ~ ~ #flashlight:passable run return 0

# Place a level-14 light block ONLY when this cell is true air (#flashlight:air) AND all 26
# surrounding cells are free of redstone / interactive blocks (#flashlight:avoid). Requiring
# true air means we never touch any existing block - including manually-placed light blocks
# (which are "replaceable", so plain setblock/keep WOULD overwrite them). fl.placed records
# whether this step actually placed a new light block.
execute store success score @s fl.placed if block ~ ~ ~ #flashlight:air unless block ~-1 ~-1 ~-1 #flashlight:avoid unless block ~ ~-1 ~-1 #flashlight:avoid unless block ~1 ~-1 ~-1 #flashlight:avoid unless block ~-1 ~-1 ~ #flashlight:avoid unless block ~ ~-1 ~ #flashlight:avoid unless block ~1 ~-1 ~ #flashlight:avoid unless block ~-1 ~-1 ~1 #flashlight:avoid unless block ~ ~-1 ~1 #flashlight:avoid unless block ~1 ~-1 ~1 #flashlight:avoid unless block ~-1 ~ ~-1 #flashlight:avoid unless block ~ ~ ~-1 #flashlight:avoid unless block ~1 ~ ~-1 #flashlight:avoid unless block ~-1 ~ ~ #flashlight:avoid unless block ~1 ~ ~ #flashlight:avoid unless block ~-1 ~ ~1 #flashlight:avoid unless block ~ ~ ~1 #flashlight:avoid unless block ~1 ~ ~1 #flashlight:avoid unless block ~-1 ~1 ~-1 #flashlight:avoid unless block ~ ~1 ~-1 #flashlight:avoid unless block ~1 ~1 ~-1 #flashlight:avoid unless block ~-1 ~1 ~ #flashlight:avoid unless block ~ ~1 ~ #flashlight:avoid unless block ~1 ~1 ~ #flashlight:avoid unless block ~-1 ~1 ~1 #flashlight:avoid unless block ~ ~1 ~1 #flashlight:avoid unless block ~1 ~1 ~1 #flashlight:avoid run setblock ~ ~ ~ minecraft:light[level=14]

# Track it ONLY if we actually placed a new light this step (never a pre-existing/manual light)
execute if score @s fl.placed matches 1 run summon minecraft:marker ~ ~ ~ {Tags:["fl.light"]}

# Step forward and continue
execute positioned ^ ^ ^0.5 run function flashlight:ray
