# 먹이를 찾아서

> Corona SDK(Solar2D) 기반 모바일 스토리 어드벤처 게임

![타이틀 화면](screenshots/title.png)

## 개요

동물 NPC 캐릭터들과 대화하고, 각 캐릭터별 미니게임을 클리어하며 스토리를 진행하는 모바일 게임입니다.

## 기술 스택

- **엔진**: Corona SDK (Solar2D)
- **언어**: Lua 5.1
- **씬 관리**: Composer API
- **물리 엔진**: Box2D (Corona Physics)
- **데이터**: JSON 기반 스토리 대사 관리
- **플랫폼**: iOS / Android

## 게임 흐름

```
타이틀 화면 → 스테이지 맵(1~5) → NPC 탭 → 스토리 대사 → 미니게임 → 결과 → 다음 스토리
```

## 스테이지 맵

좌우 화살표로 이동하며 NPC를 만날 수 있는 맵 화면입니다.

<p align="center">
  <img src="screenshots/stage_map.png" width="200" />
  <img src="screenshots/stage_map2.png" width="200" />
  <img src="screenshots/stage_map3.png" width="200" />
</p>

## 스토리 시스템

JSON 파일에서 대사 데이터를 파싱하여 배경, 캐릭터 이미지, 대화를 순차적으로 표시합니다.

- 배경(background), 해설(Narration), 대사(Dialogue) 타입 지원
- 볼륨 조절 오버레이 내장

<p align="center">
  <img src="screenshots/story.png" width="250" />
</p>

## 미니게임

### 물고기 잡기 (고양이)
제한시간 내 물고기 12마리를 탭하여 잡는 게임

![물고기 잡기](screenshots/minigame_cat.gif)

### 음식 받기 (곰)
위에서 떨어지는 음식을 곰으로 받기 (쓰레기를 받으면 감점, Box2D 물리 엔진 사용)

![음식 받기](screenshots/minigame_bear.gif)

### 숨은 고슴도치 찾기 (고슴도치)
배경에 숨은 고슴도치 6마리를 제한시간 내에 찾는 게임

![숨은 고슴도치 찾기](screenshots/minigame_hedgehog.gif)

### 장애물 피하기 (병아리)
플래피버드 스타일의 장애물 회피 게임 (Box2D 물리 엔진 사용)

![장애물 피하기](screenshots/minigame_chick.gif)

### 별 잡기 (강아지)
밤하늘의 별을 시간 내에 수집하는 게임 (2레벨 구성)

![별 잡기](screenshots/minigame_dog.gif)

## 일지(다이어리)

게임 진행 중 수집한 이야기를 다시 볼 수 있는 일지 기능

<p align="center">
  <img src="screenshots/diary.png" width="250" />
</p>

## 주요 파일 구조

```
NPC_game/
├── main.lua              # 엔트리포인트
├── config.lua            # 해상도 설정 (1080x1920, 60fps)
├── build.settings        # 빌드 설정 (iOS/Android)
├── loadsave.lua          # JSON 저장/로드 유틸리티
├── volumeControl.lua     # 볼륨 조절 오버레이
├── story.lua             # 통합 스토리 씬 (params 기반)
├── stage01~05.lua        # 스테이지 맵 씬
├── View01_main.lua       # 메인 타이틀
├── View01_bear.lua       # 곰 미니게임 (음식 받기)
├── View01_hedgehog.lua   # 고슴도치 미니게임 (숨은그림찾기)
├── View01_cat2.lua       # 고양이 미니게임 (물고기 잡기)
├── view06_chick_game.lua # 병아리 미니게임 (장애물 피하기)
├── view02_dog.lua        # 강아지 미니게임 레벨1 (별 잡기)
├── view04_dog.lua        # 강아지 미니게임 레벨2 (별 잡기)
├── diaryviewTest.lua     # 일지(다이어리) 뷰어
└── Content/
    ├── JSON/             # 스토리 대사 데이터 (11개 에피소드)
    └── PNG/              # 이미지, 음악 리소스
```

## 실행 방법

1. [Solar2D Simulator](https://solar2d.com/) 설치
2. Solar2D Simulator에서 `main.lua` 열기
3. 시뮬레이터에서 실행

## 해상도

- 기본 해상도: 1080 x 1920 (세로 모드)
- 스케일 모드: letterbox
