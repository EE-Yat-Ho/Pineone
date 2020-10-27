//
//  InitFlow.swift
//  UPlusAR
//
//  Created by baedy on 2020/03/05.
//  Copyright © 2020 최성욱. All rights reserved.
//

import Action
import Foundation
import RxCocoa
import RxFlow
import RxSwift
import Then
import UIKit

class ARTabbarFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }
    private lazy var rootViewController = ARTabBarController.shared

//    let tabBarRelay = PublishRelay<Int>()
    let disposeBag = DisposeBag()

//    let homeFlow = HomeFlow()
//    let searchFlow = SearchFlow()
//    let albumFlow = AlbumFlow()
    let activityFlow = ActivityFlow()
//    let moreSeeFlow = MoreSeeFlow()
    lazy var notificationFlow = NotificationFlow(presentable: rootViewController)

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
//    private lazy var loadAppInfoAction = Action<Void, AppInfo>(workFactory: {
//        return NetworkService.getAppInfo()
//    })

    init() {
//        rootViewController.tabBarRelay.bind(to: tabBarRelay).disposed(by: disposeBag)
    }

    func adapt(step: Step) -> Single<Step> {
        return .just(step)
    }

    // 10월 고도화 flow
    // 자사 : 앱실행 > 스플래시 > 퍼미션 > 네트워크 및 각종 팝업 체크 > 앱 업데이트 > 요금제안내 팝업 > 약관 동의 > 소개 영상 > 체험하기/휴대폰 로그인 화면 > temp/real 세션 >
    // 타사 : 앱실행 > 스플래시 > 퍼미션 > 네트워크 및 각종 팝업 체크 > 앱 업데이트 > 요금제안내 팝업 > 약관 동의 > 소개 영상 > temp 세션 >

    // 추후 es 연동건
    // 자/타사 : 앱실행 > 스플래시 > 퍼미션 > 네트워크 및 각종 팝업 체크 > 앱 업데이트 > 요금제 안내 팝업 > es carrier token > 세션 > 약관 동의 > 소개영상 > 주의 팝업 > 홈...아마 이게 맞을 꺼예요..장담은 못함

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep  else {
            return .none
        }
        Log.d("initFlow step = \(step)")

        switch step {
//        case .initRequired: // 1
//            return navigationToIntro()
//        case .initCompleted: // 16
//            return (Preference.user.bool(.showWarningGuide) ?? false) ? navigate(to: AppStep.checkAppInfo) : warningGuideShow()
        case .moveToHome(let urlScheme):
            print("moveToHome")
            return navigateToHome(urlScheme: urlScheme)
//        case .permissionRequired: // 2
//            return navigateToPermission()
//        case .permissionCompleted: //3
//            self.rootViewController.presentedViewController?.dismiss(animated: true)
//            return navigate(to: MainSteps.introNetworkCheck)
//        case .introNetworkCheck: //4
//            #if !DEBUG
//            if !DeviceManager.default.hasSim() {
//                RxAlert<Content_Text>().show(
//                    AlertModel(content: Content_Text(message: R.String.Popup.hasNoSim),
//                               buttonText: [.exitApp], buttonCompletion: { actionResultModel in
//                                if actionResultModel.result == .exitApp {
//                                    exit(0)
//                                }
//                               }
//                    ))
//                return .none
//            }
//            #endif
//                /// 네트워크 체크
//            Log.d("current network = \(DeviceManager.default.getNetworkConnectionType())")
//            if DeviceManager.default.getNetworkConnectionType() == .type_noNetwork {
//                // 네트워크 없으면 내활동 > 다운로드 콘텐츠 로 이동할 수 있는 팝업이 나와야 함.
//                return networkCheck()
//            }
//            return navigate(to: MainSteps.introNetworkCheckCompleted)
//        case .introNetworkCheckCompleted: //5
//            return navigate(to: MainSteps.appUpdateCheck)
//        case .oneIdLoginRequired: // 12
//            return navigateToOneIdLogin()
//        case .oneIdLoginClose(let type):
//            switch type {
//            case .ctn:
//                self.rootViewController.presentedViewController?.dismiss(animated: true) {
//                    AuthManager.current.showDasLogin { isLogin in
//                        Log.d("oneIdLoginClose = \(isLogin)")
//                        if !isLogin {
//                            AuthManager.current.isGuest = true
//                        }
//                        AppStepper.shared.steps.accept(MainSteps.sessionRequired)
//                    }
//                }
//                return .none
//            case .guest:
//                self.rootViewController.presentedViewController?.dismiss(animated: true)
//                AuthManager.current.isGuest = true
//                return navigate(to: MainSteps.sessionRequired)
//            }
        //return .none
//        case .sessionRequired: // 12 or 13
//            return navigateToRequest(type: .getSession)
//        case .termsRequired(let termsType, let needRegistUser): // 8
//            return navigateToTerms(termsType: termsType, needRegistUser: needRegistUser)
//        case .termsCompleted(let needRegistUser): // 9
//            self.rootViewController.presentedViewController?.dismiss(animated: true)
//            //return needRegistUser ? navigate(to: MainSteps.setUser) : navigate(to: MainSteps.appUpdateCheck)
//            return (Preference.user.bool(.showIntroGuide) ?? false) ? navigate(to: MainSteps.introGuideCompleted) : navigate(to: MainSteps.introGuideRequired)
//        case .setUser: // 14
//            return navigateToRequest(type: .userRegisteration)
//        case .setUserCompleted: // 15
//            return navigate(to: MainSteps.initCompleted)
//        case .appUpdateCheck: // 6
//            return navigateToRequest(type: .checkVersion)
//        case .appUpdateCompleted: // 7
//
//            if (DeviceManager.default.getNetworkConnectionType() == .type_5G || DeviceManager.default.getNetworkConnectionType() == .type_LTE) && !(Preference.user.bool(.showWWANNetworkGuide) ?? false) {
//                RxAlert<Content_Checkbox>().show(
//                    AlertModel(content: Content_Checkbox(message: R.String.Popup.currentWWANNetwork),
//                               buttonText: [.done],
//                               buttonCompletion: {[weak self] actionResultModel in
//                                if actionResultModel.result == .done {
//                                    if let view = actionResultModel.view as? Content_Checkbox {
//                                        if view.checkButton.isSelected {
//                                            Preference.user.set(true, forKey: .showWWANNetworkGuide)
//                                        }
//                                    }
//
//                                    if Preference.user.bool(.terms_Completed) ?? false {
//                                        AppStepper.shared.steps.accept(MainSteps.termsCompleted(needRegistUser: false))
//                                    } else {
//                                        AppStepper.shared.steps.accept(MainSteps.termsRequired(termType: .all, needRegistUser: false))
//                                    }
//                                }
//                        }
//                ))
//                return .none
//            }
//            return (Preference.user.bool(.terms_Completed) ?? false) ? navigate(to: MainSteps.termsCompleted(needRegistUser: false)) : navigate(to: MainSteps.termsRequired(termType: .all, needRegistUser: false))
//        case .introGuideRequired: // 10
//            return navigateToGuide()
//        case .introGuideCompleted: // 11
//            self.rootViewController.presentedViewController?.dismiss(animated: true)
//            #if ISINSPECTING
//            let isForceTesting: Bool = (Preference.inspect.integer(.change_CTN) ?? 0) != 0
//            if isForceTesting {
//                return navigate(to: MainSteps.sessionRequired)
//            }
//            #endif
//
//            if DeviceManager.default.isLGUPuls() {
//                if let ctn = Preference.user.string(.oneid_login_ctn) {
//                    AuthManager.current.oneIdCtn = ctn
//                    return navigate(to: MainSteps.sessionRequired)
//                }
//                return navigate(to: MainSteps.oneIdLoginRequired)
//            }
//            return navigate(to: MainSteps.sessionRequired)
//
//        case .searchSelectGenre(let index):
//            rootViewController.switchToTabBar(page: .genre)
//            return searchFlow.navigate(to: MainSteps.searchSelectGenre(index: index))
        case .moveTab(let index):
            rootViewController.selectTabBarWith(index: index)
            return .none
//        case .warningGuide:
//            return .none
        case .dismissModal:
            self.rootViewController.presentedViewController?.dismiss(animated: true)
            return .none
//        case .checkAppInfo:
//            return checkAppInfo()
        case .popToRootVC:
            rootViewController.viewControllers?.forEach {
                if let navigation = $0 as? ARNavigationController {
                    _ = navigation.popToRootViewController(animated: false)
                }
            }
            let scheme = URLScheme(scheme: .main, parameter1: .view, parameter2: nil, parameter3: nil, parameter4: nil)
            //NotificationService.shared.mapper(model: RemoteNotificationData(link: nil, directUrlScheme: scheme))
            return .none
        default:
            return .none
        }
    }
}

