//
//  RecentlyViewModel.swift
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

class RecentlyViewModel: ViewModelType, Stepper {
    // MARK: - Stepper
    var steps = PublishRelay<Step>()

    // MARK: - ViewModelType Protocol
    typealias ViewModel = RecentlyViewModel
    let disposeBag = DisposeBag()
    static let RECENTLY_LIST_COUNT_MAX = 30
    var testRecentlyLikeList = [
        RecentlyLikeList(
            key: 0,
            name: "performance,adultN,dwonN",
            type: .performance,
            image_url: nil,
            playtime: "10:00",
            req_date: 10,
            visible_yn: "Y",
            sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),
            type_badge_url: nil,
            event_badge_url: nil,
            start_dt: 1,
            end_dt: 200000000000000000,
            adult_yn: "N",
            downloadable: .N),
        RecentlyLikeList(
            key: 0,
            name: "andGame,adultY,dwonN",
            type: .aosInstallGame,
            image_url: nil,
            playtime: "10:00",
            req_date: 10,
            visible_yn: "Y",
            sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),
            type_badge_url: nil,
            event_badge_url: nil,
            start_dt: 1,
            end_dt: 200000000000000000,
            adult_yn: "Y",
            downloadable: .N),
        RecentlyLikeList(
            key: 0,
            name: "iosGame,adultY,dwonY",
            type: .iosInstallGame,
            image_url: nil,
            playtime: "10:00",
            req_date: 10,
            visible_yn: "Y",
            sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),
            type_badge_url: nil,
            event_badge_url: nil,
            start_dt: 1,
            end_dt: 200000000000000000,
            adult_yn: "Y",
            downloadable: .Y)
    ]
    
//    var testRecentlyLikeList: [RecentlyLikeList] = []
    
    lazy var recentlyList = BehaviorRelay(value: testRecentlyLikeList + testRecentlyLikeList + testRecentlyLikeList + testRecentlyLikeList + testRecentlyLikeList + testRecentlyLikeList)
    var deleteItem = BehaviorRelay(value: String())
    var buttonActionRelay = PublishRelay<ARTableViewHeaderActionType>()

    var recentlyCursor: String?
    var recentlyTotalCount = 0 ///

