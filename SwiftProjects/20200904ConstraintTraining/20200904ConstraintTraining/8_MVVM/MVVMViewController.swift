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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        setupLayout()
        bindingViewModel()
    }
    
    
    
    // MARK: - Binding
    func bindingViewModel() {
        // 테이블 바인딩
        viewModel.answerRelay.do(onNext:{[weak self] data in
            if data.count == 0 {
                self?.subView.tableView.snp.updateConstraints{
                    $0.height.equalTo(10) }
            } else {
                self?.subView.tableView.snp.updateConstraints{
                    $0.height.equalTo(CGFloat(data.count) * 43.5) }
            }
        }).bind(to: subView.tableView.rx.items(cellIdentifier: "MVVMTableCell", cellType: MVVMTableCell.self)) { [weak self]
            index, data, cell in
            cell.delegate = self?.viewModel
            cell.setupDI(asset: AssetType(text: data, index: index))
        }.disposed(by: disposeBag)
        
        // 문제 콜렉션 바인딩
        viewModel.questionImageRelay.do(onNext:{ [weak self] data in
            if data.count == 0 {
                self?.subView.questionCollectionView.snp.updateConstraints{
                    $0.height.equalTo(10) }
            } else {
                self?.subView.questionCollectionView.snp.updateConstraints{
                    $0.height.equalTo(CGFloat((data.count + 2) / 3) * self!.subView.collectionItemSize) }
            }
        }).bind(to: subView.questionCollectionView.rx.items(cellIdentifier: "MVVMCollectionCell", cellType: MVVMCollectionCell.self)) {
            index, data, cell in
            cell.imageView.image = data//self!.questionImageList[index]
        }.disposed(by: disposeBag)
        
        // 풀이 콜렉션 바인딩
        viewModel.explanationImageRelay.do(onNext: { [weak self] data in
            if data.count == 0 {
                self?.subView.explanationCollectionView.snp.updateConstraints{
                    $0.height.equalTo(10) }
            } else {
                self?.subView.explanationCollectionView.snp.updateConstraints{
                    $0.height.equalTo(CGFloat((data.count + 2) / 3) * self!.subView.collectionItemSize)
                }
            }
        }).bind(to: subView.explanationCollectionView.rx.items(cellIdentifier: "MVVMCollectionCell", cellType: MVVMCollectionCell.self)) {
            index, data, cell in
            cell.imageView.image = data
        }.disposed(by: disposeBag)
        
        // +버튼 바인딩
        subView.plusButton.rx.tap.bind{ [weak self] in
            self?.viewModel.tapPlusButton()
        }.disposed(by:disposeBag)
        
        // 완료 버튼 바인딩
        subView.completeButton.rx.tap.bind{ [weak self] in
            self?.viewModel.tapCompleteButton(questionTextView: self!.subView.questionTextView, explanationTextView: self!.subView.explanationTextView, tableView: self!.subView.tableView)
            self?.navigationController?.popViewController(animated: true)
        }.disposed(by:disposeBag)
        
        // 문제 이미지 피커 바인딩
        questionImagePicker.rx.didFinishPickingMediaWithInfo.asObservable()
            .subscribe(onNext: { [weak self] // 섭스크라이브 쓰라하심
                info in
                self?.dismiss(animated: true, completion: nil)
                if let img = info[.originalImage] as? UIImage{
                    var list = self!.viewModel.questionImageRelay.value
                    list.append(img)
                    self!.viewModel.questionImageRelay.accept(list)
                }
            }).disposed(by: disposeBag)
        
        // 풀이 이미지 피커 바인딩
        explanationImagePicker.rx.didFinishPickingMediaWithInfo.asObservable()
            .subscribe(onNext: { [weak self]
                info in
                self?.dismiss(animated: true, completion: nil)
                if let img = info[.originalImage] as? UIImage{
                    var list = self!.viewModel.explanationImageRelay.value
                    list.append(img)
                    self!.viewModel.explanationImageRelay.accept(list)
                }
            }).disposed(by: disposeBag)
        
        // 문제 카메라버튼 바인딩
        subView.questionCameraButton.rx.tap.bind{ [weak self] in
            self?.questionImagePicker.sourceType = .savedPhotosAlbum
            self?.questionImagePicker.allowsEditing = false
            self?.present(self!.questionImagePicker, animated: true, completion: nil)
        }.disposed(by:disposeBag)
        
        // 풀이 카메라버튼 바인딩
        subView.explanationCameraButton.rx.tap.bind{ [weak self] in
            self?.explanationImagePicker.sourceType = .savedPhotosAlbum
            self?.explanationImagePicker.allowsEditing = false
            self?.present(self!.explanationImagePicker, animated: true, completion: nil)
        }.disposed(by:disposeBag)
        
        // 데이터 불러와서 accept하게하기
        viewModel.transform(req: ViewModel.Input())
    }
    
    // MARK: - View
    let subView = MVVMView()
    
    func setupLayout() {
        self.view.addSubview(subView)
        subView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
