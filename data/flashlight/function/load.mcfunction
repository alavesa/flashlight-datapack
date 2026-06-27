# Right-click counter (the carrot-on-a-stick "used" statistic increments on right-click)
scoreboard objectives add fl.used minecraft.used:minecraft.carrot_on_a_stick
# Per-player ON/OFF state
scoreboard objectives add fl.on dummy
# Raycast step counter
scoreboard objectives add fl.range dummy
# Set to 1 only when the beam actually placed a NEW light block (so we never track/remove
# manually-placed light blocks the beam passes through)
scoreboard objectives add fl.placed dummy
# Constant used for the toggle math
scoreboard players set #neg1 fl.on -1

tellraw @a {"text":"[Flashlights] Loaded. Run /function flashlight:give to get a flashlight.","color":"yellow"}
