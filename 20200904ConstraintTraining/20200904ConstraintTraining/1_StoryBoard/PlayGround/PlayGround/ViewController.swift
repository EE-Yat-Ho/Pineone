//
//  ViewController.swift
//  PlayGround
//
//  Created by 박영호 on 2020/09/09.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let someView: UIView = {
        let parentsView = UIView()
        parentsView.backgroundColor = UIColor.green
        return parentsView
    }()
let childView: UIView = {
    let childView = UIView()
    childView.backgroundColor = UIColor.red
    childView.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
    childView.autoresizingMask = UIView.AutoresizingMask(rawValue: 63)
    return childView
}()
//    var parentsViewHeightConstraint: NSLayoutConstraint?
//    var parentsViewWidthConstraint: NSLayoutConstraint?
//
//    let parentsViewSizeUpButton: UIButton = {
//        let parentsViewSizeUpButton = UIButton()
//        parentsViewSizeUpButton.backgroundColor = UIColor.blue
//        parentsViewSizeUpButton.setTitle("Up", for: .normal)
//        parentsViewSizeUpButton.addTarget(self, action: #selector(parentsViewSizeUpButtonAction), for: .touchUpInside)
//        return parentsViewSizeUpButton
//    }()
//    let parentsViewSizeDownButton: UIButton = {
//        let parentsViewSizeUpButton = UIButton()
//        parentsViewSizeUpButton.backgroundColor = UIColor.blue
//        parentsViewSizeUpButton.setTitle("Down", for: .normal)
//        parentsViewSizeUpButton.addTarget(self, action: #selector(parentsViewSizeDownButtonAction), for: .touchUpInside)
//        return parentsViewSizeUpButton
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    func setupLayout(){
        view.addSubview(someView)
        //parentsView.addSubview(childView)
        //view.addSubview(parentsViewSizeUpButton)
        //view.addSubview(parentsViewSizeDownButton)
        
        //parentsViewSizeUpButton.translatesAutoresizingMaskIntoConstraints = false
        //parentsViewSizeDownButton.translatesAutoresizingMaskIntoConstraints = false
        
        //childView.translatesAutoresizingMaskIntoConstraints = false
        
someView.translatesAutoresizingMaskIntoConstraints = false
someView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
someView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
someView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
someView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
//        parentsViewSizeUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
//        parentsViewSizeUpButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -15).isActive = true
//        parentsViewSizeUpButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
//        parentsViewSizeUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//
//        parentsViewSizeDownButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 15).isActive = true
//        parentsViewSizeDownButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
//        parentsViewSizeDownButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
//        parentsViewSizeDownButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//
//        parentsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
//        parentsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
//        parentsView.topAnchor.constraint(equalTo: parentsViewSizeUpButton.bottomAnchor, constant: 30).isActive = true
//        parentsViewHeightConstraint = parentsView.heightAnchor.constraint(equalToConstant: 150)
//        parentsViewHeightConstraint?.isActive = true
//
//        childView.centerXAnchor.constraint(equalTo: parentsView.centerXAnchor).isActive = true
//        childView.centerYAnchor.constraint(equalTo: parentsView.centerYAnchor).isActive = true
//        childView.leadingAnchor.constraint(equalTo: parentsView.leadingAnchor, constant: 50).isActive = true
//        childView.topAnchor.constraint(equalTo: parentsView.topAnchor, constant: 50).isActive = true
    }
    
//    @objc func parentsViewSizeUpButtonAction(sender: UIButton!){
//        let nowParentsHeight = parentsView.frame.height
//        parentsViewHeightConstraint?.isActive = false
//        parentsViewHeightConstraint = parentsView.heightAnchor.constraint(equalToConstant: nowParentsHeight + 10)
//        parentsViewHeightConstraint?.isActive = true
//    }
//    @objc func parentsViewSizeDownButtonAction(sender: UIButton!){
//        let nowParentsHeight = parentsView.frame.height
//        parentsViewHeightConstraint?.isActive = false
//        parentsViewHeightConstraint = parentsView.heightAnchor.constraint(equalToConstant: nowParentsHeight - 10)
//        parentsViewHeightConstraint?.isActive = true
//    }
}

