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
    
    // 스크롤뷰
    let scrollView = UIScrollView()
    
    // 스크롤뷰의 서브뷰
    let subView = UIView()
    
    // 레이블들
    let questionLabel = UILabel().then{
        $0.text = "문제"
    }
    let answerLabel = UILabel().then {
        $0.text = "보기"
    }
    let explanationLabel = UILabel().then {
        $0.text = "풀이"
    }
    
    // 버튼들 (카메라2개, 플러스, 완료)
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
    
    // 문제와 풀이의 텍스트 입력창
    let questionTextView = UITextView().then {
        $0.text = MainRepository.shared.dataForScene.question
    }
    let explanationTextView = UITextView().then {
        $0.text = MainRepository.shared.dataForScene.explanation
    }
    
    // 문제와 풀이의 사진들용 콜렉션뷰
    // collectionItemSize를 사용하기 위해 lazy선언
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
    
    // 보기용 테이블뷰
    let tableView = UITableView().then {
        $0.rowHeight = 43.5
        $0.allowsSelection = false
        $0.register(MVVMTableCell.self, forCellReuseIdentifier: "MVVMTableCell")
    }
    
    // 화면에 따라 콜렉션뷰의 셀 크기를 달리함.
    let collectionItemSize = (UIScreen.main.bounds.size.width - 20) / 3
    
    // View의 핵심!!
    // Publish인 이유 : 지난 데이터를 가지고 있을 필요 없음.
    // Observable이 아닌 Reley인 이유 : 버튼들, 텍스트필드 입력들을 관찰하고있고, VC의 action에게 관찰 당함.
    // Subject가 아닌 Relay인 이유 : UI이벤트를 처리하기 때문.
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
    
    // MARK: - View <-> VC Bind to actionRelay
    
    // +버튼, 완료버튼, 카메라버튼 2개, 텍스트뷰 입력 2개 바인드
    func bindData() {
        plusButton.rx
            .tap
            .map{ .tapPlusButton }
            .bind(to: actionRelay)
            .disposed(by:rx.disposeBag)
        
        completeButton.rx
            .tap
            .map{ .tapCompleteButton }
            .bind(to: actionRelay)
            .disposed(by:rx.disposeBag)
        
        questionCameraButton.rx
            .tap
            .map{ .tapCameraButton(.question)}
            .bind(to: actionRelay)
            .disposed(by:rx.disposeBag)
        
        explanationCameraButton.rx
            .tap
            .map{ .tapCameraButton(.explanation)}
            .bind(to: actionRelay)
            .disposed(by:rx.disposeBag)
        
        questionTextView.rx
            .text
            .map{ .questionTextChange($0 ?? "qeustionTextView Text Error")}
            .bind(to: actionRelay)
            .disposed(by:rx.disposeBag)
        
        explanationTextView.rx
            .text
            .map{ .explanationTextChange($0 ?? "explanationTextView Text Error")}
            .bind(to: actionRelay)
            .disposed(by:rx.disposeBag)
    }
    
    // MARK: - Dependency Injection to table and collections.
    // VC가 뷰의 테이블뷰에 VM에서 받아온 옵저버블로 의존성 주입
    @discardableResult
    func setupDI(answerList: Observable<[String]>) -> Self{
        // 셀 갯수에 따른 높이조절
        answerList.do(onNext:{ [weak self] data in
            if let t = self?.tableView {
                self?.setTableViewHeight(tableView: t, cellCount: data.count)
            }
        })
        // 셀마다 의존성 주입, 데이터 매핑
        .bind(to: tableView.rx.items(cellIdentifier: "MVVMTableCell", cellType: MVVMTableCell.self)) {
            [weak self] index, data, cell in
            // 의존성 주입, 데이터 매핑
            if let a = self?.actionRelay {
                cell.setupDI(action: a)
            }
            cell.dataMapping(text: data, index: index)
        }.disposed(by: rx.disposeBag)
        return self
    }
    
    // 질문 콜렉션 뷰 의존성 주입
    // 이 setupDI들을 합칠 수는 없을 까..?
    // => 제네릭? : 똑같은 타입인데 행동이 다른게 있음. 콜렉션 두개.
    // => 매개변수 3개 받기 : 기능이 너무 독립적이지 못한거같음.
    // => 테이블과 콜렉션만 제네릭으로 구별 : 3덩이에서 4덩이가 되버림
    // => 아에 res를 받기 : 이미지피커까지 딸려와버림
    // => 매개변수 3개 구조체로 만들어서 받기 : 오버헤드가 더 크지않나 싶음
    // 이게 젤 나은듯..?
    // 그럼에도 제네릭을 써놓은 이유는? 그러게요 지워야지.
    @discardableResult
    func setupDI(questionImageList: Observable<[UIImage]>) -> Self{
        // 셀 갯수에 따른 높이조절
        questionImageList.do(onNext:{ [weak self] data in
            if let q = self?.questionCollectionView {
                self?.setCollectionViewHeight(collectionView: q, cellCount: data.count)
            }
        })
        // 셀에 이미지 넣기
        .bind(to: questionCollectionView.rx.items(cellIdentifier: "MVVMCollectionCell", cellType: MVVMCollectionCell.self)) {
            index, data, cell in
            cell.imageView.image = data
        }.disposed(by: rx.disposeBag)
        return self
    }
    
    // 풀이 콜렉션 뷰 의존성 주입
    @discardableResult
    func setupDI(explanationImageList: Observable<[UIImage]>) -> Self{
        explanationImageList.do(onNext: { [weak self] data in
            if let e = self?.explanationCollectionView {
                self?.setCollectionViewHeight(collectionView: e, cellCount: data.count)
            }
        }).bind(to: explanationCollectionView.rx.items(cellIdentifier: "MVVMCollectionCell", cellType: MVVMCollectionCell.self)) {
            index, data, cell in
            cell.imageView.image = data
        }.disposed(by: rx.disposeBag)
        return self
    }
   
    // 갖가지 User 입력들(버튼들, 텍스트 입력들) 의존성 주입
    @discardableResult
    func setupDI(action: PublishRelay<Action>) -> Self {
        actionRelay.bind(to: action).disposed(by: rx.disposeBag)
        return self
    }
    
    // MARK: - Setup Layout
    func setupLayout() {
        
        // 모든 뷰 .addSubView 진행
        addSubviews([scrollView, completeButton])
        scrollView.addSubview(subView)
        subView.addSubviews([questionLabel,
                             questionCameraButton,
                             questionTextView,
                             questionCollectionView,
                             answerLabel,
                             plusButton,
                             tableView,
                             explanationLabel,
                             explanationCameraButton,
                             explanationTextView,
                             explanationCollectionView])

        // 특정 뷰 테두리 그리기
        questionTextView.setBorder()
        questionCollectionView.setBorder()
        tableView.setBorder()
        explanationTextView.setBorder()
        explanationCollectionView.setBorder()
        completeButton.setBorder(UIColor.systemBlue)
        
        // 제약사항 추가
        scrollView.snp.makeConstraints{
            $0.edges.equalTo(safeAreaLayoutGuide) }
        
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
    
    // 셀 갯수에 따른 콜렉션 뷰 높이 조절
    func setCollectionViewHeight(collectionView: UICollectionView, cellCount: Int){
        if cellCount == 0 {
            collectionView.snp.updateConstraints{
                $0.height.equalTo(10) }
        } else {
            collectionView.snp.updateConstraints{
                $0.height.equalTo(CGFloat((cellCount + 2) / 3) * self.collectionItemSize) }
        }
    }
    
    // 셀 갯수에 따른 테이블 뷰 높이 조절
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
