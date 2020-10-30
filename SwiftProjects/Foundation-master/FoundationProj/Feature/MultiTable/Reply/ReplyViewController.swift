//
//  ReplyViewController.swift
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

class ReplyViewController: UIBaseViewController, ViewModelProtocol {
    private let refreshTrigger = PublishRelay<Void>()
    private lazy var loadMoreTrigger: Observable<Void> = {
        return self.replyView.tableView.rx.contentOffset
            .flatMap { _ -> Observable<Void> in
                self.replyView.tableView.isNearBottomEdge() ? Observable.just(Void()) : Observable.empty()
            }
    }()
    private let showDetailTrigger = PublishRelay<ReplyList>()
    private let buttonActionTrigger = PublishRelay<ARTableViewHeaderActionType>()
    private let deleteItemsTrigger = PublishRelay<[IndexPath]>()

    typealias ViewModel = ReplyViewModel

    // MARK: - ViewModelProtocol
    var viewModel: ViewModel!

    // MARK: - Properties

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupLayout()
        bindingViewModel()
        refreshTrigger.accept(())
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        buttonActionTrigger.accept(.cancel)
    }

    // MARK: - Binding
    func bindingViewModel() {
        let input = ViewModel.Input(refreshTrigger: refreshTrigger.asObservable(),
                                    loadMoreTrigger: loadMoreTrigger.asObservable(),
                                    showDetailTrigger: showDetailTrigger.asObservable(),
                                    buttonActionTrigger: buttonActionTrigger.asObservable(),
                                    deleteItemsTrigger: deleteItemsTrigger.asObservable())

        let response = viewModel.transform(req: input)

        replyView.setupDI(relay: showDetailTrigger)
                .setupDI(relay: buttonActionTrigger)
                .setupDI(relay: deleteItemsTrigger)
                .setupDI(relay: refreshTrigger)

        // UI 데이터 셋팅
        replyView.setupDI(observable: response.replyList)
        replyView.updateView(action: response.buttonActionRelay)
        replyView.updateDeleteItem(observable: response.deleteItem)
        replyView.deSelectRowAll(observable: response.deselectRow)
    }

    // MARK: - View
    let replyView = ReplyView()

    func setupLayout() {
        self.view.addSubview(replyView)
        replyView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Methods

}
