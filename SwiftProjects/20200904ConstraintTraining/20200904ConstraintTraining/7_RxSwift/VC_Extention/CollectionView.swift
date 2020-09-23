
import UIKit

extension MultipleChoiceQuestionViewController_RxSwift { // CollectionView
    func bindCollectionView() {
        questionImageRelay.asObservable().bind(to: questionCollectionView.rx.items) { [self] (collectionView: UICollectionView, index: Int, element: UIImage) in
            let indexPath = IndexPath(item: index, section: 0)
            let cell = questionCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
            cell.imageView.image = questionImageList[indexPath.row]
            return cell
        }.disposed(by: disposeBag)
        
        explanationImageRelay.asObservable().bind(to: explanationCollectionView.rx.items) { [self] (collectionView: UICollectionView, index: Int, element: UIImage) in
            let indexPath = IndexPath(item: index, section: 0)
            let cell = explanationCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
            cell.imageView.image = explanationImageList[indexPath.row]
            return cell
        }.disposed(by: disposeBag)
    }
    
    func collectionReload(tag: Int) { // CollectionView의 Relay 이벤트 발생, 높이 수정
        if tag == 1 {
            questionImageRelay.accept(questionImageList)
            if questionImageList.count == 0 {
                questionCollectionView.snp.updateConstraints{
                    $0.height.equalTo(10) }
            } else {
                questionCollectionView.snp.updateConstraints{
                    $0.height.equalTo(CGFloat((questionImageList.count + 2) / 3) * collectionItemSize) }
            }
        } else {
            explanationImageRelay.accept(explanationImageList)
            if explanationImageList.count == 0 {
                explanationCollectionView.snp.updateConstraints{
                    $0.height.equalTo(10) }
            } else {
                explanationCollectionView.snp.updateConstraints{
                    $0.height.equalTo(CGFloat((explanationImageList.count + 2) / 3) * collectionItemSize) }
            }
        }
    }
}
