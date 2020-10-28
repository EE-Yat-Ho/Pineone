//
//  ReplyViewModel.swift
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

class ReplyViewModel: ViewModelType, Stepper {
    // MARK: - Stepper
    var steps = PublishRelay<Step>()

    // MARK: - ViewModelType Protocol
    typealias ViewModel = ReplyViewModel
    let disposeBag = DisposeBag()

    var newReplyTotalCount = 0
    var newReplyCurrentCount = 0
    var newReplyNextCursor: String = .empty

    var replyList = BehaviorRelay(value: [ReplyList]())
    var deleteItem = BehaviorRelay(value: String())
    var buttonActionRelay = PublishRelay<ARTableViewHeaderActionType>()
    var deselectRowRelay = PublishRelay<Void>()

//    private lazy var loadReplyDataAction = Action<(Void), ContentsReply>(workFactory: {[weak self] _ in
//        self?.newReplyNextCursor = .empty
//        self?.newReplyTotalCount = 0
//        self?.newReplyCurrentCount = 0
//        return NetworkService.getContentsReply(type: .myReply).asObservable()
//    })
//
//    private lazy var loadMoreReplyDataAction = Action<(ReplyType, String?), ContentsReply>(workFactory: { type, cursor in
//        return NetworkService.getContentsReply(type: type, cursor: cursor)
//    })
//
//    private lazy var loadContentDeatailDataAction = Action<Int, ContentDetail>(workFactory: { key in
//        return NetworkService.getContentDetail(contentsKey: String(key))
//    })
//
//    private lazy var deleteReplyDataAction = Action<(String), String>(workFactory: { keys in
//        return NetworkService.deleteContentsReply(replyKey: keys)
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
            if let key = self.replyList.value[indexPath.row].key {
                selectKeys.append(String(key))
            }
        }
        let result = selectKeys.joined(separator: ",")
        //self.deleteReplyDataAction.execute(result)
        return .empty()
    })

    struct Input {
        let refreshTrigger: Observable<Void>
        let loadMoreTrigger: Observable<Void>
        let showDetailTrigger: Observable<ReplyList>
        let buttonActionTrigger: Observable<ARTableViewHeaderActionType>
        let deleteItemsTrigger: Observable<[IndexPath]>
    }

    struct Output {
        let replyList: BehaviorRelay<[ReplyList]>
        let buttonActionRelay: PublishRelay<ARTableViewHeaderActionType>
        let deleteItem: BehaviorRelay<String>
        let deselectRow: PublishRelay<Void>
    }

    func transform(req: ViewModel.Input) -> ViewModel.Output {
        // Refresh Event
//        req.refreshTrigger
//            .bind(to: loadReplyDataAction.inputs)
//            .disposed(by: disposeBag)
//
//        // Reply Data Binding
//        loadReplyDataAction
//            .elements
//            .flatMap { [unowned self] replyData -> Observable<[ReplyList]> in
//                var dummyReply: [ReplyList] = []
//                if let cursor = replyData.next_cursor {
//                    self.newReplyTotalCount = replyData.total_cnt ?? 0
//                    self.newReplyNextCursor = cursor
//                }
//                if let replyList = replyData.reply_list, replyList.count > 0 {
//                    let listCount = replyList.count
//                    self.newReplyCurrentCount = listCount
//                    for list in replyList {
//                        dummyReply.append(list)
//                    }
//                }
//                return Observable.just(dummyReply)
//            }
//            .bind(to: replyList)
//            .disposed(by: disposeBag)

        // Load More Event
//        req.loadMoreTrigger
//            .map { [unowned self] _ -> Bool in
//                return !self.newReplyNextCursor.isEmpty && self.newReplyCurrentCount < self.newReplyTotalCount
//            }
//            .filter { $0 == true }
//            .subscribe(onNext: { [unowned self] _ in
//                self.loadMoreReplyDataAction.execute((.myReply, self.newReplyNextCursor))
//                self.newReplyNextCursor = .empty
//            })
//            .disposed(by: disposeBag)
//
//        // Load More Data Binding
//        loadMoreReplyDataAction
//            .elements
//            .flatMap { [unowned self] newReplyData -> Observable<[ReplyList]> in
//                var dummyNewReply: [ReplyList] = []
//                if let cursor = newReplyData.next_cursor {
//                    self.newReplyNextCursor = cursor
//                }
//                if let replyList = newReplyData.reply_list, replyList.count > 0 {
//                    self.newReplyCurrentCount += replyList.count
//                    for new in replyList {
//                        dummyNewReply.append(new)
//                    }
//                }
//                return Observable.just(dummyNewReply)
//            }
//            .subscribe(onNext: {
//                self.replyList.accept(self.replyList.value + $0)
//            })
//            .disposed(by: disposeBag)
//
//        // 컨텐츠 상세화면 Event
//        req.showDetailTrigger
//            .filter { $0.contents_info?.key != nil }
//            .map { Int(($0.contents_info?.key ?? "0"))! }
//            .bind(to: loadContentDeatailDataAction.inputs)
//            .disposed(by: disposeBag)
//
//        loadContentDeatailDataAction.elements
//            .on(next: checkContentAdultType)
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
//        deleteReplyDataAction
//            .elements
//            .bind(to: deleteItem)
//            .disposed(by: disposeBag)
//
//        // 댓글 새로 달았을 경우 노티피케이션 - 화면 리프레시
//        NotificationCenter.default.rx.notification(.contentDetailUpdate)
//            .map { _ in }
//            .bind(to: loadReplyDataAction.inputs)
//            .disposed(by: disposeBag)

        return Output(replyList: replyList,
                      buttonActionRelay: buttonActionRelay,
                      deleteItem: deleteItem,
                      deselectRow: deselectRowRelay)
        //return Output()
    }
}

extension ReplyViewModel {
//    func checkContentAdultType(_ item: ContentDetail) {
//        guard let key = item.contents_info.key else { return }
//        if item.contents_info.adult_yn == .Y {
//            ContentLockManager.current.isLockSettingCheck { result in
//                if result {
//                    ActivityStepper.shared.stepToContentDetail(key: key)
//                }
//            }
//        } else {
//            ActivityStepper.shared.stepToContentDetail(key: key)
//        }
//        deselectRowRelay.accept(())
//    }
}
