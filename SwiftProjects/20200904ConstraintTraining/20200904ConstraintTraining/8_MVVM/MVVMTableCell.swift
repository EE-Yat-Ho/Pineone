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

struct AssetType{
    var text: String
    var index: Int
}

protocol MVVMTableCellDelegate {
    func tapXButton(_ cell: MVVMTableCell)
}

class MVVMTableCell: UITableViewCell {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let assetRelay = BehaviorRelay<AssetType>(value: AssetType(text: "", index: 0))
    let actionRelay = PublishRelay<Action>()
    var delegate: MVVMTableCellDelegate!
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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("init TableCell")
        
        setupLayout()
        bindData()
    }
    
    deinit {
        print("deinit TableCell")
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
    
    func bindData(){
        xButton.rx.tap.bind { [weak self] in
            self?.delegate.tapXButton(self!)
        }.disposed(by:disposeBag)
        
        assetRelay.subscribe(onNext: { [weak self] asset in
            self!.answerTextField.text = asset.text
            self!.exampleNumber.image = UIImage(systemName: String(asset.index + 1) + ".circle")
        }).disposed(by: disposeBag)
        
        answerTextField.rx
            .text
            .map{ .answerTextChange($0!, self.assetRelay.value.index)}
            .bind(to: actionRelay)
            .disposed(by:disposeBag)
    }
    
    func setupDI(asset: AssetType){
        self.assetRelay.accept(asset)
    }
    @discardableResult
    func setupDI<T>(action: PublishRelay<T>) -> Self {
        if let a = action as? PublishRelay<Action> {
            actionRelay.bind(to: a).disposed(by: rx.disposeBag)
        }
        return self
    }
}
