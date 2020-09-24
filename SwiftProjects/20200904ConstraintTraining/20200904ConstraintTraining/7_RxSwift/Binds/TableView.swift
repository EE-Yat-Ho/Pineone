
import UIKit

extension MultipleChoiceQuestionViewController_RxSwift { // TableView
    // Foundation에서 한 방식이 훨씬 깔끔하네
    // indexPath 쓰고싶으면 let indexPath = IndexPath(item: index, section: 0)하셈
    func bindTableView() {
        answerRelay.asObservable().bind(to: tableView.rx.items(cellIdentifier: "TableCell", cellType: TableCell.self)) { [weak self]
            index, _, cell in
            cell.exampleNumber.image = UIImage(systemName: String(index + 1) + ".circle")
            cell.answerTextField.text = self!.answerList[index]
            // self 없이
            if cell.isBinded == false {
                self!.bindXButton(cell: cell) // 버튼, TextField 동적 바인딩
                self!.bindTextField(cell: cell)
                cell.isBinded = true
            }
        }.disposed(by: rx.disposeBag)
    }
}
