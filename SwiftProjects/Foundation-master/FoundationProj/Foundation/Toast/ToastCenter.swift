//
//  ToastCenter.swift
//  UPlusAR
//
//  Created by 최성욱 on 06/20/2020.
//  Copyright © 2020 최성욱. All rights reserved.
//

import UIKit

open class ToastCenter {
    // MARK: Properties

    private let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()

    var currentToast: Toaster? {
        return self.queue.operations.first { !$0.isCancelled && !$0.isFinished } as? Toaster
    }

    public static let `default` = ToastCenter()

    // MARK: Initializing

    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.deviceOrientationDidChange),
            name: UIDevice.orientationDidChangeNotification,
            object: nil
        )
    }

    // MARK: Adding Toasts

    func add(_ toast: Toaster) {
        self.queue.addOperation(toast)
    }

    // MARK: Cancelling Toasts

    func cancelAll() {
        queue.cancelAllOperations()
    }

    // MARK: Notifications

    @objc dynamic func deviceOrientationDidChange() {
        if let lastToast = self.queue.operations.first as? Toaster {
            lastToast.view.setNeedsLayout()
        }
    }
}
