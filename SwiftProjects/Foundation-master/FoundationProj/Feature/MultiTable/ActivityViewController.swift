//
//  ActivityViewContoller.swift
//  UPlusAR
//
//  Created by baedy on 2020/03/08.
//  Copyright © 2020 최성욱. All rights reserved.
//

import Reusable
import RxCocoa
import RxSwift
import SnapKit
import Then
import UIKit

class ActivityViewController: UIViewController, ViewModelProtocol {
    typealias ViewModel = ActivityViewModel

    // MARK: - ViewModelProtocol
    var viewModel: ViewModel!

    // MARK: - Properties

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupLayout()
        bindingViewModel()
    }

    // MARK: - Binding
    func bindingViewModel() {
        _ = viewModel.transform(req: ViewModel.Input())
    }
    
    //override
    override var showLoginTooltip: Bool {
        return true
    }

    // MARK: - View
    let subView = ActivityView()

    func setupLayout() {
        self.view.addSubview(subView)
        subView.snp.makeConstraints {
            $0.trailing.leading.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
}
