//
//  MoreSeeViewController.swift
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

class MoreSeeViewController: UIViewController, StoryboardBased, ViewModelProtocol {
    typealias ViewModel = MoreSeeViewModel

    // MARK: ViewModelProtocol
    var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupLayout()
        bindingViewModel()
    }

    override var showLoginTooltip: Bool {
        return true
    }

    // MARK: Binding
    func bindingViewModel() {
        _ = viewModel.transform(req: ViewModel.Input())
    }

    // MARK: SetView
    let subView = MoreSeeView()

    func setupLayout() {
        self.view.addSubview(subView)
        subView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
