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

/// VM이 받는 입력들
//enum InputAction {
//    case deleteItems([IndexPath]) /// 셀 삭제해주세요
//    case cellDetail(RecentlyLikeList) /// 셀 선택했어요
//    case cellPlay(RecentlyLikeList) /// 셀 콘텐츠 재생해주세요
//    case refreshData /// 테이블 새로고침 해주세요
//    case error /// RecentlyCellInfo 가 nil일 경우 보내는 에러 ( 언래핑의 편의성 )
//}


class RecentlyViewModel: ViewModelType, Stepper {
    // MARK: - Stepper
    var steps = PublishRelay<Step>()

    // MARK: - ViewModelType Protocol
    typealias ViewModel = RecentlyViewModel
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
    /// 테이블에 이벤트와 데이터를 전달하기 위한 릴레이
    private let tableRelay = PublishRelay<[RecentlyLikeList]>()
    /// 삭제 했을 경우, 삭제모드 리셋을 위한 이벤트를 전달하기 위한 릴레이
    private let deleteComplete = PublishRelay<Void>()
    
    /// 비지니스 로직이 필요한 여러 입력들
    struct Input {
        let inputAction: Observable<InputAction>
    }

    /// View나 VC에 이벤트와 데이터를 전달하기 위한 릴레이들
    struct Output {
        let tableRelay: PublishRelay<[RecentlyLikeList]>
        let deleteComplete: PublishRelay<Void>
    }

    /// 입력받은 릴레이들을 알맞게 액션이나 클로저 등을 매핑 및 바인딩 후, View나 VC에게 이벤트를 전달해주기 위한 릴레이들을 반환
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
        
        /// 데이터를 삭제했으면 View에 UI업데이트용 신호를 보내고, 데이터 로드까지
        deleteRecentlyDataAction
            .elements
            .do(onNext: { [weak self] in self?.deleteComplete.accept(())})
            .bind(to: loadRecentlyDataAction.inputs)
            .disposed(by: disposeBag)
        
        return Output(tableRelay: tableRelay, deleteComplete: deleteComplete)//, deleteModeSelect: deleteModeSelect, normalModeSelect: normalModeSelect)
    }
    
    // MARK: - Processor Declaration
    /// 들어온 입력 처리하는 함수
    private func inputActionProcessor(inputAction: InputAction) {
//        switch inputAction {
//        case .refreshData:
//            loadRecentlyDataAction.inputs.onNext(())
//        case .deleteItems(let indexPaths):
//            deleteItems(indexPaths) // 서버에는 배열이 아닌 스트링값 1개만 넘겨주기위한 전초작업
//        case .cellDetail(let cellInfo):
//            cellDetail(cellInfo)
//        case .cellPlay(let cellInfo):
//            cellPlay(cellInfo)
//        case .error:
//            print("RecentlyCellInfo is nil!!")
//        }
    }

    /// 서버에는 배열이 아닌 스트링값 1개만 넘겨주기위한 전초작업
    private func deleteItems(_ indexPaths: [IndexPath]) {
        var selectIP: [String] = []
        for indexPath in indexPaths {
            selectIP.append(String(indexPath.row))
        }
        let result = selectIP.joined(separator: ",")
        deleteRecentlyDataAction.inputs.onNext(result)/// 서버에 삭제명령 넘기기
    }
    
    /// 셀 상세보기 이벤트를 처리하는 함수. VC로 이벤트를 전달해서 상세보기 화면을 띄우지 않을까
    private func cellDetail(_ cellInfo: String) {
//        switch topViewMode.value {
//        case .rightOneButton: // 일반 모드
//            normalModeSelect.accept(indexRow)
//        case .checkAndButton: // 삭제 모드
//            deleteModeSelect.accept(indexRow)
//        default:
            print("cellDetail")
        //}
    }
    
    /// 셀 재생 이벤트를 처리하는 함수. VC로 이벤트를 전달해서 콘텐츠 화면을 띄우지 않을까
    private func cellPlay(_ cellInfo: String) {
        print("cellPlay")
    }
    
    
    // MARK: - Actions for Server Communication
    /// 서버에서 새 데이터를 받아와서 방출하는 액션
    private lazy var loadRecentlyDataAction = Action<(Void), [RecentlyLikeList]>(workFactory: {
        return Observable<[RecentlyLikeList]>.just(Server.shared.getUserRecentlyContents())
    })
    
    /// 서버에서 데이터를 삭제시키고, 삭제완료(Void)를 방출하는 액션
    private lazy var deleteRecentlyDataAction = Action<(String), Void>(workFactory: { indexPathString in
        return Observable<Void>.just(Server.shared.deleteUserRecentlyContents(indexPathString: indexPathString))
    })
}
    
