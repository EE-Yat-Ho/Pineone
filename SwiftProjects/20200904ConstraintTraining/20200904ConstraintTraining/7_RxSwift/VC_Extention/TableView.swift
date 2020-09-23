
import UIKit

extension MultipleChoiceQuestionViewController_RxSwift { // TableView
    func bindTableView() {
        answerRelay.asObservable().bind(to: tableView.rx.items) { [self] (tableView: UITableView, index: Int, element: String) in
            let indexPath = IndexPath(item: index, section: 0)
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
            cell.exampleNumber.image = UIImage(systemName: String(indexPath.row + 1) + ".circle")
            cell.answerTextField.text = answerList[indexPath.row]
            cell.answerTextField.delegate = self // 안하면 타이핑할 때 배열에 저장하는 delegate가 안되자너
            if cell.isBinded == false {
                cell.xButton.rx.tap.bind { [weak self] in
                    self?.xButtonTap(cell.xButton)
                }.disposed(by:cell.disposebag)
                cell.isBinded = true
            }
            return cell
        }.disposed(by: disposeBag)
        
    }
    
    func addAnswerTap() {
        answerList.append("")
        tableReload()
    }
    func xButtonTap(_ sender: UIButton) {
        let cell = sender.superview?.superview as! TableCell
        let indexPath = tableView.indexPath(for: cell)! as IndexPath
        answerList.remove(at: indexPath.row)
        tableReload()
    }
    func tableReload() {
        answerRelay.accept(answerList)
        if answerList.count == 0 {
            tableView.snp.updateConstraints{
                $0.height.equalTo(10) }
        } else {
            tableView.snp.updateConstraints{
                $0.height.equalTo(CGFloat(answerList.count) * 43.5) }
        }
    }
}
