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

enum UserInput {
    //case trashCanButton
    //case cancel
    case bottomDeleteButton
    case topMoveButton
    //case checkAll
    case cellCheck
    case cellDetail
    case cellPlay(RecentlyCellInfo)
    case scrollUp
    case scrollDown
    case topView(ARTableViewHeaderShowType)
}

enum SystemInput {
    case isAllCheck
    case isDeleteButton
    case refreshData
}

enum SystemOutput {
    case tableView([RecentlyCellInfo])
}


class RecentlyViewModel: ViewModelType, Stepper {
    // MARK: - Stepper
    var steps = PublishRelay<Step>()

    // MARK: - ViewModelType Protocol
    typealias ViewModel = RecentlyViewModel
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
    private let userInputs = PublishRelay<UserInput>()
    private let systemInputs = PublishRelay<SystemInput>()
    private let systemOutputs = PublishRelay<SystemOutput>()

    
    

    struct Input {
        let userInputs: Observable<UserInput>
        let systemInputs: Observable<SystemInput>
    }

    struct Output {
        let systemOutputs: PublishRelay<SystemOutput>
    }

    func transform(req: ViewModel.Input) -> ViewModel.Output {
        // MARK: - Observe Input from Action
        req.systemInputs
            .on(next: { [weak self] in
                self?.systemInputProcessor(systemInput: $0) })
            .disposed(by: disposeBag)
        
//        req.topViewInput
//            .bind(to: topViewActions.inputs)
//            .disposed(by: disposeBag)
        
        // MARK: - Observe Action from Output
//        loadRecentlyDataAction
//            .elements
//            .bind(to: recentlyTableRelay)
//            .disposed(by: disposeBag)
        
        return Output(systemOutputs: systemOutputs)
    }
    
    // MARK: - Actions Declaration
    
//    private func userInputProcessor(userInput: UserInput) {
//
//    }
    
    private func systemInputProcessor(systemInput: SystemInput) {
        switch systemInput {
        case .isAllCheck:
            print("isAllCheck")
        case .isDeleteButton:
            print("isDeleteButton")
        case .refreshData:
            systemOutputs.accept(SystemOutput.tableView(Server.shared.getUserRecentlyContents()))
        }
    }

    
    /// Load Data Action
//    private lazy var loadRecentlyDataAction = Action<(Void), [RecentlyCellInfo]>(workFactory: {
//        //return NetworkService.getUserContents(type: .view, count: RecentlyViewModel.RECENTLY_LIST_COUNT_MAX)
//        return Server.shared.getUserRecentlyContents()
//    })
//
//    /// Top View Action ( trashcan, checkAll, cancel )
//    private lazy var topViewActions = Action<ARTableViewHeaderActionType, Void>(workFactory:
//    { [weak self] in
//        guard let `self` = self else { return .empty() }
//        switch $0 {
//        case .delete:
//            self.changeShowType.accept(.checkAndButton)
//            //여기서 탑뷰의 타입을 바꿔여해
//        case .check:
//            print("check")
//        case .cancel:
//            self.changeShowType.accept(.rightOneButton)
//        case .dropdown:
//            print("dropdown")
//        default:
//            break
//        }
//        return .empty()
//    })
}
