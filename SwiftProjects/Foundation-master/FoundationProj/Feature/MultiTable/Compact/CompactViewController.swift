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

class CompactViewController: UIBaseViewController, ViewModelProtocol {
    // MARK: - ViewModelProtocol
    typealias ViewModel = CompactViewModel
    var viewModel: ViewModel!

    // MARK: - Properties
    /// 비즈니스 로직이 필요한 모든 입력을 ViewModel에 전달해주기 위한 릴레이
    private let inputAction = PublishRelay<InputAction>()
    var activityDetail: ActivityDetail = .recently

    init(activityDetail: ActivityDetail) {
        super.init(nibName:nil, bundle:nil)
        self.activityDetail = activityDetail
    }

    // This is also necessary when extending the superclass.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented") // or see Roman Sausarnes's answer
    }
    
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
        let response = viewModel.transform(req: CompactViewModel.Input(inputAction: inputAction.asObservable()))
        
        /// [View -(emit)-> VC]
        /// VC가 View를 관찰하여 inputAction을 받기 위한 DI
        compactView.setupDI(inputAction: inputAction)
            
        /// [View <-(emit)- VC]
        /// 비즈니스 로직 결과를 View가 관찰하기 위한 DI
        compactView.setupDI(tableOv: response.tableRelay.asObservable())
                    .setupDI(deleteCompleteOv: response.deleteComplete.asObservable())
    }

    // MARK: - View
    lazy var compactView = CompactView(activityDetail: activityDetail)

    func setupLayout() {
        self.view.addSubview(compactView)
        compactView.snp.makeConstraints {
            $0.trailing.leading.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
}
