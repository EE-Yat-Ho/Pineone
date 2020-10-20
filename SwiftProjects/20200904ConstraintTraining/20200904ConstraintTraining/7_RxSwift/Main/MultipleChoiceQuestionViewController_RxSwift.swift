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
import RxDataSources

class MultipleChoiceQuestionViewController_RxSwift: UIViewController {
    var disposeBag = DisposeBag()
    
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
    
    let questionTextView = UITextView()
//        .then {
//        $0.text = MainRepository.shared.question
//    }
    let explanationTextView = UITextView()
//        .then {
//        $0.text = MainRepository.shared.explanation
//    }
    
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
    var answerList = [String]() // 텍스트 필드때매 써야함..
    let collectionItemSize = (UIScreen.main.bounds.size.width - 20) / 3
    
    let questionImagePicker = UIImagePickerController()
    let explanationImagePicker = UIImagePickerController()
    
    let answerRelay = BehaviorRelay<[String]>(value: [])
    let questionImageRelay = BehaviorRelay<[UIImage]>(value: [])
    let explanationImageRelay = BehaviorRelay<[UIImage]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        setLayout() // 레이아웃
        bindData() // RxSwift
        requestData()
    }
    
    deinit{
        print("RxSwift deinit")
        disposeBag = DisposeBag()
    }
}


