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
    private let userInputs = PublishRelay<UserInput>()
    private let systemInputs = PublishRelay<SystemInput>()
    private let systemOutputs = PublishRelay<SystemOutput>()
        
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        bindingViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        /// Init Data Load
        systemInputs.accept(.refreshData)
    }


    // MARK: - Input Observables to VM. SetUpDI to View use Output.
    func bindingViewModel() {
        /// Input VM, get Output.
        let response = viewModel.transform(
            req: RecentlyViewModel.Input(
                userInputs: userInputs.asObservable(),
                systemInputs: systemInputs.asObservable()
            )
        )
        
//        recentlyView.setupDI(observable: response.recentlyTableOv)
//        recentlyView.setupDI(changeShowType: response.changeShowType)
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

    // MARK: - Methods

}
