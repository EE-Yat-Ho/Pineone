//
//  AlertPresentManager.swift
//  UPlusAR
//
//  Created by 정지원 on 2020/03/21.
//  Copyright © 2020 정지원. All rights reserved.
//

import UIKit

public enum AnimationStyle {
    case bottom
    case top
    case left
    case right
    case fadein
}

class DefaultTransitioning: NSObject {
    var aniStyle: AnimationStyle
    var duration: TimeInterval

    init(aniStyle: AnimationStyle, duration: TimeInterval) {
        self.aniStyle = aniStyle
        self.duration = duration
        super.init()
    }

    func setupAnimationStyle(alert: UIView, width: CGFloat, height: CGFloat) {
        switch aniStyle {
        case .bottom:   alert.transform = CGAffineTransform(translationX: 0, y: height); break
        case .top:       alert.transform = CGAffineTransform(translationX: 0, y: -height); break
        case .left:     alert.transform = CGAffineTransform(translationX: -width, y: 0); break
        case .right:    alert.transform = CGAffineTransform(translationX: width, y: 0); break
        case .fadein:   alert.alpha = 0; break
        }
    }
}

class AlertPresentTransitioning: DefaultTransitioning, UIViewControllerAnimatedTransitioning {
    var originFrame = UIScreen.main.bounds

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let toVC = transitionContext.viewController(forKey: .to), let alertView = toVC.view {
            toVC.view.frame = originFrame
            transitionContext.containerView.addSubview(toVC.view)

            setupAnimationStyle(alert: alertView, width: toVC.view.bounds.size.width, height: toVC.view.bounds.size.height)
            let duration = transitionDuration(using: transitionContext)

            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                alertView.alpha = 1
                alertView.transform = .identity
                toVC.view.backgroundColor = UIColor(white: 0, alpha: 0.4)
            }, completion: { finished in
                transitionContext.completeTransition(finished)
            })
        }
    }
}

class AlertDismissTransitioning: DefaultTransitioning, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let fromVC = transitionContext.viewController(forKey: .from), let alertView = fromVC.view {
            let duration = transitionDuration(using: transitionContext)

            UIView.animate(withDuration: duration, animations: {
                self.setupAnimationStyle(alert: alertView, width: fromVC.view.bounds.size.width, height: fromVC.view.bounds.size.height)
                fromVC.view.backgroundColor = .clear
            }) { _ in transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}

class AlertPresentManager: NSObject, UIViewControllerTransitioningDelegate {
    static let shared = AlertPresentManager()

    public var style: AnimationStyle = .fadein
    var presentDuration = 0.3
    var dismissDuration = 0.3
    var interactor: UIPercentDrivenInteractiveTransition?

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AlertPresentTransitioning(aniStyle: self.style, duration: presentDuration)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AlertDismissTransitioning(aniStyle: self.style, duration: dismissDuration)
    }
}

class AlertViewPresentManager {
    //static let shared = WindowAlertPresentManager()

    static func fadeOutTransition(view: UIView, _ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
            view.alpha = 0.0
        }) { _ in
            completion()
        }
    }

    static func scaleInTransition(view: UIView) {
        view.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            view.alpha = 1.0
        })

        let previousTransform = view.transform
        view.layer.transform = CATransform3DMakeScale(0.9, 0.9, 0.0)

        UIView.animate(withDuration: 0.2, animations: {
            view.layer.transform = CATransform3DMakeScale(1.1, 1.1, 0.0)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, animations: {
                view.layer.transform = CATransform3DMakeScale(1.0, 1.0, 0.0)
            }, completion: { _ in
                view.transform = previousTransform
            })
        })
    }
}
