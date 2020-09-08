//
//  MultipleChoiceQuestionViewController.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/09/04.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import UIKit



class MultipleChoiceQuestionViewController_NSLayout_VisualFormat: UIViewController {
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
    let explanationCollectionView: UICollectionView = {
        let explanationCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewLayout())
        let explanationCollectionViewFlowLayout = UICollectionViewFlowLayout()
        explanationCollectionViewFlowLayout.itemSize = CGSize(width: 110, height: 110)
        explanationCollectionViewFlowLayout.minimumLineSpacing = 0
        explanationCollectionView.collectionViewLayout = explanationCollectionViewFlowLayout
        explanationCollectionView.backgroundColor = UIColor.white
        return explanationCollectionView
    }()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
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
        
        makeViewArrays() // 어디에 들어가느냐에 따라나눈 뷰 배열 만들기
        setLayout()
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
        addSubViews(parentsView: self.view, childViews: inSelfViewViews)
        addSubViews(parentsView: scrollView, childViews: inScrollViewViews)
        addSubViews(parentsView: subView, childViews: inSubViewViews)
        
        // 모든 뷰 오토 리사이징 끄기
        autoResizingFalse(views: inSelfViewViews + inScrollViewViews + inSubViewViews)
        
        // 특정 뷰 테두리 그리기
        setBorder(instans: questionTextView, color: nil)
        setBorder(instans: questionCollectionView, color: nil)
        setBorder(instans: tableView, color: nil)
        setBorder(instans: explanationTextView, color: nil)
        setBorder(instans: explanationCollectionView, color: nil)
        setBorder(instans: completeButton, color: UIColor.systemBlue)
        
        // Anchor기반 제약사항 추가 쭉
        addConstraintUseAnchor()
    }
    
    func addSubViews(parentsView: UIView, childViews: [UIView]){
        for childView in childViews {
            parentsView.addSubview(childView)
        }
    }
    
    func autoResizingFalse(views: [UIView]){
        for someView in views {
            someView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setBorder(instans: AnyObject, color: UIColor?){
        if color == nil {
            instans.layer.borderColor = UIColor(displayP3Red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0).cgColor
        } else {
            instans.layer.borderColor = color?.cgColor
        }
        instans.layer.borderWidth = 1.0
        instans.layer.cornerRadius = 5.0
    }
    
    func addConstraintUseAnchor(){
        var constraints:[NSLayoutConstraint] = []
        let views = ["cameraButton1": cameraButton1, "questionTextView": questionTextView, "questionCollectionView":questionCollectionView, "plusButton": plusButton, "tableView": tableView, "cameraButton2":cameraButton2, "explanationTextView":explanationTextView, "explanationCollectionView":explanationCollectionView]

        NSLayoutConstraint(item: scrollView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal,
                           toItem: self.view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: scrollView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal,
                           toItem: self.view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: scrollView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal,
                           toItem: self.view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: scrollView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal,
                           toItem: self.view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0).isActive = true

        NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal,
                           toItem: scrollView.contentLayoutGuide, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal,
                           toItem: scrollView.contentLayoutGuide, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal,
                           toItem: scrollView.contentLayoutGuide, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal,
                           toItem: scrollView.contentLayoutGuide, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal,
                           toItem: scrollView.frameLayoutGuide, attribute: NSLayoutConstraint.Attribute.width , multiplier: 1, constant: 0).isActive = true
        
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-55-[questionLabel(20)]", options: [], metrics: nil, views: ["questionLabel": questionLabel]))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[questionCollectionView]-10-[answerLabel(20)]", options: [], metrics: nil, views: ["questionCollectionView":questionCollectionView, "answerLabel": answerLabel]))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[tableView]-10-[explanationLabel(20)]", options: [], metrics: nil, views: ["tableView":tableView, "explanationLabel": explanationLabel]))
        
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[questionLabel]", options: [], metrics: nil, views: ["questionLabel": questionLabel]))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[answerLabel]", options: [], metrics: nil, views: ["answerLabel": answerLabel]))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[explanationLabel]", options: [], metrics: nil, views: ["explanationLabel": explanationLabel]))
        
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:[cameraButton1(30)]-30-|", options: [], metrics: nil, views: ["cameraButton1": cameraButton1]))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:[plusButton(30)]-30-|", options: [], metrics: nil, views: ["plusButton": plusButton]))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:[cameraButton2(30)]-30-|", options: [], metrics: nil, views: ["cameraButton2": cameraButton2]))
        
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[questionTextView]-10-|", options: [], metrics: nil, views: ["questionTextView": questionTextView]))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[questionCollectionView]-10-|", options: [], metrics: nil, views: ["questionCollectionView": questionCollectionView]))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[tableView]-10-|", options: [], metrics: nil, views: ["tableView": tableView]))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[explanationTextView]-10-|", options: [], metrics: nil, views: ["explanationTextView": explanationTextView]))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[explanationCollectionView]-10-|", options: [], metrics: nil, views: ["explanationCollectionView": explanationCollectionView]))
        
        constraints.append(contentsOf:NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[cameraButton1(30)]-5-[questionTextView(130)]-5-[questionCollectionView(110)]-5-[plusButton(30)]-5-[tableView(217.5)]-5-[cameraButton2(30)]-5-[explanationTextView(130)]-5-[explanationCollectionView(110)]-100-|", options: [], metrics: nil, views: views))
        
        constraints.append(contentsOf:NSLayoutConstraint.constraints(withVisualFormat: "V:[completeButton(60)]-40-|", options: [], metrics: nil, views: ["completeButton": completeButton]))
        constraints.append(contentsOf:NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[completeButton]-10-|", options: [], metrics: nil, views: ["completeButton": completeButton]))
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension MultipleChoiceQuestionViewController_NSLayout_VisualFormat: UICollectionViewDelegate, UICollectionViewDataSource {
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

extension MultipleChoiceQuestionViewController_NSLayout_VisualFormat: UITableViewDelegate, UITableViewDataSource {
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
