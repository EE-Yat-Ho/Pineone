//
//  MVVMView.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/10/06.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class MVVMView: UIView {
    typealias Model = Void
    
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
    
    let questionTextView = UITextView().then {
        $0.text = MainRepository.shared.dataForScene.question
    }
    let explanationTextView = UITextView().then {
        $0.text = MainRepository.shared.dataForScene.explanation
    }
    
    lazy var questionCollectionView = UICollectionView(
        frame: CGRect(x: 0, y: 0, width: 0, height: 0),
        collectionViewLayout: UICollectionViewFlowLayout().then {
            $0.itemSize = CGSize(width: collectionItemSize, height: collectionItemSize)
            $0.minimumInteritemSpacing = 0
            $0.minimumLineSpacing = 0
        }).then {
        $0.backgroundColor = UIColor.white
        $0.register(MVVMCollectionCell.self, forCellWithReuseIdentifier: "MVVMCollectionCell")
    }
    lazy var explanationCollectionView = UICollectionView(
        frame: CGRect(x: 0, y: 0, width: 0, height: 0),
        collectionViewLayout: UICollectionViewFlowLayout().then {
            $0.itemSize = CGSize(width: collectionItemSize, height: collectionItemSize)
            $0.minimumInteritemSpacing = 0
            $0.minimumLineSpacing = 0
        }).then {
        $0.backgroundColor = UIColor.white
        $0.register(MVVMCollectionCell.self, forCellWithReuseIdentifier: "MVVMCollectionCell")
    }
    
    let tableView = UITableView().then {
        $0.rowHeight = 43.5
        $0.allowsSelection = false
        $0.register(MVVMTableCell.self, forCellReuseIdentifier: "MVVMTableCell")
    }
    
    let collectionItemSize = (UIScreen.main.bounds.size.width - 20) / 3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        bindData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let actionRelay = PublishRelay<Action>()
    let cameraRelay = PublishRelay<CameraAction>()
    var nowSceneData = DataForScene()
    var savedSceneData = DataForScene()
    func bindData() {
        // +버튼 바인딩
        plusButton.rx
            .tap
            .map{ .tapPlusButton } //여기서 플러스로 바뀌네
            .bind(to: actionRelay)
        .disposed(by:disposeBag)
        
        completeButton.rx
            .tap
            .map{ .tapCompleteButton(DataForScene(question: self.questionTextView.text, explanation: self.explanationTextView.text, answerList: ["1","2"], questionImageList: [], explanationImageList: [])) }
            .bind(to: actionRelay)
            .disposed(by:disposeBag)
        
        questionCameraButton.rx
            .tap
            .map{ .question}
            .bind(to: cameraRelay)
            .disposed(by:disposeBag)
        
        explanationCameraButton.rx
            .tap
            .map{ .explanation}
            .bind(to: cameraRelay)
            .disposed(by:disposeBag)
        
        questionTextView.rx
            .text
            .map{ .questionTextChange($0!)}
            .bind(to: actionRelay)
            .disposed(by:disposeBag)
        
        explanationTextView.rx
            .text
            .map{ .explanationTextChange($0!)}
            .bind(to: actionRelay)
            .disposed(by:disposeBag)
        
    }
    
    // MARK: - model Dependency Injection
    @discardableResult
    func setupDI<T>(observable: Observable<T>) -> Self{
        if let o = observable as? Observable<[String]> {
            o.do(onNext:{ [weak self] data in
                if data.count == 0 {
                    self?.tableView.snp.updateConstraints{
                        $0.height.equalTo(10) }
                } else {
                    self?.tableView.snp.updateConstraints{
                        $0.height.equalTo(CGFloat(data.count) * 43.5) }
                }
            }).bind(to: tableView.rx.items(cellIdentifier: "MVVMTableCell", cellType: MVVMTableCell.self)) {
                [weak self] index, data, cell in
//                cell.delegate = self?.viewModel
                cell.setupDI(asset: AssetType(text: data, index: index))
                cell.setupDI(action: self!.actionRelay)
            }.disposed(by: disposeBag)
        }
        return self
    }
    
    @discardableResult
    func setupDI<T>(questionImageList: Observable<T>) -> Self{
        if let o = questionImageList as? Observable<[UIImage]> {
            o.do(onNext:{ [weak self] data in
                if data.count == 0 {
                    self?.questionCollectionView.snp.updateConstraints{
                        $0.height.equalTo(10) }
                } else {
                    self?.questionCollectionView.snp.updateConstraints{
                        $0.height.equalTo(CGFloat((data.count + 2) / 3) * self!.collectionItemSize) }
                }
            }).bind(to: questionCollectionView.rx.items(cellIdentifier: "MVVMCollectionCell", cellType: MVVMCollectionCell.self)) {
                index, data, cell in
                cell.imageView.image = data//self!.questionImageList[index]
            }.disposed(by: disposeBag)
        }
        return self
    }
    
    @discardableResult
    func setupDI<T>(explanationImageList: Observable<T>) -> Self{
        if let o = explanationImageList as? Observable<[UIImage]> {
            o.do(onNext:{ [weak self] data in
                if data.count == 0 {
                    self?.explanationCollectionView.snp.updateConstraints{
                        $0.height.equalTo(10) }
                } else {
                    self?.explanationCollectionView.snp.updateConstraints{
                        $0.height.equalTo(CGFloat((data.count + 2) / 3) * self!.collectionItemSize) }
                }
            }).bind(to: explanationCollectionView.rx.items(cellIdentifier: "MVVMCollectionCell", cellType: MVVMCollectionCell.self)) {
                index, data, cell in
                cell.imageView.image = data//self!.questionImageList[index]
            }.disposed(by: disposeBag)
        }
        return self
    }
   
    
    @discardableResult
    func setupDI<T>(action: PublishRelay<T>) -> Self {
        if let a = action as? PublishRelay<Action> {
            actionRelay.bind(to: a).disposed(by: rx.disposeBag)
        }
        return self
    }
    
    @discardableResult
    func setupDI<T>(camera: PublishRelay<T>) -> Self {
        if let c = camera as? PublishRelay<CameraAction> {
            cameraRelay.bind(to: c).disposed(by: rx.disposeBag)
        }
        return self
    }
    
    func setupLayout() {
        inSelfViewViews.append(scrollView)
        inSelfViewViews.append(completeButton)
        
        inScrollViewViews.append(subView)
        
        inSubViewViews.append(questionLabel)
        inSubViewViews.append(questionCameraButton)
        inSubViewViews.append(questionTextView)
        inSubViewViews.append(questionCollectionView)
        inSubViewViews.append(answerLabel)
        inSubViewViews.append(plusButton)
        inSubViewViews.append(tableView)
        inSubViewViews.append(explanationLabel)
        inSubViewViews.append(explanationCameraButton)
        inSubViewViews.append(explanationTextView)
        inSubViewViews.append(explanationCollectionView)
        
        // 모든 뷰 .addSubView 진행
        addSubviews(inSelfViewViews)
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
        scrollView.snp.makeConstraints{ $0.edges.equalTo(safeAreaLayoutGuide) }
        
        subView.snp.makeConstraints{
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide.snp.width) }
        
        questionLabel.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 30).isActive = true
        questionLabel.topAnchor.constraint(equalTo: subView.topAnchor, constant: 55).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        questionLabel.snp.makeConstraints{
            $0.leading.equalTo(subView.snp.leading).offset(30)
            $0.top.equalTo(subView.snp.top).offset(55)
            //$0.top.equalTo(subView.snp.top).offset(20)
            $0.height.equalTo(20) }
        
        questionCameraButton.snp.makeConstraints{
            $0.trailing.equalTo(subView.snp.trailing).offset(-30)
            $0.top.equalTo(subView.snp.top).offset(50)
            //$0.top.equalTo(subView.snp.top).offset(15)
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
        
        questionTextView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(questionCameraButton.snp.bottom).offset(5)
            $0.height.equalTo(130) }
        
        questionCollectionView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(questionTextView.snp.bottom).offset(5)
            $0.height.equalTo(10)
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
            $0.height.equalTo(10)
        }
        explanationLabel.snp.makeConstraints{
            $0.leading.equalTo(subView.snp.leading).offset(30)
            $0.top.equalTo(tableView.snp.bottom).offset(10)
            $0.height.equalTo(20) }
        
        explanationCameraButton.snp.makeConstraints{
            $0.trailing.equalTo(subView.snp.trailing).offset(-30)
            $0.top.equalTo(tableView.snp.bottom).offset(5)
            $0.height.equalTo(30)
            $0.width.equalTo(30) }
        
        explanationTextView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(explanationCameraButton.snp.bottom).offset(5)
            $0.height.equalTo(130) }
        
        explanationCollectionView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(explanationTextView.snp.bottom).offset(5)
            $0.bottom.equalTo(subView.snp.bottom).offset(-100)
            $0.height.equalTo(10)

        }
        completeButton.snp.makeConstraints{
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(10)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(20)
            $0.height.equalTo(60) }
    }
}
