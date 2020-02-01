# GDD

## Assets

- Player States :
-- Idle
-- Run
-- Jump
-- Slash
-- Jump Slash ?
-- Hurt
-- Dead

- Enemy States :
-- Idle / Walk
-- Angry / Attack
-- Hurt
-- Dead

- World :
-- Stone (wall, floor, platform)
-- Plant (decoration)
-- Spike
-- Tree (trunk, Vine)
-- Apple
-- Clouds (BG)

- Sound :
-- BGM Start Menu ?
-- BGM aggressive
-- BGM boss ?
-- BGM mellow ?
-- SFX enemy idle
-- SFX enemy angry
-- SFX enemy hurt
-- SFX Boss angry
-- SFX Boss talk mellow

- Character Infos :
-- Animations (Player, enemy, Plant, Apple) : 3 frames
-- Enemies : 1 kind priority, then boss, then enemy variation
-- Drawing priorities : Static stats 1st, animation stats 2nd

- Placeholders :
-- Pill for player
-- Rectangle for sword
-- Same for enemy (bigger)
-- Square for level
-- Circle for apple
-- Rectangle for apple tree


## Logic :

- Inputs :
-- Run : Right  -> / (D) | Left <- (A)
-- Jump : Space
-- Slash : C
-- Get / Give apples : C (contextual in apple / dead enemy area)
-- Pause : Echap

- Player logic :
-- Body hitbox
-- Attack hitbox
-- HP 3 or 5 hearts

- Enemy logic :
-- Attack when attacked
-- Body hitbox
-- Attack hitbox
-- Attack pattern : higher reach, lower action time / shorter reach, higher action time
-- 3 hits to die

- Level logic
-- Enemy idle gets angry when player attack
-- Kill ennemies to proceed
-- Enemies stay visible when dead, no process, condition to give apple after boss talk, timer countdown
-- Apples appear after boss talk
-- Countdown after boss talk, lose when one enemy dies
-- When all enemies healed, boss talk and end

## Scenario

- Text intro : Village scared of nearby monsters and ask player to kill them
- Gameplay : Player kill enemies and reach boss
- Player attacks boss but invincible and gets killed
- Boss talks : why did you attack my children, you won't pass until you've healed them with this kind of apple. Use this sword of yours to cut trees and give the apples to hurt bodies. Do it before they run out of time and die, then come back to me.
- Gameplay : Player cuts trees, gets apples, heals ennemies, gets back to boss
- Boss talks : We never had intention to attack villagers. Go tell them to rest easy.
- End

## Gameloop

- Start menu : Title / Play / Inputs / About
- Game state 1 : Kill (platform, attack, hurt on contact)
- Game state 2 : Boss (attack boss no effect, boss attack remove all HP, dialogue)
- Game state 3 : Heal (platform, see apples, cut vines, gather apples, give them, countdown)
- Game state 4 : Boss (dialogue, exit)
- End screen
- Game Over screen (if phase 2, respawn to boss)
- Pause menu

## Game Manager

- Global

- Phases :
-- Game phases : 0 - Kill / 1 - Boss / 2 - Heal / 3 - End
-- Phase 0 : Enemy hitbox & animation / No apples
-- Phase 1 : Boss attacks / dialogue
-- Phase 2 : Apples appear + hitbox / player apple count & contextual action / enemy contextual heal action / countdown
-- Phase 3 : Talk to boss for end

- Data :
-- Player hearts (in player scene)
-- Game phase
-- Countdown
-- Nbr enemies killled / healed
-- Nbr apples collected