//
//  NotificationFlow.swift
//  UPlusAR
//
//  Created by baedy on 2020/06/24.
//  Copyright © 2020 최성욱. All rights reserved.
//

import RxCocoa
import RxFlow
import RxSwift
import UIKit

class NotificationFlow: Flow {
    var root: Presentable {
        return self.tabBarViewController
    }

    private let tabBarViewController: ARTabBarController!
    var disposeBag = DisposeBag()

    init(presentable: ARTabBarController) {
        tabBarViewController = presentable
    }

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? NotificationSteps else { return .none }
        switch step {
        case .none:
            return .none
        case .initialize:
            return .none
//        case .navigate(let action, let data):
//            return navigate(action, data: data)
        case .moveTap(let index):
            return tabBarViewController.selectTabBarWith(index: index)
        }
    }

    private let arrayStepper: [Stepper] = [ActivityStepper.shared,
                                           AppStepper.shared]

    let loopForForwardStep: (Stepper, [Step]?) -> Void = { stepper, scenes in
        if let scenes = scenes {
            for step in scenes {
                stepper.steps.accept(step)
            }
        }
    }

//    func navigate(_ action: ActionProtocol, data: RemoteNotification) -> FlowContributors {
//        // 0. dismiss modal
//        AppStepper.shared.steps.accept(AppStep.dismissModal)
//
//        // 1. 파라미터 설정 부터 진행
//        action.mapperForParam(data)
//
//        // 2. 탭 변경이 필요하면 이동
//        if action.needMoveTap, let index = action.flow {
//            AppStepper.shared.steps.accept(AppStep.moveTab(index: index))
//        }
//
//        // 3. 함수 실행 후 결과 값을 받아서 step 실행
//        if let flow = action.flow {
//            let stepper = arrayStepper[flow.rawValue]
//            switch flow {
//            case .activity:
//                if let subject = action.resultSubject {
//                    subject.subscribe(onNext: {
//                        Log.d("@@@@ processing data \($0) @@@@")
//                        self.loopForForwardStep(stepper, action.scenes)
//                        self.disposeBag = DisposeBag()
//                    }).disposed(by: self.disposeBag)
//                } else {
//                    self.loopForForwardStep(stepper, action.scenes)
//                }
//            }
//        }
//        // 4. 플로우 없이 현재 화면에서 무엇인가 함(팝업, 전체화면 등) ~> 그렇다면 MainFlow로 전달
//        else if let scenes = action.scenes {
//            self.loopForForwardStep(AppStepper.shared, scenes)
//        }
//
//        // 5. step이 없어 함수만 실행
//        action.execute()
//
//        return .none
//    }
}
