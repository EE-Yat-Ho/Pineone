//
//  LikeViewController.swift
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

class LikeViewController: UIBaseViewController, ViewModelProtocol {
    private let refreshTrigger = PublishRelay<Void>()
    private let showDetailTrigger = PublishRelay<RecentlyLikeList>()
    private let playContentTrigger = PublishRelay<RecentlyLikeList>()
    private let buttonActionTrigger = PublishRelay<ARTableViewHeaderActionType>()
    private let deleteItemsTrigger = PublishRelay<[IndexPath]>()

    private lazy var loadMoreTrigger: Observable<Void> = {
        return self.likeView.tableView.rx.contentOffset
            .flatMap {[unowned self] _ -> Observable<Void> in
                self.likeView.tableView.isNearBottomEdge(edgeOffset: 0) ? Observable.just(Void()) : Observable.empty()
            }
    }()

    typealias ViewModel = LikeViewModel

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
       // buttonActionTrigger.accept(.cancel)
    }

    // MARK: - Binding
    func bindingViewModel() {
        let response = viewModel.transform(req: LikeViewModel.Input(refreshTrigger: refreshTrigger.asObservable(),
            loadMoreTrigger: loadMoreTrigger.asObservable(),
            showDetailTrigger: showDetailTrigger.asObservable(),
            playContentTrigger: playContentTrigger.asObservable(),
            buttonActionTrigger: buttonActionTrigger.asObservable(),
            deleteItemsTrigger: deleteItemsTrigger.asObservable()
        ))

        likeView.setupDI(relay: refreshTrigger)
                .setupDI(relay: showDetailTrigger)
                .setupDI(relay: buttonActionTrigger)
                .setupDI(relay: deleteItemsTrigger)
                .setupDI(playRelay: playContentTrigger)

        // UI 데이터 셋팅
        likeView.setupDI(observable: response.likeList)
        likeView.updateView(action: response.buttonActionRelay)
        likeView.updateDeleteItem(observable: response.deleteItem)
    }

    // MARK: - View
    let likeView = LikeView()

    func setupLayout() {
        self.view.addSubview(likeView)
        likeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Methods

}
