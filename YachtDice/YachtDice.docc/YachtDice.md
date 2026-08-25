# Yacht Dice

visionOS에서 `TabletopKit`을 처음 사용하는 개발자를 위한 Yacht Dice 샘플 튜토리얼입니다.

## Overview

Xcode에서 **visionOS > App** 템플릿을 만들고 Initial Scene을 **Volume**으로 선택한 뒤 시작합니다. 튜토리얼에서 제공하는 `table.usda`와 `D6.usdz`를 `RealityKitContent.rkassets`에 추가하고, `realityKitContentBundle`에서 직접 불러와 TabletopKit의 tabletop과 equipment로 연결합니다.

Yacht Dice는 네 가지 역할이 연결되어 동작합니다.

- **SwiftUI**는 volumetric window와 결과·점수표 UI를 구성합니다.
- **RealityKit**은 `RealityKitContent` package에서 table과 D6 asset을 불러와 실제로 보이는 3D `Entity`를 렌더링합니다.
- **TabletopKit**은 RealityKit entity에 tabletop, seat, equipment라는 게임 의미를 부여하고 사용자의 조작과 toss를 관리합니다.
- **Yacht 게임 로직**은 roll 횟수, Hold, 점수 계산처럼 TabletopKit이 알 필요가 없는 규칙을 관리합니다.

먼저 3D 공간과 tabletop을 만들고, 그 위에 dice를 equipment로 등록합니다. 이후 `TabletopInteraction`으로 dice를 굴리고 snapshot에서 결과를 읽어 Yacht의 turn state와 score sheet로 전달합니다. 이 흐름을 따라가면 **보이는 3D object가 어떻게 TabletopKit의 game equipment가 되고, 그 결과가 다시 앱의 게임 규칙으로 이어지는지** 확인할 수 있습니다.

> Note: TabletopKit의 equipment 구성과 toss interaction의 초기 접근은 Apple의 *Simulating dice rolls as a component for your game* 샘플을 참고했습니다. Yacht 규칙, Hold, 점수 계산, 점수표와 game state는 이 프로젝트에서 별도로 구성했습니다.

## Topics

### Tutorial

- <doc:Yacht-Dice-with-TabletopKit>

### Reference

- <doc:Attribution>
