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
        let questionTabBarController = UIStoryboard.init(name: "Storyboard", bundle: nil).instantiateViewController(withIdentifier: "QuestionTabBarController_StoryBoard") as! QuestionTabBarController_StoryBoard
        self.navigationController?.pushViewController(questionTabBarController, animated: true)
    }
    @IBAction func NSLayoutButtonClick(_ sender: Any) {
        let questionTabBarController = QuestionTabBarController()
        questionTabBarController.VCNumber = 2
        self.navigationController?.pushViewController(questionTabBarController, animated: true)
    }
    @IBAction func VisualFormatButtonClick(_ sender: Any) {
        let questionTabBarController = QuestionTabBarController()
        questionTabBarController.VCNumber = 3
        self.navigationController?.pushViewController(questionTabBarController, animated: true)
    }
    @IBAction func NSLayoutVisualFormatButtonClick(_ sender: Any) {
        let questionTabBarController = QuestionTabBarController()
        questionTabBarController.VCNumber = 4
        self.navigationController?.pushViewController(questionTabBarController, animated: true)
    }
    @IBAction func AnchorButtonClick(_ sender: Any) {
        let questionTabBarController = QuestionTabBarController()
        questionTabBarController.VCNumber = 5
        self.navigationController?.pushViewController(questionTabBarController, animated: true)
    }
    @IBAction func SnapKitButtonClick(_ sender: Any) {
        let questionTabBarController = QuestionTabBarController()
        questionTabBarController.VCNumber = 6
        self.navigationController?.pushViewController(questionTabBarController, animated: true)
    }
    @IBAction func RxSwiftMVVMButtonClick(_ sender: Any) {
        let questionTabBarController = QuestionTabBarController()
        questionTabBarController.VCNumber = 7
        self.navigationController?.pushViewController(questionTabBarController, animated: true)
    }
}

