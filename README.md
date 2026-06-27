# Flashlight Datapack

A small Minecraft datapack that adds a **flashlight**: right-click to toggle a beam of light that lights the way ~6 blocks ahead of you.

Built — vibe-coded, really — together with my 17-year-old nephew over Discord, for the Minecraft server he's building. It took twelve versions and one very blunt QA lead (*"the light breaks even more"*). The winning move was rolling back to Version 8. 🔦

## What it does

- Adds a **Flashlight** item (a renamed carrot-on-a-stick).
- **Right-click** to turn it ON, right-click again for OFF.
- While ON and held, it casts a beam of light blocks where you look, stopping at walls.
- Switching it out of your main hand turns it OFF automatically.

## Install

1. **Set the pack format.** Open [`pack.mcmeta`](pack.mcmeta) and set `pack_format` to the number for your Minecraft version (it ships as `88`). If the pack shows up red/incompatible, this is the fix.
2. Copy the `Flashlights` folder into your world's `datapacks/` folder:
   - Single-player: `…/saves/<world>/datapacks/`
   - Server: `…/world/datapacks/`
3. In game: `/reload`, then `/function flashlight:give` to get a flashlight.

## How it works

- Right-clicks are detected via the `minecraft.used:minecraft.carrot_on_a_stick` statistic.
- Each tick the pack raycasts from your eyes and places `light[level=14]` blocks along your view, tracking each with an invisible marker so the beam can be cleared and redrawn as you move.
- Light is only ever placed into **air** and a marker is only dropped on a light the beam actually placed — so existing blocks, including **manually-placed light blocks**, are never overwritten or removed.
- A light is only placed when all 26 surrounding cells are clear of redstone / interactive blocks (`#flashlight:avoid`), keeping a **1-block buffer** from trapdoors, redstone lamps, etc.

### Known limitation

Placing or removing any block via command sends a "block update" to its neighbours, and Minecraft has no command flag to suppress that. So moving the beam past a block whose state was forced with a debug stick can snap it back to normal. This is a vanilla-engine limit, not something a datapack can override.

## Resource pack (optional 3D model)

The datapack works on its own (the item looks like a carrot-on-a-stick). A separate resource pack can give it a custom 3D model — see the in-pack notes if you want to add one.

## Credits

Made by [@alavesa](https://github.com/alavesa) with a teenage server-owner on QA, and an AI pair on the keyboard. Human-in-the-loop, the whole way. 🙂
