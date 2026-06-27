# Run as a player:  /function flashlight:cleanup
# Removes ALL flashlight light blocks (level 14) within 15 blocks - including "orphan" lights
# left over from earlier testing that no longer have a tracking marker. Manually-placed light
# blocks (level 15) are kept untouched.
fill ~-15 ~-15 ~-15 ~15 ~15 ~15 air replace minecraft:light[level=14]
kill @e[type=marker,tag=fl.light,distance=..24]
tellraw @s {"text":"[Flashlights] Cleared stray flashlight lights within 15 blocks (level-15 lights kept). Run again elsewhere if needed.","color":"yellow"}
