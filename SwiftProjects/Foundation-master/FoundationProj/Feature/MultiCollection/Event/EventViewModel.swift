//
//  EventViewModel.swift
//  UPlusAR
//
//  Created by baedy on 2020/03/23.
//  Copyright © 2020 최성욱. All rights reserved.
//

import Action
import RxCocoa
import RxFlow
import RxSwift
import UIKit

class EventViewModel: ViewModelType {
    // MARK: ViewModelType Protocol
    typealias ViewModel = EventViewModel

    // MARK: Property
    private let type: MoreSeeDetail
    private let repositoty: FDRepository

    private let disposeBag = DisposeBag()

    private lazy var dataLoadAction = Action<Void, [FDEvent]>(workFactory: {
        return self.repositoty.loadEvents().map(self.sortEvents(_:))
    })

    init(repository: FDRepository, type: MoreSeeDetail) {
        self.type = type
        self.repositoty = repository
    }

    struct Input {
        let dataLoadTrigger: Observable<Void>
        let modelSelect: Observable<FDEvent>
    }

    struct Output {
        let events: Observable<[FDEvent]>
        let errors: Observable<Error>
        let isLoading: Observable<Bool>
    }

    func transform(req: ViewModel.Input) -> ViewModel.Output {
        req.dataLoadTrigger
            .bind(to: dataLoadAction.inputs)
            .disposed(by: disposeBag)

        req.modelSelect
            .subscribe(onNext: {
                MoreSeeStepper.shared.stepToEventDetail(event: $0)
            })
            .disposed(by: disposeBag)

        return Output(events: dataLoadAction.elements, errors: dataLoadAction.underlyingError, isLoading: dataLoadAction.executing)
    }

    /**
     이벤트 정렬
     1. show - true만 처리
     2. 시작날짜, 종료날짜 nil 일 경우 포함X
     3. 시작날짜 이후, 종료날자 이전 일 경우 이벤트 진행중
     4. 3번 외의 경우엔 이벤트 종료 상태
     5. 상단 고정 -> 일반 진행중 -> 종료
     6. 이 경우 외에는 전부 표시 안함
     7. 시작날짜 동일할 경우 종료날자 기준 가까운 날자로 정렬
     */
    func sortEvents(_ events: [FDEvent]) -> [FDEvent] {
        let showList = events.filter {
            $0.stopAt != nil
        }.filter {
            $0.startAt != nil
        }.filter {
            $0.show == true
        }

        let sortFuc: (FDEvent, FDEvent) -> Bool = { lfe, rfe -> Bool in
            if (lfe.startAt)!.compare(rfe.startAt!) == .orderedSame {
                return (lfe.stopAt)!.compare(rfe.stopAt!) == .orderedDescending
            } else {
                return (lfe.startAt)!.compare(rfe.startAt!) == .orderedDescending
            }
        }

        /// 상단 고정
        let fixedList = showList.filter {
            $0.isFixedEvent()
        }.sorted(by: sortFuc)

        /// 현재 진행중
        let runningList = showList.filter {
            $0.isRunningEvent()
        }.filter {
            $0.isFixedEvent() != true
        }.sorted(by: sortFuc)

        /// 종료
        let notRunningList = showList.filter {
            $0.isRunningEvent() != true
        }.sorted(by: sortFuc)

        return fixedList + runningList + notRunningList
    }
}
