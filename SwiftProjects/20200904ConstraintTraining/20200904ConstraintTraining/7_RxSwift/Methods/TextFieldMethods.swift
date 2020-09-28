
import UIKit

extension MultipleChoiceQuestionViewController_RxSwift {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.tag < answerList.count { // 삭제한 경우 뻑나서 추가
            answerList[textField.tag] = textField.text!
        }
    }
}
