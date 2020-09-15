# map, filter, reduce
배열의 프로퍼티들로, 클로저를 입력으로 받는 함수임

## map
~~~
func map<U>(transform: (T) -> U) -> Array<U>
~~~
각 원소들에 클로저를 적용한 새로운 배열을 반환합니다

~~~
let array = [0, 1, 2, 3]
let multipliedArray = array.map( { (value: Int) -> Int in return value * 2 } )
// [2, 4, 6, 8]
~~~

value의 타입과 return 생략
~~~
array.map( { (value) -> Int in value * 2 } )
~~~

반환타입 생략
~~~
array.map( {value in value * 2 } )
~~~

매개변수 이름 생략
~~~
array.map( {$0 * 2} )
~~~

괄호 생략
~~~
array.map { $0 * 2 }
~~~

String으로 변환하는 예제
~~~
array.map{ "Number :  \($0)" }
~~~

## filter
~~~
func filter(includeElement: (T) -> Bool) -> Array<T>
~~~
Bool타입을 반환하는 클로저를 받고,  
각 원소에 적용하여 true인 원소들만 가진 새로운 배열을 반환합늬다

~~~
let oddArray = array.filter( { (value: Int) -> Bool in return (value % 2 == 0) } )
//[2, 4]
~~~

쭉 생략하면 이케됨
~~~
array.filter { $0 % 2 == 0 }
~~~


## reduce
~~~
func reduce<U>(initial: U, combine: (U, T) -> U) -> U
~~~
각 원소들에 재귀적으로 클로저를 적용시켜 하나의 값을 만듦
initial는 시작하는 지점의 인덱스.
0이면 젤 첨부터 쭉
이름이 reduce인데 네이밍 별로인듯..ㅡㅡ

~~~
array.reduce(0, { (s1: Int, s2: Int) -> Int in
    return s1 + s2
})
~~~

후행 클로저
~~~
array.reduce(0) { (s1: Int, s2: Int) -> Int in
    return s1 + s2
}
~~~

쭉 생략
~~~
array.reduce(0) { $0 + $1 }
~~~

+는 중위 연산자이기 때문에, 두 값 생략 가능
~~~
array.reduce( 0, + )
~~~
