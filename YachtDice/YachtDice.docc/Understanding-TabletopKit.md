# TabletopKit을 처음 보기 전에

Yacht Dice를 만들기 전에 TabletopKit이 어떤 문제를 해결하는지 세 개의 계층으로 나누어 이해합니다.

## TabletopKit은 3D 모델링 프레임워크가 아닙니다

`TabletopKit`은 테이블 게임의 **논리적인 배치와 상태, 장비 상호작용**을 관리합니다. 실제 모델은 RealityKit의 `Entity`가 렌더링합니다.

예를 들어 한 개의 주사위는 동시에 두 가지 의미를 가집니다.

- RealityKit 관점: 화면에 보이는 D6 `Entity`
- TabletopKit 관점: 고유 ID, 현재 pose, 현재 face state를 가진 `EntityEquipment`

`EntityEquipment`는 이 두 계층을 연결합니다.

## 핵심 객체의 관계

```text
EntityTabletop
      ↓
TableSetup
 ├─ TableSeat
 └─ EntityEquipment
      ↓
TabletopGame
      ↓
TabletopInteraction
```

`TableSetup`은 게임을 시작할 때의 초기 구성을 설명하고, `TabletopGame`은 그 구성을 기반으로 실행 중인 게임 상태를 관리합니다.

사용자가 장비를 집거나 옮기면 `TabletopInteraction`을 통해 장비의 상태를 변경합니다.

## 이 튜토리얼에서 먼저 다루지 않는 것

TabletopKit은 SharePlay를 이용한 공간 멀티플레이도 지원하지만, 이 튜토리얼은 API의 기본 구조에 집중하기 위해 **싱글플레이 Yacht Dice**만 구현합니다. seat와 player 개념은 사용하지만 네트워크 동기화는 추가하지 않습니다.
