//
//  RecentlyViewController.swift
//  UPlusAR
//
//  Created by SukHo Song on 2020/04/09.
//  Copyright (c) 2020 최성욱. All rights reserved.
//

import Reusable
import RxCocoa
import RxSwift
import SnapKit
import Then
import UIKit

class RecentlyViewController: UIBaseViewController, ViewModelProtocol {
    // MARK: - ViewModelProtocol
    typealias ViewModel = RecentlyViewModel
    var viewModel: ViewModel!

    // MARK: - Properties
    private let inputAction = PublishRelay<InputAction>()
    private let tableRelay = PublishRelay<[RecentlyCellInfo]>()
        
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        bindingViewModel()
        
        /// Init Data Load
        inputAction.accept(.refreshData)
    }

    // MARK: - Input Observables to VM. SetUpDI to View use Output.
    func bindingViewModel() {
        /// 바인드를 위한 릴레이 교환
        let response = viewModel.transform(req: RecentlyViewModel.Input(inputAction: inputAction.asObservable()))
        
        /// VC가 View를 관찰하기 위한 DI
        recentlyView.setupDI(inputAction: inputAction)
            
        /// 비즈니스 로직 결과를 View가 관찰하기 위한 DI
        recentlyView.setupDI(tableOv: response.tableRelay.asObservable())
    }

    // MARK: - View
    let recentlyView = RecentlyView()

    func setupLayout() {
        self.view.addSubview(recentlyView)
        recentlyView.snp.makeConstraints {
            $0.trailing.leading.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(56)
        }
    }
}
