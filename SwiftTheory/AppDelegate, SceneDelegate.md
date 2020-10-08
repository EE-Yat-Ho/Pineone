# AppDelegate, SceneDelegate
https://velog.io/@dev-lena/iOS-AppDelegate%EC%99%80-SceneDelegate
여기 설명 굳

1. iOS12까지는 대부분 하나의 앱에 하나의 window였지만 
iOS 13부터는 window의 개념이 scene으로 대체되고, 하나의 앱에서 여러개의 scene을 가질 수 있습니다.

2. AppDelegate의 역할 중 UI의 상태를 알 수 있는 UILifeCycle에 대한 부분을 SceneDelegate가 하게 됐습니다.

3. 그리고 AppDelegate에 Session Lifecycle에 대한 역할이 추가됐습니다.


## Scene
UIKit는 UIWindowScene 객체를 사용하는 앱 UI의 각 인스턴스를 관리합니다. 
Scene에는 UI의 하나의 인스턴스를 나타내는 windows와 view controllers가 들어있습니다. 
또한 각 scene에 해당하는 UIWindowSceneDelegate 객체를 가지고 있고, 
이 객체는 UIKit와 앱 간의 상호 작용을 조정하는 데 사용합니다. 
Scene들은 같은 메모리와 앱 프로세스 공간을 공유하면서 서로 동시에 실행됩니다. 
결과적으로 하나의 앱은 여러 scene과 scene delegate 객체를 동시에 활성화할 수 있습니다.
(Scenes - Apple Developer Document 참고)

UI의 상태를 알 수 있는 UILifeCycle에 대한 역할을 SceneDelegate가 하게 됐죠! 
역할이 분리된 대신 AppDelegate에서 Scene Session을 통해서 scene에 대한 정보를 업데이트 받는데요! 
그럼 Scene Session은 뭘까요??

## Scene Session
UISceneSession 객체는 scene의 고유의 런타임 인스턴스를 관리합니다. 
사용자가 앱에 새로운 scene을 추가하거나 프로그래밍적으로 scene을 요청하면, 
시스템은 그 scene을 추적하는 session 객체를 생성합니다. 
그 session에는 고유한 식별자와 scene의 구성 세부사항(configuration details)가 들어있습니다. 
UIKit는 session 정보를 그 scene 자체의 생애(life time)동안 유지하고 app switcher에서 사용자가 그 scene을 클로징하는 것에 대응하여 그 session을 파괴합니다. 
session 객체는 직접 생성하지않고 UIKit가 앱의 사용자 인터페이스에 대응하여 생성합니다. 
또한 위 3번에서 소개한 두 메소드를 통해서 UIKit에 새로운 scene과 session을 프로그래밍적 방식으로 생성할 수 있습니다.
(UISceneSession - Apple Developer Document 참고)

그럼 SceneDelegate가 추가된 iOS13에서 AppDelegate는 어떤 일을 할까요??

## AppDelegate (iOS 13부터)
이전에는 앱이 foreground에 들어가거나 background로 이동할 때 앱의 상태를 업데이트하는 등의 앱의 주요 생명 주기 이벤트를 관리했었지만 더이상 하지 않습니다.
현재 하는 일은
1. 앱의 가장 중요한 데이터 구조를 초기화하는 것
2. 앱의 scene을 환경설정(Configuration)하는 것
3. 앱 밖에서 발생한 알림(배터리 부족, 다운로드 완료 등)에 대응하는 것
4. 특정한 scenes, views, view controllers에 한정되지 않고 앱 자체를 타겟하는 이벤트에 대응하는 것.
5. 애플 푸쉬 알림 서브스와 같이 실행시 요구되는 모든 서비스를 등록하는것.
입니다.
(UIApplicationDelegate - Apple Developer Document 참고)
