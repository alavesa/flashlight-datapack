# Runs as a player with the flashlight ON. Start the raycast 1 block in front of the eyes
# (so light is never placed inside the player) and allow up to 10 steps of 0.5 blocks = ~6 blocks.
scoreboard players set @s fl.range 10
execute anchored eyes positioned ^ ^ ^1 run function flashlight:ray
