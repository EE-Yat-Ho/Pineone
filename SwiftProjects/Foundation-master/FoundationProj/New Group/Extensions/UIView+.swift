//
//  UIView+.swift
//  FoundationProj
//
//  Created by baedy on 2020/05/28.
//  Copyright © 2020 baedy. All rights reserved.
//

import UIKit

extension UIView {
    func deepCopy() -> UIView {
        let archive = NSKeyedArchiver.archivedData(withRootObject: self)
        return NSKeyedUnarchiver.unarchiveObject(with: archive) as! UIView
    }

    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
    
    var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: cgColor)
        }
        set { layer.borderColor = newValue?.cgColor }
    }

    var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
}

extension UIView {
    var realSafeAreaInsetTop: CGFloat {
        return UIApplication.shared.keyWindowInConnectedScenes?.safeAreaInsets.top ?? 0
    }
    var realSafeAreaInsetLeft: CGFloat {
        return UIApplication.shared.keyWindowInConnectedScenes?.safeAreaInsets.left ?? 0
    }
    var realSafeAreaInsetRight: CGFloat {
        return UIApplication.shared.keyWindowInConnectedScenes?.safeAreaInsets.right ?? 0
    }
    var realSafeAreaInsetBottom: CGFloat {
        return UIApplication.shared.keyWindowInConnectedScenes?.safeAreaInsets.bottom ?? 0
    }
}
