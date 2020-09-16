import UIKit

class _20200903MainViewController: UIViewController {
    // 델리게이트를 가진 메세지 박스를 생성했고,
    var messageBox: MessageBox?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageBox = MessageBox(frame: CGRect(origin: .zero, size: CGSize(width: 300, height: 200)))
        if let msg = messageBox {
            msg.frame.origin = CGPoint(x: (UIScreen.main.bounds.width - msg.bounds.width) * 0.5,
                                     y: (UIScreen.main.bounds.height - msg.bounds.height) * 0.5)

            msg.backgroundColor = .lightGray
            
            // 원래 하던대로 delegate = self
            msg.delegate = self
            self.view.addSubview(msg)
        }
    }
}

// 구현부
extension _20200903MainViewController: MessageBoxDelegate {
    func touchButton() {
        print("touchButton")
    }
}

