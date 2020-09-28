
import UIKit

extension MultipleChoiceQuestionViewController_RxSwift { // CollectionView
    // 역시 Foundation 소스가 훨씬 깔끔함 굳굳
    func bindQuestionCollectionView() {
        
        questionImageRelay.bind(to: questionCollectionView.rx.items(cellIdentifier: "CollectionCell", cellType: CollectionCell.self)) {
            index, data, cell in
            cell.imageView.image = data//self!.questionImageList[index]
            
            // self 없이 // data쓰니까 되네 ㅆ
        }.disposed(by: disposeBag)
    }
    
    func bindExplanationCollectionView() {
        explanationImageRelay.bind(to: explanationCollectionView.rx.items(cellIdentifier: "CollectionCell", cellType: CollectionCell.self)) {
            index, data, cell in
            cell.imageView.image = data//self!.explanationImageList[index]
            
            // self 없이
        }.disposed(by: disposeBag)
    }
}
