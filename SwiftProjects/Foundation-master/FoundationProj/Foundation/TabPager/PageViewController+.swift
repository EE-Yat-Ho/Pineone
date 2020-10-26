//
//  PageViewController+Extension.swift
//  UPlusAR
//
//  Created by baedy on 2020/03/25.
//  Copyright © 2020 최성욱. All rights reserved.
//

import UIKit

extension UIPageViewController {
    var isScrollEnabled: Bool {
        get {
            var isEnabled: Bool = true
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    isEnabled = subView.isScrollEnabled
                }
            }
            return isEnabled
        }
        set {
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    subView.isScrollEnabled = newValue
                }
            }
        }
    }
}
