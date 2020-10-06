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

class MainViewModel: ViewModelType, Stepper {
    // MARK: - Stepper
    var steps = PublishRelay<Step>()
    
    let disposeBag = DisposeBag()
    
    // viewWillAppear 이런 류가 ViewBased에 보면 onNext 호출하는데 그 때 마다 얘 실행됨
    // workFactory : Input -> Observable<Element>
    // mainList : Screen 배열을 리턴함
    
    // loadAction은 ViewLifeState와 [Screen]를 가지고 만든 Action 인스턴스
    // Action의 workFactory는 (ViewLifeState) -> Observable<[Screen]> 하는 클로저로 설정
    let loadAction: Action<ViewLifeState, [Screen]> = Action(workFactory:{ _ in
        return Observable.just(MainRepository.mainList())
    })
    
    // MARK: - ViewModelType Protocol
    typealias ViewModel = MainViewModel
    
    struct Input {
        let selectItem: Observable<Screen>
    }
    
    struct Output {
        let itemList: Observable<[Screen]>
    }
    
    struct State {
        let viewLife: Observable<ViewLifeState>
//        let isHidden: Observable<Bool>
    }
    
    func stateBind(state: ViewModel.State){
        _ = state.viewLife.subscribe(onNext: { _ in
//            print("Main ------ \($0)")
        })
        
        state.viewLife.filter{$0 == .viewDidAppear}.bind(to: loadAction.inputs).disposed(by: disposeBag)
    }
    
    func transform(req: ViewModel.Input) -> ViewModel.Output {
        // 처음 : req, selectItem 있음. emitStep 실행 안함.
        // 버튼 클릭시 : Input 있지도 않음. emitStep 실행.
        req.selectItem.map(emitStep(_:))
            .bind(to: self.steps)
            .disposed(by: disposeBag)
   
        // 얘는 나중에 실행 안함. 처음 엮을 때만 실행함.
        // loadAction.elements : Observable<[Screen]>
        return Output(itemList: loadAction.elements)
    }
    
    func emitStep(_ screen: Screen) -> AppStep{
        switch screen {
        case .storyBoard:
            return .storyBoard
        case .nSLayout:
            return .nSLayout
        case .visualFormat:
            return .visualFormat
        case .nSLayout_VisualFormat:
            return .nSLayout_VisualFormat
        case .anchor:
            return .anchor
        case .snapKit:
            return .snapKit
        case .rxSwift:
            return .rxSwift
        case .mVVM:
            return .mVVM
        }
    }
}

