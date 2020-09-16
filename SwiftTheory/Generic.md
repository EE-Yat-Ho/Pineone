# Generic

구현 로직은 동일하지만, 타입만 다르다면 Generic 을 통해 코드의 중복을 방지할 수 있음.  
~~~
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}
~~~
이거면 Int, Float, String 다 스왑 가능!! ( a, b 타입이 같은 경우만 )  
( inout 은 매개변수가 값참조가 아니라 주소참조로 바꾸는거고 ㅇㅇ )  

T는 이 함수 안에서만 쓰는 Placeholder 타입의 이름이닷  
함수가 호출 될 때, a, b 에 의해 T가 무슨 타입인지 결정된닷  

보통은 매개변수의 역할에 맞는것으로 타입의 이름을 정하지만(Upper camel case. ex. MyTypeParam),  
별 의미가 없을 때는 T, V와 같은 단일문자 사용  

### 타입 제약 ( Type Constraint )
Placeholer 타입( 타입 파라미터라고도 하눼.. ) 가 
특정 클래스를 상속하거나, 특정 프로토콜을 준수해야만 하도록 제약을 걸 수 있뜸

~~~
func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    // function body goes here
}
~~~
<>꺽쇠에 타입 파라미터를 쓸 때 설정함.  
T가 SomeClass를 상속해야하고,
U가 SomeProtocol을 준수해야한다는 뜻~

예를들어 == 를 쓸 경우 Equatable 프로토콜을 준수해야함!

