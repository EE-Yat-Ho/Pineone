//
//  ViewController.swift
//  내사랑2
//
//  Created by 박영호 on 2020/11/24.
//

import UIKit

protocol SendDelegate {
    func Send(data: Int)
}

class SendViewController: UIViewController {

    var delegate: SendDelegate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

