//
//  DownloadViewModel.swift
//  UPlusAR
//
//  Created by SukHo Song on 2020/04/09.
//  Copyright (c) 2020 최성욱. All rights reserved.
//

import Action
import RxCocoa
import RxFlow
import RxSwift
import UIKit
import Unrealm

class DownloadViewModel: ViewModelType, Stepper {
    
    // MARK: - Stepper
    var steps = PublishRelay<Step>()

    // MARK: - ViewModelType Protocol
    typealias ViewModel = DownloadViewModel

    static let DOWNLOAD_LIST_COUNT_MAX = 30

    let disposeBag = DisposeBag()
    var downloadList = BehaviorRelay(value: [RealmMyDownloadFile]())
    let downloadNotications = PublishRelay<Notification>()
    var buttonActionRelay = PublishRelay<ARTableViewHeaderActionType>()
    var currentSortType: DownloadSortingType = .download
    let sortTypeRelay = PublishRelay<DownloadSortingType>()

    var RetryCount = 1
    var getAllDownloads = false

//    private lazy var loadDownloadDataAction = Action<(Void), [RealmMyDownloadFile]>(workFactory: { [weak self] _ in
//        guard let `self` = self else { return Observable.never() }
//        if let data = MyDownloadDatabaseService.current.myDownloadContents {
//            var result = data.map { $0 }
//            if self.currentSortType == .download {
//                let results = data.map { $0 }
//                        .sorted(by: { $0.createDate!.compare($1.createDate!) == .orderedDescending })
//                        .gaurdGetItems(withIndex: DownloadViewModel.DOWNLOAD_LIST_COUNT_MAX * self.RetryCount)
//                if results.count < DownloadViewModel.DOWNLOAD_LIST_COUNT_MAX * self.RetryCount {
//                    self.getAllDownloads = true
//                }
//                self.RetryCount += 1
//                return Observable.just(results)
//            } else {
//                let results = data.map { $0 }
//                        .sorted(by: { $0.allDownloadFilesByte > $1.allDownloadFilesByte })
//                        .gaurdGetItems(withIndex: DownloadViewModel.DOWNLOAD_LIST_COUNT_MAX * self.RetryCount)
//                if results.count < DownloadViewModel.DOWNLOAD_LIST_COUNT_MAX * self.RetryCount {
//                    self.getAllDownloads = true
//                }
//                self.RetryCount += 1
//                return Observable.just(results)
//            }
//        }
//        return Observable.never()
//    })

    // 버튼 동작 Action
    lazy var buttonAction = Action<ARTableViewHeaderActionType, Void> { [weak self] in
        guard let `self` = self else { return .empty() }
        switch $0 {
        case .delete:
            //self.sortedListAction.execute(.download)
            self.sortTypeRelay.accept(.download)
            self.buttonActionRelay.accept(.delete)
        case .check:
            self.buttonActionRelay.accept(.check)
        case .cancel:
            self.buttonActionRelay.accept(.cancel)
        case .dropdown:
            self.buttonActionRelay.accept(.dropdown)
        default:
            break
        }
        return .empty()
    }

//    private lazy var deleteItemsAction = Action<[IndexPath], Void>(workFactory: { [weak self] indexPaths in
//        guard let `self` = self else { return .empty() }
//        var selectKeys: [String] = []
//        for indexPath in indexPaths {
//            DownloadManager.shared.cancelDownload(forUniqueKey: Int(self.downloadList.value[indexPath.row].key))
////            MyDownloadDatabaseService.current.deleteMyDownload(key: String(self.downloadList.value[indexPath.row].key))
//        }
//        return Observable.just(())
//    })
//
//    private lazy var sortedListAction = Action<DownloadSortingType, [RealmMyDownloadFile]>(workFactory: { [weak self] sort in
//        guard let `self` = self else { return Observable.never() }
//        self.currentSortType = sort
//        if let data = MyDownloadDatabaseService.current.myDownloadContents {
//            if sort == .download {
//                let results = data
//                    .map { $0 }
//                    .sorted(by: { $0.createDate!.compare($1.createDate!) == .orderedDescending })
//                    .gaurdGetItems(withIndex: DownloadViewModel.DOWNLOAD_LIST_COUNT_MAX * self.RetryCount)
//
//                return Observable.just(results)
//            } else {
//                return Observable.just(data.map { $0 }
//                                        .sorted(by: { $0.allDownloadFilesByte > $1.allDownloadFilesByte })
//                                        .gaurdGetItems(withIndex: DownloadViewModel.DOWNLOAD_LIST_COUNT_MAX * self.RetryCount))
//            }
//        }
//        return Observable.never()
//    })

    struct Input {
        let refreshTrigger: Observable<Void>
        let loadMoreTrigger: Observable<Void>
        let showDetailTrigger: Observable<RealmMyDownloadFile>
        let playContentTrigger: Observable<RealmMyDownloadFile>
        let buttonActionTrigger: Observable<ARTableViewHeaderActionType>
        let deleteItemsTrigger: Observable<[IndexPath]>
        let sortItemsTrigger: Observable<DownloadSortingType>
    }

    struct Output {
        let downloadList: BehaviorRelay<[RealmMyDownloadFile]>
        let buttonActionRelay: PublishRelay<ARTableViewHeaderActionType>
        let downloadNotications: PublishRelay<Notification>
        //let deleteItem: Observable<Void>
        let sortType: PublishRelay<DownloadSortingType>
    }

