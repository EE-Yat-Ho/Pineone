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

enum Action {
    case tapPlusButton
    case tapCompleteButton(DataForScene)
    case questionImagePickerSelect(UIImage)
    case explanationImagePickerSelect(UIImage)
    case questionTextChange(String)
    case explanationTextChange(String)
    case answerTextChange(String, Int)
}

enum CameraAction{
    case question
    case explanation
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
    
    func tapCompleteButton(){
        print("complete")
        MainRepository.shared.dataForScene = nowSceneData
    }
    
    func questionImagePickerSelected(_ img: UIImage){
        print("QCamera")
        var newList = questionImageRelay.value
        newList.append(img)
        questionImageRelay.accept(newList)
    }
    
    func explanationImagePickerSelected(_ img: UIImage){
        print("QCamera")
        var newList = explanationImageRelay.value
        newList.append(img)
        explanationImageRelay.accept(newList)
    }
    
    func questionTextChange(_ text: String){
        nowSceneData.question = text
    }
    func explanationTextChange(_ text: String){
        nowSceneData.explanation = text
    }
    func answerTextChange(_ text: String, _ index: Int){
        
    }
    
    // MARK: - Properties
    let answerRelay = BehaviorRelay<[String]>(value: [])
    let questionImageRelay = BehaviorRelay<[UIImage]>(value: [])
    let explanationImageRelay = BehaviorRelay<[UIImage]>(value: [])
    
    let disposeBag = DisposeBag()
    
    var nowSceneData = DataForScene()
    
    // MARK: - ViewModelType Protocol
    typealias ViewModel = MVVMViewModel
    
    struct Input { // 한번 그리면서, 바인드를 쫘아악?
        let action: PublishRelay<Action>
    }
    
    struct Output {
        let answerList: Observable<[String]>
        let questionImageList: Observable<[UIImage]>
        let explanationImageList: Observable<[UIImage]>
    }
    
    func transform(req: ViewModel.Input) -> ViewModel.Output {
        req.action.subscribe(onNext: { [weak self] action in
            self?.actionProcess(action: action)
        }).disposed(by: disposeBag)
        
        return Output(answerList: answerRelay.asObservable(), questionImageList: questionImageRelay.asObservable(), explanationImageList: explanationImageRelay.asObservable())
    }
    
    func actionProcess(action: Action) {
        switch action {
        case .tapPlusButton:
            self.tapPlusButton()
        case .tapCompleteButton(let data):
            nowSceneData = data
            self.tapCompleteButton()
        case .questionImagePickerSelect(let img):
            self.questionImagePickerSelected(img)
        case .explanationImagePickerSelect(let img):
            self.explanationImagePickerSelected(img)
        case .questionTextChange(let text):
            self.questionTextChange(text)
        case .explanationTextChange(let text):
            self.explanationTextChange(text)
        case .answerTextChange(let text, let index):
            self.answerTextChange(text, index)
        }
    }
}
