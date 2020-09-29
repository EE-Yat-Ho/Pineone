# create

구현부
~~~
public static func create(_ subscribe: @escaping (RxSwift.AnyObserver<Self.Element>) -> RxSwift.Disposable) -> RxSwift.Observable<Self.Element>
~~~
subscribe라는 매개변수를 받음  
이 subscribes는 탈출클로저임  
그리고 그 탈출클로저는 옵저버를 받아서 Disposable을 반환함  
그리고 create는 옵저버를 반환함   

[ Observer를 받아서 Disposable로 바꾸는 탈출 클로저 ]를 받고 Observable을 반환함.  

~~~
func myJust<E>(_ element: E) -> Observable<E> {
    return Observable.create { observer in
        observer.on(.next(element))
        observer.on(.completed)
        return Disposables.create()
    }
}
~~~
[ 하나의 요소를 반환하고 종료되는 옵저버블 ]를 반환하는 myJust라는 함수


~~~
Observable<String>.create { observer in 
    observer.onNext("A")
    observer.onCompleted()
    
    return Disposables.create()
}.subscribe(
    onNext: { print($0) },
    onError: { print($0) }, 
    onCompleted: { print("Completed") }, 
    onDisposed: { print("Disposed") }
).disposed(by: disposeBag)

// print 
A
Completed 
Disposed
~~~
자, A를 emit하고 Completed하는 옵저버블을 만듦 create가 ㅇㅇ
그리고 subscribe함 얘는 
뒤에 따라붙은건 emit을 받으면 실행되는 클로저인거임
그리고 emit으로 받은 이벤트에따라 스위치로 분기한거일뿐임

