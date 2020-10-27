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

    //AR
    //let aRTabbarFlow = ARTabbarFlow()
    let activityFlow = ActivityFlow()
    var tabBarTitle: [String] {
        return [R.String.home, R.String.search, R.String.album, R.String.activity, R.String.moreSee]
    }
    var tabBarImageN: [UIImage] {
        return [#imageLiteral(resourceName: "gnbHomeNor"), #imageLiteral(resourceName: "gnbGenreNor"), #imageLiteral(resourceName: "gnbAlbumNor"), #imageLiteral(resourceName: "gnbMyNor"), #imageLiteral(resourceName: "gnbMoreNor") ]
    }

    var tabBarImageP: [UIImage] {
        return [#imageLiteral(resourceName: "gnbHomePre"), #imageLiteral(resourceName: "gnbGenrePre"), #imageLiteral(resourceName: "gnbAlbumPre"), #imageLiteral(resourceName: "gnbMyPre"), #imageLiteral(resourceName: "gnbMorePre") ]
    }

    var tabBarImageS: [UIImage] {
        return [#imageLiteral(resourceName: "gnbHomeSel"), #imageLiteral(resourceName: "gnbGenreSel"), #imageLiteral(resourceName: "gnbAlbumSel"), #imageLiteral(resourceName: "gnbMySel"), #imageLiteral(resourceName: "gnbMoreSel") ]
    }
    /// Tab ViewController Array
    private lazy var tabControllers: [UIViewController] = makeInitialize()
    /// Tab Header Cell Array
    private lazy var tabHeaderCells: [TabPagerHeaderCellModel] = makeTabModels()
    /// Index Header
    private var inputTabIndex: ActivityDetail!
    private var tabPagerView: TabPagerView?
    private let disposeBag = DisposeBag()
    var loadContent = PublishRelay<Void>()
    
    
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
        
//        return FlowSugar(ActivityViewModel(),
//                         ActivityViewController.self)
//            .navigationItem(with:{
//                $0.title = "multiSelectTable"
//            }).oneStepPushBy(self.rootViewController)
//        let flows: [Flow] = [activityFlow]
//        Flows.use(flows, when: .created) {[unowned self] (roots: [ARNavigationController]) in
//            for(index, root) in roots.enumerated() {
//                root.tabBarItem = UITabBarItem(title: self.tabBarTitle[index],
//                                               image: self.tabBarImageN[index].withRenderingMode(.alwaysOriginal),
//                                               selectedImage: self.tabBarImageS[index].withRenderingMode(.alwaysOriginal))
//                if index == 0 {
//                    root.tabBarItem.imageInsets = UIEdgeInsets(top: -3.33, left: 0, bottom: 3.33, right: 0)
//                } else {
//                    root.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//                }
//                root.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -6)
//            }
//
//            UITabBarItem.setupBarItem()
////            self.unityInit {
////                self.rootViewController.tabBar.isHidden = false
////                self.rootViewController.setViewControllers(roots, animated: true)
////            }
//
//            //rootViewController.pushViewController(flows, animated: true)
//        }
//        /// notificationFlow 가 준비 된 후에 딥링크 ㄱㄱ
////        Flows.use(notificationFlow, when: .ready) { _ in
////            AppDelegate.shared.readyNotificationFlow = true
////            if let scheme = urlScheme {
////                let nofiticationData = NotificationService.shared.parseLinkObject(directUrlScheme: scheme)
////                NotificationService.shared.mapper(model: nofiticationData)
////            } else if let deepLink = AppDelegate.shared.readyDeepLink {
////                ARLinkService.shared.link(linkType: .deep, link: deepLink)
////                AppDelegate.shared.readyDeepLink = nil
////            }
////        }
//
//
//        //ActivityStepper.shared.steps.accept(AppStep.moveToHome())
//
//        return .multiple(flowContributors: [
//            .contribute(withNextPresentable: activityFlow, withNextStepper: CompositeStepper(steppers: [OneStepper(withSingleStep: AppStep.activity(detail: .recently)), ActivityStepper.shared]))
//        ])
        
        //self.inputTabIndex = detail

//        Observable.from(AuthManager.dasLoginedNotifications)
//            .observeOn(MainScheduler.instance)
//            .merge().map { _ in Void() }
//            .bind(to: loadContent).disposed(by: disposeBag)

//        ReachabilityManager.current.rx.netState
//            .filter { $0 == .connect }.map { _ in Void() }
//            .bind(to: loadContent).disposed(by: disposeBag)

        loadContent.subscribe(onNext: { //_ in
            //Log.d("updateStatus")
            //_ = NetworkService.getHome().subscribe(onSuccess:
            [weak self] _ in
                guard let `self` = self else { return }
                self.tabControllers = self.makeInitialize()
                self.tabHeaderCells = self.makeTabModels()
                self.tabPagerView?.reload()
                self.tabPagerView?.didLoadsetupLayout()
                self.tabPagerView?.changeIndex(0)
        }).disposed(by: disposeBag)

        return FlowSugar(viewModel: ActivityViewModel())
            .presentable(ActivityViewController.self)
            .navigationItem(with: {
                $0.title = R.String.activity
            })
            .setVCProperty(viewControllerBlock: {[weak self] in
                $0.subView.tabPagerView.dataSource = self
                $0.subView.tabPagerView.delegate = self
                $0.subView.tabPagerView.layoutDelegate = self
                $0.subView.tabPagerView.hostController = $0
                $0.subView.tabPagerView.reload()
                $0.subView.tabPagerView.didLoadsetupLayout()
                self?.tabPagerView = $0.subView.tabPagerView
            })
            .oneStepPushBy(rootViewController)
//        //return .none
    }
    /////
    /// 내 활동 화면 초기화
    func makeInitialize() -> [UIViewController] {
        /// lg 통신사가 아닌경우 다운로드
//        if !AuthManager.current.isUplusMember {
//            let downloadVC = DownloadViewController()
//            let downloadVM = DownloadViewModel()
//            downloadVC.viewModel = downloadVM
//            return [downloadVC]
//        }

        /// 최근 본
        let recentlyVC = RecentlyViewController()
        let recentlyVM = RecentlyViewModel()
        recentlyVC.viewModel = recentlyVM

        /// 다운로드
        let downloadVC = DownloadViewController()
        let downloadVM = DownloadViewModel()
        downloadVC.viewModel = downloadVM

        /// 좋아요
        let likeVC = LikeViewController()
        let likeVM = LikeViewModel()
        likeVC.viewModel = likeVM

        /// 내가 쓴 댓글
        let replyVC = ReplyViewController()
        let replyVM = ReplyViewModel()
        replyVC.viewModel = replyVM

        return [recentlyVC, downloadVC, likeVC, replyVC]
    }

    /// 내 활동 탭 모델링
    func makeTabModels() -> [TabPagerHeaderCellModel] {
//        if !AuthManager.current.isUplusMember {
//            return [TabPagerHeaderCellModel(title: ActivityDetail(rawValue: 1)!.title, displayNewIcon: false)]
//        } else {
            return (0 ..< self.tabControllers.count).map {
                ActivityDetail(rawValue: $0)
            }.map {
                TabPagerHeaderCellModel(title: $0!.title, displayNewIcon: false)
            }
//        }
    }
    /////
    
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


/////
// MARK: - TabPagerViewDataSource
extension InitFlow: TabPagerViewDataSource {
    func numberOfItems() -> Int? {
        return self.tabControllers.count
    }

    func controller(at index: Int) -> UIViewController? {
        if index >= self.tabControllers.count {
            return self.tabControllers.last
        }
        return self.tabControllers[index]
    }

    func setCell(at index: Int) -> TabPagerHeaderCellModel? {
        return tabHeaderCells[index]
    }

    func separatViewColor() -> UIColor {
        return #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
    }

    func defaultIndex() -> Int {
//        if !AuthManager.current.isUplusMember {
//            return 0
//        }
//
//        if DeviceManager.default.getNetworkConnectionType() == .type_noNetwork {
//            return ActivityDetail.download.rawValue
//        }
//
//        return inputTabIndex.rawValue
        return 0
    }

    func shouldEnableSwipeable() -> Bool {
        return true
    }
}

// MARK: - TabPagerViewDelegate
extension InitFlow: TabPagerViewDelegate {
    func willTransition(to index: Int) {
        Log.d("Current index before transition: \(index)")
    }

    func didTransition(to index: Int) {
        Log.d("Current index after transition: \(index)")
    }

    func didSelectButton(at index: Int) {
        Log.d("Current index after transition: \(index)")
    }
}

// MARK: - TabPagerViewDelegateLayout
extension InitFlow: TabPagerViewDelegateLayout {
    func heightForHeader() -> CGFloat {
        return 56
    }

    func heightForSeparation() -> CGFloat {
        return 1
    }

    func isStaticCellWidth() -> Bool {
        return true
    }
}

