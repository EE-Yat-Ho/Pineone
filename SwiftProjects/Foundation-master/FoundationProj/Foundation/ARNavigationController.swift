//
//  ARNavigationController.swift
//  UPlusAR
//
//  Created by 최성욱 on 2020/05/28.
//  Copyright © 2020 최성욱. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class ARNavigationController: UINavigationController {
    var forceAnimation: Bool = false
    var isEnableForceAnimation: Bool = false
    var isDasLoginDisplay: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = rx.willShow.subscribe(onNext: { [weak self] viewController in
            self?.navigationBar.isTranslucent = false
            self?.navigationBar.isHidden = true
            if let isDasLogin = self?.isDasLoginDisplay, !isDasLogin {
                ARTabBarController.shared.checkLoginGuideTooltip(isShow: false)
            }

            if viewController.interactivePopGestureRecognizer {
                self?.interactivePopGestureRecognizer?.delegate = self
            }

            // remove "back" title
            let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            viewController.navigationItem.backBarButtonItem = backBarButtonItem
        })

        _ = rx.didShow.subscribe(onNext: { [weak self] viewController in
            if let isDasLogin = self?.isDasLoginDisplay, !isDasLogin {
                ARTabBarController.shared.checkLoginGuideTooltip(isShow: viewController.showLoginTooltip && true)//AuthManager.current.isGuest)
            }
        })
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: isEnableForceAnimation ? forceAnimation : animated)
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        super.popViewController(animated: isEnableForceAnimation ? forceAnimation : animated)
    }

    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        return super.popToViewController(viewController, animated: isEnableForceAnimation ? forceAnimation : animated)
    }

    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        return super.popToRootViewController(animated: isEnableForceAnimation ? forceAnimation : animated)
    }
}

extension ARNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

class RxNavigationControllerDelegateProxy: DelegateProxy<UINavigationController, UINavigationControllerDelegate>, DelegateProxyType, UINavigationControllerDelegate {
    /// Typed parent object.
    public private(set) weak var navigationController: UINavigationController?

    static func registerKnownImplementations() {
        self.register { RxNavigationControllerDelegateProxy(navigationController: $0) }
    }

    public init(navigationController: ParentObject) {
        self.navigationController = navigationController
        super.init(parentObject: navigationController, delegateProxy: RxNavigationControllerDelegateProxy.self)
    }

    class func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
        let navigationController = object as! UINavigationController
        navigationController.delegate = (delegate as? UINavigationControllerDelegate)
    }

    class func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
        return (object as! UINavigationController).delegate
    }
}

extension Reactive where Base: UINavigationController {
    var delegate: DelegateProxy<UINavigationController, UINavigationControllerDelegate> {
        return RxNavigationControllerDelegateProxy.proxy(for: base)
    }

    var willShow: Observable<UIViewController> {
        return delegate
            .methodInvoked(#selector(UINavigationControllerDelegate.navigationController(_:willShow:animated:)))
            .map { $0[1] as! UIViewController }
    }

    var didShow: Observable<UIViewController> {
        return delegate
            .methodInvoked(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
            .map { $0[1] as! UIViewController }
    }
}

extension UIViewController {
    @objc
    var interactivePopGestureRecognizer: Bool {
        return true
    }

    @objc
    var showLoginTooltip: Bool {
        return false
    }
}
