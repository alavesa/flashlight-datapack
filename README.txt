==================================================================
 FLASHLIGHTS  -  a Minecraft datapack
 Right-click to toggle a beam of light in front of you.
==================================================================

------------------------------------------------------------------
1. IMPORTANT: SET THE PACK FORMAT FIRST
------------------------------------------------------------------
Open  pack.mcmeta  and set "pack_format" to the number used by your
Minecraft version. It is currently set to 88 as a placeholder.

If the pack shows up RED / "incompatible" in the datapack list,
this number is the thing to fix. Everything else uses modern
syntax (execute if items, item components, singular function/
tags folders) and does not need changing.

------------------------------------------------------------------
2. INSTALL
------------------------------------------------------------------
A) SINGLE-PLAYER WORLD
   1. Open your world save folder:
        Windows:  %appdata%\.minecraft\saves\<world>\
        macOS:    ~/Library/Application Support/minecraft/saves/<world>/
        Linux:    ~/.minecraft/saves/<world>/
   2. UNZIP this file first, then copy the whole "Flashlights"
      folder into the "datapacks" folder inside your world.
      (Create "datapacks" if it doesn't exist.)
      NOTE: don't drop the .zip in directly -- it has a nested
      "Flashlights" folder, so Minecraft won't read it as a pack.
      Use the unzipped folder.
   3. In game, run:   /reload

B) SERVER
   Unzip, then put the "Flashlights" folder in:
        <server>/world/datapacks/
   Then run:   /reload

To confirm it loaded you'll see this in chat:
   "[Flashlights] Loaded. Run /function flashlight:give ..."
   If you DON'T see it (and no pack errors), the pack_format is
   almost certainly wrong -- fix it in pack.mcmeta (see section 1).

------------------------------------------------------------------
3. HOW TO USE
------------------------------------------------------------------
   1. Get a flashlight:   /function flashlight:give
   2. Hold it in your main hand.
   3. RIGHT-CLICK to turn it ON. Right-click again to turn it OFF.
   4. While ON and held, a beam of light is cast wherever you look,
      up to ~6 blocks, stopping at walls.
   5. Switching it out of your main hand turns it OFF automatically;
      hold it and right-click again to turn it back on.

------------------------------------------------------------------
4. HOW IT WORKS (for the curious)
------------------------------------------------------------------
 - The item is a carrot_on_a_stick tagged with custom_data
   {flashlight:true} and renamed "Flashlight".
 - Right-clicks are detected with the
   minecraft.used:minecraft.carrot_on_a_stick statistic.
 - Each tick, while ON, the pack raycasts from your eyes and
   places light[level=14] blocks along your view, tracking each
   with an invisible marker so the whole beam is cleared and
   redrawn next tick as you move. Light is only placed into air
   (setblock ... keep), so it never overwrites or replaces your
   builds or neighbouring blocks.
 - A light block is only placed when ALL 26 surrounding cells are
   clear of redstone / interactive blocks (the #flashlight:avoid
   tag: trapdoors, doors, redstone lamps, repeaters, etc.), keeping
   the beam at least 1 block away from them. Spots inside that
   1-block buffer are skipped but the beam keeps going, so tight
   areas still light up everywhere else. Edit
   data/flashlight/tags/block/avoid.json to change this list.
 - The beam MAY sit right next to other light blocks. It only ever
   places into air ("keep") and only tracks/removes lights it placed
   itself (via setblock success), so light blocks you placed
   manually are never overwritten or removed.

------------------------------------------------------------------
5. TROUBLESHOOTING
------------------------------------------------------------------
 - Pack won't load / shows red:
     Fix "pack_format" in pack.mcmeta (see section 1).

 - Right-click does nothing:
     The carrot-on-a-stick "used" statistic is the usual trick but
     can vary by version. Test it: hold the flashlight, right-click,
     then run:   /scoreboard players get @s fl.used
     If that number never rises, switch to a spyglass instead:
       * In data/flashlight/function/load.mcfunction change:
           minecraft.used:minecraft.carrot_on_a_stick
         to:
           minecraft.used:minecraft.spyglass
       * In data/flashlight/function/give.mcfunction and the two
         "items entity ... weapon.mainhand" checks (toggle.mcfunction
         and tick.mcfunction), replace carrot_on_a_stick with
         spyglass.
       * Run /reload.

 - Leftover / stuck light blocks (looks permanently ON):
     Stray flashlight lights (e.g. left over from testing earlier
     versions) have no tracking marker, so the beam can't clear them
     and the area looks lit even with the flashlight off / not held.
     Fix: stand near them and run   /function flashlight:cleanup
     It removes flashlight lights (level 14) within 15 blocks but
     KEEPS manually-placed lights (level 15). Run it again elsewhere
     if stray lights are spread out.

------------------------------------------------------------------
6. FILES
------------------------------------------------------------------
 pack.mcmeta                                  pack metadata
 data/minecraft/tags/function/load.json       run load on world load
 data/minecraft/tags/function/tick.json       run tick every tick
 data/flashlight/function/load.mcfunction     sets up scoreboards
 data/flashlight/function/give.mcfunction     gives a flashlight
 data/flashlight/function/tick.mcfunction     main loop
 data/flashlight/function/toggle.mcfunction   on/off toggle
 data/flashlight/function/beam.mcfunction     starts the raycast
 data/flashlight/function/ray.mcfunction      recursive raycast
 data/flashlight/tags/block/passable.json     blocks the beam passes
 data/flashlight/tags/block/avoid.json         blocks the beam stays 1 away from
==================================================================
