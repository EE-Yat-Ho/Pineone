//
//  InitFlow.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/10/06.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import RxFlow
import UIKit
import Then
import RxSwift
import RxCocoa

class InitFlow: Flow {
    static let `shared`: InitFlow = InitFlow()
    let tabBarController = QuestionTabBarController()

    var root: Presentable{
        return self.rootViewController
    }
    
    private lazy var rootViewController = NavigationController().then {
          $0.setNavigationBarHidden(false, animated: false)
      }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else {
            return .none
        }
        
        switch step {
        case .initialize:
            return navigateToMain()
        case .storyBoard:
            return navigateToStoryBoard()
        case .nSLayout:
            return navigateToNSLayout()
        case .visualFormat:
            return navigateToVisualFormat()
        case .nSLayout_VisualFormat:
            return navigateToNSLayout_VisualFormat()
        case .anchor:
            return navigateToAnchor()
        case .snapKit:
            return navigateToSnapKit()
        case .rxSwift:
            return navigateToRxSwift()
        case .mVVM:
            return navigateToMVVM()
        default:
            return .none
        }
    }
}

extension InitFlow{
    private func navigateToStoryBoard() -> FlowContributors{
//        FlowSugar(WebTestViewModel(), WebTestViewController.self)
//            .navigationItem(with: {
//                $0.title = "web scheme test"
//            }).oneStepPushBy(self.rootViewController)
        return .none
    }
    
    private func navigateToNSLayout() -> FlowContributors{
//        FlowSugar(HorizontalStackScrollViewModel(), HorizontalStackScrollViewController.self)
//            .navigationItem(with: {
//                $0.title = "HorizontalStackScroll"
//            }).oneStepPushBy(self.rootViewController)
        return .none
    }
    
    private func navigateToVisualFormat() -> FlowContributors{
//        FlowSugar(TableMultiSelectionViewModel(), TableMultiSelectionViewController.self)
//            .navigationItem(with:{
//                $0.title = "multiSelectTable"
//            }).oneStepPushBy(self.rootViewController)
        return .none
    }
    
    private func navigateToNSLayout_VisualFormat() -> FlowContributors{
//         FlowSugar(CollectionMultiSelectionViewModel(), CollectionMultiSelectionViewController.self)
//             .navigationItem(with:{
//                 $0.title = "multiSelectCollection"
//             }).oneStepPushBy(self.rootViewController)
        return .none
     }
    
    private func navigateToAnchor() -> FlowContributors{
//        FlowSugar(LinkImageGridViewModel(), LinkImageGridViewController.self)
//            .navigationItem(with:{
//                $0.title = "LinkImageGrid"
//            })
//            .oneStepPushBy(self.rootViewController)
        return .none
    }
    private func navigateToSnapKit() -> FlowContributors{
        return .none
    }
    private func navigateToRxSwift() -> FlowContributors{
        return .none
    }
    private func navigateToMVVM() -> FlowContributors{
        FlowSugar(MVVMViewModel(), MVVMViewController.self)
            .navigationItem(with:{
                $0.title = "MVVM"
            })
            .oneStepPushBy(self.rootViewController)
    }
    
    private func popView() -> FlowContributors{
        rootViewController.popViewController(animated: true)
        return .none
    }
     
    private func navigateToMain() -> FlowContributors{
        FlowSugar(MainViewModel(), MainViewController.self)
            .navigationItem(with: {
                $0.title = "Fondation"
            })
            .oneStepPushBy(self.rootViewController)
    }
}
