//
//  QuestionTabBarController.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/09/04.
//  Copyright © 2020 Park young ho. All rights reserved.
//

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
        
        NVC_height = (self.navigationController?.navigationBar.frame.size.height)!
        let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        
        if UIDevice.current.orientation.isLandscape == false { // 여기서 한거만 먹히네..흠..
            UITabBarItem.appearance().titlePositionAdjustment.vertical = (18 - NVC_height!) / 2
        } else {
            UITabBarItem.appearance().titlePositionAdjustment.vertical = 0
        }
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
            item1 = MultipleChoiceQuestionViewController_Anchor()
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
            self.tabBar.frame = CGRect(x: 0, y: self.NVC_height! * 2, width: self.tabBar.frame.size.width, height: self.NVC_height!)
            UITabBarItem.appearance().titlePositionAdjustment.vertical = (18 - self.NVC_height!) / 2
        } else {
            self.tabBar.frame = CGRect(x: 0, y: self.NVC_height!, width: self.tabBar.frame.size.width, height: self.NVC_height!)
            UITabBarItem.appearance().titlePositionAdjustment.vertical = 0
        }
   
        super.viewDidLayoutSubviews()
    }
}
