# Optional Chaning & Binding
## Binding
"먼저 체크해준다!" 라는 개념. 안전장치임ㅇㅇㅇ
주로 if let, if var과 같이 쓰이게 됨
변수가 nil 값이 아닌 경우, 클로저 실행.
nil 값인 경우 그냥 넘어감.

### 1. 기본형
~~~
 if let name = myName {
     printName(_name: name)
 }
~~~

### 2. And
쉼표(,)를 통해 And(&&) 효과 가능
~~~
if let value = height, value >= 160{
     print("wow")
} 
~~~


## Chaining
하위 프로퍼티를 쭉 타고 들어가면서 중간에 하나라도 nil 값이 있는지 확인하는 것
마찬가지로 안전장치임ㅇㅇㅇ
만약 nil 값이 있으면 nil을 반환하게됨. 즉 클로저를 실행하지 않음
nil 값 없으면 클로저 실행

~~~
if let roomCount = zedd.residence?.numberOfRooms {
    print("zedd's residence has \(roomCount) room(s).")
} else {
   print("Unable to retrieve the number of rooms.")
}
~~~
