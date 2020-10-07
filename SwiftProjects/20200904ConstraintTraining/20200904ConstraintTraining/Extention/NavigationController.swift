////
////  NavigationController.swift
////  20200904ConstraintTraining
////
////  Created by 박영호 on 2020/10/06.
////  Copyright © 2020 Park young ho. All rights reserved.
////
//
//import UIKit
//
//class NavigationController: UINavigationController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//    
//    override var shouldAutorotate: Bool {
//        return (self.topViewController?.shouldAutorotate)!
//    }
//    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return (self.topViewController?.supportedInterfaceOrientations)!
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
