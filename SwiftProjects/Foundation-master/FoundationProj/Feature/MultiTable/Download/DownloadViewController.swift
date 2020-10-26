//
//  DownloadViewController.swift
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

class DownloadViewController: UIBaseViewController, ViewModelProtocol {
//    private let refreshTrigger = PublishRelay<Void>()
//    private let showDetailTrigger = PublishRelay<RealmMyDownloadFile>()
//    private let playContentTrigger = PublishRelay<RealmMyDownloadFile>()
//    private let buttonActionTrigger = PublishRelay<ARTableViewHeaderActionType>()
//    private let deleteItemsTrigger = PublishRelay<[IndexPath]>()
//    private let sortItemsTrigger = PublishRelay<DownloadSortingType>()
//
//    private lazy var loadMoreTrigger: Observable<Void> = {
//        return self.downloadView.tableView.rx.contentOffset
//            .flatMap {[unowned self] _ -> Observable<Void> in
//                self.downloadView.tableView.isNearBottomEdge(edgeOffset: 0) ? Observable.just(Void()) : Observable.empty()
//            }
//    }()

    typealias ViewModel = DownloadViewModel

    // MARK: - ViewModelProtocol
    var viewModel: ViewModel!

    // MARK: - Properties

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupLayout()
        //bindingViewModel()
        //refreshTrigger.accept(())
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //refreshTrigger.accept(())
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //buttonActionTrigger.accept(.cancel)
    }

    // MARK: - Binding
//    func bindingViewModel() {
//        let response = viewModel.transform(req: ViewModel.Input(refreshTrigger: refreshTrigger.asObservable(),
//                                                                loadMoreTrigger: loadMoreTrigger.asObservable(),
//                                                                showDetailTrigger: showDetailTrigger.asObservable(),
//                                                                playContentTrigger: playContentTrigger.asObservable(),
//                                                                buttonActionTrigger: buttonActionTrigger.asObservable(),
//                                                                deleteItemsTrigger: deleteItemsTrigger.asObservable(),
//                                                                sortItemsTrigger: sortItemsTrigger.asObservable()
//        ))
//
//        // 상단 Refresh Binding
//        downloadView
//            .refreshControl
//            .rx
//            .refreshTrigger
//            .bind(to: refreshTrigger)
//            .disposed(by: rx.disposeBag)
//
//        // Sorting Binding
//        downloadView
//            .sortItemsTrigger
//            .bind(to: sortItemsTrigger)
//            .disposed(by: rx.disposeBag)
//
//        // View UI Binding
//        downloadView
//            .buttonActionTrigger
//            .bind(to: buttonActionTrigger)
//            .disposed(by: rx.disposeBag)
//
//        // 삭제모드 아닌 경우, 컨텐츠 상세 화면 진입
//        downloadView
//            .showDetailTrigger
//            .bind(to: showDetailTrigger)
//            .disposed(by: rx.disposeBag)
//
//        // 플레이 버튼, 컨텐츠 플레이
//        downloadView
//            .playContentTrigger
//            .bind(to: playContentTrigger)
//            .disposed(by: rx.disposeBag)
//
//        // 삭제 Item Binding
//        downloadView
//            .deleteItemsTrigger
//            .bind(to: deleteItemsTrigger)
//            .disposed(by: rx.disposeBag)
//
//        downloadView.setupDI(observable: response.downloadList)
//        downloadView.updateView(action: response.buttonActionRelay)
//        downloadView.setupDI(relay: response.downloadNotications)
//        downloadView.setupDI(sortType: response.sortType)
//        downloadView.updateDeleteItem(observable: response.deleteItem)
//    }

    // MARK: - View
    let downloadView = DownloadView()

    func setupLayout() {
        self.view.addSubview(downloadView)
        downloadView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(100)
        }
    }

    // MARK: - Methods

}
