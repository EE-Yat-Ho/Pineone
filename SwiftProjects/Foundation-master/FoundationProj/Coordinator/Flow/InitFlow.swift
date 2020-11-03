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

    /// Tab ViewController Array
    private lazy var tabControllers: [UIViewController] = makeInitialize()
    /// Tab Header Cell Array
    private lazy var tabHeaderCells: [TabPagerHeaderCellModel] = makeTabModels()
    /// Index Header
    //private var inputTabIndex: ActivityDetail!
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
        guard let step = step as? AppStep else {
            return .none
        }
        
        switch step {
        case .initialize:
            return navigateToMain()
        case .multiSelectTable:
            return navigateToMultiTable()
        case .multiSelectCollection:
            return navigateToMultiCollection()
        case .webSchemeTest:
            return navigateToWebTest()
        case .linkCollection:
            return navigateToLinkImageCollection()
        case .linkImageZoom(let urls, let index):
            return modalShowImageSlider(withItems: urls, initialIndex: index)
        case .close:
            return popView()
        case .assetImageZoom(let aseets, let index):
            return modalShowImageSlider(withItems: aseets, initialIndex: index)
        case .horizontalStackScroll:
            return navigateToHSS()
        case .rotate:
            return FlowSugar(RotateViewModel(), RotateViewController.self)
                .oneStepPushBy(self.rootViewController)
        case .playerSlider:
            return FlowSugar(PlayerViewModel(), PlayerViewController.self)
                .oneStepPushBy(self.rootViewController)
        case .filterSlider:
            return FlowSugar(FilterSliderViewModel(), FilterSliderViewController.self)
                .oneStepPushBy(self.rootViewController)
        case .rotateStackScroll:
            return FlowSugar(RotateSSViewModel(), RotateSSViewController.self)
            .oneStepPushBy(self.rootViewController)
        case .toastWithView:
            return FlowSugar(ToastShowViewModel(), ToastShowViewController.self)
                .oneStepPushBy(self.rootViewController)
        default:
            return .none
        }
    }
}

extension InitFlow{
    private func navigateToWebTest() -> FlowContributors{
        return FlowSugar(WebTestViewModel(), WebTestViewController.self)
            .navigationItem(with: {
                $0.title = "web scheme test"
            }).oneStepPushBy(self.rootViewController)
    }
    
    private func navigateToHSS() -> FlowContributors{
        return FlowSugar(HorizontalStackScrollViewModel(), HorizontalStackScrollViewController.self)
            .navigationItem(with: {
                $0.title = "HorizontalStackScroll"
            }).oneStepPushBy(self.rootViewController)
    }
    
    private func navigateToMultiTable() -> FlowContributors{
        
        loadContent.subscribe(onNext: {
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
        /// 최근 본
        let recentlyVC = CompactViewController(activityDetail: .recently)
        let recentlyVM = CompactViewModel()
        recentlyVC.viewModel = recentlyVM
        recentlyVM.activityDetail = .recently

        /// 다운로드
        let downloadVC = CompactViewController(activityDetail: .download)
        let downloadVM = CompactViewModel()
        downloadVC.viewModel = downloadVM
        downloadVM.activityDetail = .download
        
        /// 좋아요
        let likeVC = CompactViewController(activityDetail: .like)
        let likeVM = CompactViewModel()
        likeVC.viewModel = likeVM
        likeVM.activityDetail = .like

        /// 내가 쓴 댓글
        let replyVC = CompactViewController(activityDetail: .reply)
        let replyVM = CompactViewModel()
        replyVC.viewModel = replyVM
        replyVM.activityDetail = .reply

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
        return FlowSugar(CollectionMultiSelectionViewModel(), CollectionMultiSelectionViewController.self)
             .navigationItem(with:{
                 $0.title = "multiSelectCollection"
             }).oneStepPushBy(self.rootViewController)
     }
    
    private func navigateToLinkImageCollection() -> FlowContributors{
        return FlowSugar(LinkImageGridViewModel(), LinkImageGridViewController.self)
            .navigationItem(with:{
                $0.title = "LinkImageGrid"
            })
            .oneStepPushBy(self.rootViewController)
    }
    
    private func modalShowImageSlider<T>(withItems items: [T], initialIndex: Int) -> FlowContributors{
        
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
        rootViewController.popViewController(animated: true)
        return .none
    }
     
    private func navigateToMain() -> FlowContributors{
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
        return 4
        //return self.tabControllers.count
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

