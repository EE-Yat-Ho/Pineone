# AssociatedType
= 관련된 타입  
원래 typealias 였는데, Swift 2.2부터 이거로 바뀜  
프로토콜에서 사용  

name을 MyType을 따르게 해주면
~~~
protocol ZeddProtocol {
    associatedtype MyType
    var name: MyType { get }
}
~~~
name은 Int도 되고, String도 되고 다됨ㅇㅇ
~~~
struct Zedd: ZeddProtocol{
    var name: Int{
        return 100
    }
}
~~~
~~~
struct Elsa: ZeddProtocol {
    var name: String {
        return "Elsa"
    }
}
~~~

associatedtype에 타입 제약도 가능 ㅇㅇ  
이건 Equatable 프로토콜을 따르는 타입만 가능하다는 뜻
~~~
protocol ZeddProtocol{
    associatedtype MyType: Equatable
    var name: MyType { get }
}
