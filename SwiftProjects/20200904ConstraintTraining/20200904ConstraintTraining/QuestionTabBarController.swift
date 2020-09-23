
import UIKit

class QuestionTabBarController: UITabBarController, UITabBarControllerDelegate {
    var VCNumber: Int?
    var NVC_height: CGFloat?
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NVC_height = 50
        let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        UITabBarItem.appearance().titlePositionAdjustment.vertical = -8.5
        // 객관식 만들기 화면 설정
        var item1 = UIViewController()
        switch VCNumber {
        case 2 :
            item1 = MultipleChoiceQuestionViewController_NSLayoutConstraint()
        case 3 :
            item1 = MultipleChoiceQuestionViewController_VisualFormat()
        case 4 :
            item1 = MultipleChoiceQuestionViewController_NSLayout_VisualFormat()
        case 5 :
            item1 = MultipleChoiceQuestionViewController_Anchor()
        case 6 :
            item1 = MultipleChoiceQuestionViewController_SnapKit()
        case 7 :
            item1 = MultipleChoiceQuestionViewController_RxSwift()
        default:
            print("VCNumber Error!")
        }
        item1.tabBarItem.title = "객관식 만들기"
        
        // 주관식 만들기 화면 설정
        let item2 = UIViewController()
        item2.view.backgroundColor = UIColor.white
        item2.tabBarItem.title = "주관식 만들기"
        
        let controllers = [item1, item2]
        self.viewControllers = controllers
    }
    
    override func viewDidLayoutSubviews() {
        if UIDevice.current.orientation.isLandscape == false {
            self.tabBar.frame = CGRect(x: 0, y: self.view.safeAreaInsets.top - 15, width: self.tabBar.frame.size.width, height: self.NVC_height!)
        } else {
            self.tabBar.frame = CGRect(x: 0, y: self.view.safeAreaInsets.top, width: self.tabBar.frame.size.width, height: self.NVC_height!)
        }
        super.viewDidLayoutSubviews()
    }
}
