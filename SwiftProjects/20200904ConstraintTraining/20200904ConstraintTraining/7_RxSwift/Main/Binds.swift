
import UIKit

extension MultipleChoiceQuestionViewController_RxSwift { // TableView
    // Foundation에서 한 방식이 훨씬 깔끔하네
    // indexPath 쓰고싶으면 let indexPath = IndexPath(item: index, section: 0)하셈
    func bindTableView() {
        answerRelay.do(onNext:{[weak self] data in
            if data.count == 0 {
                self?.tableView.snp.updateConstraints{
                    $0.height.equalTo(10) }
            } else {
                self?.tableView.snp.updateConstraints{
                    $0.height.equalTo(CGFloat(data.count) * 43.5) }
            }
        }).bind(to: tableView.rx.items(cellIdentifier: "TableCell", cellType: TableCell.self)) { [weak self]
            index, data, cell in
            cell.delegate = self
            cell.setupDI(asset: AssetType(text: data, index: index))
        }.disposed(by: disposeBag)
    }
    
    // 역시 Foundation 소스가 훨씬 깔끔함 굳굳
    func bindQuestionCollectionView() {
        questionImageRelay.do(onNext:{ [weak self] data in
            if data.count == 0 {
                self?.questionCollectionView.snp.updateConstraints{
                    $0.height.equalTo(10) }
            } else {
                self?.questionCollectionView.snp.updateConstraints{
                    $0.height.equalTo(CGFloat((data.count + 2) / 3) * self!.collectionItemSize) }
            }
        }).bind(to: questionCollectionView.rx.items(cellIdentifier: "CollectionCell", cellType: CollectionCell.self)) {
            index, data, cell in
            cell.imageView.image = data//self!.questionImageList[index]
        }.disposed(by: disposeBag)
    }
    
    func bindExplanationCollectionView() {
        explanationImageRelay.do(onNext: { [weak self] data in
            if data.count == 0 {
                self?.explanationCollectionView.snp.updateConstraints{
                    $0.height.equalTo(10) }
            } else {
                self?.explanationCollectionView.snp.updateConstraints{
                    $0.height.equalTo(CGFloat((data.count + 2) / 3) * self!.collectionItemSize)
                }
            }
        }).bind(to: explanationCollectionView.rx.items(cellIdentifier: "CollectionCell", cellType: CollectionCell.self)) {
            index, data, cell in
            cell.imageView.image = data//self!.explanationImageList[index]
        }.disposed(by: disposeBag)
    }
    
    func bindQuestionImagePickerController() {
        questionImagePicker.rx.didFinishPickingMediaWithInfo.asObservable()
            .subscribe(onNext: { [weak self] // 섭스크라이브 쓰라하심
                info in
                self?.dismiss(animated: true, completion: nil)
                if let img = info[.originalImage] as? UIImage{
                    var list = self!.questionImageRelay.value
                    list.append(img)
                    self!.questionImageRelay.accept(list)
                }
            })
            .disposed(by: disposeBag)
    }
    func bindExplanationImagePickerController() {
        explanationImagePicker.rx.didFinishPickingMediaWithInfo.asObservable()
            .subscribe(onNext: { [weak self]
                info in
                self?.dismiss(animated: true, completion: nil)
                if let img = info[.originalImage] as? UIImage{
                    var list = self!.explanationImageRelay.value
                    list.append(img)
                    self!.explanationImageRelay.accept(list)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func bindPlusButton() {
        plusButton.rx.tap.bind{ [weak self] in
            self?.tapPlusButton()
        }.disposed(by:disposeBag)
    }
    
    func bindQuestionCameraButton() {
        questionCameraButton.rx.tap.bind{ [weak self] in
            self?.tapQuestionCameraButton()
        }.disposed(by:disposeBag)
    }
    
    func bindExplanationCameraButton() {
        explanationCameraButton.rx.tap.bind{ [weak self] in
            self?.tapExplanationCameraButton()
        }.disposed(by:disposeBag)
    }
    
    func bindCompleteButton() {
        completeButton.rx.tap.bind{ [weak self] in
            self?.tapCompleteButton()
        }.disposed(by:disposeBag)
    }
    
}
