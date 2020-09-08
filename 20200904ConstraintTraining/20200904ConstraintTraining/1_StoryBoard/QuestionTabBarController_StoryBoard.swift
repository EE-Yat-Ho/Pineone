//
//  QuestionTabBarController.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/09/04.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import UIKit

class QuestionTabBarController_StoryBoard: UITabBarController {
    // ?? 아니 viewDidLayoutSubviews로 들어가니까 탭바 높이가 바뀌네;
    // 그리고 폰 기종마다 탭바 높이도 다른듯..
    // 걍 네비게이션바 높이 기준으로 정함.
    // 그리고 탭바 프레임 y좌표에 왜 하단 좌표가 들어가냐 원래 그런가? 아닌거같은데 
    var NVC_height: CGFloat?
    override func viewDidLoad() {
        NVC_height = (self.navigationController?.navigationBar.frame.size.height)!
        super.viewDidLoad()
        let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        UITabBarItem.appearance().titlePositionAdjustment.vertical = 9 - NVC_height! / 2
    }
    override func viewDidLayoutSubviews() {
        // 탭바 상단에 위치
        tabBar.frame = CGRect(x: 0, y: NVC_height! * 2, width: tabBar.frame.size.width, height: NVC_height!)
        super.viewDidLayoutSubviews()
    }
}
