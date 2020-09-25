
import UIKit
import RxSwift
import RxCocoa

extension MultipleChoiceQuestionViewController_RxSwift { // ImagePicker 와 이게 되네 ㅆㅆㅆㅆㅅ
    func bindQuestionImagePickerController() {
        questionImagePicker.rx.didFinishPickingMediaWithInfo.asObservable()
            .subscribe(onNext: { [weak self] // 섭스크라이브 쓰라하심
                info in
                self?.dismiss(animated: true, completion: nil)
                if let img = info[.originalImage] as? UIImage{
                    self?.questionImageList.append(img)
                    self?.reloadQuestionCollectionView()
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
                    self?.explanationImageList.append(img)
                    self?.reloadExplanationCollectionView()
                }
            })
            .disposed(by: disposeBag)
    }

}
