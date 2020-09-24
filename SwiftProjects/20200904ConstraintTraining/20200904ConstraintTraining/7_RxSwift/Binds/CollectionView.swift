
import UIKit

extension MultipleChoiceQuestionViewController_RxSwift { // CollectionView
    // 역시 Foundation 소스가 훨씬 깔끔함 굳굳
    func bindQuestionCollectionView() {
        questionImageRelay.asObservable().bind(to: questionCollectionView.rx.items(cellIdentifier: "CollectionCell", cellType: CollectionCell.self)) { [weak self]
            index, _, cell in
            cell.imageView.image = self!.questionImageList[index]
            
            // self 없이
        }.disposed(by: rx.disposeBag)
    }
    
    func bindExplanationCollectionView() {
        explanationImageRelay.asObservable().bind(to: explanationCollectionView.rx.items(cellIdentifier: "CollectionCell", cellType: CollectionCell.self)) {
            index, _, cell in
            cell.imageView.image = explanationImageList[index]
            
            // self 없이
        }.disposed(by: rx.disposeBag)
    }
}
