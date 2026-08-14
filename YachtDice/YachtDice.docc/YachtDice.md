# Yacht Dice

visionOS에서 `TabletopKit`을 처음 사용하는 개발자를 위한 단계별 Yacht Dice 튜토리얼입니다.

## Overview

이 튜토리얼은 완성 코드를 한 번에 보여주지 않습니다. 한 단계에서 가능한 한 **한 가지 TabletopKit 개념만 추가**하고, 매 단계마다 화면이나 상태가 어떻게 달라지는지 확인합니다.

먼저 다음 세 계층을 구분해서 생각합니다.

- **SwiftUI**: volumetric window와 점수판 같은 2D 인터페이스를 구성합니다.
- **RealityKit**: 테이블과 주사위처럼 실제로 보이는 3D `Entity`를 렌더링합니다.
- **TabletopKit**: 테이블, 좌석, 장비의 논리적 상태와 상호작용을 관리합니다.

완성 과정은 다음 순서로 진행합니다.

1. 1m 크기의 volumetric window를 만듭니다.
2. RealityKit root entity를 준비합니다.
3. `EntityTabletop`으로 테이블을 정의합니다.
4. `TableSetup`과 `TabletopGame`을 만듭니다.
5. 한 명의 `TableSeat`을 추가합니다.
6. 한 개의 `EntityEquipment` 주사위를 추가합니다.
7. 주사위를 다섯 개로 늘립니다.
8. `TabletopInteraction`으로 주사위를 던집니다.
9. snapshot에서 결과를 읽고 한 턴을 세 번으로 제한합니다.
10. 주사위를 Hold해서 다음 toss에서 제외합니다.
11. Yacht 점수표와 Numbers 보너스를 완성합니다.

> Note: TabletopKit의 장비 구성, face mapping, toss interaction의 초기 접근은 Apple의 *Simulating dice rolls as a component for your game* 샘플을 참고했습니다. Yacht 규칙, Hold 상태, 점수 계산, 보너스, 게임 상태와 UI는 이 튜토리얼에서 단계적으로 별도 구현합니다.

## Topics

### Start Here

- <doc:Understanding-TabletopKit>
- <doc:Yacht-Dice-with-TabletopKit>

### Publishing

- <doc:Publishing-DocC-to-GitHub-Pages>
