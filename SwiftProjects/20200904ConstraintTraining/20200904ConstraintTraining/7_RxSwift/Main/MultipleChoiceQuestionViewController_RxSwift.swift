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
        $0.text = "풀이"
    }
    
    let questionCameraButton = UIButton().then {
        $0.setImage(UIImage(systemName: "camera"), for: .normal)
    }
    let explanationCameraButton = UIButton().then {
        $0.setImage(UIImage(systemName: "camera"), for: .normal)
    }
    let plusButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
    }
    let completeButton = UIButton().then{
        $0.setTitle("완료", for: .normal)
        $0.backgroundColor = UIColor.systemBlue
    }
    
    let questionTextView = UITextView().then {
        $0.text = MainRepository.shared.question
    }
    let explanationTextView = UITextView().then {
        $0.text = MainRepository.shared.explanation
    }
    
    lazy var questionCollectionView = UICollectionView(
        frame: CGRect(x: 0, y: 0, width: 0, height: 0),
        collectionViewLayout: UICollectionViewFlowLayout().then {
            $0.itemSize = CGSize(width: collectionItemSize, height: collectionItemSize)
            $0.minimumInteritemSpacing = 0
            $0.minimumLineSpacing = 0
        }).then {
        $0.backgroundColor = UIColor.white
        $0.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
    }
    lazy var explanationCollectionView = UICollectionView(
        frame: CGRect(x: 0, y: 0, width: 0, height: 0),
        collectionViewLayout: UICollectionViewFlowLayout().then {
            $0.itemSize = CGSize(width: collectionItemSize, height: collectionItemSize)
            $0.minimumInteritemSpacing = 0
            $0.minimumLineSpacing = 0
        }).then {
        $0.backgroundColor = UIColor.white
        $0.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
    }
    
    let tableView = UITableView().then {
        $0.rowHeight = 43.5
        $0.allowsSelection = false
        $0.register(TableCell.self, forCellReuseIdentifier: "TableCell")
    }
    
    var questionImageList = MainRepository.shared.questionImageList
    var explanationImageList = MainRepository.shared.explanationImageList
    var answerList = MainRepository.shared.answerList
    
    let collectionItemSize = (UIScreen.main.bounds.size.width - 20) / 3
    
    let questionImagePicker = UIImagePickerController()
    let explanationImagePicker = UIImagePickerController()
    
    lazy var answerRelay = BehaviorRelay<[String]>(value: answerList)
    lazy var questionImageRelay = BehaviorRelay<[UIImage]>(value: questionImageList)
    lazy var explanationImageRelay = BehaviorRelay<[UIImage]>(value: explanationImageList)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        setLayout() // 레이아웃
        bindData() // RxSwift
    }
    
    func setLayout(){
        makeViewArrays() // 어디에 들어가느냐에 따라나눈 뷰 배열 만들기
        
        // 모든 뷰 .addSubView 진행
        self.view.addSubviews(inSelfViewViews)
        scrollView.addSubviews(inScrollViewViews)
        subView.addSubviews(inSubViewViews)

        // 특정 뷰 테두리 그리기
        questionTextView.setBorder()
        questionCollectionView.setBorder()
        tableView.setBorder()
        explanationTextView.setBorder()
        explanationCollectionView.setBorder()
        completeButton.setBorder(UIColor.systemBlue)
        
        // 제약사항 추가
        addConstraint()
    }
    
    func bindData() {
        bindQuestionCameraButton()
        bindQuestionImagePickerController()
        bindQuestionCollectionView()
        bindPlusButton()
        bindTableView()
        bindExplanationCameraButton()
        bindExplanationImagePickerController()
        bindExplanationCollectionView()
        bindCompleteButton()
    }
    
    
    // 아뉘 왜안되누
    deinit{
        print("RxSwift deinit")
    }
}


