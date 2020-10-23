//
//  AlertService.swift
//  UPlusAR
//
//  Created by 정지원 on 2020/03/25.
//  Copyright © 2020 정지원. All rights reserved.
//

import UIKit

enum OverlapMode {
    case queue
    case lastOne
    case firstOne
}

class AlertService {
    public static let shared = AlertService()
    private var queue: [UIViewController] = []
    private var isPresenting: Bool = false
    private let mode: OverlapMode = .queue
    private var presentViewController: UIViewController?

    private var rootViewController: UIViewController? {
        get { UIApplication.shared.windows.first?.rootViewController }
    }

    func enqueue(alert: UIViewController) {
        guard !isPresenting else {
            queue.append(alert)
            return
        }

        present(viewController: alert)
    }

    func dequeue() {
        guard !queue.isEmpty else {
            isPresenting = false
            return
        }

        present(viewController: queue.removeFirst())
    }

    func present(viewController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            if let window = UIApplication.shared.keyWindowInConnectedScenes {
                self?.presentViewController = viewController
                self?.isPresenting = true

                window.addSubview(viewController.view)
                window.bringSubviewToFront(viewController.view)
                viewController.view.frame = window.bounds

                AlertViewPresentManager.scaleInTransition(view: viewController.view)
            }
        }
    }

    func dismiss() {
        if let vc = presentViewController {
            vc.view.removeFromSuperview()
            presentViewController = nil
//            AlertViewPresentManager.fadeOutTransition(view: vc.view) {
//                Log.d("done")
//            }
        }
        dequeue()
    }
}
