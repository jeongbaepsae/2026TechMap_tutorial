# YachtDice

A single-player Yacht Dice game for visionOS built with SwiftUI, RealityKit, and TabletopKit.

This repository also contains a DocC tutorial collection that teaches TabletopKit fundamentals by building the game step by step.

## DocC tutorial

The Documentation Catalog is located at:

```text
YachtDice/YachtDice.docc/
```

The tutorial collection contains eight lessons:

1. Create a volumetric Tabletop app
2. Build a TabletopKit tabletop
3. Add five dice as equipment
4. Toss dice with `TabletopInteraction`
5. Read dice results and limit a turn to three rolls
6. Hold dice and exclude them from the next toss
7. Calculate Yacht scores with pure Swift
8. Record scores, calculate the Numbers bonus, and finish the UI with ornaments

In Xcode, choose **Product > Build Documentation** to open the tutorials in the Developer Documentation window.

## GitHub Pages

This project includes `.github/workflows/deploy-docc.yml`.

On GitHub:

1. Open **Settings > Pages**.
2. Set **Source** to **GitHub Actions**.
3. Push the project to the `main` branch.

The workflow builds the visionOS app documentation with `xcodebuild docbuild`, sets `DOCC_HOSTING_BASE_PATH` to the repository name, and deploys the resulting static DocC archive with GitHub Pages Actions.

You can also build the static site locally on a Mac with Xcode installed:

```bash
./Scripts/build-docc.sh YachtDice
```

The generated site is written to `.docc-build/site`.

## Project structure

- `Equipment/`: TabletopKit equipment and 3D die appearance
- `Interaction/`: Dice grab-and-toss interaction
- `Scoring/`: Yacht categories, score calculation, score sheet, and bonus rules
- `Support/`: Game coordination and sample-derived helpers
- `Views/Components/`: Reusable SwiftUI components
- `Views/ScoreSheet/`: Score sheet UI components
- `YachtDice.docc/`: DocC articles, tutorials, tutorial code snapshots, and resources

## Sample code attribution

This is an independent Yacht Dice app, but its initial TabletopKit equipment setup, toss interaction, and face-mapping structure were adapted in part from Apple’s sample **“Simulating dice rolls as a component for your game.”** The Yacht rules, hold mechanic, scoring system, bonus calculation, game flow, and game UI were implemented for this project.

Apple-derived source files retain attribution comments and remain subject to the Apple Sample Code License.

- Apple sample: https://developer.apple.com/documentation/tabletopkit/simulating-dice-rolls-as-a-component-for-your-game
- Apple Sample Code License: https://developer.apple.com/support/downloads/terms/apple-sample-code/Apple-Sample-Code-License.pdf

## Documentation references

- Swift-DocC: https://www.swift.org/documentation/docc/
- GitHub Pages custom workflows: https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages
## DocC Tutorial

`YachtDice.docc` is written for developers who are new to visionOS TabletopKit. The tutorial intentionally adds one concept at a time: volume → RealityKit root → tabletop → seat → one die → five dice → interaction → game rules → scoring.