extension ARTabbarFlow {
//    private func navigationToIntro() -> FlowContributors {
//        let sugar = FlowSugar(viewModel: IntroViewModel())
//            .presentable(IntroViewController.self)
//
//        if let vc = sugar.getViewController() {
//            rootViewController.tabBar.isHidden = true
//            rootViewController.setViewControllers([vc], animated: true)
//            return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: sugar.vm))
//        }
//        return .none
//    }
//
//    private func navigateToPermission() -> FlowContributors {
//        return FlowSugar(viewModel: PermissionViewModel())
//            .presentable(PermissionViewController.self)
//            .oneStepModalPresentMakeNavi(rootViewController, .fullScreen)
//    }
//
//    private func navigateToRequest(type: IntroRequsetType) -> FlowContributors {
//        if let intro = rootViewController.children.first as? IntroViewController {
//            intro.flowRequest(type)
//        }
//        return .none
//    }
//
//    private func navigateToTerms(termsType: TermsType, needRegistUser: Bool) -> FlowContributors {
//        let flow = TermsFlow()
//        Flows.use(flow, when: .created) { root in
//            root.modalPresentationStyle = .fullScreen
//            self.rootViewController.present(root, animated: true, completion: nil)
//        }
//        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: OneStepper(withSingleStep: MainSteps.termsRequired(termType: termsType, needRegistUser: needRegistUser))))
//    }
//
//    private func navigateToGuide() -> FlowContributors {
//        return FlowSugar(viewModel: IntroGuideViewModel())
//            .presentable(IntroGuideViewController.self)
//            .oneStepModalPresentMakeNavi(rootViewController, .fullScreen)
//    }
//
//    private func navigateToOneIdLogin() -> FlowContributors {
//        return FlowSugar(viewModel: OneIdLoginViewModel())
//            .presentable(OneIdLoginViewController.self)
//            .oneStepModalPresentMakeNavi(rootViewController, .fullScreen)
//    }
//
    private func navigateToHome(urlScheme: URLScheme? = nil) -> FlowContributors {
        let flows: [Flow] = [activityFlow]
        Flows.use(flows, when: .created) {[unowned self] (roots: [ARNavigationController]) in
            for(index, root) in roots.enumerated() {
                root.tabBarItem = UITabBarItem(title: self.tabBarTitle[index],
                                               image: self.tabBarImageN[index].withRenderingMode(.alwaysOriginal),
                                               selectedImage: self.tabBarImageS[index].withRenderingMode(.alwaysOriginal))
                if index == 0 {
                    root.tabBarItem.imageInsets = UIEdgeInsets(top: -3.33, left: 0, bottom: 3.33, right: 0)
                } else {
                    root.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                }
                root.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -6)
            }

            UITabBarItem.setupBarItem()

            self.unityInit {
                self.rootViewController.tabBar.isHidden = false
                self.rootViewController.setViewControllers(roots, animated: true)
            }
        }
        /// notificationFlow 가 준비 된 후에 딥링크 ㄱㄱ 이거 없어도 동작함
 //       Flows.use(notificationFlow, when: .ready) { _ in
//            AppDelegate.shared.readyNotificationFlow = true
//            if let scheme = urlScheme {
//                let nofiticationData = NotificationService.shared.parseLinkObject(directUrlScheme: scheme)
//                NotificationService.shared.mapper(model: nofiticationData)
//            } else if let deepLink = AppDelegate.shared.readyDeepLink {
//                ARLinkService.shared.link(linkType: .deep, link: deepLink)
//                AppDelegate.shared.readyDeepLink = nil
//            }/
 //       }

