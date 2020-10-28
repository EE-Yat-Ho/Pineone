# Flow, Coordinator, Stepper
ha..
사th사th히 파헤쳐주지..

앱델리게이트에서 앱코디네이터가 시작됨 ㅇㅇ

Flow : 어플 내부의 네비게이션 공간!
Step : 어플 내부의 네비게이션 상태!...
Stepper : Flow내부에 모든 네비게이션 행동들을 트리거하는 ( Step을 생성하는 ) 모든 것
Presentable : 기본적으로 UIViewController와 Flow를 뜻하며, 표현될 수 있는 무언가를 추상화..했데..
// NextFlowItem : navigate(to:) 함수를 통해 Step이 이것으로 변형됨...



Step은 enum으로, 모든 화면과 화면이동 트리거를 가지고있음
Flow는 모든 네비게이션 코드(present, push 등)을 정의함. Step과 합쳐질 경우 네비게이션 행동을 일으킴.
* navigate(to:)를 가지고 있으며, Step에 의해 네비게이션 행동을 일으키는 함수임.
* 이 네비게이션 행동은 Flow에 있는 rootVC( : 네비게이션 컨트롤러;;)로 일어남

네비게이팅은! NextFlowItem을 만드는 것!
NextFlowItem은 기본적으로 Presentable과 Stepper를 가진 데이터 구조.
Presentable : Coordinator에게 다음에 보여줄 것이 무엇인지 알려줌.
Stepper : Coordinator에게 Step을 발생하기 위해 해야할 다음 일을 알려줌.

ㅁ..모든 VC는 Presentable. 모든 Flow도 Presentable( 새로운 네비게이션 공간을 만들수도 있기때문).

Step은 자신을 발생시킬 수 있는( 연결된 ) Presentable이 보여지기 전까지 발생될 수 없음.
Presentable은 Coordinator가 구독할 옵저버블을 제공함. = Coordinator가 Presentable의 상태를 알음.

Stepper는 무엇이든 될 수 있음. 커스텀 VC, VM, Presenter 등등..
Coordinator에 한번 등록된 Stepper 클래스는 자신이 가진 step (self.step.onNext)을 통해 Step을 발생시킬 수 있음

뒤로가기 액션은 navigate(to:)의 NextFlowItem.noNavigation을 반환
NextFlowItems 이거 파운데이션 에서는 FlowContributors 로 typealias..;;

네비게이션 과정 :
1. navigate(to:)함수가 Step을 파라미터로 받아서 호출됨.
2. Step에 따라 어떠한 네비게이션 코드가 호출됨.(사이드 이펙트)
3. 호출된 네비게이션 코드로 NextFlowItem(Presentable과 Stepper)이 생성되고, Presentable과 Stepper이 Coordinator에 등록됨.
4. Stepper는 새로운 Step을 발생시킴.


AppCoordinator는 shared로 생성되어있고..
AppCoordinator가 shared로 생성 -> shared.start -> AppCoordinator 안에 있는 IntiFlow.shared도 생성
이게 AppCoordinator안의 mainFlow ㅇㅇ
whenReady 실행.
-> mainFlow 를 클로저가 관찰하게함 
이 클로저는 mainFlow의 Root가 window.rootViewController가 되게하고, window.makeKeyAndVisible을 실행..)

AppCoordinator의 coordinator를 mainFlow와 AppStepper.shared로 coordinate함.
flow는 coordinate하고싶은 navigation이고, stepper는 Flow의 global navigation임.

[앱 전체를 아우르는 코디네이터, 플로우, 스탭퍼가 만들어지고, 코디네이터에.. 붙혀진다?]
[아 이게 Coordinator를 생성하고, 첫번째로 보여줄 Flow를 생성하고, Coordinator가 Flow와 Step을 합치고, 첫번째 Flow가 준비되면 루트를 Window의 rootVC로 설정하는 작업]



ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
결론
야 일단 샘플링 했고, 플로우 바꾸는 식으로 하는건 공부가 더 필요해보임.
근데 어느정도 감 잡았자너? U+ AR 요구사항부터 허자
