//
//  Button.swift
//  UPlusAR
//
//  Created by 최성욱 on 2020/06/02.
//  Copyright © 2020 최성욱. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class Button: UIButton {
    var normalBackgroundColor: UIColor? {
        didSet {
            guard let color = normalBackgroundColor else {
                setBackgroundImage(nil, for: .normal)
                return
            }
            setBackgroundImage(UIImage(color: color), for: .normal)
        }
    }

    var highlightedBackgroundColor: UIColor? {
        didSet {
            guard let color = highlightedBackgroundColor else {
                setBackgroundImage(nil, for: .highlighted)
                return
            }
            setBackgroundImage(UIImage(color: color), for: .highlighted)
        }
    }

    var disabledBackgroundColor: UIColor? {
        didSet {
            guard let color = disabledBackgroundColor else {
                setBackgroundImage(nil, for: .disabled)
                return
            }
            setBackgroundImage(UIImage(color: color), for: .disabled)
        }
    }

    var selectedBackgroundColor: UIColor? {
        didSet {
            guard let color = selectedBackgroundColor else {
                setBackgroundImage(nil, for: .selected)
                return
            }
            setBackgroundImage(UIImage(color: color), for: .selected)
        }
    }

    var normalTintColor: UIColor? {
        didSet {
            guard let normalTintColor = normalTintColor else {
                return
            }
            tintColor = normalTintColor
        }
    }

    var highlightedTintColor: UIColor?
    var disabledTintColor: UIColor?
    var selectedTintColor: UIColor?

    var normalBorderColor: UIColor? {
        didSet {
            guard let normalBorderColor = normalBorderColor else {
                return
            }
            borderColor = normalBorderColor
        }
    }

    var highlightedBorderColor: UIColor?
    var disabledBorderColor: UIColor?
    var selectedBorderColor: UIColor?
}

extension Button {
    override var isHighlighted: Bool {
        didSet {
            let normalTint = isSelected ? (selectedTintColor ?? tintColor!) : (normalTintColor ?? tintColor!)
            let highlightedTint = highlightedTintColor ?? normalTint
            tintColor = isHighlighted ? highlightedTint : normalTint
            let normalBorder = isSelected ? (selectedBorderColor ?? borderColor!) : (normalBorderColor ?? borderColor!)
            let highlightedBorder = highlightedBorderColor ?? normalBorder
            borderColor = isHighlighted ? highlightedBorder : normalBorder
        }
    }

    override var isEnabled: Bool {
        didSet {
            let normalTint = isSelected ? (selectedTintColor ?? tintColor!) : (normalTintColor ?? tintColor!)
            let disabledTint = disabledTintColor ?? normalTint
            tintColor = isEnabled ? normalTint : disabledTint
            let normalBorder = isSelected ? (selectedBorderColor ?? borderColor!) : (normalBorderColor ?? borderColor!)
            let disabledBorder = disabledBorderColor ?? normalBorder
            borderColor = isEnabled ? normalBorder : disabledBorder
        }
    }

    override var isSelected: Bool {
        didSet {
            let normalTint = normalTintColor ?? tintColor!
            let selectedTint = selectedTintColor ?? normalTint
            tintColor = isSelected ? selectedTint : normalTint
            let normalBorder = isEnabled ? (normalBorderColor ?? borderColor!) : (disabledBorderColor ?? borderColor!)
            let selectedBorder = isEnabled ? (selectedBorderColor ?? normalBorder) : (disabledBorderColor ?? borderColor!)
            borderColor = isSelected ? selectedBorder : normalBorder
        }
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !isUserInteractionEnabled || isHidden || alpha <= 0.01 {
            return nil
        }

        let touchRect = bounds.insetBy(dx: -10, dy: -10)
        if touchRect.contains(point) {
            for subview in subviews.reversed() {
                let convertedPoint = subview.convert(point, from: self)
                if let hitTestView = subview.hitTest(convertedPoint, with: event) {
                    return hitTestView
                }
            }
            return self
        }
        return nil
    }
}

extension Reactive where Base: Button {
    var titleChanged: Observable<()> {
        let change = self.methodInvoked(#selector(UIButton.setTitle(_:for:)))
        return Observable.create { observer in
            _ = change.subscribe(onNext: { _ in
                observer.on(.next(()))
            })
            return Disposables.create()
        }
    }
}
