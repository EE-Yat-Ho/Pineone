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

enum InputAction {
    case deleteItems([IndexPath])
    case cellDetail(RecentlyCellInfo)
    case cellPlay(RecentlyCellInfo)
    case refreshData
}


class RecentlyViewModel: ViewModelType, Stepper {
    // MARK: - Stepper
    var steps = PublishRelay<Step>()

    // MARK: - ViewModelType Protocol
    typealias ViewModel = RecentlyViewModel
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
    private let tableRelay = PublishRelay<[RecentlyCellInfo]>()
    private let topViewRelay = PublishRelay<ARTableViewHeaderActionType>()
    
    

    struct Input {
        let inputAction: Observable<InputAction>
    }

    struct Output {
        let tableRelay: PublishRelay<[RecentlyCellInfo]>
        let topViewRelay: PublishRelay<ARTableViewHeaderActionType>
        
    }

    func transform(req: ViewModel.Input) -> ViewModel.Output {
        // MARK: - Observe Input from Closure
        /// 들어온 입력들 프로세서 클로저로
        req.inputAction
            .on(next: { [weak self] in
                self?.inputActionProcessor(inputAction: $0) })
            .disposed(by: disposeBag)
        
        // MARK: - Observe Action from Output
        /// 데이터를 로드해오면 테이블 리프래쉬
        loadRecentlyDataAction
            .elements
            .bind(to: tableRelay)
            .disposed(by: disposeBag)
        
        /// 데이터를 삭제했으면 데이터 로드
        deleteRecentlyDataAction
            .elements
            .bind(to: loadRecentlyDataAction.inputs)
            .disposed(by: disposeBag)
        
        return Output(tableRelay: tableRelay, topViewRelay: topViewRelay)
    }
    
    // MARK: - Processor Declaration
    private func inputActionProcessor(inputAction: InputAction) {
        switch inputAction {
        case .refreshData:
            loadRecentlyDataAction.inputs.onNext(())
        case .deleteItems(let indexPaths):
            deleteItems(indexPaths) // 서버에는 배열이 아닌 스트링값 1개만 넘겨주기위한 전초작업
        case .cellDetail(let cellInfo):
            cellDetail(cellInfo)
        case .cellPlay(let cellInfo):
            cellPlay(cellInfo)
        }
    }

    private func deleteItems(_ indexPaths: [IndexPath]) {
        var selectIP: [String] = []
        for indexPath in indexPaths {
            selectIP.append(String(indexPath.row))
        }
        let result = selectIP.joined(separator: ",")
        deleteRecentlyDataAction.inputs.onNext(result)
    }
    
    private func cellDetail(_ cellInfo: RecentlyCellInfo) {
        print("cellDetail")
    }
    
    private func cellPlay(_ cellInfo: RecentlyCellInfo) {
        print("cellPlay")
    }
    
    
    // MARK: - Actions for Server Communication
    private lazy var loadRecentlyDataAction = Action<(Void), [RecentlyCellInfo]>(workFactory: {
        return Observable<[RecentlyCellInfo]>.just(Server.shared.getUserRecentlyContents())
    })
    
    private lazy var deleteRecentlyDataAction = Action<(String), Void>(workFactory: { indexPathString in
        return Observable<Void>.just(Server.shared.deleteUserContents(indexPathString: indexPathString))
    })
}
    
