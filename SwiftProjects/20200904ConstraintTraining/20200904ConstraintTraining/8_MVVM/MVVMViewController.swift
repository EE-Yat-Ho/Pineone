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
    // 여기 느낌표는 프로토콜이라 어쩔 수 없는거 같은데?
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
    
    // Publish인 이유 : 지난 데이터를 가지고 있을 필요 없음.
    // Observable이 아닌 Reley인 이유 : 버튼들, 텍스트필드 입력들을 관찰하고있고, VC에게 관찰 당함.
    // Subject가 아닌 Relay인 이유 : UI이벤트를 처리하기 때문.
    let action = PublishRelay<Action>()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindingViewModel()
        setupLayout()
    }
    
    // MARK: - Binding
    func bindingViewModel() {
        // VM에서 관찰 할 수 있도록 액션을 넘겨주고,
        // 테이블과 콜렉션들이 관찰 하기 위한 옵저버블과,
        // 이미지 피커를 띄우는 클로저가 관찰하기 위한 옵저버블을 받음
        let res = viewModel.transform(req: ViewModel.Input(action: action.asObservable())) // 옵저버블만 넘겨주기 뷰모델은 관찰만하니까 
        
        // VM에서 받은 옵저버블로 뷰에 있는 테이블과 콜렉션에 의존성을 주입.
        // 뷰에서 들어오는 액션을 받기위해 VC에 있는 릴레이로 의존성 주입.
        subView.setupDI(answerList: res.answerList)
            .setupDI(questionImageList: res.questionImageList)
            .setupDI(explanationImageList: res.explanationImageList)
            .setupDI(action: self.action)

        // 뷰모델에서 내린 판단으로 이미지 피커 올리기
        res.questionCameraObb.bind(onNext: { [weak self] in
            if let q = self?.questionImagePicker {
                self?.present(q, animated: true, completion: nil)
            }
        }).disposed(by: disposeBag)
        res.explanationCameraObb.bind(onNext: { [weak self] in
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
