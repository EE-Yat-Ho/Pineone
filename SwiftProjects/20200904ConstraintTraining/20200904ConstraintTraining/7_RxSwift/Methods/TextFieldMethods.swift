
import UIKit

extension MultipleChoiceQuestionViewController_RxSwift {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.tag < answerList.count {
            answerList[textField.tag] = textField.text!
        }
    }
}
