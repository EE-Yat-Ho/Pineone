## 0. 프로퍼티 ( Property )
프로퍼티는 값을 특정 클래스, 구조체, 열거형과 연결합니다.
...음 그렇구나

## 1. 저장 프로퍼티 ( Stored Property )
클래스와 구조체에서만 사용가능.
클래스와 구조체의 인스턴스의 일부가 되는 상수(let)와 변수(var)들.

클래스 인스턴스를 let으로 선언했을 경우, 인스턴스가 가지는 var 저장 프로퍼티는
~~~
struct testST {
var a: Int = 3
}

let testSTInstans = testST()
testSTInstans.a = 3
~~~ 


## 2. 연산 프로퍼티 ( Computed Property )


