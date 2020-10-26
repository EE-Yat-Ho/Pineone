//
//  LikeViewModel.swift
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

class LikeViewModel: ViewModelType, Stepper {
    // MARK: - Stepper
    var steps = PublishRelay<Step>()

    // MARK: - ViewModelType Protocol
    typealias ViewModel = LikeViewModel
//    let disposeBag = DisposeBag()
//    static let LIKE_LIST_COUNT_MAX = 30
//
//    var likeList = BehaviorRelay(value: [RecentlyLikeList]())
//    var deleteItem = BehaviorRelay(value: String())
//    var buttonActionRelay = PublishRelay<ARTableViewHeaderActionType>()
//
//    var likeCursor: String?

    // notification listen reloadData
//    @objc private func needUpdate(notification: NSNotification) {
//        loadLikeDataAction.execute(())
//    }
//
//    private lazy var loadMoreLikeDataAction = Action<(Void), ContentsRecentlyLike>(workFactory: {[weak self] in
//        return NetworkService.getUserContents(type: .like, cursor: self?.likeCursor, count: LikeViewModel.LIKE_LIST_COUNT_MAX)
//    })
//
//    private lazy var loadLikeDataAction = Action<(Void), ContentsRecentlyLike>(workFactory: {
//        return NetworkService.getUserContents(type: .like, count: LikeViewModel.LIKE_LIST_COUNT_MAX)
//    })
//
//    private lazy var deleteLikeDataAction = Action<(String), String>(workFactory: { keys in
//        return NetworkService.deleteUserContents(type: .like, contentsKey: keys)
//    })
//
//    // 버튼 동작 Action
//    lazy var buttonAction = Action<ARTableViewHeaderActionType, Void> { [weak self] in
//        guard let `self` = self else { return .empty() }
//        switch $0 {
//        case .delete:
//            self.buttonActionRelay.accept(.delete)
//        case .check:
//            self.buttonActionRelay.accept(.check)
//        case .cancel:
//            self.buttonActionRelay.accept(.cancel)
//        case .dropdown:
//            self.buttonActionRelay.accept(.dropdown)
//        default:
//            break
//        }
//        return .empty()
//    }
//
//    // 삭제 동작 Action
//    private lazy var deleteItemsAction = Action<[IndexPath], Void>(workFactory: { [weak self] indexPaths in
//        guard let `self` = self else { return .empty() }
//        var selectKeys: [String] = []
//        for indexPath in indexPaths {
//            if let key = self.likeList.value[indexPath.row].key {
//                selectKeys.append(String(key))
//            }
//        }
//        let result = selectKeys.joined(separator: ",")
//        self.deleteLikeDataAction.execute(result)
//        return .empty()
//    })

    struct Input {
//        let refreshTrigger: Observable<Void>
//        let loadMoreTrigger: Observable<Void>
//        let showDetailTrigger: Observable<RecentlyLikeList>
//        let playContentTrigger: Observable<RecentlyLikeList>
//        let buttonActionTrigger: Observable<ARTableViewHeaderActionType>
//        let deleteItemsTrigger: Observable<[IndexPath]>
    }

    struct Output {
//        let likeList: BehaviorRelay<[RecentlyLikeList]>
//        let buttonActionRelay: PublishRelay<ARTableViewHeaderActionType>
//        let deleteItem: BehaviorRelay<String>
    }

