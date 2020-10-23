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
    /// 비즈니스 로직이 필요한 모든 입력을 ViewModel에 전달해주기 위한 릴레이
    private let inputAction = PublishRelay<InputAction>()
        
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        bindingViewModel()
        
        /// Init Data Load
        inputAction.accept(.refreshData)
    }

    // MARK: - Input Observables & Get Relay to VM. SetupDI to View use VM's Output.
    func bindingViewModel() {
        /// 바인드를 위한 VM과의 릴레이 교환
        let response = viewModel.transform(req: RecentlyViewModel.Input(inputAction: inputAction.asObservable()))
        
        /// [View -(emit)-> VC]
        /// VC가 View를 관찰하여 inputAction을 받기 위한 DI
        recentlyView.setupDI(inputAction: inputAction)
            
        /// [View <-(emit)- VC]
        /// 비즈니스 로직 결과를 View가 관찰하기 위한 DI
        recentlyView.setupDI(tableOv: response.tableRelay.asObservable())
                    .setupDI(deleteCompleteOv: response.deleteComplete.asObservable())
                    //.setupDI(deleteModeSelectOv: response.deleteModeSelect.asObservable())
        /// normalModeSelect 인 경우, Cell Detial로 넘어가게 VC에서 바인드
//        response
//            .normalModeSelect
//            .on(next: { print("indexRow = \($0). cellDetail")})
//            .disposed(by: rx.disposeBag)
        
    }

    // MARK: - View
    let recentlyView = RecentlyView()

    func setupLayout() {
        self.view.addSubview(recentlyView)
        recentlyView.snp.makeConstraints {
            $0.trailing.leading.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
}
