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
import Then

class TableCell: UITableViewCell {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isBinded = false
    var disposebag = DisposeBag()
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
    let xButton = CustomUIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
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
        print("init TableCell")
    }
    deinit {// ?? 왜안됨?
        print("deinit TableCell")
    }
    
}
