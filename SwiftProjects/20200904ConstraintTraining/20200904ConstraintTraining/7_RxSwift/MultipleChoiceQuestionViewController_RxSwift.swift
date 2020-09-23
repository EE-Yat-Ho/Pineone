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
    }
    let cameraButton2 = UIButton().then {
        $0.setImage(UIImage(systemName: "camera"), for: .normal)
        $0.tag = 2
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
    var answerList = MainRepository.shared.answerList
    let collectionItemSize = (UIScreen.main.bounds.size.width - 20) / 3
    
    var disposeBag = DisposeBag()
    lazy var answerRelay = BehaviorRelay<[String]>(value: answerList)
    lazy var questionImageRelay = BehaviorRelay<[UIImage]>(value: questionImageList)
    lazy var explanationImageRelay = BehaviorRelay<[UIImage]>(value: explanationImageList)
    var imagePickerRelay: BehaviorRelay<UIImage>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        configure() // 설정
        setLayout() // 레이아웃
        bindData() // RxSwift 부분
    }
    
    func configure() {
        questionCollectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        
        explanationCollectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        
        tableView.register(TableCell.self, forCellReuseIdentifier: "TableCell")
        tableView.rowHeight = 43.5
        tableView.allowsSelection = false
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
    
    func bindData() {
       
        
        bindTableView()
        bindCollectionView()
        bindButtons()
    }
    
    func bindButtons() {
        plusButton.rx.tap.bind{ [weak self] in
            self?.addAnswerTap()
        }.disposed(by:disposeBag)
        
        completeButton.rx.tap.bind{ [weak self] in
            self?.completeTap()
        }.disposed(by:disposeBag)
        
//        cameraButton1.rx.tap.subscribe{ [weak self] event in
//            self?.addImageTap(self!.cameraButton1)
//            switch event {
//            case .next:
//                print("next")
//            case .completed:
//                print("completed")
//            case .error(_):
//                print("Error")
//            }
//        }.disposed(by:disposeBag)
        
        cameraButton1.rx.tap.flatMapLatest{ [weak self] _ in
            return UIImagePickerController.rx.createWithParent(self) { picker in
                picker.sourceType = .photoLibrary
                picker.allowsEditing = false
            }
            .flatMap { $0.rx.didFinishPickingMediaWithInfo }
            .take(1)
        }.subscribe(onNext: { (info) in
            print(info)
        }, onError: { (err) in
            print(err.localizedDescription)
        }, onCompleted: {
            print("completed")
        }) {
            print("disposed")
        }.disposed(by: disposeBag)
        
        cameraButton2.rx.tap.bind{ [weak self] in
            self?.addImageTap(self!.cameraButton2)
        }.disposed(by:disposeBag)
    }
    
    deinit{
        print("RxSwift deinit")
    }
}


