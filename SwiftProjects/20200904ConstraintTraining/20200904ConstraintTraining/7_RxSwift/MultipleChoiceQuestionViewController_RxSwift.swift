//
//  MultipleChoiceQuestionViewController.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/09/04.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import NSObject_Rx

class MultipleChoiceQuestionViewController_RxSwift: UIViewController {
    var inSelfViewViews: [UIView] = []
    var inScrollViewViews: [UIView] = []
    var inSubViewViews: [UIView] = []
    
    let scrollView = UIScrollView()
    let subView = UIView()
    
    let questionLabel = UILabel().then{
        $0.text = "문제"
    }
    let answerLabel = UILabel().then {
        $0.text = "보기"
    }
    let explanationLabel = UILabel().then {
        $0.text = "문제"
    }
    let cameraButton1 = UIButton().then {
        $0.setImage(UIImage(systemName: "camera"), for: .normal)
        $0.tag = 1
        $0.addTarget(self, action: #selector(addImage), for: .touchUpInside)
    }
    let cameraButton2 = UIButton().then {
        $0.setImage(UIImage(systemName: "camera"), for: .normal)
        $0.tag = 2
        $0.addTarget(self, action: #selector(addImage), for: .touchUpInside)
    }
    let plusButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.addTarget(self, action: #selector(addAnswer), for: .touchUpInside)
    }
    let completeButton = UIButton().then{
        $0.setTitle("완료", for: .normal)
        $0.backgroundColor = UIColor.systemBlue
        $0.addTarget(self, action: #selector(complete), for: .touchUpInside)
    }
    let questionTextView = UITextView().then {
        $0.text = MainRepository.shared.question
    }
    let explanationTextView = UITextView().then {
        $0.text = MainRepository.shared.explanation
    }
    
    let questionCollectionView = UICollectionView(
        frame: CGRect(x: 0, y: 0, width: 0, height: 0),
        collectionViewLayout: UICollectionViewFlowLayout().then {
            let collectionItemSize = (UIScreen.main.bounds.size.width - 20) / 3
            $0.itemSize = CGSize(width: collectionItemSize, height: collectionItemSize)
            $0.minimumInteritemSpacing = 0
            $0.minimumLineSpacing = 0
        }).then {
        $0.backgroundColor = UIColor.white
        $0.tag = 1
    }
    let explanationCollectionView = UICollectionView(
        frame: CGRect(x: 0, y: 0, width: 0, height: 0),
        collectionViewLayout: UICollectionViewFlowLayout().then {
            let collectionItemSize = (UIScreen.main.bounds.size.width - 20) / 3
            $0.itemSize = CGSize(width: collectionItemSize, height: collectionItemSize)
            $0.minimumInteritemSpacing = 0
            $0.minimumLineSpacing = 0
        }).then {
        $0.backgroundColor = UIColor.white
        $0.tag = 2
    }
    
    let tableView = UITableView()
    let imagePicker = UIImagePickerController()
    var imageButtonTag: Int!
    var questionImageList = MainRepository.shared.questionImageList
    var explanationImageList = MainRepository.shared.explanationImageList
    let collectionItemSize = (UIScreen.main.bounds.size.width - 20) / 3
    var answerList = MainRepository.shared.answerList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        configure() // delegate, dataSource, register
        setLayout() // ㅇㅇ
        bindData() // RxSwift 부분
    }
    
    func configure() {
        questionCollectionView.delegate = self
        questionCollectionView.dataSource = self
        questionCollectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        questionCollectionView.tag = 1
        
        explanationCollectionView.delegate = self
        explanationCollectionView.dataSource = self
        explanationCollectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        explanationCollectionView.tag = 2
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableCell.self, forCellReuseIdentifier: "TableCell")
        tableView.rowHeight = 43.5
        tableView.allowsSelection = false
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
        makeViewArrays() // 어디에 들어가느냐에 따라나눈 뷰 배열 만들기
        
        // 모든 뷰 .addSubView 진행
        self.view.addSubviews(inSelfViewViews)
        scrollView.addSubviews(inScrollViewViews)
        subView.addSubviews(inSubViewViews)

        // 특정 뷰 테두리 그리기
        questionTextView.setBorder(nil)
        questionCollectionView.setBorder(nil)
        tableView.setBorder(nil)
        explanationTextView.setBorder(nil)
        explanationCollectionView.setBorder(nil)
        completeButton.setBorder(UIColor.systemBlue)
        
        // 제약사항 추가
        addConstraint()
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
            if questionImageList.count == 0 {
                $0.height.equalTo(10)
            } else {
                $0.height.equalTo(CGFloat((questionImageList.count + 2) / 3) * collectionItemSize)
            }
        }
        
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
            if answerList.count == 0 {
                $0.height.equalTo(10)
            } else {
                $0.height.equalTo(43.5 * CGFloat(answerList.count))
            }
        }
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
            if explanationImageList.count == 0 {
                $0.height.equalTo(10)
            } else {
                $0.height.equalTo(CGFloat((explanationImageList.count + 2) / 3) * collectionItemSize)
            }
        }
        completeButton.snp.makeConstraints{
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(0)
            $0.height.equalTo(60) }
    }
    
    @objc func complete() {
        MainRepository.shared.question = questionTextView.text
        MainRepository.shared.explanation = explanationTextView.text
        MainRepository.shared.answerList = answerList
        MainRepository.shared.questionImageList = questionImageList
        MainRepository.shared.explanationImageList = explanationImageList
        navigationController?.popViewController(animated: true)
    }
}

