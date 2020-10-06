//
//  RxSwifViewModel.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/10/06.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxFlow
import SnapKit
import Then
import NSObject_Rx

class MVVMViewModel: ViewModelType, Stepper {
    // MARK: - Stepper
    var steps = PublishRelay<Step>()
    
    // MARK: - Action
    
    // MARK: - Properties
    var answerList = [String]() // 텍스트 필드때매 써야함..
    let questionImagePicker = UIImagePickerController()
    let explanationImagePicker = UIImagePickerController()
    
    let answerRelay = BehaviorRelay<[String]>(value: [])
    let questionImageRelay = BehaviorRelay<[UIImage]>(value: [])
    let explanationImageRelay = BehaviorRelay<[UIImage]>(value: [])
    
    let disposeBag = DisposeBag()
    
    // MARK: - ViewModelType Protocol
    typealias ViewModel = MVVMViewModel
    
    struct Input {
        //var questionCameraAction: Observable<Void>
        //var explanationCameraAction: Observable<Void>
        //var answerPlusAction: Observable<Void>
    }
    
    struct Output {
        //let questionImageList: Observable<[UIImage]>
        //let explanationImageList: Observable<[UIImage]>
        //let answerList: Observable<[String]>
    }
    
    func transform(req: ViewModel.Input) -> ViewModel.Output {
        
        
//        req.questionCameraAction.bind{
//            self.questionImagePicker.sourceType = .savedPhotosAlbum
//            self.questionImagePicker.allowsEditing = false
//            present(questionImagePicker, animated: true, completion: nil)
//        }.disposed(by:disposeBag)
//
//        questionImagePicker.rx.didFinishPickingMediaWithInfo.asObservable()
//            .subscribe(onNext: { [weak self] // 섭스크라이브 쓰라하심
//                info in
//                self?.dismiss(animated: true, completion: nil)
//                if let img = info[.originalImage] as? UIImage{
//                    var list = self!.questionImageRelay.value
//                    list.append(img)
//                    self!.questionImageRelay.accept(list)
//                }
//            })
//            .disposed(by: disposeBag)
//
        return Output()
    }
}
