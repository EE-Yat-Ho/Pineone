# Observable + Observer

## Observer : 옵저버블을 관찰, 구독, 리슨
https://medium.com/@rkdthd0403/rxswift-%EC%8B%9C%EC%9E%91-497dfada1e22  
ㅋㅋㅋㅋ아 여기 맛집이넹

## Observable : 이벤트를 발생 시키는 주체
= sequence , observable sequence , stream  
async  
이벤트를 발생시키는 주체 ( emit한다라고 함 )  

Event<Elment>  
case next(Element)  
case error(Swift.Error)  
case completed  

just : 1  
of : 1 2 3  
from : [1 2 3]  

Observable은 Subscriber이 없으면 이벤트를 전송하지 않음  

Observable에서 subscribe()를 하면, 이 클로저 안에서 observer를 생성;;    
그리고 그 observer를 해제할 수 있는 Disposable타입을 리턴하고, 이를 통해  
우리는 마지막에 .dispose 뭐 이런 소스를 가지고 해제까지 매무리짓는 아름다운 형태   
~~~
observable.subscribe(onNext: { (element) in
        print(element)
})
~~~

### 20200928
Array, String 같이 IteratorProtocol 를 따르는 모든 오브젝트는 Observable로 바꿀 수 있음  
다만 Observable은 비동기적이라는 것.
