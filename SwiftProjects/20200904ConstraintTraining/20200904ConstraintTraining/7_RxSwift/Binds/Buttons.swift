
import UIKit

extension MultipleChoiceQuestionViewController_RxSwift { // Buttons
    func bindXButton(_ sender: UIButton) {
        // 다른 방법으로
        sender.rx.tap.bind { [weak self] in
            self?.tapXButton(sender)
        }.disposed(by:disposeBag)
    }
    
    func bindTextField(_ sender: UITextField){
        sender.rx.text
            .distinctUntilChanged()
            .bind { [weak self] _ in // _ 여기에 newValue가 들어가네 호옹이
                self?.textFieldDidChangeSelection(sender)
        }.disposed(by:disposeBag)
    }
    
    func bindPlusButton() {
        plusButton.rx.tap.bind{ [weak self] in
            self?.tapPlusButton()
        }.disposed(by:disposeBag)
    }
    
    func bindQuestionCameraButton() {
        questionCameraButton.rx.tap.bind{ [weak self] in
            self?.tapQuestionCameraButton()
        }.disposed(by:disposeBag)
    }
    
    func bindExplanationCameraButton() {
        explanationCameraButton.rx.tap.bind{ [weak self] in
            self?.tapExplanationCameraButton()
        }.disposed(by:disposeBag)
    }
    
    func bindCompleteButton() {
        completeButton.rx.tap.bind{ [weak self] in
            self?.tapCompleteButton()
        }.disposed(by:disposeBag)
    }
}
