# Yacht Dice

@Metadata {
    @TechnologyRoot
}

A Yacht Dice sample tutorial for developers who are using `TabletopKit` on visionOS for the first time.

## Overview

**Languages:** English | [한국어](https://jeongbaepsae.github.io/2026TechMap_tutorial/documentation/yachtdice/)

Start by creating a project from the Xcode `visionOS > App` template and choosing `Volume` as the Initial Scene. Add the `table.usda` and `D6.usdz` assets provided with the tutorial to `RealityKitContent.rkassets`, load them directly from `realityKitContentBundle`, and connect them to TabletopKit as the tabletop and equipment.

Yacht Dice works by connecting four roles:

- **SwiftUI** builds the volumetric window and the result and score sheet UI.
- **RealityKit** loads the table and D6 assets from the `RealityKitContent` package and renders the visible 3D `Entity` objects.
- **TabletopKit** gives the RealityKit entities their game meaning — tabletop, seat, and equipment — and manages player interaction and tosses.
- **Yacht game logic** manages the rules that TabletopKit doesn't need to know about, such as roll count, Hold, and scoring.

First you create the 3D space and the tabletop, then register the dice on it as equipment. After that, you roll the dice with `TabletopInteraction`, read the results from a snapshot, and pass them on to Yacht's turn state and score sheet. Following this flow shows **how a visible 3D object becomes TabletopKit game equipment, and how its result flows back into the app's game rules**.

> Note: The equipment setup and the initial approach to toss interaction in TabletopKit are based on Apple's *Simulating dice rolls as a component for your game* sample. The Yacht rules, Hold, scoring, score sheet, and game state were built separately for this project.

## Topics

### Tutorial

- <doc:Yacht-Dice-with-TabletopKit>

### Reference

- <doc:Attribution>
