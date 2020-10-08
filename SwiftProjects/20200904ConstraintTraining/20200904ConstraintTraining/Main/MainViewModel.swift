//
//  MainViewModel.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/10/06.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxFlow
import Action
import CoreTelephony

class MainViewModel: ViewModelType {
    
//    let loadAction: Action<ViewLifeState, [Screen]> = Action(workFactory:{ _ in
//        return Observable.just(MainRepository.mainList())
//    })
    
    // MARK: - Parameters
    let mainRelay = BehaviorRelay<[Screen]>(value: [])
    
    
    // MARK: - ViewModelType Protocol
    typealias ViewModel = MainViewModel
    
    struct Input {
        //let mainTableView: UITableView
    }
    
    struct Output {
        
    }
    
    func transform(req: ViewModel.Input) -> ViewModel.Output {
        // 처음 : req, selectItem 있음. emitStep 실행 안함.
        // 버튼 클릭시 : Input 있지도 않음. emitStep 실행.
//        req.selectItem.map(emitStep(_:))
//            .bind(to: self.steps)
//            .disposed(by: disposeBag)
   
        // 얘는 나중에 실행 안함. 처음 엮을 때만 실행함.
        // loadAction.elements : Observable<[Screen]>
        //return Output(itemList: loadAction.elements)
        
        
        // 테이블에 값 뿌려주기
        mainRelay.accept(MainRepository.mainList())
        
        return Output()
    }
    
//    func emitStep(_ screen: Screen) -> AppStep{
//        switch screen {
//        case .storyBoard:
//            return .storyBoard
//        case .nSLayout:
//            return .nSLayout
//        case .visualFormat:
//            return .visualFormat
//        case .nSLayout_VisualFormat:
//            return .nSLayout_VisualFormat
//        case .anchor:
//            return .anchor
//        case .snapKit:
//            return .snapKit
//        case .rxSwift:
//            return .rxSwift
//        case .mVVM:
//            return .mVVM
//        }
//    }
}

