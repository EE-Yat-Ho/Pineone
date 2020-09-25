# weak self
[ 요약 : 클로저 내부에서 self를 사용할 경우, weak self를 명시해주자 ]  

closure에서 [weak self]  
weak는 내가 아는 그 약한참조임 ㅇㅇ  

클로저에서 내부에 self를 사용하는 경우가 있는데, 특수한 상황에서 문제가 발생함.  
~~~
class Thing { 
    var disposable: Disposable? 
    var total: Int = 0 
    
    deinit { 
        disposable?.dispose() 
    } 
    
    init(producer: SignalProducer<Int, NoError>) { 
        disposable = producer.startWithNext { number in 
            self.total += number 
            print(self.total) 
        } 
    }
}
~~~
이 코드를 보면 closure 내부에 total이라는 프로퍼티를 사용하기 위해 self를 명시해 주고 있다. Self는 사용과 함께 retain count를 증가시키게 되는데 위의 코드 역시 closure가 self를 해제하여 retain count를 다시 낮춰준다면 문제가 없이 작동하게 되지만, closure에 대한 참조가 disposable 프로퍼티에 의해 붙잡혀 있다면 문제가 발생할 수 있다.  

이 말은 즉, closure는 self가 해제 될 때까지 기다리고 self는 closure가 해제될 때까지 기다리는 strong reference cycle 상황을 만들어 내게 된다. 이러한 상황을 해결하기 위해 사용하는 것이 [weak self] in이다.  

~~~
disposable = producer.startWithNext { [weak self] number in 
    self?.total += number 
    print(self?.total) 
}
~~~
코드에서 볼 수 있듯이 closure의 선언부에 [weak self] param in을 명시해주고 self가 사용되는 곳에 self를 optional로 사용해주면 strong reference cycle 상황을 피해 갈 수 있게 된다.  

어떠한 상황에서 strong reference cycle이 발생하는지 사전에 알기 어렵기 때문에 만약 closure 내부에서 self를 사용하게 된다면 [weak self] param in을 항상 먼저 명시해주는 습관을 기르면 더 좋지 않을까 싶다.  


