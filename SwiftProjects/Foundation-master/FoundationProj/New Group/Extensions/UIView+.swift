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


extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }


    func roundConers(corners: UIRectCorner, radius: CGFloat) {
        _ = _round(corners, radius: radius)
    }

    func roundConers(corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        let mask = _round(corners, radius: radius)
        addBorder(mask, borderColor: borderColor, borderWidth: borderWidth)
    }

    private func _round(_ corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        return mask
    }

    private func addBorder(_ mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }

    func addShadow(shadowColor: UIColor, offSet: CGSize = .zero, opacity: Float, shadowRadius: CGFloat) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = opacity
    }

    func addGradient(colors: [CGColor], locations: [NSNumber] = [0.0, 1.0]) {
        let gradient = CAGradientLayer()
        gradient.frame.size = self.frame.size
        gradient.colors = colors
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }

    func allLabelLetterSpacing(view: UIView, letterSpacing: Double = -0.4) {
        for insideView in view.subviews {
            if insideView.subviews.count > 0 {
                allLabelLetterSpacing(view: insideView)
            } else if insideView.isKind(of: UILabel.self) {
                let label = (insideView as! UILabel)

                if !label.isPartiallyAttributed {
                    label.setTextSpacingBy(value: letterSpacing)
                } else if let currentAttrString = label.attributedText {
                    let attributedString: NSMutableAttributedString!
                    attributedString = NSMutableAttributedString(attributedString: currentAttrString)
                    attributedString.addAttribute(.kern,
                                                  value: letterSpacing,
                                                  range: NSRange(location: 0, length: attributedString.length))
                    label.attributedText = attributedString
                }
            }
        }
    }
}
