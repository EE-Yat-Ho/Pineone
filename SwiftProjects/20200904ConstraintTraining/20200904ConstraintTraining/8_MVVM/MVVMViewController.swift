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
    
    let questionImagePicker = UIImagePickerController()
    let explanationImagePicker = UIImagePickerController()
    
    let action = PublishRelay<Action>()
    let camera = PublishRelay<CameraAction>()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindingViewModel()
        setupLayout()
        configure()
    }
    
    
    
    // MARK: - Binding
    func bindingViewModel() {
        let res = viewModel.transform(req: ViewModel.Input(action: action))
        
        subView.setupDI(observable: res.answerList)
            .setupDI(questionImageList: res.questionImageList)
            .setupDI(explanationImageList: res.explanationImageList)
            .setupDI(action: self.action)
            .setupDI(camera: camera)

        
        camera.bind(onNext: { [weak self] cameraAction in
            switch cameraAction {
            case .question:
                self!.present(self!.questionImagePicker, animated: true, completion: nil)
            case .explanation:
                self!.present(self!.explanationImagePicker, animated: true, completion: nil)
            }
        }).disposed(by: disposeBag)
          
        questionImagePicker.rx
            .didFinishPickingMediaWithInfo
            .asObservable()
            .do(onNext: { [weak self] _ in
                self!.questionImagePicker.dismiss(animated: true, completion: nil)
            })
            .map{ .questionImagePickerSelect($0[.originalImage] as! UIImage) }
            .bind(to: action)
            .disposed(by:disposeBag)
        
        explanationImagePicker.rx
            .didFinishPickingMediaWithInfo
            .asObservable()
            .do(onNext: { [weak self] _ in
                self!.dismiss(animated: true, completion: nil)
            })
            .map{ .explanationImagePickerSelect($0[.originalImage] as! UIImage) }
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
    
    func configure() {
        questionImagePicker.sourceType = .savedPhotosAlbum
        questionImagePicker.allowsEditing = false
        explanationImagePicker.sourceType = .savedPhotosAlbum
        explanationImagePicker.allowsEditing = false
    }

}