//    private lazy var loadMoreRecentlyDataAction = Action<(Void), ContentsRecentlyLike>(workFactory: { [weak self] in
//        return NetworkService.getUserContents(type: .view, cursor: self?.recentlyCursor, count: RecentlyViewModel.RECENTLY_LIST_COUNT_MAX)
//    })
//
//    private lazy var loadRecentlyDataAction = Action<(Void), ContentsRecentlyLike>(workFactory: {
//        return NetworkService.getUserContents(type: .view, count: RecentlyViewModel.RECENTLY_LIST_COUNT_MAX)
//    })
//
//    private lazy var deleteRecentlyDataAction = Action<(String), String>(workFactory: { keys in
//        return NetworkService.deleteUserContents(type: .view, contentsKey: keys)
//    })

    // 버튼 동작 Action
    lazy var buttonAction = Action<ARTableViewHeaderActionType, Void> { [weak self] in
        guard let `self` = self else { return .empty() }
        switch $0 {
        case .delete:
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

    // 삭제 동작 Action
    private lazy var deleteItemsAction = Action<[IndexPath], Void>(workFactory: { [weak self] indexPaths in
        guard let `self` = self else { return .empty() }
        var selectKeys: [String] = []
        for indexPath in indexPaths {
            if let key = self.recentlyList.value[indexPath.row].key {
                selectKeys.append(String(key))
            }
        }
        let result = selectKeys.joined(separator: ",")
        //self.deleteRecentlyDataAction.execute(result)
        return .empty()
    })

    struct Input {
        let refreshTrigger: Observable<Void>
        let loadMoreTrigger: Observable<Void>
        let showDetailTrigger: Observable<RecentlyLikeList>
        let playContentTrigger: Observable<RecentlyLikeList>
        let buttonActionTrigger: Observable<ARTableViewHeaderActionType>
        let deleteItemsTrigger: Observable<[IndexPath]>
    }

    struct Output {
        let recentlyList: BehaviorRelay<[RecentlyLikeList]>
        let buttonActionRelay: PublishRelay<ARTableViewHeaderActionType>
        let deleteItem: BehaviorRelay<String>
    }

    func transform(req: ViewModel.Input) -> ViewModel.Output {
        // Refresh Event
//        req.refreshTrigger
//            .bind(to: loadRecentlyDataAction.inputs)
//            .disposed(by: disposeBag)
//
//        req.loadMoreTrigger
//            .filter {[weak self] in
//                return self?.recentlyCursor != nil
//            }
//            .bind(to: loadMoreRecentlyDataAction.inputs)
//            .disposed(by: disposeBag)

        // Recently Data Binding
//        loadRecentlyDataAction
//            .elements
//            .flatMap {[weak self] recentlyData -> Observable<[RecentlyLikeList]> in
//                self?.recentlyCursor = recentlyData.next_cursor
//
//                var dummyRecently: [RecentlyLikeList] = []
//                if let recentlyList = recentlyData.contents_list {
//                    for list in recentlyList {
//                        if let adult = list.adult_yn, adult == "Y", let block = ContentLockManager.current.currentBlockState, block == true {
//                        } else {
//                            dummyRecently.append(list)
//                        }
//                    }
//                }
//                return Observable.just(dummyRecently)
//            }
//            .bind(to: recentlyList)
//            .disposed(by: disposeBag)

        // 컨텐츠 상세화면 Event
//        req.showDetailTrigger
//            .subscribe(onNext: { [weak self] item in
//                guard self != nil else { return }
//                guard let key = item.key, let contentList = self?.recentlyList.value else {
//                    return
//                }
//                Log.d("item = \(item.key!)")
//                var keyList = contentList.map { return $0.key! }
//
//                let index = keyList.firstIndex(of: key)!
//                for _ in 0..<index {
//                    keyList.removeFirst()
//                }
//                let playlistArray = keyList
//
//                if let adult = item.adult_yn, adult == "Y" {
//                    ContentLockManager.current.isLockSettingCheck { result in
//                        if result {
//                            ARUnityService.default.contentDetail(contentKey: key, playList: [])
//                        }
//                    }
//                } else {
//                    ARUnityService.default.contentDetail(contentKey: key, playList: [])
//                }
//            })
//            .disposed(by: disposeBag)

        // 컨텐츠 바로 실행
//        req.playContentTrigger
//            .subscribe(onNext: { [weak self] item in
//                guard self != nil else { return }
//
//                guard let key = item.key, let contentList = self?.recentlyList.value else {
//                    return
//                }
//                Log.d("item = \(item.key!)")
//                var keyList = contentList.map { return $0.key! }
//
//                let index = keyList.firstIndex(of: key)!
//                for _ in 0..<index {
//                    keyList.removeFirst()
//                }
//                let playlistArray = keyList
//                if let adult = item.adult_yn, adult == "Y" {
//                    ContentLockManager.current.isLockSettingCheck { result in
//                        if result {
//                            ActivityStepper.shared.steps.accept(MainSteps.navigationARPlayer(isDetail: false, contentKey: key, playList: []))
//                        }
//                    }
//                } else {
//                    ActivityStepper.shared.steps.accept(MainSteps.navigationARPlayer(isDetail: false, contentKey: key, playList: []))
//                }
//            })
//            .disposed(by: disposeBag)

        // 버튼 Action
        req.buttonActionTrigger
            .bind(to: buttonAction.inputs)
            .disposed(by: disposeBag)

        // 삭제 Event
        req.deleteItemsTrigger
            .bind(to: deleteItemsAction.inputs)
            .disposed(by: disposeBag)

        // 삭제 Data Binding
//        deleteRecentlyDataAction
//            .elements
//            .bind(to: deleteItem)
//            .disposed(by: disposeBag)

//        Observable.combineLatest(ContentLockManager.current.rx.isAdultBlockState,
//                                 ContentLockManager.current.rx.changeAdultLockState)
//            .throttle(.microseconds(500), latest: false, scheduler: MainScheduler.instance)
//            .on(next: { [weak self] _ in
//                guard let `self` = self else { return }
//                self.loadRecentlyDataAction.execute(())
//            })
//            .disposed(by: disposeBag)
//
        return Output(recentlyList: recentlyList, buttonActionRelay: buttonActionRelay, deleteItem: deleteItem)
    }
}
