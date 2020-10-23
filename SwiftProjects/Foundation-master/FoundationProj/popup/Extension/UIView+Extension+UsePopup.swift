//
//  UIView+Extension.swift
//  UPlusAR
//
//  Created by baedy on 2020/04/02.
//  Copyright © 2020 최성욱. All rights reserved.
//

import UIKit

extension UIView {
    open func addSubview(_ view: UIView, with block: @escaping () -> Void) {
        self.addSubview(view)
        block()
    }
}
