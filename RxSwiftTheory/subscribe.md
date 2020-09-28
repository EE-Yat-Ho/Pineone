# subscribe

구현부
~~~
public func subscribe<Observer: ObserverType>(_ observer: Observer) -> Disposable where Observer.Element == Element {
    rxAbstractMethod()
}
~~~
observer하나를 받고 Disposable을 반환하네
이 옵저버는 emit을 받았을 때 실행될 클로저인 경우가 많은듯?
