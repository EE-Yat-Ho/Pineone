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
    var index: Int? // 지금은 어쩔 수 없이 인덱스 쓰라고 하셨음 와웅
    let actionRelay = PublishRelay<Action>() // 셀에 있는 텍스트필드와 버튼을 관찰하고, View에 있는 actionRelay에 관찰당하기 떄문에 릴레이.
    var disposeBag = DisposeBag()
    var exampleNumber = UIImageView() // 젤 왼쪽 보기 번호
    let answerTextField = UITextField().then { // 보기에 있는 텍스트
        $0.setBorder()
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: $0.frame.height))
        $0.leftViewMode = .always
    }
    let incorrectOrCorrect = UILabel().then { // 오답, 정답 여부. 구현 안함.
        $0.text = "오답"
        $0.setBorder(UIColor.systemRed)
        $0.textColor = UIColor.systemRed
    }
    let xButton = UIButton().then { // 보기를 지울 수 있는 X버튼
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
    }
    var isSetupDI: Bool = false // 셀이 추가, 삭제되면서 테이블을 리로드할때, 중복 의존성주입을 방지하기 위한 변수
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("init TableCell")
        
        setupLayout()
        bindData()
    }
    
    // 셀의 갖가지 뷰들 레이아웃
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
    
    // 데이터 매핑..!!
    func dataMapping(text: String, index: Int) {
        self.answerTextField.text = text
        self.exampleNumber.image = UIImage(systemName: String(index + 1) + ".circle")
        self.index = index
    }
    
    // 텍스트 필드와 버튼을 뷰에 바인드
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
    
    /// 셀의 액션릴레이를 뷰의 액션릴레이가 관찰하도록 해서 의존성을 주입.
    @discardableResult
    func setupDI(action: PublishRelay<Action>) -> Self {
        // 여기서 판단해야지 내가 내 프로퍼티가 아닌거에접근하지않게 하기위해 setupDI만 쓰는거임 뷰에서 isBinded를 쓰면 안됨
        // 중복 의존성주입 방지
        if isSetupDI == false {
            actionRelay.bind(to: action).disposed(by: disposeBag)
            isSetupDI = true
        }
        return self
    }
    deinit {
        print("tableCell deinit")
    }
}