extension MultipleChoiceQuestionViewController_RxSwift: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return questionImageList.count
        } else {
            return explanationImageList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        if collectionView.tag == 1 {
            cell.imageView.image = questionImageList[indexPath.row]
        } else {
            cell.imageView.image = explanationImageList[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        collectionView.deselectItem(at: indexPath, animated: true)
        if collectionView.tag == 1 {
            questionImageList.remove(at: indexPath.row)
            collectionReload(tag: 1)
        } else {
            explanationImageList.remove(at: indexPath.row)
            collectionReload(tag: 2)
        }
    }
    func collectionReload(tag: Int) {
        if tag == 1 {
            questionCollectionView.reloadData()
            if questionImageList.count == 0 {
                questionCollectionView.snp.updateConstraints{
                    $0.height.equalTo(10) }
            } else {
                questionCollectionView.snp.updateConstraints{
                    $0.height.equalTo(CGFloat((questionImageList.count + 2) / 3) * collectionItemSize) }
            }
        } else {
            explanationCollectionView.reloadData()
            if explanationImageList.count == 0 {
                explanationCollectionView.snp.updateConstraints{
                    $0.height.equalTo(10) }
            } else {
                explanationCollectionView.snp.updateConstraints{
                    $0.height.equalTo(CGFloat((explanationImageList.count + 2) / 3) * collectionItemSize) }
            }
        }
        
    }
}

extension MultipleChoiceQuestionViewController_RxSwift: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        cell.exampleNumber.image = UIImage(systemName: String(indexPath.row + 1) + ".circle")
        cell.answerTextField.text = answerList[indexPath.row]
        cell.answerTextField.delegate = self
        cell.xButton.addTarget(self, action: #selector(xButtonClick), for: .touchUpInside)
        return cell
    }
    
    @objc func addAnswer() {
        answerList.append("")
        tableReload()
    }
    
    @objc func xButtonClick(_ sender: UIButton) {
        let cell = sender.superview?.superview as! TableCell
        let indexPath = tableView.indexPath(for: cell)! as IndexPath
        answerList.remove(at: indexPath.row)
        tableReload()
    }
    func tableReload() {
        tableView.reloadData()
        if answerList.count == 0 {
            tableView.snp.updateConstraints{
                $0.height.equalTo(10) }
        } else {
            tableView.snp.updateConstraints{
                $0.height.equalTo(CGFloat(answerList.count) * 43.5) }
        }
    }
}

extension MultipleChoiceQuestionViewController_RxSwift: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @objc func addImage(_ sender: UIButton) {
        imageButtonTag = sender.tag
        self.openImagePicker()
    }
    func openImagePicker(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey :Any]){
        dismiss(animated: true, completion: nil)
        if let img = info[.originalImage] as? UIImage{
            if imageButtonTag == 1 {
                questionImageList.append(img)
                collectionReload(tag: 1)
                
            } else {
                explanationImageList.append(img)
                collectionReload(tag: 2)
            }
        }
    }
    
}

extension MultipleChoiceQuestionViewController_RxSwift: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let cell = textField.superview?.superview as! TableCell
        let indexPath = tableView.indexPath(for: cell)
        answerList[indexPath!.row] = textField.text!
    }
}
