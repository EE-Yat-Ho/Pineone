
import UIKit

extension MultipleChoiceQuestionViewController_RxSwift: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let cell = textField.superview?.superview as! TableCell
        let indexPath = tableView.indexPath(for: cell)
        answerList[indexPath!.row] = textField.text!
    }
}
