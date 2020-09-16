import UIKit

// :class 하는 건 클래스만 채택 가능한 프로토콜이라는 표시임.
// 이걸 왜 하냐면,
//
// 메인VC에서 MsgBox객체를 가지고 있기때문에 [메인VC -> MsgBox 로 강한참조]
// MsgBox.delegate = self(==메인VC)를 통해 [MsgBox -> 메인VC 로 강한참조]
// 함으로써 메모리 문제중 하나인 Retain Cycle 발생.
// ( 강한참조 갯수가 0이면 메모리에서 해재하는 방식을 사용하기 때문 )
//
// 이를 해결하기 위해 delegate 선언시 weak를 사용해야하고, ( 그러면 MsgBox -> 메인VC 가 약한참조가 됨 )
// weak는 struct, enum은 안되고 class만 가능하기 때문에,
// 프로토콜을 아에 class만 채택할 수 있게 표시해서 weak를 사용가능하게 만듦.
protocol MessageBoxDelegate: class {
    func touchButton()
}

class MessageBox: UIView {
    weak var delegate: MessageBoxDelegate?
    var button: UIButton?
    
    // UIView의 위치기반 생성자를 오버라이드.( configure 실행 )
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // 단순히 UIView의 required init 대응용
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    // 생성한 UIView에 버튼 추가
    func configure() {
        button = UIButton(type: .system)
        if let btn = button {
            btn.setTitle("SEND", for: .normal)
            btn.sizeToFit()
            
            // 버튼 중앙배치
            btn.frame.origin = CGPoint(x: (self.bounds.width - btn.bounds.width) * 0.5,
                                       y: (self.bounds.height - btn.bounds.height) * 0.5)
            
            // 버튼 클릭시 tapButton 함수 호출하게 설정.
            // 피호출 함수에 @objc 붙이는건 없애는 방법이 없는듯함
            btn.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
            self.addSubview(btn)
        }
    }
    
    // 버튼을 누르면 델리게이트 프로퍼티가 가진 touchButton함수를 구현하는 방식
    // 즉, 델리게이트를 적용하고 싶은 클래스에서는 특정 행동과 델리게이트가 가진 함수를 이어주면 됨.
    
    // 이제 이 델리게이트의 구현부를 지정해줘야하는데, (메인컨트롤러로)
    @objc func tapButton() {
        delegate?.touchButton()
    }
}
