# 이서준 전임님의 MVVM, Coordinator, RxFlow 세미나를 들음
## 1. 좋은 아키텍처란 무엇인가
개체들간 책임 분리  
테스트하기 쉬움  
사용하기 편함  

## 2. MVC ( Model View Controller )
Model :  데이터 소유  
View : 데이터 시각화  
Controller : 두 사이에서 상호작용  
이 모델은 3가지 요소가 밀접하게 관련되어 있어서 재사용성이 낮음  
정지원 책임님 : "뭐 하나 수정하려해도 다 봐야하고 사이드위험(?)도 있다."  

## 3. MVVM ( Model View ViewModel )
View -[입력]-> ViewModel -[데이터 요청]-> Model -[데이터 반환]-> ViewModel -[bind를 통한 화면갱신]-> View  
모든 과정은 SetupDI로 의존성을 주입하는 비동기 이벤트 처리방식.  
정지원 책임님 : "EventView를 만들때, EventViewController, EventView, EventViewModel, EventModel 을 다 만들어야한다.", "ViewController는 View와 ViewModel의 브릿지."  
나름대로의 이해 : 일단 다 추상화시켜서 ViewModel에서 왔다갔다 할 수 있게 만듦.  
그래서 나중에 새로운 View를 추가할 때는, ViewController, ViewModel은 건들일 필요가 없어짐 와우~  

## 4. Coordinator
화면의 흐름을 제어해줌.  

기존의 방식  
ㅁ -> ㅁ -> ㅁ -> ㅁ-> ㅁ  

코디네이터 방식  
ㅁ <-> ㅁㅁㅁ    << 이 커다란 덩어리가 Coordinator. 자유롭고 재사용성이 높아보임  
ㅁ <-> ㅁㅁㅁ  
ㅁ <-> ㅁㅁㅁ  

나름대로의 이해 : 네비게이션 컨트롤러의 생성, 뷰 컨트롤러의 push, pop, 네비게이션 컨트롤러 해제 까지 Coordinator에서 완전 책임짐. Coordinator를 App, Main, Sub로 기능별로 나눠놓으신건데 무슨 기능들인지 궁금. 그리고 내 생각인데 전환할 화면을 가장 처음 결정하는건 VC일건데, 결국 분기 나누고 화면 띄우고.. 음 원래방식이랑 차이가 뭔지 소스를 봐야할거같음.  

## 5. RxFlow
Stepper : 집  
Step : 방  
Flow : 걸음?  
Flow를 여러개 뿌리기, 하나 뿌리기 등이 있었고, 아마 이 Flow 하나하나가 비동기 처리를 해주는 무언가.. 모르겠다 ㄹㄴㅁㄴㅇㅁ  
