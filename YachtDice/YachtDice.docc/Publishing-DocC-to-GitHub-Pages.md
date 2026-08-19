# GitHub Pages에 DocC 정적 배포하기

`YachtDice.docc`를 Xcode에서 확인한 뒤 GitHub Actions로 정적 사이트를 배포합니다.

## Xcode에서 먼저 확인하기

Xcode에서 **Product > Build Documentation**을 실행합니다. DocC는 앱 타깃도 문서화할 수 있으며, Documentation Catalog의 article과 tutorial을 함께 빌드합니다.

GitHub Pages의 프로젝트 사이트는 저장소 이름이 URL의 base path가 되므로 Build Settings의 **DocC Archive Hosting Base Path**(`DOCC_HOSTING_BASE_PATH`)를 저장소 이름으로 설정해야 합니다.

예를 들어 저장소가 `YachtDice`라면 base path도 `YachtDice`입니다.

## GitHub Pages 설정

저장소의 **Settings > Pages > Build and deployment > Source**에서 **GitHub Actions**를 선택합니다.

이 프로젝트에 포함된 `.github/workflows/deploy-docc.yml`은 다음 순서로 동작합니다.

1. macOS 26 runner에서 프로젝트를 체크아웃합니다.
2. `xcodebuild docbuild`로 visionOS 앱의 DocC archive를 만듭니다.
3. archive의 정적 웹 파일을 Pages artifact로 업로드합니다.
4. `actions/deploy-pages`로 GitHub Pages에 배포합니다.

`DOCC_HOSTING_BASE_PATH`는 workflow에서 `${{ github.event.repository.name }}`으로 자동 지정하므로 저장소 이름을 바꾸어도 별도 수정이 필요하지 않습니다.

## 로컬 빌드

프로젝트 루트에서 다음 스크립트를 실행할 수도 있습니다.

```bash
./Scripts/build-docc.sh YachtDice
```

빌드된 정적 파일은 `.docc-build/site`에 생성됩니다. GitHub Pages용 최종 배포에서는 workflow가 이 과정을 자동으로 수행합니다.
