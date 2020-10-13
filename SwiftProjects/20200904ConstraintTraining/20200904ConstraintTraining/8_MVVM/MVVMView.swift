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
    
    
    // MARK: - Properties
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
    
    // View의 핵심!!
    let actionRelay = PublishRelay<Action>()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        bindData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View <-> VC Bind to [ actionRelay ]
    func bindData() {
        // [ +버튼, 완료버튼, 카메라버튼 2개, 텍스트뷰 입력 2개 ]바인드
        plusButton.rx
            .tap
            .map{ .tapPlusButton }
            .bind(to: actionRelay)
        .disposed(by:disposeBag)
        
        completeButton.rx
            .tap
            .map{ .tapCompleteButton }
            .bind(to: actionRelay)
            .disposed(by:disposeBag)
        
        questionCameraButton.rx
            .tap
            .map{ .tapCameraButton("question")}
            .bind(to: actionRelay)
            .disposed(by:disposeBag)
        
        explanationCameraButton.rx
            .tap
            .map{ .tapCameraButton("explanation")}
            .bind(to: actionRelay)
            .disposed(by:disposeBag)
        
        questionTextView.rx
            .text
            .map{ .questionTextChange($0 ?? "Error")}
            .bind(to: actionRelay)
            .disposed(by:disposeBag)
        
        explanationTextView.rx
            .text
            .map{ .explanationTextChange($0 ?? "Error")}
            .bind(to: actionRelay)
            .disposed(by:disposeBag)
    }
    
    // MARK: - Dependency Injection to table and collections.
    // 테이블 뷰 의존성 주입
    @discardableResult
    func setupDI<T>(answerList: Observable<T>) -> Self{
        if let o = answerList as? Observable<[String]> {
            // 셀 갯수에 따른 높이조절
            o.do(onNext:{ [weak self] data in
                if let t = self?.tableView {
                    self?.setTableViewHeight(tableView: t, cellCount: data.count)
                }
            })
            // 셀마다 의존성 주입, 데이터 매핑
            .bind(to: tableView.rx.items(cellIdentifier: "MVVMTableCell", cellType: MVVMTableCell.self)) {
                [weak self] index, data, cell in
                // 테이블을 그릴때 마다 셀에 의존성 주입하는 것을 방지.
                if cell.isSetupDI == false {
                    guard let a = self?.actionRelay else {
                        print("tableCell's actionRelay is nil!!")
                        return
                    }
                    cell.setupDI(action: a)
                    cell.isSetupDI = true
                }
                // 의존성 주입을 하든안하든 텍스트와 인덱스 값은 갱신해주어야함.
                cell.dataMapping(text: data, index: index)
            }.disposed(by: disposeBag)
        }
        return self
    }
    
    // 질문 콜렉션 뷰 의존성 주입
    @discardableResult
    func setupDI<T>(questionImageList: Observable<T>) -> Self{
        if let o = questionImageList as? Observable<[UIImage]> {
            // 셀 갯수에 따른 높이조절
            o.do(onNext:{ [weak self] data in
                if let q = self?.questionCollectionView {
                    self?.setCollectionViewHeight(collectionView: q, cellCount: data.count)
                }
            })
            // 셀에 이미지 넣기
            .bind(to: questionCollectionView.rx.items(cellIdentifier: "MVVMCollectionCell", cellType: MVVMCollectionCell.self)) {
                index, data, cell in
                cell.imageView.image = data
            }.disposed(by: disposeBag)
        }
        return self
    }
    
    // 풀이 콜렉션 뷰 의존성 주입
    @discardableResult
    func setupDI<T>(explanationImageList: Observable<T>) -> Self{
        if let o = explanationImageList as? Observable<[UIImage]> {
            o.do(onNext:{ [weak self] data in
                if let e = self?.explanationCollectionView {
                    self?.setCollectionViewHeight(collectionView: e, cellCount: data.count)
                }
            }).bind(to: explanationCollectionView.rx.items(cellIdentifier: "MVVMCollectionCell", cellType: MVVMCollectionCell.self)) {
                index, data, cell in
                cell.imageView.image = data
            }.disposed(by: disposeBag)
        }
        return self
    }
   
    // 갖가지 유저 입력들(버튼들, 텍스트 입력들) 의존성 주입
    @discardableResult
    func setupDI<T>(action: PublishRelay<T>) -> Self {
        if let a = action as? PublishRelay<Action> {
            actionRelay.bind(to: a).disposed(by: rx.disposeBag)
        }
        return self
    }
    
    
    // MARK: - Setup Layout
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
        
        questionLabel.snp.makeConstraints{
            $0.leading.equalTo(subView.snp.leading).offset(30)
            $0.top.equalTo(subView.snp.top).offset(55)
            $0.height.equalTo(20) }
        
        questionCameraButton.snp.makeConstraints{
            $0.trailing.equalTo(subView.snp.trailing).offset(-30)
            $0.top.equalTo(subView.snp.top).offset(50)
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
    
    func setCollectionViewHeight(collectionView: UICollectionView, cellCount: Int){
        if cellCount == 0 {
            collectionView.snp.updateConstraints{
                $0.height.equalTo(10) }
        } else {
            collectionView.snp.updateConstraints{
                $0.height.equalTo(CGFloat((cellCount + 2) / 3) * self.collectionItemSize) }
        }
    }
    
    func setTableViewHeight(tableView: UITableView, cellCount: Int) {
        if cellCount == 0 {
            tableView.snp.updateConstraints{
                $0.height.equalTo(10) }
        } else {
            tableView.snp.updateConstraints{
                $0.height.equalTo(CGFloat(cellCount) * 43.5) }
        }
    }
    
    deinit {
        print("view deinit")
    }
}
