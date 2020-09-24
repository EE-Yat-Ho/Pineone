
import UIKit

extension MultipleChoiceQuestionViewController_RxSwift {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let cell = textField.superview?.superview as! TableCell
        if let indexPath = tableView.indexPath(for: cell) {
            answerList[indexPath.row] = textField.text!
        }
    }
}