        return .multiple(flowContributors: [
//            .contribute(withNextPresentable: homeFlow, withNextStepper: HomeStepper.shared),
//            .contribute(withNextPresentable: searchFlow, withNextStepper: SearchStepper.shared),
//            .contribute(withNextPresentable: albumFlow, withNextStepper: AlbumStepper.shared),
            .contribute(withNextPresentable: activityFlow, withNextStepper: CompositeStepper(steppers: [OneStepper(withSingleStep: AppStep.activity(detail: .recently)), ActivityStepper.shared])),
//            .contribute(withNextPresentable: moreSeeFlow, withNextStepper: CompositeStepper(steppers: [OneStepper(withSingleStep: MainSteps.moreSee(detail: .event)), MoreSeeStepper.shared])),
//            .contribute(withNextPresentable: ARUnityService.default.arFlow, withNextStepper: ARStepper.shared),
//            .contribute(withNextPresentable: notificationFlow, withNextStepper: NotificationStepper.shared)
        ])
    }

    func unityInit(complete :(() -> Void)? = nil) {
//        LoadingService.shared.show()
//        AppDelegate.shared.unityInit {
//            DispatchQueue.main.async {
//                LoadingService.shared.hide()
//                complete?()
//            }
//        }
    }
//
//    func warningGuideShow() -> FlowContributors {
//        RxAlert<Content_warning>(tapTodismiss: false, need: false).show(
//            AlertModel(content: Content_warning(),
//                       buttonText: [.noMore, .done],
//                       buttonCompletion: { action in
//                        switch action.result {
//                        case .noMore:
//                            Preference.user.set(true, forKey: .showWarningGuide)
//                        default:
//                            break
//                        }
//                        AppStepper.shared.steps.accept(MainSteps.checkAppInfo)
//            })
//        )
//        return .none
//    }
//
//    func checkAppInfo() -> FlowContributors {
//        loadAppInfoAction
//            .execute()
//            .on(next: { appInfo in
//                if let list = appInfo.hot_keyword_list {
//                    Preference.user.set(list, forKey: .hot_keyword_list)
//                }
//                if let info = appInfo.blocking_info {
//                    if let mode = info.blocking_mode {
//                        Preference.user.set(mode == .on, forKey: .bloking_mode)
//                    }
//                    if let time = info.preview_time {
//                        Preference.user.set(time, forKey: .preview_time)
//                    }
//                }
//
//                AppStepper.shared.steps.accept(MainSteps.moveToHome())
//            }).disposed(by: disposeBag)
//        return .none
//    }
//
//    func networkCheck() -> FlowContributors {
//        RxAlert<Content_Text>().show(
//            AlertModel(content: Content_Text(message: R.String.Popup.introNetworkCheck),
//                       buttonText: [.exitApp, .yes],
//                       buttonCompletion: { actionResultModel in
//                        if actionResultModel.result == .yes {
//                            let scheme = URLScheme(scheme: .my, parameter1: .download, parameter2: nil, parameter3: nil, parameter4: nil)
//                            AppStepper.shared.steps.accept(MainSteps.moveToHome(urlScheme: scheme))
//                        } else if actionResultModel.result == .exitApp {
//                             exit(0)
//                        }
//            }
//        ))
//        return .none
//    }
}

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
