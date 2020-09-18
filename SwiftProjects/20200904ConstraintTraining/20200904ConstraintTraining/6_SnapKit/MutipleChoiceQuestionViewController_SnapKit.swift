//
//  MultipleChoiceQuestionViewController.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/09/04.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import UIKit
import SnapKit

class MultipleChoiceQuestionViewController_SnapKit: UIViewController {
    var inSelfViewViews: [UIView] = []
    var inScrollViewViews: [UIView] = []
    var inSubViewViews: [UIView] = []
    
    let scrollView = UIScrollView()
    let subView = UIView()
    
    let questionLabel: UILabel = {
        let questionLabel = UILabel()
        questionLabel.text = "문제"
        return questionLabel
    }()
    let answerLabel: UILabel = {
        let answerLabel = UILabel()
        answerLabel.text = "보기"
        return answerLabel
    }()
    let explanationLabel: UILabel = {
        let explanationLabel = UILabel()
        explanationLabel.text = "문제"
        return explanationLabel
    }()
    
    let cameraButton1: UIButton = {
        let cameraButton1 = UIButton()
        cameraButton1.setImage(UIImage(systemName: "camera"), for: .normal)
        return cameraButton1
    }()
    let cameraButton2: UIButton = {
        let cameraButton2 = UIButton()
            cameraButton2.setImage(UIImage(systemName: "camera"), for: .normal)
            return cameraButton2
    }()
    let plusButton: UIButton = {
        let plusButton = UIButton()
            plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
            return plusButton
    }()
    let completeButton: UIButton = {
        let completeButton = UIButton()
        completeButton.setTitle("완료", for: .normal)
        completeButton.backgroundColor = UIColor.systemBlue
        return completeButton
    }()
    
    let questionTextView: UITextView = {
        let questionTextView = UITextView()
        questionTextView.text = "1+1=?"
        return questionTextView
    }()
    let explanationTextView: UITextView = {
        let explanationTextView = UITextView()
        explanationTextView.text = "1. 1은 자연수이다.\n2. n이 자연수일 때, n의 계승자 n'는 자연수이다.\n3. n' = 1인 자연수 n은 없다.\n4. m' = n' 이면 m = n 이다.\n5. P(1)이 참이고 모든 자연수 k에 대해 P(k)가 참일 때, P(k')이 참이면 P는 모든 자연수에 대해 참이다.\n링크 : https://dimenchoi.tistory.com/16"
        return explanationTextView
    }()
    
