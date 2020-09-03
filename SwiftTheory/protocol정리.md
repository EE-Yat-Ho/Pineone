## 1. 프로토콜이란?
특정 역할을 하기 위한 메소드, 프로퍼티, 기타 요구사항 등의 청사진  

## 2. 프로토콜의 사용
구조체, 클래스, 열거형에서 프로토콜을 채택.  
프로토콜은 정의를 제시하지 기능 구현은 안함.  
프로토콜도 하나의 타입으로 사용됨. ( 함수의 파라미터나 리턴타입, 배열의 원소 등으로도 사용이 가능하다. )  


## 3. 기본 형태
protocol 프로토콜이름 {  
    프로토콜 정의  
}  

클래스에서만 채택가능  
protocol 프로토콜이름: class {  
    프로토콜 정의  
}  

클래스에서 부모클래스, 프로토콜 채택을 모두 표시할 경우, 부모클래스, 프로토콜 순으로 작성  
class SomeClass: SuperClass, SomeProtocol {  
    클래스 정의   
}  

프로토콜에서의 프로퍼티는 항상 var로 선언하며, 이름, 타입, gettable여부, settable여부를 명시함  
protocol Student {  
    var height: Double { get set }  
    var name: String { get }  
    static var schoolNumber: Int { get set }  
}  

그리고 프로토콜의 프로퍼티는 저장프로퍼티, 연산프로퍼티 다 사용해서 구현할 수 있다.  
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


미완성..!  
