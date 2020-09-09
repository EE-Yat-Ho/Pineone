//
//  ViewController.swift
//  PlayGround
//
//  Created by 박영호 on 2020/09/09.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import UIKit

class old1_ViewController: UIViewController {
    let parentsView: UIView = {
        let parentsView = UIView()
        parentsView.backgroundColor = UIColor.green
        parentsView.frame = CGRect(x: 150, y: 50, width: 150, height: 150)
        return parentsView
    }()
    let childView: UIView = {
        let childView = UIView()
        childView.backgroundColor = UIColor.red
        childView.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
        childView.autoresizingMask = UIView.AutoresizingMask(rawValue: 18)
        return childView
    }()
    let someView: UIView = {
        let someView = UIView()
        someView.backgroundColor = UIColor.red
        someView.frame = CGRect(x: 20, y: 20, width: 120, height: 80)
        return someView
    }()
    
    let parentsViewSizeUpButton: UIButton = {
        let parentsViewSizeUpButton = UIButton()
        parentsViewSizeUpButton.backgroundColor = UIColor.blue
        parentsViewSizeUpButton.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
        parentsViewSizeUpButton.setTitle("Up", for: .normal)
        parentsViewSizeUpButton.addTarget(self, action: #selector(parentsViewSizeUpButtonAction), for: .touchUpInside)
        return parentsViewSizeUpButton
    }()
    let parentsViewSizeDownButton: UIButton = {
        let parentsViewSizeUpButton = UIButton()
        parentsViewSizeUpButton.backgroundColor = UIColor.blue
        parentsViewSizeUpButton.frame = CGRect(x: 50, y: 110, width: 50, height: 50)
        parentsViewSizeUpButton.setTitle("Down", for: .normal)
        parentsViewSizeUpButton.addTarget(self, action: #selector(parentsViewSizeDownButtonAction), for: .touchUpInside)
        return parentsViewSizeUpButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    func setupLayout(){
        view.addSubview(parentsView)
        parentsView.addSubview(childView)
        view.addSubview(parentsViewSizeUpButton)
        view.addSubview(parentsViewSizeDownButton)
    }
    
    @objc func parentsViewSizeUpButtonAction(sender: UIButton!){
        self.parentsView.frame = CGRect(x: parentsView.frame.minX, y: parentsView.frame.minY, width: parentsView.frame.width + 10, height: parentsView.frame.height + 10)
    }
    @objc func parentsViewSizeDownButtonAction(sender: UIButton!){
        self.parentsView.frame = CGRect(x: parentsView.frame.minX, y: parentsView.frame.minY, width: parentsView.frame.width - 10, height: parentsView.frame.height - 10)
    }
}

