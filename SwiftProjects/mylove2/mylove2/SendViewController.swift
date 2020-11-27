//
//  ViewController.swift
//  mylove2
//
//  Created by 박영호 on 2020/11/24.
//

import UIKit

class SendViewController: UIViewController {
    @IBOutlet weak var cnt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SendViewController: GetDelegate {
    func get() -> Int {
        return Int(cnt.text!) ?? 0
    }
}
