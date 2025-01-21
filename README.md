# Roblox Magic Orb System

## Project Documentation

## About

This project is a simple, versatile, and customizable magical attack mechanic that can be implemented into Roblox games. It is designed to be easily altered to suit any game's mechanics.

## Key Features

* **Magic orb projectile:** Visually customizable orb with particle, light, and sound effects.
* **Collision system:** Customizable collision effects and requirements.
* **Mechanics:** Customizable gameplay mechanics such as orb speed, damage amount, and cooldown length.

## Fast Setup Guide

1. **Tool Setup:** Create a `Tool` object inside of a game in Roblox Studio. Create a `Part` object named Handle and set it as a child of the tool.
2. **Script Insertion:** Add the *MagicOrbServerScript* to your game's `ServerScriptService` as a 'Script' and add the *MagicOrbLocalScript* as a child of the tool you created as a 'LocalScript'.
3. **Customization:** Customize the orb's visual or gameplay mechanics however you see fit.

## Visual Customization

**The magic orb's visual appearance can be customized to fit your game's aesthetics in various ways:**

* **Base Effects**
    * **Size:** The size of the orb can be changed by editing the `orbSize` variable in the server script. _Note: Changing the size of the orb will also affect its collision detection._
    * **Color:** The color of the orb can be changed by altering the `BrickColor` of `orb` in the server script.
    * **Material:** The material of the orb can be changed by altering the `Material` of `orb` in the server script.

* **Particle Effects**
    * **Particle Texture:** The texture of the particles emitted by the orb can be changed by editing the `TextureId` of `particleEmitter` in the server script.
    * **Particle Color:** The color of the particles can be changed by editing the `ColorSequence` of `particleEmitter` in the server script. _Note: Depending on the texture you use, the color may not change much._
    * **Particle Size:** The size of the particles can be changed by editing the `NumberSequence` of `particleEmitter` in the server script.

* **Explosion Particle Effects**
    * **Explosion Texture:** The texture of the particles emitted whenever the orb successfully collides can be changed by editing the `TextureId` of `explosionEmitter` in the server script.
    * **Explosion Color:** The color of the explosion particles can be changed by editing the `ColorSequence` of `explosionEmitter` in the server script. _Note: Depending on the texture you use, the color may not change much._
    * **Explosion Size:** The size of the particles can be changed by editing the `NumberSequence` of `explosionEmitter` in the server script.

* **Light Effects**
    * **Light Color:** The color of the light emitted by the orb can be changed by editing the `Color` value of `light` in the server script.
    * **Light Brightness:** The brightness of the light emitted by the orb can be changed by editing the `Brightness` value of `light` in the server script.
    * **Light Range:** The range of the light emitted by the orb can be changed by editing the `Range` value of `light` in the server script.

* **Sound Effects**
    * **Cast Sound:** The sound played when the player activates the attack can be altered by editing the `SoundID` and `Volume` of `castSound` in the server script.
    * **Explosion Sound:** The sound played when the orb successfully collides can be altered by editing the `SoundID` and `Volume` of `explosionSound` in the server script.

## Gameplay Customization

**The gameplay mechanics of the magic orb system can be customized to fit your game's needs:**

* **Size:** The size of the orb can be changed by editing the `orbSize` variable in the server script. _Note: Changing the size of the orb will also affect its visual size._
* **Speed:** The speed of the orb can be changed by editing the `orbSpeed` variable in the local script.
* **Cooldown:** The number of seconds it takes a player to recharge the ability after use can be changed by editing the `cooldownTime` variable in the local script.
* **Collisions:** What the orb collides with can be changed within the `onTouch()` function in the server script. It can be edited to only collide with players or to collide with players and additional objects based on name (such as objects named `Barrier`).

## Reusability

**The magic system is designed to be reusable.** If you want to create multiple types of magic attacks (e.g., fireballs and frostbolts), simply follow the setup guide again, but change the name of the `Remote Event` and then customize the new orb as desired. Remember to change the name of the `Remote Event` in both the local and server scripts.

## Ideas for Future Features

* **Changing the shape of the orb:** A special mesh could be added to `orb` in order to give the orb a different visual appearance (e.g., an Ice Spike).
* **Changing damage mechanics:** The orb could be altered to apply a damage-over-time effect rather than instant damage.
* **Adding healing mechanics:** The orb could be changed to apply healing rather than damage to players who are on the same team as the caster.
* **Implementing an autofire system:** The orb could be changed to be autofired as long as the player holds down a button instead of needing to be manually activated every time.
