//
//  UIViewController+Extension.swift
//  UPlusAR
//
//  Created by baedy on 2020/03/24.
//  Copyright © 2020 최성욱. All rights reserved.
//

import UIKit

extension UIViewController {
    private struct RuntimeKey {
        static let indexKey = UnsafeRawPointer(bitPattern: "indexKey".hashValue)
    }

    public var index: Int {
        set {
            objc_setAssociatedObject(self, RuntimeKey.indexKey!, NSNumber(value: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }

        get {
            return  (objc_getAssociatedObject(self, RuntimeKey.indexKey!) as! NSNumber).intValue
        }
    }
}
