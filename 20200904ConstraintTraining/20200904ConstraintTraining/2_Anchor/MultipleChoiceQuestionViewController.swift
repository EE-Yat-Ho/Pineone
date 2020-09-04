//
//  MultipleChoiceQuestionViewController.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/09/04.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import UIKit

class MultipleChoiceQuestionViewController: UIViewController {
    let scrollView = UIScrollView()
    let subView = UIView()
    let label1 = UILabel() // 문제
    let cameraButton1 = UIButton()
    let questionTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leftAnchor.constraint(equalTo: super.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: super.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: super.view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: super.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        scrollView.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor).isActive = true
        subView.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor).isActive = true
        subView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        subView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        subView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true
        
        subView.addSubview(label1)
        label1.text = "문제"
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        label1.leftAnchor.constraint(equalTo: subView.leftAnchor, constant: 30).isActive = true
        label1.topAnchor.constraint(equalTo: subView.topAnchor, constant: 55).isActive = true
        
        subView.addSubview(cameraButton1)
        cameraButton1.setImage(UIImage(systemName: "camera"), for: .normal)
        cameraButton1.translatesAutoresizingMaskIntoConstraints = false
        cameraButton1.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        cameraButton1.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        cameraButton1.rightAnchor.constraint(equalTo: subView.rightAnchor, constant: -30).isActive = true
        cameraButton1.topAnchor.constraint(equalTo: subView.topAnchor, constant: 50).isActive = true
        
        subView.addSubview(questionTextView)
        questionTextView.text = "1+1=?"
        //questionTextView.translatesAutoresizingMaskIntoConstraints = false
        //questionTextView.leftAnchor
        //
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
