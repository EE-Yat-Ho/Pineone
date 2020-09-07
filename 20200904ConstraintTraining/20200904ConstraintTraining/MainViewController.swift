//
//  ViewController.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/09/04.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func StoryBoardButtonClick(_ sender: Any) {
        let questionTabBarController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QuestionTabBarController_StoryBoard") as! QuestionTabBarController_StoryBoard
        self.navigationController?.pushViewController(questionTabBarController, animated: true)
    }
    
    @IBAction func AnchorButtonClick(_ sender: Any) {
        let questionTabBarController = QuestionTabBarController_Anchor()
        self.navigationController?.pushViewController(questionTabBarController, animated: true)
    }
    
    @IBAction func AutoResizingMaskButtonClick(_ sender: Any) {
        let questionTabBarController = QuestionTabBarController_AutoResizingMask()
        self.navigationController?.pushViewController(questionTabBarController, animated: true)
    }

}

