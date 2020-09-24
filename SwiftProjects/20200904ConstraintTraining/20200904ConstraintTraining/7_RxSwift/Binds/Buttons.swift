
import UIKit

extension MultipleChoiceQuestionViewController_RxSwift { // Buttons
    func bindXButton(cell: TableCell) {
        // 다른 방법으로
        cell.xButton.rx.tap.bind { [weak self] in
            self?.tapXButton(cell.xButton)
        }.disposed(by:cell.disposebag)
    }
    
    func bindTextField(cell: TableCell){
        cell.answerTextField.rx.text
            .distinctUntilChanged()
            .bind { [weak self] _ in // _ 여기에 newValue가 들어가네 호옹이
            self?.textFieldDidChangeSelection(cell.answerTextField)
        }.disposed(by:cell.disposebag)
    }
    
    func bindPlusButton() {
        plusButton.rx.tap.bind{ [weak self] in
            self?.tapPlusButton()
        }.disposed(by:rx.disposeBag)
    }
    
    func bindQuestionCameraButton() {
        questionCameraButton.rx.tap.bind{ [weak self] in
            self?.tapQuestionCameraButton()
        }.disposed(by:rx.disposeBag)
    }
    
    func bindExplanationCameraButton() {
        explanationCameraButton.rx.tap.bind{ [weak self] in
            self?.tapExplanationCameraButton()
        }.disposed(by:rx.disposeBag)
    }
    
    func bindCompleteButton() {
        completeButton.rx.tap.bind{ [weak self] in
            self?.tapCompleteButton()
        }.disposed(by:rx.disposeBag)
    }
}
