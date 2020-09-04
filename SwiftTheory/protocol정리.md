## 1. 프로토콜이란?
특정 역할을 하기 위한 메소드, 프로퍼티, 기타 요구사항 등의 청사진  

## 2. 프로토콜의 사용
구조체, 클래스, 열거형에서 프로토콜을 채택.  
프로토콜은 정의를 제시하지 기능 구현은 안함.  
프로토콜도 하나의 타입으로 사용됨. ( 함수의 파라미터나 리턴타입, 배열의 원소 등으로도 사용이 가능하다. )  

## 3. 기본 형태
~~~
protocol 프로토콜이름 {  
    프로토콜 정의  
}  
~~~  

클래스에서만 채택가능  
~~~
protocol 프로토콜이름: class {  
    프로토콜 정의  
}  
~~~  

클래스에서 부모클래스, 프로토콜 채택을 모두 표시할 경우, 부모클래스, 프로토콜 순으로 작성  
~~~
class SomeClass: SuperClass, SomeProtocol {  
    클래스 정의   
}  
~~~  

프로토콜에서의 프로퍼티는 항상 var로 선언하며, 이름, 타입, gettable여부, settable여부를 명시함  
~~~
protocol Student {  
    var height: Double { get set }  
    var name: String { get }  
    static var schoolNumber: Int { get set }  
}  
~~~  

그리고 프로토콜의 프로퍼티는 저장프로퍼티, 연산프로퍼티 다 사용해서 구현할 수 있다.  
~~~
class Aiden: Student {  
    var roundingHeight: Double = 0.0  
    var height: Double {  
        get {  
            return roundingHeight  
        }  
        set {  
            roundingHeight = 183.0  
        }  
    }  
    var name: String = "Aiden"  
    static var schoolNumber: Int = 20112330  
}  

let aiden = Aiden()
print(aiden.height, aiden.name, Aiden.schoolNumber)
// 0.0 Aiden 20112330
aiden.height = 183.0
print(aiden.height, aiden.name, Aiden.schoolNumber)
// 183.0 Aiden 20112330
~~~  

메소드 앞에 mutating 키워드를 붙혀서 인스턴스에서 변경이 가능함을 알림.  
[첨언] 데이터 접근 레이어 중 struct와 enum은 값 타입이다 ( class는 레퍼런스 타입 )  
swift에서 값 타입들은 자신의 인스턴스 메소드로 프로퍼티를 변경할 수 가 없는데, mutating을 붙혀주면 가능해진다!  
때문에, 프로토콜의 경우에도 값 타입에서 채택할 메소드 중 프로퍼티를 변경해야 하는 메소드는 mutating을 붙혀줘야한다.  
더불어, 클래스에서 채택하는 경우에도, "이 메소드가 프로퍼티를 변경시키는 구나~" 라고 유추할 수 있다.
~~~
protocol Person {
  static func breathing()
  func sleeping(time: Int) -> Bool
  mutating func running()
}

struct Aiden: Person {
    var heartRate = 100
    static func breathing() {
        print("숨을 쉽니다")
    }
    
    func sleeping(time: Int) -> Bool {
        if time >= 23 {
            return true
        } else {
            return false
        }
        
    }
    
    mutating func running() {
        heartRate += 20
    }
}

print(Aiden.breathing())
// 숨을 쉽니다.
var aiden = Aiden()
print(aiden.sleeping(time: 23))
// true
print(aiden.heartRate)
// 100
aiden.running()
print(aiden.heartRate)
// 120
~~~  

프로토콜에서는 이니셜라이저 정의도 가능하며, 채택한 클래스 내에서 구현시  
꼭 구현해야 하는 이니셜라이저이므로 required를 붙여준다.  
~~~
protocol SomeProtocol {
  init(someParameter: Int)
}
class SomeClass: SomeProtocol {
  required init(someParameter: Int) {
    // 구현부
  }
}
~~~  

프로토콜을 선언하면서 필수 구현이 아닌 선택적 구현 조건을 정의할 수 있다.  
두가지 방법이 있음. ( @objc , extention )  

1. @objc을 활용한 방법  
프로토콜 앞에 @objc붙이고, 메소드나 프로퍼티에는 @objc optional 을 붙힘.  
@objc 프로토콜은 클래스만 채택이 가능함.
~~~
@objc protocol Person {
  @objc optional var name: String {get}
  @objc optional func speak()
}

class Aiden: Person {
  func notChoice() {
    print("name, speak()를 사용하지 않았습니다.")
  }
}

let aiden = Aiden()
aiden.notChoice() // name, speak()를 사용하지 않았습니다.
~~~  

또한 @objc 프로토콜의 프로퍼티에 사용자가 정의한 타입을 사용할 수 없음.  
사용하려면 사용자 정의 타입이 NSObject를 상속받으면 됨. ( 즉, 사용자 정의 타입이 클래스여야함. )
~~~
// NSObject를 상속받아야 해서 클래스만 가능
class CustomType: NSObject {
    var property: String = "특수타입"
}

@objc protocol Person {
    @objc optional var name: CustomType {get}
    @objc optional func speak()
}

class Aiden: Person {
    func notChoice() {
        print("name, speak()를 사용하지 않았습니다.")
    }
}

let aiden = Aiden()
aiden.notChoice()
~~~  

2. extension을 활용한 방법  
프로토콜에 extension을 추가하고, 선택적 구현 메소드 넣어준다.  
이러면 그 메소드는 채택한 클래스에서는 구현할 필요 없어짐.  
또 extention에서 기능을 구현해놓으면, 이미 기능이 구현된 상태로 프로토콜 채택이 가능.
~~~
struct CustomType {
    var name: String
}

protocol Person {
    var specialPeople: CustomType {get}
    func speak()
    func sleep()
}

extension Person {
    func speak() {
        print(specialPeople.name+"이 말합니다.")
    }
}

class Aiden: Person { // name과 sleep() 메소드만 구현하면 된다.
    var specialPeople: CustomType = CustomType(property: "Aiden")
    func sleep() {
        print(specialPeople.name+"잡니다.zzz")
    }
}

let aiden = Aiden()
aiden.speak() // Aiden이 말합니다.
aiden.sleep() // Aiden잡니다.zzz
~~~  

extention의 경우, 선택적 메소드도 빈 메소드로 남아있기 때문에 메모리면에서 @objc가 우수.  
다만, @objc는 프로토콜이 클래스에서만 채택할 수 있고, 사용자 정의 타입도 클래스만 가능.  

즉, 선택적 구현을 하려할 때 @objc로 하되, 안되면 extention 사용.  
