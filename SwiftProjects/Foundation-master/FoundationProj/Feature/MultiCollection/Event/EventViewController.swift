//
//  EventViewController.swift
//  UPlusAR
//
//  Created by baedy on 2020/03/23.
//  Copyright © 2020 최성욱. All rights reserved.
//

import NSObject_Rx
import Reusable
import RxCocoa
import RxSwift
import SnapKit
import Then
import UIKit

class EventViewController: UIViewController, StoryboardBased, ViewModelProtocol {
    typealias ViewModel = EventViewModel

    let triggerRelay = PublishRelay<Void>()

    // MARK: ViewModelProtocol
    var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupLayout()
        bindingViewModel()
        triggerRelay.accept(())
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: Binding
    func bindingViewModel() {
        let response = viewModel.transform(req: ViewModel.Input(dataLoadTrigger: triggerRelay.asObservable(),
                                                                modelSelect: eventView.eventTableView.rx.modelSelected(FDEvent.self).asObservable()))

        eventView
            .refreshControl
            .rx
            .refreshTrigger
            .bind(to: triggerRelay)
            .disposed(by: rx.disposeBag)

        eventView.setupDI(observable: response.events)
    }

    // MARK: SetView
    let eventView = EventView()

    func setupLayout() {
        self.view.addSubview(eventView)
        eventView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
