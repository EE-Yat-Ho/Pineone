//
//  UIWindow+Extension.swift
//  UPlusAR
//
//  Created by 최성욱 on 2020/05/28.
//  Copyright © 2020 최성욱. All rights reserved.
//

import UIKit

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