    let questionCollectionView: UICollectionView = {
        let questionCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewLayout())
        let questionCollectionViewFlowLayout = UICollectionViewFlowLayout()
        questionCollectionViewFlowLayout.itemSize = CGSize(width: 110, height: 110)
        questionCollectionViewFlowLayout.minimumLineSpacing = 0
        questionCollectionView.collectionViewLayout = questionCollectionViewFlowLayout
        questionCollectionView.backgroundColor = UIColor.white
        return questionCollectionView
    }()
    lazy var explanationCollectionView: UICollectionView = {
        let explanationCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: customCollectionLayout())
        
        explanationCollectionView.backgroundColor = UIColor.white
        return explanationCollectionView
    }()
    
    func customCollectionLayout() -> UICollectionViewLayout{
        
        let explanationCollectionViewFlowLayout = UICollectionViewFlowLayout()
        explanationCollectionViewFlowLayout.itemSize = CGSize(width: 110, height: 110)
        explanationCollectionViewFlowLayout.minimumLineSpacing = 0
        
        return explanationCollectionViewFlowLayout
    }
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        configure() // delegate, dataSource, register
        makeViewArrays() // 어디에 들어가느냐에 따라나눈 뷰 배열 만들기
        setLayout() // ㅇㅇ
        bindData() // RsSwift 부분
    }
    
    func configure() {
        questionCollectionView.delegate = self
        questionCollectionView.dataSource = self
        questionCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        questionCollectionView.tag = 1
        
        explanationCollectionView.delegate = self
        explanationCollectionView.dataSource = self
        explanationCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        explanationCollectionView.tag = 2
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 43.5
    }
    
    func setupLayout() {
        
    }
    
    func bindData() {
        
    }
    
    func makeViewArrays(){
        inSelfViewViews.append(scrollView)
        inSelfViewViews.append(completeButton)
        
        inScrollViewViews.append(subView)
        
        inSubViewViews.append(questionLabel)
        inSubViewViews.append(cameraButton1)
        inSubViewViews.append(questionTextView)
        inSubViewViews.append(questionCollectionView)
        inSubViewViews.append(answerLabel)
        inSubViewViews.append(plusButton)
        inSubViewViews.append(tableView)
        inSubViewViews.append(explanationLabel)
        inSubViewViews.append(cameraButton2)
        inSubViewViews.append(explanationTextView)
        inSubViewViews.append(explanationCollectionView)
    }
    
    func setLayout(){
        // 모든 뷰 .addSubView 진행
        self.view.addSubviews(inSelfViewViews)
        scrollView.addSubviews(inScrollViewViews)
        subView.addSubviews(inSubViewViews)
//        addSubViews(parentsView: self.view, childViews: inSelfViewViews)
//        addSubViews(parentsView: scrollView, childViews: inScrollViewViews)
//        addSubViews(parentsView: subView, childViews: inSubViewViews)
        
        
        
        // 모든 뷰 오토 리사이징 끄기
        //autoResizingFalse(views: inSelfViewViews + inScrollViewViews + inSubViewViews)
        
        // 특정 뷰 테두리 그리기
        setBorder(instans: questionTextView, color: nil)
        setBorder(instans: questionCollectionView, color: nil)
        setBorder(instans: tableView, color: nil)
        setBorder(instans: explanationTextView, color: nil)
        setBorder(instans: explanationCollectionView, color: nil)
        setBorder(instans: completeButton, color: UIColor.systemBlue)
        
        // 제약사항 추가 쭉
        addConstraint()
    }
    
    func addSubViews(parentsView: UIView, childViews: [UIView]){
        for childView in childViews {
            parentsView.addSubview(childView)
        }
    }
    
//    func autoResizingFalse(views: [UIView]){
//        for someView in views {
//            someView.translatesAutoresizingMaskIntoConstraints = false
//        }
//    }
    
    func setBorder(instans: AnyObject, color: UIColor?){
        if color == nil {
            instans.layer.borderColor = UIColor(displayP3Red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0).cgColor
        } else {
            instans.layer.borderColor = color?.cgColor
        }
        instans.layer.borderWidth = 1.0
        instans.layer.cornerRadius = 5.0
    }
    
    func addConstraint(){
        scrollView.snp.makeConstraints{ $0.edges.equalTo(self.view.safeAreaLayoutGuide) }
        
        subView.snp.makeConstraints{
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide.snp.width) }
        
        questionLabel.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 30).isActive = true
        questionLabel.topAnchor.constraint(equalTo: subView.topAnchor, constant: 55).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        questionLabel.snp.makeConstraints{
            $0.leading.equalTo(subView.snp.leading).offset(30)
            $0.top.equalTo(subView.snp.top).offset(55)
            $0.height.equalTo(20) }
        
        cameraButton1.snp.makeConstraints{
            $0.trailing.equalTo(subView.snp.trailing).offset(-30)
            $0.top.equalTo(subView.snp.top).offset(50)
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
        
        questionTextView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(cameraButton1.snp.bottom).offset(5)
            $0.height.equalTo(130) }
        
        questionCollectionView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(questionTextView.snp.bottom).offset(5)
            $0.height.equalTo(110) }
        
        answerLabel.snp.makeConstraints{
            $0.leading.equalTo(subView.snp.leading).offset(30)
            $0.top.equalTo(questionCollectionView.snp.bottom).offset(10)
            $0.height.equalTo(20) }
        
        plusButton.snp.makeConstraints{
            $0.trailing.equalTo(subView.snp.trailing).offset(-30)
            $0.top.equalTo(questionCollectionView.snp.bottom).offset(5)
            $0.height.equalTo(30)
            $0.width.equalTo(30) }
        
        tableView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(plusButton.snp.bottom).offset(5)
            $0.height.equalTo(217.5) }
        
        explanationLabel.snp.makeConstraints{
            $0.leading.equalTo(subView.snp.leading).offset(30)
            $0.top.equalTo(tableView.snp.bottom).offset(10)
            $0.height.equalTo(20) }
        
        cameraButton2.snp.makeConstraints{
            $0.trailing.equalTo(subView.snp.trailing).offset(-30)
            $0.top.equalTo(tableView.snp.bottom).offset(5)
            $0.height.equalTo(30)
            $0.width.equalTo(30) }
        
        explanationTextView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(cameraButton2.snp.bottom).offset(5)
            $0.height.equalTo(130) }
        
        explanationCollectionView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(explanationTextView.snp.bottom).offset(5)
            $0.bottom.equalTo(subView.snp.bottom).offset(-100)
            $0.height.equalTo(110) }
        
        completeButton.snp.makeConstraints{
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(0)
            $0.height.equalTo(60) }
    }
}

