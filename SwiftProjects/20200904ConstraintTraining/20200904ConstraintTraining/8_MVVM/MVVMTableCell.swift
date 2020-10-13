//
//  TableViewCell.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/09/21.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then

class MVVMTableCell: UITableViewCell {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var index: Int?
    let actionRelay = PublishRelay<Action>()
    var disposeBag = DisposeBag()
    var exampleNumber = UIImageView()
    let answerTextField = UITextField().then {
        $0.setBorder()
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: $0.frame.height))
        $0.leftViewMode = .always
    }
    let incorrectOrCorrect = UILabel().then {
        $0.text = "오답"
        $0.setBorder(UIColor.systemRed)
        $0.textColor = UIColor.systemRed
    }
    let xButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
    }
    var isSetupDI: Bool = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("init TableCell")
        
        setupLayout()
        bindData()
    }
    
    func setupLayout(){
        self.contentView.addSubviews([exampleNumber, answerTextField, incorrectOrCorrect, xButton])
        exampleNumber.snp.makeConstraints{
            $0.height.width.equalTo(30)
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
        }
        
        answerTextField.snp.makeConstraints{
            $0.leading.equalTo(exampleNumber.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(34)
        }
        
        incorrectOrCorrect.snp.makeConstraints{
            $0.leading.equalTo(answerTextField.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        
        xButton.snp.makeConstraints{
            $0.leading.equalTo(incorrectOrCorrect.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(20)
        }
    }
    
    func dataMapping(text: String, index: Int) {
        self.answerTextField.text = text
        self.exampleNumber.image = UIImage(systemName: String(index + 1) + ".circle")
        self.index = index
    }
    
    func bindData(){
        // 셀 안에 텍스트가 변경 될 때, 엑션 릴레이를 쭉 연결하여 뷰 모델까지 데이터를 전달하는 부분
        answerTextField.rx
            .text
            .map{[weak self] in .answerTextChange($0 ?? "error", (self?.index) ?? 0)} // 인덱스 일단은 쓰고 셀프 쓰는거만 바꿔보기.
            .bind(to: actionRelay)
            .disposed(by:disposeBag)
        
        // 셀의 x버튼을 누를 시, 액션 릴레이를 쭉 연결하여 뷰 모델까지 데이터를 전달하는 부분
        xButton.rx
            .tap
            .map{[weak self] _ in .tapXButton((self?.index) ?? 0)}
            .bind(to: actionRelay)
            .disposed(by:disposeBag)
    }
    
    @discardableResult
    func setupDI<T>(action: PublishRelay<T>) -> Self {
        if let a = action as? PublishRelay<Action> {
            actionRelay.bind(to: a).disposed(by: disposeBag)
        }
        return self
    }
    deinit {
        print("tableCell deinit")
    }
}
