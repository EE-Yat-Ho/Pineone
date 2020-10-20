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
    private let refreshTrigger = PublishRelay<Void>()
    private let showDetailTrigger = PublishRelay<RecentlyLikeList>()
    private let playContentTrigger = PublishRelay<RecentlyLikeList>()
    private let buttonActionTrigger = PublishRelay<ARTableViewHeaderActionType>()
    private let deleteItemsTrigger = PublishRelay<[IndexPath]>()

    // 넌뭐니 대췌..? 옵저버블이네 ㅎㅇ
    // 근데 테이블뷰의 콘텐츠오프셋을 flatMap(바텀엣지와 가까운가) 해서, 아 맨밑에 스크롤하면 더 로드하는 그거같은데?
    private lazy var loadMoreTrigger: Observable<Void> = {
        return self.recentlyView.tableView.rx.contentOffset
            .flatMap {[unowned self] _ -> Observable<Void> in
                self.recentlyView.tableView.isNearBottomEdge(edgeOffset: 0) ? Observable.just(Void()) : Observable.empty()
            }
    }()

    typealias ViewModel = RecentlyViewModel

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
        let response = viewModel.transform(req: RecentlyViewModel.Input(refreshTrigger: refreshTrigger.asObservable(),
                loadMoreTrigger: loadMoreTrigger.asObservable(),
                showDetailTrigger: showDetailTrigger.asObservable(),
                playContentTrigger: playContentTrigger.asObservable(),
                buttonActionTrigger: buttonActionTrigger.asObservable(),
                deleteItemsTrigger: deleteItemsTrigger.asObservable()
))

        recentlyView.setupDI(relay: refreshTrigger)
                .setupDI(relay: showDetailTrigger)
                .setupDI(relay: buttonActionTrigger)
                .setupDI(relay: deleteItemsTrigger)
                .setupDI(playRelay: playContentTrigger)

        // UI 데이터 셋팅
        recentlyView.setupDI(observable: response.recentlyList)
        recentlyView.updateView(action: response.buttonActionRelay)
        recentlyView.updateDeleteItem(observable: response.deleteItem)
    }

    // MARK: - View
    let recentlyView = RecentlyView()

    func setupLayout() {
        self.view.addSubview(recentlyView)
        recentlyView.snp.makeConstraints {
            //$0.edges.equalToSuperview()
            $0.trailing.leading.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(56)
        }
    }

    // MARK: - Methods

}