extension MultipleChoiceQuestionViewController_SnapKit: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        let imageView = UIImageView()
        cell.contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: cell.contentView.leftAnchor, constant: 5).isActive = true
        imageView.rightAnchor.constraint(equalTo: cell.contentView.rightAnchor, constant: -5).isActive = true
        imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 5).isActive = true
        imageView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -5).isActive = true
        
        if collectionView.tag == 1 {
            imageView.image = UIImage(systemName: "paperplane")
            imageView.tintColor = UIColor.systemGreen
            imageView.backgroundColor = UIColor.systemBlue
        } else {
            imageView.image = UIImage(systemName: "tray.fill")
            imageView.tintColor = UIColor.black
            imageView.backgroundColor = UIColor.systemYellow
        }
        
        return cell
    }
    
    
}

extension MultipleChoiceQuestionViewController_SnapKit: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let exampleNumber: UIImageView = {
            let exampleNumber = UIImageView()
            exampleNumber.image = UIImage(systemName: String(indexPath.row + 1) + ".circle")
            return exampleNumber
        }()
        let answerTextField: UITextField = {
            let answerTextField = UITextField()
            answerTextField.text = String(indexPath.row + 1)
            setBorder(instans: answerTextField, color: nil)
            answerTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: answerTextField.frame.height))
            answerTextField.leftViewMode = .always
            return answerTextField
        }()
        let incorrectOrCorrect: UILabel = {
            let incorrectOrCorrect = UILabel()
            if indexPath.row == 1 {
                incorrectOrCorrect.text = "정답"
                setBorder(instans: incorrectOrCorrect, color: UIColor.systemGreen)
                incorrectOrCorrect.textColor = UIColor.systemGreen
            } else {
                incorrectOrCorrect.text = "오답"
                setBorder(instans: incorrectOrCorrect, color: UIColor.systemRed)
                incorrectOrCorrect.textColor = UIColor.systemRed
            }
            return incorrectOrCorrect
        }()
        let xButton: UIButton = {
            let xButton = UIButton()
            xButton.setImage(UIImage(systemName: "xmark"), for: .normal)
            return xButton
        }()
        
        cell.contentView.addSubview(exampleNumber)
        cell.contentView.addSubview(answerTextField)
        cell.contentView.addSubview(incorrectOrCorrect)
        cell.contentView.addSubview(xButton)
        
        exampleNumber.translatesAutoresizingMaskIntoConstraints = false
        answerTextField.translatesAutoresizingMaskIntoConstraints = false
        incorrectOrCorrect.translatesAutoresizingMaskIntoConstraints = false
        xButton.translatesAutoresizingMaskIntoConstraints = false
        
        exampleNumber.leftAnchor.constraint(equalTo: cell.contentView.leftAnchor, constant: 10).isActive = true
        exampleNumber.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor).isActive = true
        exampleNumber.heightAnchor.constraint(equalToConstant: 30).isActive = true
        exampleNumber.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        answerTextField.leftAnchor.constraint(equalTo: exampleNumber.rightAnchor, constant: 10).isActive = true
        answerTextField.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor).isActive = true
        answerTextField.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        incorrectOrCorrect.leftAnchor.constraint(equalTo: answerTextField.rightAnchor, constant: 10).isActive = true
        incorrectOrCorrect.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor).isActive = true
        
        xButton.leftAnchor.constraint(equalTo: incorrectOrCorrect.rightAnchor,constant: 10).isActive = true
        xButton.rightAnchor.constraint(equalTo: cell.contentView.rightAnchor,constant: -10).isActive = true
        xButton.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor).isActive = true
        xButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        xButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        return cell
    }
}


extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }

}
