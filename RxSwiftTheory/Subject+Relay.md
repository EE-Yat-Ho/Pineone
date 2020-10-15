# Subject + Relay

## Subject : Observable이자, Observer
실시간으로 Observable에 값을 추가하고, Subscriber할 수 있는 놈이 필요. 그때 얘를 사용  

PublishSubject  
subscribe 이후부터 .completed, .error 전까지  

BehaviorSubject  
subscribe 이후부터 .completed, .error 전까지. subscribe시 이전 값 하나를 받음  

ReplaySubject  
subscribe 이후부터 .completed, .error 전까지. subscribe시 지정한 버퍼 크기만큼 이전 값을 받음  


## Relay : Subject의 Wrapper 클래스
RxSwift가 아닌 RxCocoa의 클래스.  
.completed, .error 가 발생하지 않고, Dispose되기 전까지 계속 작동하기 때문에 UI Event에 적절함ㅇㅇㅇ  

PublishRelay  
PublishSubject의 Wrapper 클래스  

BehaviorRelay  
BehaviorSubject의 Wrapper 클래스  


## 20201015 
단순히 관찰 당한다고해서, Observable로 선언해서 다 되는게 아님.
옵저버블은 내가 원하는 타이밍에 이벤트를 발생 시킬 수 없고, 구독당할 때 or 주기적인 발생만 가능하기 때문.
내가 원하는 타이밍에 이벤트를 발생하는 것은 Subject나 Relay임.
왜 그러냐?
소스 보면 그냥 그렇게 구현한거같음 만든사람이..
애초에 이벤트라는 것은 구독할 때 발생하는데,
Subject나 Relay가 옵저버블을 가지고있고, on을 호출할 때 마다, 
옵저버 생성 - 구독 - 해제하는 식으로 구현한거같음. 