    func transform(req: ViewModel.Input) -> ViewModel.Output {
//        req.refreshTrigger
//            .bind(to: loadDownloadDataAction.inputs)
//            .disposed(by: disposeBag)
//
//        req.refreshTrigger.on(next: { [weak self] _ in
//            guard let `self` = self else { return }
//            self.RetryCount = 1
//            self.getAllDownloads = false
//        }).disposed(by: disposeBag)
//
//        req.loadMoreTrigger
//            .filter { [weak self] in
//                guard let `self` = self else { return false }
//                return !self.getAllDownloads
//            }
//            .bind(to: loadDownloadDataAction.inputs)
//            .disposed(by: disposeBag)

//        loadDownloadDataAction
//            .elements
//            .flatMap { data -> Observable<[RealmMyDownloadFile]> in
//                var dummy: [RealmMyDownloadFile] = []
//                for list in data {
//                    if list.downloadStatus == .completed || list.downloadStatus == .downloading || list.downloadStatus == .paused {
//                        dummy.append(list)
//                    }
//                }
//                return Observable.just(dummy)
//            }
//            .bind(to: downloadList).disposed(by: disposeBag)

//        req.sortItemsTrigger
//            .bind(to: sortedListAction.inputs)
//            .disposed(by: disposeBag)

//        sortedListAction
//            .elements
//            .flatMap { data -> Observable<[RealmMyDownloadFile]> in
//                var dummy: [RealmMyDownloadFile] = []
//                for list in data {
//                    if list.downloadStatus == .completed || list.downloadStatus == .downloading || list.downloadStatus == .paused {
//                        dummy.append(list)
//                    }
//                }
//                return Observable.just(dummy)
//            }
//            .bind(to: downloadList).disposed(by: disposeBag)

        // 컨텐츠 상세화면 Event
//        req.showDetailTrigger
//            .filter {
//                if let dt = $0.end_dt?.getJavaTimestampDate() {
//                    return dt > Date()
//                } else { return true }
//            }
//            .subscribe(onNext: { [weak self] item in
//                guard self != nil else { return }
//                Log.d("item = \(item.key)")
//                let key = Int(item.key)!
//
//                self?.loadDeatailDataAction(isDetail: true, item, key)
//            })
//            .disposed(by: disposeBag)
//
//        // 컨텐츠 바로 실행
//        req.playContentTrigger
//            .filter {
//                if let dt = $0.end_dt?.getJavaTimestampDate() {
//                    return dt > Date()
//                } else { return true }
//            }
//            .subscribe(onNext: { [weak self] item in
//                guard self != nil else { return }
//                Log.d("item = \(item.key)")
//                let key = Int(item.key)!
//
//                self?.loadDeatailDataAction(isDetail: false, item, key)
//            })
//            .disposed(by: disposeBag)

        // 버튼 Action
        req.buttonActionTrigger
            .bind(to: buttonAction.inputs)
            .disposed(by: disposeBag)

//        Observable
//            .from(DownloadManager.downloadNotifications)
//            .merge()
//            .bind(to: downloadNotications)
//            .disposed(by: disposeBag)

//        req.deleteItemsTrigger
//            .bind(to: deleteItemsAction.inputs)
//            .disposed(by: disposeBag)

        return Output(downloadList: downloadList,
                      buttonActionRelay: buttonActionRelay,
                      downloadNotications: downloadNotications,
                      //deleteItem: deleteItemsAction.elements,
                      sortType: sortTypeRelay)
    }

//    func loadDeatailDataAction(isDetail: Bool, _ item: RealmMyDownloadFile, _ key: Int) {
//        if true {//ReachabilityManager.isConnected {
//            //_ = NetworkService.getContentDetail(contentsKey: String(key)).asObservable().on(next: { [unowned self] _ in
//            if item.adult_yn == .Y {//, ContentLockManager.current.currentLockState == .locked {
//                //ContentLockManager.current.isLockSettingCheck { result in
//                   // if result {
//                        ActivityStepper.shared.steps.accept(AppStep.navigationARPlayer(isDetail: isDetail, contentKey: key, playList: []))
//                 //   }
//                //}
//            } else {
//                ActivityStepper.shared.steps.accept(AppStep.navigationARPlayer(isDetail: isDetail, contentKey: key, playList: []))
//            }
//            }, error: { [unowned self] _, _, _ in
//                LoadingService.shared.hide()
//                var lists = self.downloadList.value
//                let endDt = Date(timeIntervalSinceNow: -5000).timeIntervalSince1970 * 1000
//
//                if let row = lists.firstIndex(where: { $0.key == item.key }) {
//                    lists[row].end_dt = endDt
//                    self.downloadList.accept(lists)
//                }
//
//                var newItem = item
//                newItem.end_dt = endDt
//
//                MyDownloadDatabaseService.current.overWriteDownloadContents(item: newItem)
//            })
//        } else {
            // 네트워크 미연결시
//            if item.adult_yn == .Y {//}, ContentLockManager.current.currentLockState == .locked {
//                ContentLockManager.current.isLockSettingCheck { result in
//                    if result {
//                        ActivityStepper.shared.steps.accept(MainSteps.navigationARPlayer(isDetail: isDetail, contentKey: key, playList: []))
//                    }
//                }
//            } else {
//                ActivityStepper.shared.steps.accept(MainSteps.navigationARPlayer(isDetail: isDetail, contentKey: key, playList: []))
//            }
        //}
    //}
}
