## 1. 클로저(Closure)란?
호출 가능한 코드 블록.  
클로저가 작성된 범위에서 사용가능한 변수나 함수들도 접근가능!  
다른 범위에서 실행되도 작성된 범위의 항목만 접근가능.

## 2. map 메소드로 축약문법 알아보기
(map은 배열의 모든 원소에 특정 연산을 수행한 배열을 반환)  
finc map<T>(_ transform: (Element) throws -> T) rethrows -> [T]
~~~
var numbers = [20, 19, 7, 12]
numbers.map({ (number: Int) -> Int in
    return 3 * number
})
// [60, 57, 21, 36]
~~~
### 1. return 생략
명령어가 하나뿐인 클로저라면 자동으로 그 명령어의 값을 리턴합니다
~~~
numbers.map({ (number: Int) -> Int in
    3 * number
})
~~~
### 2. 매개 변수 [유형] 및 반환 [유형] 생략
컴파일러가 추론 가능할 경우 생략가능
~~~
numbers.map({ number -> Int in 3 * number }) // 매개 변수의 유형을 생략함
numbers.map({ (number: Int) in 3 * number }) // 반환 유형을 생략함
numbers.map({ number in 3 * number }) // 둘다 생략함
~~~
### 3. 매개 변수 이름 생략
$1, $2 등 매개 변수를 숫자, 순서로 참조할 수 있음.
즉 매개 변수 입력부분의 이름을 안적어도됨!!
~~~
numbers.map({ 3 * $0 })
~~~
### 4. 클로저가 인자인 함수의 괄호 생략
마지막 인자가 클로저인 경우 밖에 적을 수 있음
~~~
numbers.map() { 3 * $0 }
~~~
인자가 클로저뿐인 경우 괄호를 아에 생략 가능
~~~
numbers.map { 3 * $0 }
~~~
