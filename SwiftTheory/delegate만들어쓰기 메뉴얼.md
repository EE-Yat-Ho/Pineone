## 1. 이런 식으로 선언
protocol AAADelegate: class {  
    func touchButton()  
    func dragUp()  
}  


## 2. 이후 원하는 클래스의 구현부에 델리게이트 객체를 넣어줌
class AAA: UIView {  
    weak var delegate: AAADelegate?  
    var button: UIButton?  
    ~~  
}  


## 3. 그리고 특정 행동시 델리게이트의 함수를 실행하게 함
( 이 부분이 나중에 복잡해질 듯..? )  
class AAA: UIView {  
    weak var delegate: AAADelegate?  
    var button: UIButton?  
    ~~  
    button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)  
    @objc func tapButton() {  
        delegate?.touchButton()  
    }  
    ~~  
}  

## 4. 이후 원래 VC에서 TableView나 CollectionView로 쓰던거처럼 aaa.delegate = self하고 함수 구현부 만들면됨!


## 참고. 프로토콜 선언시 :class 하는 이유
처음 프로토콜 선언시 :class 하는 건 클래스만 채택 가능한 프로토콜이라는 표시임.  
이걸 왜 하냐면,  

메인VC에서 MsgBox객체를 가지고 있기때문에 [메인VC -> MsgBox 로 강한참조]  
MsgBox.delegate = self(==메인VC)를 통해 [MsgBox -> 메인VC 로 강한참조]  
함으로써 메모리 문제중 하나인 Retain Cycle 발생.  
( 강한참조 갯수가 0이면 메모리에서 해재하는 방식을 사용하기 때문 )  

이를 해결하기 위해 delegate 선언시 weak를 사용해야하고, ( 그러면 MsgBox -> 메인VC 가 약한참조가 됨 )  
weak는 struct, enum은 안되고 class만 가능하기 때문에,  
프로토콜을 아에 class만 채택할 수 있게 표시해서 weak를 사용가능하게 만듦.  
