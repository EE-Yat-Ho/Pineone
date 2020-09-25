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
