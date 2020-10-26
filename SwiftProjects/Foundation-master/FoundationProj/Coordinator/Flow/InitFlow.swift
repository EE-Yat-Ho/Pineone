//
//  InitFlow.swift
//  FondationProj
//
//  Created by baedy on 2020/05/06.
//  Copyright © 2020 baedy. All rights reserved.
//

import RxFlow
import UIKit
import Then
import RxSwift
import RxCocoa

class InitFlow: Flow {
    static let `shared`: InitFlow = InitFlow()

    var root: Presentable{
        print("InitFlow root")
        return self.rootViewController
    }
    
    private lazy var rootViewController = NavigationController().then {
          $0.setNavigationBarHidden(false, animated: false)
      }
    
    func navigate(to step: Step) -> FlowContributors {
        print("InitFlow navigate")
        guard let step = step as? AppStep else {
            return .none
        }
        
        switch step {
        case .initialize:
            print("InitFlow step.initialize")
            return navigateToMain()
        case .multiSelectTable:
            print("InitFlow step.multiSelectTable")
            return navigateToMultiTable()
        case .multiSelectCollection:
            print("InitFlow step.multiSelectCollection")
            return navigateToMultiCollection()
        case .webSchemeTest:
            print("InitFlow step.webSchemeTest")
            return navigateToWebTest()
        case .linkCollection:
            print("InitFlow step.linkCollection")
            return navigateToLinkImageCollection()
        case .linkImageZoom(let urls, let index):
            print("InitFlow step.linkImageZoom")
            return modalShowImageSlider(withItems: urls, initialIndex: index)
        case .close:
            print("InitFlow step.close")
            return popView()
        case .assetImageZoom(let aseets, let index):
            print("InitFlow step.assetImageZoom")
            return modalShowImageSlider(withItems: aseets, initialIndex: index)
        case .horizontalStackScroll:
            print("InitFlow step.horizontalStackScroll")
            return navigateToHSS()
        case .rotate:
            print("InitFlow step.rotate")
            return FlowSugar(RotateViewModel(), RotateViewController.self)
                .oneStepPushBy(self.rootViewController)
        case .playerSlider:
            print("InitFlow step.playerSlider")
            return FlowSugar(PlayerViewModel(), PlayerViewController.self)
                .oneStepPushBy(self.rootViewController)
        case .filterSlider:
            print("InitFlow step.filterSlider")
            return FlowSugar(FilterSliderViewModel(), FilterSliderViewController.self)
                .oneStepPushBy(self.rootViewController)
        case .rotateStackScroll:
            print("InitFlow step.rotateStackScroll")
            return FlowSugar(RotateSSViewModel(), RotateSSViewController.self)
            .oneStepPushBy(self.rootViewController)
        case .toastWithView:
            print("InitFlow step.toastWithView")
            return FlowSugar(ToastShowViewModel(), ToastShowViewController.self)
                .oneStepPushBy(self.rootViewController)
        default:
            return .none
        }
    }
}

extension InitFlow{
    private func navigateToWebTest() -> FlowContributors{
        print("InitFlow navigateToWebTest")
        return FlowSugar(WebTestViewModel(), WebTestViewController.self)
            .navigationItem(with: {
                $0.title = "web scheme test"
            }).oneStepPushBy(self.rootViewController)
    }
    
    private func navigateToHSS() -> FlowContributors{
        print("InitFlow navigateToHSS")
        return FlowSugar(HorizontalStackScrollViewModel(), HorizontalStackScrollViewController.self)
            .navigationItem(with: {
                $0.title = "HorizontalStackScroll"
            }).oneStepPushBy(self.rootViewController)
    }
    
    private func navigateToMultiTable() -> FlowContributors{
        print("InitFlow navigateToMultiTable")
        return FlowSugar(RecentlyViewModel(),
                  RecentlyViewController.self)
            .navigationItem(with:{
                $0.title = "multiSelectTable"
            }).oneStepPushBy(self.rootViewController)
    }
    
    private func navigateToMultiCollection() -> FlowContributors{
        print("InitFlow navigateToMultiCollection")
        return FlowSugar(CollectionMultiSelectionViewModel(), CollectionMultiSelectionViewController.self)
             .navigationItem(with:{
                 $0.title = "multiSelectCollection"
             }).oneStepPushBy(self.rootViewController)
     }
    
    private func navigateToLinkImageCollection() -> FlowContributors{
        print("InitFlow navigateToLinkImageCollection")
        return FlowSugar(LinkImageGridViewModel(), LinkImageGridViewController.self)
            .navigationItem(with:{
                $0.title = "LinkImageGrid"
            })
            .oneStepPushBy(self.rootViewController)
    }
    
    private func modalShowImageSlider<T>(withItems items: [T], initialIndex: Int) -> FlowContributors{
        print("InitFlow modalShowImageSlider")
        
        return FlowSugar(ZoomingViewModel(items, initialIndex), ZoomingViewController<T>.self)
            .setVCProperty(viewControllerBlock:{
                
                self.rootViewController.delegate = $0.transitionController
                $0.transitionController.animator.currentIndex = initialIndex
                                
                if let parentVC = UIApplication.shared.topViewController as? CollectionMultiSelectionViewController {
                    parentVC.zoomIndexDelegate = $0
                    $0.transitionController.fromDelegate = parentVC
                }
                if let parentVC = UIApplication.shared.topViewController as? LinkImageGridViewController {
                    parentVC.zoomIndexDelegate = $0
                    $0.transitionController.fromDelegate = parentVC
                }
                
                $0.transitionController.toDelegate = $0
            })
            .oneStepPushBy(self.rootViewController)
    }
    
    private func popView() -> FlowContributors{
        print("InitFlow popView")
        rootViewController.popViewController(animated: true)
        return .none
    }
     
    private func navigateToMain() -> FlowContributors{
        print("InitFlow navigateToMain")
        return FlowSugar(MainViewModel(), MainViewController.self)
            .navigationItem(with: {
                $0.title = "Fondation"
            })
            .oneStepPushBy(self.rootViewController)
    }
}

//AR
extension UITabBarItem {
    static func setupBarItem() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.notoSans(.regular, size: 10),
                                                          NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6)], for: .normal)

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.notoSans(.bold, size: 10),
                                                          NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)], for: .focused)

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.notoSans(.bold, size: 10),
                                                          NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)], for: .selected)
    }
}
