////
////  BaseFlow.swift
////  UPlusAR
////
////  Created by baedy on 2020/06/24.
////  Copyright © 2020 최성욱. All rights reserved.
////
//
//import RxFlow
//import UIKit
//
//class BaseFlow: Flow {
//    var root: Presentable {
//        return navigationController
//    }
//
//    var navigationController = ARNavigationController().then {
//        $0.setNavigationBarHidden(true, animated: false)
//    }
//
//    @discardableResult
//    func navigate(to step: Step) -> FlowContributors {
//        guard let step = step as? AppStep else { return .none }
//
//        switch step {
//        case .dismissModal:
//            navigationController.dismiss(animated: true)
//            return .none
////        case .share(let list, let handler):
////            return self.shareAsset(list, handler)
//
////        case .navigationARPlayer(value: let value):
////            if value.isDetail {
////                ARUnityService.default.contentDetail(contentKey: value.contentKey, playList: value.playList)
////            } else {
////                ARUnityService.default.varifyThenWith(contentKey: value.contentKey, playList: value.playList)
////            }
////            return .none
////        case .navigationARGame(value: let value):
////            if value.formDetail {
////                if let item = value.contentItem {
////                    ARGameService.shared.gamePlay(data: item, formDetail: true)
////                }
////            } else {
////                ARGameService.shared.loadARGame(contentKey: value.contentKey, playList: value.playList)
////            }
////            return .none
//        default:
//            return .none
//        }
//    }
//
//    private func shareAsset(_ list: [Any], _ handler: UIActivityViewController.CompletionWithItemsHandler? = nil) -> FlowContributors {
//        LoadingService.shared.show()
//        let activityViewController = UIActivityViewController(activityItems: list, applicationActivities: nil)
//
//        activityViewController.completionWithItemsHandler = handler
//
//        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.saveToCameraRoll]
//
//        activityViewController.popoverPresentationController?.sourceView = UIApplication.shared.topViewController?.view
//
//        UIApplication.shared.topViewController?.present(activityViewController, animated: true, completion: {
//            LoadingService.shared.hide()
//        })
//
//        return .none
//    }
//}
//
////extension BaseFlow {
////    public func navigateToImageSlider<T>(withItems items: [T], initialIndex: Int, zoomType: ZoomViewType = .album, animate: Bool = true, orient: UIDeviceOrientation = .portrait) -> FlowContributors {
////        return FlowSugar(ZoomingViewModel(items, initialIndex), ZoomingViewController<T>.self)
////            .setVCProperty(viewControllerBlock: {[weak self] vc in
////                guard let `self` = self else { return }
////                vc.zoomType = zoomType
////                if animate {
////                    vc.transitioningDelegate = vc.transitionController
////                    vc.transitionController.toDelegate = vc
////                }
////                vc.transitionController.animator.currentIndex = initialIndex
////                vc.hidesBottomBarWhenPushed = true
////                vc.extendedLayoutIncludesOpaqueBars = true
////                vc.currentOrient = orient
////
////                if let parentVC = self.navigationController.topViewController as? MyAlbumViewController {
////                    parentVC.zoomIndexDelegate = vc
////                    parentVC.transitioningDelegate = vc.transitionController
////                    vc.transitionController.fromDelegate = parentVC
////                } else if let parentVC = self.navigationController.topViewController as? ContentDetailViewController {
////                    parentVC.zoomIndexDelegate = vc
////                    parentVC.transitioningDelegate = vc.transitionController
////                    vc.transitionController.fromDelegate = parentVC
////                }
////            })
////        .oneStepModalPresent(navigationController)
////    }
////}
//
//extension FlowContributors {
//    var isNone: Bool {
//        switch self {
//        case .none:
//            return true
//        default:
//            return false
//        }
//    }
//}
