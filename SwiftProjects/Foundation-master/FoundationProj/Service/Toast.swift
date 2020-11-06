//
//  Toast.swift
//  UPlusAR
//
//  Created by 최성욱 on 2020/06/20.
//  Copyright © 2020 최성욱. All rights reserved.
//

import UIKit

struct Toast {
    static func show(_ text: String) {
        if let currentToast = ToastCenter.default.currentToast {
            currentToast.cancel()
        }
        DispatchQueue.main.async {
            if UIApplication.shared.topViewController?.tabBarController?.tabBar.isHidden ?? false {
                ToastView.appearance().bottomOffsetPortrait = 34
            } else {
                ToastView.appearance().bottomOffsetPortrait = ARTabBarController.shared.tabBarHeight + 12
            }
        }
        Toaster(text: text).show()
    }

    static func showOnKeyboard(_ text: String) {
        if let currentToast = ToastCenter.default.currentToast {
            currentToast.cancel()
        }

        DispatchQueue.main.async {
            if UIApplication.shared.topViewController?.tabBarController?.tabBar.isHidden ?? false {
                ToastView.appearance().bottomOffsetPortrait = 34
            } else {
                ToastView.appearance().bottomOffsetPortrait = ARTabBarController.shared.tabBarHeight + 12
            }
        }
        Toaster(text: text, type: .onKeyboard).show()
    }
}

