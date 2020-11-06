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

    //MARK:- MoreSee Properties
    private var inputDetailIndex: MoreSeeDetail!
    //let fdRepository = FDRepository()
    
    //MARK:- 공통 소유
    /// Tab ViewController Array
    private lazy var tabControllers: [UIViewController] = makeActivityControllers()
    /// Tab Header Cell Array
    private lazy var tabHeaderCells: [TabPagerHeaderCellModel] = makeActivityModels()
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
    // MARK:- Activity
    private func navigateToMultiTable() -> FlowContributors{
        tabControllers = makeActivityControllers()
        tabHeaderCells = makeActivityModels()
        
        loadContent.subscribe(onNext: {
            [weak self] _ in
                guard let `self` = self else { return }
                self.tabControllers = self.makeActivityControllers()
                self.tabHeaderCells = self.makeActivityModels()
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
    /// 내 활동 화면 초기화
    func makeActivityControllers() -> [UIViewController] {
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
    func makeActivityModels() -> [TabPagerHeaderCellModel] {
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
    
<<<<<<< HEAD
    private func navigateToMultiCollection() -> FlowContributors{
        return FlowSugar(CollectionMultiSelectionViewModel(), CollectionMultiSelectionViewController.self)
             .navigationItem(with:{
                 $0.title = "multiSelectCollection"
             }).oneStepPushBy(self.rootViewController)
=======
    // MARK:- MoreSee
    private func navigateToMultiCollection(_ detail: MoreSeeDetail? = nil) -> FlowContributors{
        tabControllers = makeMoreSeeControllers()
        tabHeaderCells = makeMoreSeeModels()
//        return FlowSugar(CollectionMultiSelectionViewModel(), CollectionMultiSelectionViewController.self)
//             .navigationItem(with:{
//                 $0.title = "multiSelectCollection"
//             }).oneStepPushBy(self.rootViewController)
        self.inputDetailIndex = detail

//        Observable.from(AuthManager.dasLoginedNotifications)
//            .observeOn(MainScheduler.instance)
//            .merge()
        loadContent.on(next: {[weak self] _ in
            guard let `self` = self else { return }
            self.tabControllers = self.makeMoreSeeControllers()
            self.tabHeaderCells = self.makeMoreSeeModels()
            self.tabPagerView?.reload()
            self.tabPagerView?.didLoadsetupLayout()
            self.tabPagerView?.changeIndex(0)
        }).disposed(by: disposeBag)

        return FlowSugar(viewModel: MoreSeeViewModel())
        .presentable(MoreSeeViewController.self)
        .navigationItem(with: {
            $0.title = R.String.moreSee
        })
        .setVCProperty(viewControllerBlock: {[weak self] in
            $0.subView.pagerView.dataSource = self
            $0.subView.pagerView.delegate = self
            $0.subView.pagerView.layoutDelegate = self
            $0.subView.pagerView.hostController = $0
            $0.subView.pagerView.reload()

            $0.subView.pagerView.didLoadsetupLayout()
            self?.tabPagerView = $0.subView.pagerView
        })
        //.oneStepPushBy(navigationController)
        .oneStepPushBy(rootViewController)
>>>>>>> project
     }

    func makeMoreSeeControllers() -> [UIViewController] {
        // 이벤트
        let eventVC = EventViewController()
        let eventVM = EventViewModel(repository: fdRepository, type: .event)
        eventVC.viewModel = eventVM

        // 공지사항
//        let noticeVC = NoticeViewController()
//        let noticeVM = NoticeViewModel(type: .notice, repository: webViewService)
//        noticeVC.viewModel = noticeVM
//
//        // FAQ
//        let faqVC = FAQViewController()
//        let faqVM = FAQViewModel(type: .faq, repository: webViewService)
//        faqVC.viewModel = faqVM
//
//        // 1:1 문의
//        let questionVC = DirectQuestionViewController()
//        let questionVM = MoreSeeDetailViewModel(type: .question, repository: fdRepository)
//        questionVC.viewModel = questionVM
//        questionVC.extendedLayoutIncludesOpaqueBars = true
//        subNavigationController.pushViewController(questionVC, animated: false)
//
//        // 기타 설정
//        let etcVC = ETCViewController()
//        let etcVM = MoreSeeDetailViewModel(type: .etc, repository: fdRepository)
//        etcVC.viewModel = etcVM
//        etcVC.extendedLayoutIncludesOpaqueBars = true
//        etcSubNavigationController.pushViewController(etcVC, animated: false)
//
//        return [eventVC, noticeVC, faqVC, subNavigationController, etcSubNavigationController]
        return [eventVC]
    }
    
    func makeMoreSeeModels() -> [TabPagerHeaderCellModel] {
        return (0 ..< self.tabControllers.count).map {
            MoreSeeDetail(rawValue: $0)
        }.map {
            TabPagerHeaderCellModel(title: $0!.title)
        }
    }
    
    
    private func navigateToLinkImageCollection() -> FlowContributors{
        return FlowSugar(LinkImageGridViewModel(), LinkImageGridViewController.self)
            .navigationItem(with:{
                $0.title = "LinkImageGrid"
            })
            .oneStepPushBy(self.rootViewController)
    }
    
    private func modalShowImageSlider<T>(withItems items: [T], initialIndex: Int) -> FlowContributors{
        
//        return FlowSugar(ZoomingViewModel(items, initialIndex), ZoomingViewController<T>.self)
//            .setVCProperty(viewControllerBlock:{
<<<<<<< HEAD
//                
//                self.rootViewController.delegate = $0.transitionController
//                $0.transitionController.animator.currentIndex = initialIndex
//                                
=======
//
//                self.rootViewController.delegate = $0.transitionController
//                $0.transitionController.animator.currentIndex = initialIndex
//
>>>>>>> project
//                if let parentVC = UIApplication.shared.topViewController as? CollectionMultiSelectionViewController {
//                    parentVC.zoomIndexDelegate = $0
//                    $0.transitionController.fromDelegate = parentVC
//                }
//                if let parentVC = UIApplication.shared.topViewController as? LinkImageGridViewController {
//                    parentVC.zoomIndexDelegate = $0
//                    $0.transitionController.fromDelegate = parentVC
//                }
<<<<<<< HEAD
//                
=======
//
>>>>>>> project
//                $0.transitionController.toDelegate = $0
//            })
//            .oneStepPushBy(self.rootViewController)
        return FlowSugar(LinkImageGridViewModel(), LinkImageGridViewController.self)
            .navigationItem(with:{
                $0.title = "LinkImageGrid"
            })
            .oneStepPushBy(self.rootViewController)
    }
    
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

