//
//  QuestionTabBarController.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/09/04.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import UIKit

class QuestionTabBarController_AutoResizingMask: UITabBarController, UITabBarControllerDelegate{
    var NVC_height: CGFloat?
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 탭바 컨트롤러 전체에 대한 설정. 원래 뷰 디드로드에서 했었는데 안되네 호오..
        NVC_height = (self.navigationController?.navigationBar.frame.size.height)!
        let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        UITabBarItem.appearance().titlePositionAdjustment.vertical = 9 - NVC_height! / 2
        
        // 객관식 만들기 화면 설정
        let item1 = MultipleChoiceQuestionViewController_AutoResizingMask()
        item1.tabBarItem.title = "객관식 만들기"
        
        
        // 주관식 만들기 화면 설정
        let item2 = UIViewController()
        item2.tabBarItem.title = "주관식 만들기"
        
        let controllers = [item1, item2]
        self.viewControllers = controllers
    }
    
    override func viewDidLayoutSubviews() {
        // 탭바 상단에 위치
        tabBar.frame = CGRect(x: 0, y: NVC_height! * 2, width: tabBar.frame.size.width, height: NVC_height!)
        super.viewDidLayoutSubviews()
    }
}
