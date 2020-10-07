
import UIKit

class QuestionTabBarController: UITabBarController, UITabBarControllerDelegate {
    var screen: Screen?
    var NVC_height = CGFloat(50.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 객관식 만들기 화면 설정
        var item1 = UIViewController()
        switch screen {
        case .storyBoard:
            print("StrotBoard removed..;;")
            //item1 = MultipleChoiceQuestionViewController_StoryBoard()
        case .nSLayout:
            item1 = MultipleChoiceQuestionViewController_NSLayoutConstraint()
        case .visualFormat:
            item1 = MultipleChoiceQuestionViewController_VisualFormat()
        case .nSLayout_VisualFormat:
            item1 = MultipleChoiceQuestionViewController_NSLayout_VisualFormat()
        case .anchor:
            item1 = MultipleChoiceQuestionViewController_Anchor()
        case .snapKit:
            item1 = MultipleChoiceQuestionViewController_SnapKit()
        case .rxSwift:
            item1 = MultipleChoiceQuestionViewController_RxSwift()
        case .mVVM:
            item1 = MVVMViewController()
        case .none:
            print("Tabbar VC Error")
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
            self.tabBar.frame = CGRect(x: 0, y: self.view.safeAreaInsets.top - 15, width: self.tabBar.frame.size.width, height: self.NVC_height)
        } else {
            self.tabBar.frame = CGRect(x: 0, y: self.view.safeAreaInsets.top, width: self.tabBar.frame.size.width, height: self.NVC_height)
        }
        super.viewDidLayoutSubviews()
    }
    deinit {
        print("deinit QuestionTabBar")
    }
}
