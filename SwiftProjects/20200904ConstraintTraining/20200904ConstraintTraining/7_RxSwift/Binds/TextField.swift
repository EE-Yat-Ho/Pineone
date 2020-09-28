
import UIKit

extension MultipleChoiceQuestionViewController_RxSwift { // TextField
    func bindTextField(_ sender: UITextField){
        sender.rx.text
            .distinctUntilChanged()
            .bind { [weak self] _ in // _ 여기에 newValue가 들어가네 호옹이
                self?.textFieldDidChangeSelection(sender)
            }.disposed(by:(sender.superview?.superview as! TableCell).disposeBag)
    }
}
