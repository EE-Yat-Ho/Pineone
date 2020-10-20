//
//  UIButton+Extension.swift
//  UPlusAR
//
//  Created by baedy on 2020/07/14.
//  Copyright © 2020 최성욱. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

extension UIButton {
    /// Nor, Pre, Dim matching
    func arImageSet(imageName: String) {
        self.setImage(#imageLiteral(resourceName: imageName + "Nor"), for: .normal)
        self.setImage(#imageLiteral(resourceName: imageName + "Pre"), for: .highlighted)
        self.setImage(#imageLiteral(resourceName: imageName + "Dim"), for: .disabled)
    }

    func arSelectedImageSet(imageName: String) {
        self.setImage(#imageLiteral(resourceName: imageName + "Nor"), for: [.selected])
        self.setImage(#imageLiteral(resourceName: imageName + "Pre"), for: [.selected, .highlighted])
        self.setImage(#imageLiteral(resourceName: imageName + "Dim"), for: [.selected, .disabled])
    }

    func arTitleSet(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        self.titleLabel?.font = .notoSans(.regular, size: 10)
        self.titleLabel?.lblShadow(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), radius: 10, opacity: 0.15)
        self.titleLabel?.letterSpace = -0.4
        self.centerImageAndButton()
    }

    func centerImageAndButton(_ gap: CGFloat = 0.0, imageOnTop: Bool = true) {
        guard let imageView = self.imageView,
            let titleLabel = self.titleLabel else { return }

        let sign: CGFloat = imageOnTop ? 1 : -1
        let imageSize = imageView.frame.size
        let titleSize = titleLabel.frame.size

        self.titleEdgeInsets = UIEdgeInsets(top: (imageSize.height + gap) * sign, left: -imageSize.width, bottom: 0, right: 0)

        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + gap) * sign, left: 0, bottom: 0, right: -titleSize.width)
    }
}

extension UIButton {
    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !isUserInteractionEnabled || isHidden || alpha <= 0.01 {
            return nil
        }

        let touchRect = bounds.insetBy(dx: -12, dy: -12)
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

extension UIButton {
    func addGradientForButton(normalColors: [UIColor] = [#colorLiteral(red: 0.862745098, green: 0.1294117647, blue: 0.2196078431, alpha: 1), #colorLiteral(red: 0.9568627451, green: 0.337254902, blue: 0.4823529412, alpha: 1)], highColors: [UIColor] = [#colorLiteral(red: 0.6901960784, green: 0.1294117647, blue: 0.2156862745, alpha: 1), #colorLiteral(red: 0.8352941176, green: 0.1568627451, blue: 0.3058823529, alpha: 1)], dimColor: UIColor = #colorLiteral(red: 0.5607843137, green: 0.5607843137, blue: 0.5607843137, alpha: 1), startPoint: CGPoint = CGPoint(x: 0, y: 0.5), endPoint: CGPoint = CGPoint(x: 1, y: 0.5)) {
        let gradientNormal = CAGradientLayer()
        gradientNormal.colors = normalColors.map { $0.cgColor }
        gradientNormal.startPoint = startPoint
        gradientNormal.endPoint = endPoint
        gradientNormal.frame = self.bounds
        self.layer.insertSublayer(gradientNormal, at: 0)

        self.setImage(UIImage(color: dimColor), for: .disabled)

        self.rx.observe(Bool.self, "hidden")
            .compactMap { $0 }.distinctUntilChanged()
            .subscribe(onNext: {[weak self] _ in
                gradientNormal.frame = self?.bounds ?? .zero
            }).disposed(by: rx.disposeBag)

        self.rx.observe(Bool.self, "enabled")
            .compactMap { $0 }.distinctUntilChanged()
            .subscribe(onNext: {
                gradientNormal.isHidden = !$0
            }).disposed(by: rx.disposeBag)

        self.rx.observe(Bool.self, "highlighted")
            .compactMap { $0 }.distinctUntilChanged()
            .subscribe(onNext: {
                if $0 {
                    gradientNormal.colors = highColors.map { $0.cgColor }
                } else {
                    gradientNormal.colors = normalColors.map { $0.cgColor }
                }
            }).disposed(by: rx.disposeBag)
    }
}

extension Reactive where Base: UIButton {
    /// Reactive `TouchUpInside` then state toggling, return changed current control's `selected` value
    public var toggle: Observable<Bool> {
        controlEvent(.touchUpInside).asObservable()
            .do(onNext: { self.base.isSelected.toggle() })
            .map { self.base.isSelected }
//            .flatMap { Observable.just( self.base.isSelected ) }
    }
}
