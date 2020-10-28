////
////  ActivityFlow.swift
////  UPlusAR
////
////  Created by baedy on 2020/03/05.
////  Copyright © 2020 최성욱. All rights reserved.
////
//
//import RxCocoa
//import RxFlow
//import RxSwift
//import UIKit
//
/// 내 활동 화면 탭 타이틀 정의
enum ActivityDetail: Int {
    case recently
    case download
    case like
    case reply

    var title: String {
        get {
            switch self {
            case .recently:
                return R.String.Activity.recently_title
            case .download:
                return R.String.Activity.donwload_title
            case .like:
                return R.String.Activity.like_title
            case .reply:
                return R.String.Activity.reply_title
            }
        }
    }
}
//}
//
//class ActivityFlow: BaseFlow {
//    /// Tab ViewController Array
//    private lazy var tabControllers: [UIViewController] = makeInitialize()
//    /// Tab Header Cell Array
//    private lazy var tabHeaderCells: [TabPagerHeaderCellModel] = makeTabModels()
//    /// Index Header
//    private var inputTabIndex: ActivityDetail!
//    private var tabPagerView: TabPagerView?
//    private let disposeBag = DisposeBag()
//
//    var loadContent = PublishRelay<Void>()
//
//    /// Navigate to step
//    override func navigate(to step: Step) -> FlowContributors {
//        let superContributors = super.navigate(to: step)
//        if !superContributors.isNone {
//            return superContributors
//        }
//
//        guard let step = step as? AppStep else { return .none }
//        Log.d("ActivityFlow step = \(step)")
//        switch step {
//        case .activity(let detail):
//            return self.navigateToActivityScreen(detail)
////        case .contentDetail(value: let value):
////            return .one(flowContributor: .contribute(withNextPresentable: ContentsDetailFlow(with: navigationController),
////            withNextStepper: OneStepper(withSingleStep: MainSteps.contentDetail(contentKey: value.contentKey, playList: value.playList))))
////        case .contentDetailExit:
////            self.navigationController.popViewController(animated: true)
////            return .none
//
//        case .navigationActivity(let index):
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
////                if !AuthManager.current.isUplusMember {
////                    self?.tabPagerView?.changeIndex(0)
////                } else if DeviceManager.default.getNetworkConnectionType() == .type_noNetwork {
////                    self?.tabPagerView?.changeIndex(0)
////                } else {
//                    self?.tabPagerView?.changeIndex(index)
//                //}
//            }
//
//            return .none
//        default:
//            return .none
//        }
//    }
//}
//
//extension ActivityFlow {
//    private func navigateToActivityScreen(_ detail: ActivityDetail? = nil) -> FlowContributors {
//        print("navigateToActivityScreen")
//        self.inputTabIndex = detail
//
////        Observable.from(AuthManager.dasLoginedNotifications)
////            .observeOn(MainScheduler.instance)
////            .merge().map { _ in Void() }
////            .bind(to: loadContent).disposed(by: disposeBag)
//
////        ReachabilityManager.current.rx.netState
////            .filter { $0 == .connect }.map { _ in Void() }
////            .bind(to: loadContent).disposed(by: disposeBag)
//
//        loadContent.subscribe(onNext: { //_ in
//            //Log.d("updateStatus")
//            //_ = NetworkService.getHome().subscribe(onSuccess:
//            [weak self] _ in
//                guard let `self` = self else { return }
//                self.tabControllers = self.makeInitialize()
//                self.tabHeaderCells = self.makeTabModels()
//                self.tabPagerView?.reload()
//                self.tabPagerView?.didLoadsetupLayout()
//                self.tabPagerView?.changeIndex(0)
//        }).disposed(by: disposeBag)
//
//        return FlowSugar(viewModel: ActivityViewModel())
//            .presentable(ActivityViewController.self)
//            .navigationItem(with: {
//                $0.title = R.String.activity
//            })
//            .setVCProperty(viewControllerBlock: {[weak self] in
//                $0.subView.tabPagerView.dataSource = self
//                $0.subView.tabPagerView.delegate = self
//                $0.subView.tabPagerView.layoutDelegate = self
//                $0.subView.tabPagerView.hostController = $0
//                $0.subView.tabPagerView.reload()
//                $0.subView.tabPagerView.didLoadsetupLayout()
//                self?.tabPagerView = $0.subView.tabPagerView
//            })
//            .oneStepPushBy(navigationController)
//    }
//
//    /// 내 활동 화면 초기화
//    func makeInitialize() -> [UIViewController] {
//        /// lg 통신사가 아닌경우 다운로드
////        if !AuthManager.current.isUplusMember {
////            let downloadVC = DownloadViewController()
////            let downloadVM = DownloadViewModel()
////            downloadVC.viewModel = downloadVM
////            return [downloadVC]
////        }
//
//        /// 최근 본
//        let recentlyVC = RecentlyViewController()
//        let recentlyVM = RecentlyViewModel()
//        recentlyVC.viewModel = recentlyVM
//
//        /// 다운로드
//        let downloadVC = DownloadViewController()
//        let downloadVM = DownloadViewModel()
//        downloadVC.viewModel = downloadVM
//
//        /// 좋아요
//        let likeVC = LikeViewController()
//        let likeVM = LikeViewModel()
//        likeVC.viewModel = likeVM
//
//        /// 내가 쓴 댓글
//        let replyVC = ReplyViewController()
//        let replyVM = ReplyViewModel()
//        replyVC.viewModel = replyVM
//
//        return [recentlyVC, downloadVC, likeVC, replyVC]
//    }
//
//    /// 내 활동 탭 모델링
//    func makeTabModels() -> [TabPagerHeaderCellModel] {
////        if !AuthManager.current.isUplusMember {
////            return [TabPagerHeaderCellModel(title: ActivityDetail(rawValue: 1)!.title, displayNewIcon: false)]
////        } else {
//            return (0 ..< self.tabControllers.count).map {
//                ActivityDetail(rawValue: $0)
//            }.map {
//                TabPagerHeaderCellModel(title: $0!.title, displayNewIcon: false)
//            }
////        }
//    }
//}
//
//// MARK: - TabPagerViewDataSource
//extension ActivityFlow: TabPagerViewDataSource {
//    func numberOfItems() -> Int? {
//        return self.tabControllers.count
//    }
//
//    func controller(at index: Int) -> UIViewController? {
//        if index >= self.tabControllers.count {
//            return self.tabControllers.last
//        }
//        return self.tabControllers[index]
//    }
//
//    func setCell(at index: Int) -> TabPagerHeaderCellModel? {
//        return tabHeaderCells[index]
//    }
//
//    func separatViewColor() -> UIColor {
//        return #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
//    }
//
//    func defaultIndex() -> Int {
////        if !AuthManager.current.isUplusMember {
////            return 0
////        }
////
////        if DeviceManager.default.getNetworkConnectionType() == .type_noNetwork {
////            return ActivityDetail.download.rawValue
////        }
////
////        return inputTabIndex.rawValue
//        return 0
//    }
//
//    func shouldEnableSwipeable() -> Bool {
//        return true
//    }
//}
//
//// MARK: - TabPagerViewDelegate
//extension ActivityFlow: TabPagerViewDelegate {
//    func willTransition(to index: Int) {
//        Log.d("Current index before transition: \(index)")
//    }
//
//    func didTransition(to index: Int) {
//        Log.d("Current index after transition: \(index)")
//    }
//
//    func didSelectButton(at index: Int) {
//        Log.d("Current index after transition: \(index)")
//    }
//}
//
//// MARK: - TabPagerViewDelegateLayout
//extension ActivityFlow: TabPagerViewDelegateLayout {
//    func heightForHeader() -> CGFloat {
//        return 56
//    }
//
//    func heightForSeparation() -> CGFloat {
//        return 1
//    }
//
//    func isStaticCellWidth() -> Bool {
//        return true
//    }
//}
