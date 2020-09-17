# 클로저의 벨류캡처, 래퍼런스 캡처  
~~~
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
~~~
incrementer이 runningTotal은 변화하기 때문에 참조획득,  
amount는 그대로라서 값획득.   
Swift에서 알아서 캡쳐한다고함.  흠.....ㅇㅋㅇㅋ;  

~~~
let incrementByTen = makeIncrementer(forIncrement: 10)

incrementByTen()
// returns a value of 10
incrementByTen()
// returns a value of 20
incrementByTen()
// returns a value of 30
~~~

자신만의 참조 변수를 가지고있음  
~~~
let incrementByTwo: (() -> Int) = makeIncrementer(forIncrement: 2)
let incrementByTwo2: (() -> Int) = makeIncrementer(forIncrement: 2)
let incrementByTen: (() -> Int) = makeIncrementer(forIncrement: 10)

let first: Int = incrementByTwo() // 2
let second: Int = incrementByTwo() // 4
let third: Int = incrementByTwo() // 6

let first2: Int = incrementByTwo2() // 2
let second2: Int = incrementByTwo2() // 4
let third2: Int = incrementByTwo2() // 6

let ten: Int = incrementByTen() // 10
let twenty: Int = incrementByTen() // 20
let thirty: Int = incrementByTen() // 30
~~~

클로저는 참조타입이기 때문에 이렇게하면 first second는 같은 클로저를 참조하게됨
~~~
let incrementByTwo: (() -> Int) = makeIncrementer(forIncrement: 2)
let sameIncrementByTwo: (() -> Int) = incrementByTwo

let first: Int = incrementByTwo() // 2
let second: Int = sameWithIncrementByTwo() // 4
~~~

