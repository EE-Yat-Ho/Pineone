//
//  ARTabBarController.swift
//  UPlusAR
//
//  Created by 최성욱 on 2020/05/28.
//  Copyright © 2020 최성욱. All rights reserved.
//

import RxCocoa
import RxFlow
import RxSwift
import UIKit

enum ARTabPage: Int {
    case home
    case genre
    case myAlbum
    case activity
    case more
}

class ARTabBarController: UITabBarController, UITabBarControllerDelegate {
    static let shared = ARTabBarController()
//    let tabBarRelay = PublishRelay<Int>()
    private var popupEnable = true

    private var _tabBarHeight: CGFloat = 0
    var tabBarHeight: CGFloat {
        get {
            return _tabBarHeight
        }
    }

    var isHidden: Bool {
        return self.tabBar.isHidden
    }

    lazy var loginGuideTooltip = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.87)
        $0.cornerRadius = 12
        $0.isHidden = true
        let guideTextView = UILabel().then {
            $0.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            $0.text = R.String.Login.tooltipMessage
            $0.font = .notoSans(.medium, size: 13)
            $0.letterSpace = -0.4
            $0.textAlignment = .left
            $0.numberOfLines = 0
        }

        let arrowButton = Button().then {
            $0.setImage(#imageLiteral(resourceName: "icRightNor"), for: .normal)
            $0.setImage(#imageLiteral(resourceName: "icRightPre"), for: .highlighted)
            $0.isUserInteractionEnabled = false
        }

        $0.addSubviews([guideTextView, arrowButton])

        guideTextView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(arrowButton.snp.leading).offset(8)
        }

        arrowButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-10)
            $0.width.height.equalTo(14)
        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.buttonAction))
        $0.addGestureRecognizer(gesture)
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        delegate = self
//        tabBar.isTranslucent = false
        tabBar.barTintColor = .black

        view.addSubview(loginGuideTooltip)
        loginGuideTooltip.snp.makeConstraints {
            $0.width.equalTo(259)
            $0.height.equalTo(66)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(0)
        }

//        _ = AuthManager.current.rx.logined.on(next: { _ in
//            guard let vc = UIApplication.shared.topViewController else { return }
//            self.checkLoginGuideTooltip(isShow: vc.showLoginTooltip && AuthManager.current.isGuest)
//        })
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let window = UIWindow.key else { return }
        let height = window.safeAreaInsets.bottom + 60
        _tabBarHeight = height
        tabBar.frame.size.height = height
        tabBar.frame.origin.y = view.frame.height - height
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let tabBarItems = tabBar.items else { return }
        tabBarImageInsetSetting(tabBarItems: tabBarItems, selectItem: item)
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        tabBarRelay.accept(tabBarController.selectedIndex)
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let tabViewControllers = tabBarController.viewControllers,
            let index = tabViewControllers.firstIndex(of: viewController) else { return false }
        tapTransition(toIndex: index)
        return true
    }

    @discardableResult
    func selectTabBarWith(index: ARTabPage) -> FlowContributors {
        switchToTabBar(page: index)
        //self.selectedIndex = index

        return .none
    }

    func switchToTabBar(page: ARTabPage) {
        guard let tabBarItems = tabBar.items else { return }
        tapTransition(toIndex: page.rawValue)
        selectedIndex = page.rawValue
        tabBarImageInsetSetting(tabBarItems: tabBarItems, selectItem: tabBarItems[page.rawValue])
    }

    func tabBarImageInsetSetting(tabBarItems: [UITabBarItem], selectItem: UITabBarItem) {
        for tabBarItem in tabBarItems {
            tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            if tabBarItem == selectItem {
                tabBarItem.imageInsets = UIEdgeInsets(top: -3.33, left: 0, bottom: 3.33, right: 0)
            }
        }
    }

    func checkLoginGuideTooltip(isShow: Bool) {
//        if let limitDate = Preference.user.date(.setShowingLoginTooltipDate) {
//            if limitDate > Date() {
//                Log.d("checkLoginGuideTooltip limitDate hidden")
//                loginGuideTooltip.isHidden = true
//                return
//            }
//        }
//        Log.d("checkLoginGuideTooltip isShow = \(isShow)")
//        loginGuideTooltip.isHidden = !isShow
//        loginGuideTooltip.snp.updateConstraints {
//            $0.bottom.equalToSuperview().offset(-(_tabBarHeight + 12))
//        }
    }

    @objc func buttonAction(_ button: UIButton) {
//        if !popupEnable {
//            return
//        }
//
//        popupEnable = false
//        RxAlert<Content_Verify_CTN>(isExistNeverShowingCheck: true)
//            .show(AlertModel(content: Content_Verify_CTN(),
//                             buttonText: [.verifyCTN],
//                             buttonCompletion: {[weak self] actionResultModel in
//                                if let vc = actionResultModel.alertViewController as? CustomAlertViewController<Content_Verify_CTN> {
//                                    if vc.checkButton.isSelected {
//                                        let limiteDate = Date(string: Date().adding(7, .day).string(withFormat: "yyyyMMdd") + "2359", format: "yyyyMMddHHmm")
//                                        guard let date = limiteDate else { return }
//                                        Log.d("Content_Verify_CTN alert limiteDate : \(date)")
//                                        self?.loginGuideTooltip.isHidden = true
//                                        Preference.user.set(date, forKey: .setShowingLoginTooltipDate)
//                                    }
//                                }
//
//                                if actionResultModel.result == .verifyCTN {
//                                    AuthManager.current.notLoginUserVerityCTN {
//                                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: {
//                                            NotificationCenter.default.post(name: Notification.Name.DasLogined, object: nil)
//                                        })
//                                    }
//                                }
//                                self?.popupEnable = true
//            }))
    }
}

extension ARTabBarController {
    func tapTransition(toIndex: Int) {
        guard let tabViewControllers = viewControllers,
            let selectedVC = selectedViewController else { return }

        guard let fromView = selectedVC.view,
            let toView = tabViewControllers[toIndex].view,
            let fromIndex = tabViewControllers.firstIndex(of: selectedVC),
            fromIndex != toIndex else { return }

        fromView.superview?.addSubview(toView)

//        switch toIndex {
//        case 0: // 홈화면
//            AnalyticsService.shared.logEvent(opCode: .entry_home)
//        case 1: // 검색 화면 entry_zenre
//            AnalyticsService.shared.logEvent(opCode: .entry_zenre)
//        case 2: // 내앨범
//            AnalyticsService.shared.logEvent(opCode: .entry_myAlbum)
//        case 3: // 내 활동
//            AnalyticsService.shared.logEvent(opCode: .entry_activity)
//        case 4: // 더보기
//            AnalyticsService.shared.logEvent(opCode: .entry_more)
//        default: break
//        }

        let screenWidth = UIScreen.main.bounds.size.width
        let scrollRight = toIndex > fromIndex
        let offset = (scrollRight ? screenWidth : -screenWidth)
        toView.center = CGPoint(x: fromView.center.x + offset, y: toView.center.y)

        view.isUserInteractionEnabled = false

        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
                        fromView.center = CGPoint(x: fromView.center.x - offset, y: fromView.center.y)
                        toView.center = CGPoint(x: toView.center.x - offset, y: toView.center.y)
        }, completion: { _ in
            fromView.removeFromSuperview()
            self.selectedIndex = toIndex
            self.view.isUserInteractionEnabled = true
        })
    }
}
