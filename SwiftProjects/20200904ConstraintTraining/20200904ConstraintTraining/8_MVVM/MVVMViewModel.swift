//
//  RxSwifViewModel.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/10/06.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxFlow
import SnapKit
import Then
import NSObject_Rx

enum AnswerAction {
    case plus
}

class MVVMViewModel: ViewModelType, MVVMTableCellDelegate {
    // MARK: - Action
    func tapXButton(_ cell: MVVMTableCell) {
        let tableView = cell.superview as! UITableView
        let index = tableView.indexPath(for: cell)!.row
        var list = answerRelay.value
        
        for i in 0..<list.count {
            list[i] = (tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! MVVMTableCell).answerTextField.text!
        }
        list.remove(at: index)
        answerRelay.accept(list)
    }
    
    func tapPlusButton(){
        var list = answerRelay.value
        list.append("")
        answerRelay.accept(list)
    }
    
    func tapCompleteButton(questionTextView: UITextView, explanationTextView: UITextView, tableView: UITableView){
        MainRepository.shared.question = questionTextView.text
        MainRepository.shared.explanation = explanationTextView.text
        
        var list = answerRelay.value
        for i in 0..<list.count {
            list[i] = (tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! MVVMTableCell).answerTextField.text!
        }
        MainRepository.shared.answerList = list
        
        MainRepository.shared.questionImageList = questionImageRelay.value
        MainRepository.shared.explanationImageList = explanationImageRelay.value
    }
    
    
    // MARK: - Properties
    let answerRelay = BehaviorRelay<[String]>(value: [])
    let questionImageRelay = BehaviorRelay<[UIImage]>(value: [])
    let explanationImageRelay = BehaviorRelay<[UIImage]>(value: [])
    
    let disposeBag = DisposeBag()
    
    // MARK: - ViewModelType Protocol
    typealias ViewModel = MVVMViewModel
    
    struct Input { // 한번 그리면서, 바인드를 쫘아악?
        let action: PublishRelay<AnswerAction>
        //var questionCameraAction: Observable<Void>
        //var explanationCameraAction: Observable<Void>
        //var answerPlusAction: Observable<Void>
        //let action: Observable<Type>
    }
    
    struct Output {
        let answerList: Observable<[String]>
        //let questionImageList: Observable<[UIImage]>
        //let explanationImageList: Observable<[UIImage]>
        //let answerList: Observable<[String]>
    }
    
    func transform(req: ViewModel.Input) -> ViewModel.Output {
        req.action.subscribe(onNext: { [weak self] action in
            self?.actionProcess(action: action)
        }).disposed(by: disposeBag)
        
        let answerList = MainRepository.shared.answerList
        answerRelay.accept(answerList)
        
        let questionImageList = MainRepository.shared.questionImageList
        questionImageRelay.accept(questionImageList)
        
        let explanationImageList = MainRepository.shared.explanationImageList
        explanationImageRelay.accept(explanationImageList)
        
        return Output(answerList: answerRelay.asObservable())
    }
    
    func actionProcess(action: AnswerAction) {
        switch action {
        case .plus:
            self.tapPlusButton()
        }
    }
}
