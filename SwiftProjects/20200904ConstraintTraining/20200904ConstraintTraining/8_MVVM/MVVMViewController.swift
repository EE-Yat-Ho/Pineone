//
//  MVVMViewController.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/10/06.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
import SnapKit
import Then



class MVVMViewController: UIViewController, ViewModelProtocol {
    
    typealias ViewModel = MVVMViewModel
    
    // MARK: - ViewModelProtocol
    var viewModel: ViewModel! = ViewModel()
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
    let questionImagePicker = UIImagePickerController().then {
        $0.sourceType = .savedPhotosAlbum
        $0.allowsEditing = false
    }
    let explanationImagePicker = UIImagePickerController().then {
        $0.sourceType = .savedPhotosAlbum
        $0.allowsEditing = false
    }
    
    let action = PublishRelay<Action>()
    let presentQImagePicker = PublishRelay<Void>()
    let presentEImagePicker = PublishRelay<Void>()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindingViewModel()
        setupLayout()
    }
    
    // MARK: - Binding
    func bindingViewModel() {
        let res = viewModel.transform(req: ViewModel.Input(action: action)) // 옵저버블만 넘겨주기 뷰모델은 관찰만하니까 
        
        // 뷰에 있는 테이블뷰, 콜렉션뷰, 버튼들, 텍스트입력에 의존성 주입
        subView.setupDI(answerList: res.answerList)
            .setupDI(questionImageList: res.questionImageList)
            .setupDI(explanationImageList: res.explanationImageList)
            .setupDI(action: self.action)

        // 뷰모델에서 내린 판단으로 어떤 이미지 피커를 올릴지 결정
        res.questionCameraObb.bind(to: presentQImagePicker).disposed(by: disposeBag)
        res.explanationCameraObb.bind(to: presentEImagePicker).disposed(by: disposeBag)
        
        presentQImagePicker.bind(onNext: { [weak self] in
            if let q = self?.questionImagePicker {
                self?.present(q, animated: true, completion: nil)
            }
        }).disposed(by: disposeBag)
        
        presentEImagePicker.bind(onNext: { [weak self] in
            if let e = self?.explanationImagePicker {
                self?.present(e, animated: true, completion: nil)
            }
        }).disposed(by: disposeBag)
        
        
        // 이미지 피커에서 이미지를 선택하면, 피커를 닫고 이미지를 뷰모델에 넘겨줌
        questionImagePicker.rx
            .didFinishPickingMediaWithInfo
            .asObservable()
            .do(onNext: { [weak self] _ in
                self?.questionImagePicker.dismiss(animated: true, completion: nil)
            })
            .map{ .questionImagePickerSelect($0[.originalImage] as? UIImage ?? UIImage()) }
            .bind(to: action)
            .disposed(by:disposeBag)
        
        explanationImagePicker.rx
            .didFinishPickingMediaWithInfo
            .asObservable()
            .do(onNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            })
            .map{ .explanationImagePickerSelect($0[.originalImage] as? UIImage ?? UIImage()) }
            .bind(to: action)
            .disposed(by:disposeBag)
    }
    
    // MARK: - View
    let subView = MVVMView()
    
    func setupLayout() {
        self.view.addSubview(subView)
        self.view.backgroundColor = UIColor.white
        subView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    deinit {
        print("VC deinit")
    }
}
