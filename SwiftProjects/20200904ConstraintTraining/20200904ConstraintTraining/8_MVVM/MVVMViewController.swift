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

class MVVMViewController: UIBaseViewController, ViewModelProtocol {
    typealias ViewModel = MVVMViewModel
    
    let disposeBag = DisposeBag()
    
    // MARK: - ViewModelProtocol
    var viewModel: ViewModel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupLayout()
        bindingViewModel()
        
        //subView.hssView.refreshStackView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //self.subView.hssView.stackView.sizeToFit()
        //self.subView.hssView.stackView.layoutIfNeeded()
    }
    
    // MARK: - View
    let subView = MVVMView()
    
    // MARK: - Binding
    func bindingViewModel() {
        _ = viewModel.transform(req: ViewModel.Input())
        
        viewModel.questionImageRelay.do(onNext:{ [weak self] data in
            if data.count == 0 {
                self?.subView.questionCollectionView.snp.updateConstraints{
                    $0.height.equalTo(10) }
            } else {
                self?.subView.questionCollectionView.snp.updateConstraints{
                    $0.height.equalTo(CGFloat((data.count + 2) / 3) * (self?.subView.collectionItemSize)!) }
            }
        }).bind(to: subView.questionCollectionView.rx.items(cellIdentifier: "CollectionCell", cellType: CollectionCell.self)) {
            index, data, cell in
            cell.imageView.image = data//self!.questionImageList[index]
        }.disposed(by: disposeBag)
        
    }
    
    func setupLayout() {
        self.view.addSubview(subView)
        subView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
