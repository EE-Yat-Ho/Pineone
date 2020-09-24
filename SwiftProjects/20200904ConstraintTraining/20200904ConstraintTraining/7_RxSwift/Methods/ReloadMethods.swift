
import UIKit

extension MultipleChoiceQuestionViewController_RxSwift {
    func reloadTableView() {
        answerRelay.accept(answerList)
        if answerList.count == 0 {
            tableView.snp.updateConstraints{
                $0.height.equalTo(10) }
        } else {
            tableView.snp.updateConstraints{
                $0.height.equalTo(CGFloat(answerList.count) * 43.5) }
        }
    }
    func reloadQuestionCollectionView() {
        questionImageRelay.accept(questionImageList)
        if questionImageList.count == 0 {
            questionCollectionView.snp.updateConstraints{
                $0.height.equalTo(10) }
        } else {
            questionCollectionView.snp.updateConstraints{
                $0.height.equalTo(CGFloat((questionImageList.count + 2) / 3) * collectionItemSize) }
        }
    }
    func reloadExplanationCollectionView() {
        explanationImageRelay.accept(explanationImageList)
        if explanationImageList.count == 0 {
            explanationCollectionView.snp.updateConstraints{
                $0.height.equalTo(10) }
        } else {
            explanationCollectionView.snp.updateConstraints{
                $0.height.equalTo(CGFloat((explanationImageList.count + 2) / 3) * collectionItemSize)
            }
        }
    }
}
