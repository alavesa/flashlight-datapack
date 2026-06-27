# Giving the Flashlight a custom 3D model

The datapack works on its own — the flashlight just looks like a carrot-on-a-stick.
A custom 3D model is **client-side**, so it lives in a separate **resource pack**
(not the datapack). Anyone who wants to *see* the model needs the resource pack too.

The release zip includes a ready-made starter resource pack
(`Flashlights Resource Pack/`) with these instructions baked in
(`HOW-TO-ADD-MODEL.txt`) **and a working example model + texture** (a simple
grey flashlight with a yellow lens) so you can see it in game immediately — just
overwrite `flashlight.json` / `flashlight.png` with your own. Summary:

## 1. Set the resource-pack format

Open the resource pack's `pack.mcmeta` and set `pack_format` to your version's
**resource-pack** number (different from the datapack number). If it shows up
red/incompatible, that's the fix.

## 2. Make the model (Blockbench, free)

1. Download [Blockbench](https://www.blockbench.net).
2. New Project → "Minecraft: Java Block/Item".
3. Model your flashlight and assign a texture.
4. `File → Export → Export Block/Item Model` → save the JSON, and note the PNG.

## 3. Drop your files in

Replace the two placeholders in the resource pack:

```
assets/minecraft/models/item/flashlight.json   <- your model JSON
assets/minecraft/textures/item/flashlight.png  <- your texture
```

Make sure the texture path in `flashlight.json` points to `minecraft:item/flashlight`.

## 4. How the swap works (no editing needed)

The flashlight item is given with `custom_model_data={strings:["flashlight"]}`.
`assets/minecraft/items/carrot_on_a_stick.json` reads that string and swaps in
your model; every normal carrot-on-a-stick stays vanilla.

> **Version note:** the `assets/minecraft/items/` + `select` approach is the
> 1.21.4+ item-model system. On older versions you'd use model `overrides` with a
> `predicate` and a numeric `custom_model_data` instead.

## 5. Install & test

Put the resource pack folder in `resourcepacks/`, enable it in
**Options → Resource Packs**, then `/function flashlight:give` — the item shows
your model.