    func transform(req: ViewModel.Input) -> ViewModel.Output {
        // Notification Listener
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(self.needUpdate),
//                                               name: Notification.Name.contentLikeChange,
//                                               object: nil)
//
//        // Refresh Event
//        req.refreshTrigger
//            .bind(to: loadLikeDataAction.inputs)
//            .disposed(by: disposeBag)
//
//        req.loadMoreTrigger
//            .filter {[weak self] in
//                return self?.likeCursor != nil
//            }
//            .bind(to: loadMoreLikeDataAction.inputs)
//            .disposed(by: disposeBag)
//
//        // Like Data Binding
//        loadLikeDataAction
//            .elements
//            .flatMap {[weak self] likeData -> Observable<[RecentlyLikeList]> in
//                self?.likeCursor = likeData.next_cursor
//
//                var dummyLike: [RecentlyLikeList] = []
//                if let likeList = likeData.contents_list {
//                    for list in likeList {
//                        if let adult = list.adult_yn, adult == "Y", let block = ContentLockManager.current.currentBlockState, block == true {
//                        } else {
//                            dummyLike.append(list)
//                        }
//                    }
//                }
//                return Observable.just(dummyLike)
//            }
//            .bind(to: likeList)
//            .disposed(by: disposeBag)
//
//        loadMoreLikeDataAction.elements
//            .flatMap { [weak self] likeData -> Observable<[RecentlyLikeList]> in
//                guard let `self` = self else { return Observable.just([]) }
//                self.likeCursor = likeData.next_cursor
//
//                var dummyLike: [RecentlyLikeList] = []
//                if let likeList = likeData.contents_list {
//                    for list in likeList {
//                        if let adult = list.adult_yn, adult == "Y", let block = ContentLockManager.current.currentBlockState, block == true {
//                        } else {
//                            dummyLike.append(list)
//                        }
//                    }
//                }
//                var likeLists = self.likeList.value
//                likeLists.append(contentsOf: dummyLike)
//
//                return Observable.just(likeLists)
//            }.bind(to: likeList)
//            .disposed(by: disposeBag)
//
//        // 컨텐츠 상세화면 Event
//        req.showDetailTrigger.subscribe(onNext: { [weak self] item in
//            guard self != nil else { return }
//            guard let key = item.key, let contentList = self?.likeList.value else {
//                return
//            }
//            Log.d("item = \(item.key!)")
//            var keyList = contentList.map { return $0.key! }
//
//            let index = keyList.firstIndex(of: key)!
//            for _ in 0..<index {
//                keyList.removeFirst()
//            }
//            let playlistArray = keyList
//
//            if let adult = item.adult_yn, adult == "Y" {
//                ContentLockManager.current.isLockSettingCheck { result in
//                    if result {
//                        ARUnityService.default.contentDetail(contentKey: key, playList: [])
//                    }
//                }
//            } else {
//                ARUnityService.default.contentDetail(contentKey: key, playList: [])
//            }
//        }).disposed(by: disposeBag)
//
//        // 컨텐츠 바로 실행
//        req.playContentTrigger
//            .subscribe(onNext: { [weak self] item in
//                guard self != nil else { return }
//
//                guard let key = item.key, let contentList = self?.likeList.value else {
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
//                if let adult = item.adult_yn, adult == "Y", ContentLockManager.current.currentLockState == .locked {
//                    ContentLockManager.current.isLockSettingCheck { result in
//                        if result {
//                            ActivityStepper.shared.steps.accept(MainSteps.navigationARPlayer(isDetail: false, contentKey: key, playList: []))
//                        }
////                        ARUnityService.default.varifyThenWith(contentKey: key, playList: playlistArray)
//                    }
//                } else {
//                    ActivityStepper.shared.steps.accept(MainSteps.navigationARPlayer(isDetail: false, contentKey: key, playList: []))
////                    ARUnityService.default.varifyThenWith(contentKey: key, playList: playlistArray)
//                }
//            })
//            .disposed(by: disposeBag)
//
//        // 버튼 Action
//        req.buttonActionTrigger
//            .bind(to: buttonAction.inputs)
//            .disposed(by: disposeBag)
//
//        // 삭제 Event
//        req.deleteItemsTrigger
//            .bind(to: deleteItemsAction.inputs)
//            .disposed(by: disposeBag)
//
//        // 삭제 Data Binding
//        deleteLikeDataAction
//            .elements
//            .bind(to: deleteItem)
//            .disposed(by: disposeBag)
//
//        // 19+ 콘텐츠 잠금 체크
//        ContentLockManager
//            .current
//            .rx
//            .changeAdultLockState
//            .on(next: { [weak self] _ in
//                guard let `self` = self else { return }
//                self.loadLikeDataAction.execute()
//            })
//            .disposed(by: disposeBag)

//        return Output(likeList: likeList, buttonActionRelay: buttonActionRelay, deleteItem: deleteItem)
        return Output()
    }
}
