//
//  ToastView.swift
//  UPlusAR
//
//  Created by 최성욱 on 06/20/2020.
//  Copyright © 2020 최성욱. All rights reserved.
//

import UIKit

class ToastView: UIView {
    var isStatusBarOrientationChanging = false

    var shouldRotateManually: Bool {
        let application = UIApplication.shared
        var supportsAllOrientations = false
        if let window = application.delegate?.window {
            supportsAllOrientations = application.supportedInterfaceOrientations(for: window) == .all
        }

        let info = Bundle.main.infoDictionary
        let requiresFullScreen = (info?["UIRequiresFullScreen"] as? NSNumber)?.boolValue == true
        let hasLaunchStoryboard = info?["UILaunchStoryboardName"] != nil

        if supportsAllOrientations && !requiresFullScreen && hasLaunchStoryboard {
            return false
        }
        return true
    }

    var text: String? {
        get { return self.textLabel.text }
        set { self.textLabel.text = newValue }
    }

    override open dynamic var backgroundColor: UIColor? {
        get { return self.backgroundView.backgroundColor }
        set { self.backgroundView.backgroundColor = newValue }
    }

    /// The background view's corner radius.
    //    @objc open dynamic var cornerRadius: CGFloat {
    //        get { return self.backgroundView.layer.cornerRadius }
    //        set { self.backgroundView.layer.cornerRadius = newValue }
    //    }

    /// The inset of the text label.
    @objc open dynamic var textInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

    /// The color of the text label's text.
    @objc open dynamic var textColor: UIColor? {
        get { return self.textLabel.textColor }
        set { self.textLabel.textColor = newValue }
    }

    /// The font of the text label.
    @objc open dynamic var font: UIFont? {
        get { return self.textLabel.font }
        set { self.textLabel.font = newValue }
    }

    /// The bottom offset from the screen's bottom in portrait mode.
    @objc open dynamic var bottomOffsetPortrait: CGFloat = {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone: return 34
        default: return 50
        }
    }()

    /// The bottom offset from the screen's bottom in landscape mode.
    @objc open dynamic var bottomOffsetLandscape: CGFloat = {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone: return 34
        default: return 50
        }
    }()

    lazy var backgroundView = UIView().then {
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        $0.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.87)
    }

    lazy var textLabel = UILabel().then {
        $0.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        $0.backgroundColor = .clear
        $0.font = .notoSans(size: 15)
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    // MARK: Initializing

    public init() {
        super.init(frame: .zero)
        self.isUserInteractionEnabled = false
        self.addSubviews([backgroundView, textLabel])

        self.handleRotate(UIApplication.shared.statusBarOrientation)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.bringWindowToTop),
            name: UIWindow.didBecomeVisibleNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.statusBarOrientationWillChange),
            name: UIApplication.willChangeStatusBarOrientationNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.statusBarOrientationDidChange),
            name: UIApplication.didChangeStatusBarOrientationNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.applicationDidBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }

    public required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }

    // MARK: Layout

    override open func layoutSubviews() {
        super.layoutSubviews()
        let containerSize = UIScreen.main.bounds
        let constraintSize = CGSize(
            width: containerSize.width * (280.0 / 320.0),
            height: CGFloat.greatestFiniteMagnitude
        )
        let textLabelSize = self.textLabel.sizeThatFits(constraintSize)
        self.textLabel.frame = CGRect(
            x: self.textInsets.left,
            y: self.textInsets.top,
            width: textLabelSize.width,
            height: textLabelSize.height
        )
        self.backgroundView.frame = CGRect(
            x: 0,
            y: 0,
            width: self.textLabel.frame.size.width + self.textInsets.left + self.textInsets.right,
            height: self.textLabel.frame.size.height + self.textInsets.top + self.textInsets.bottom
        )

        var x: CGFloat
        var y: CGFloat
        var width: CGFloat
        var height: CGFloat

        let orientation = UIApplication.shared.statusBarOrientation
        if orientation.isPortrait || shouldRotateManually {
            width = containerSize.width
            height = containerSize.height
            y = self.bottomOffsetPortrait
        } else {
            width = containerSize.height
            height = containerSize.width
            y = self.bottomOffsetLandscape
        }

        let backgroundViewSize = self.backgroundView.frame.size
        x = (width - backgroundViewSize.width) * 0.5
        y = height - (backgroundViewSize.height + y)
        self.frame = CGRect(
            x: x,
            y: y,
            width: backgroundViewSize.width,
            height: backgroundViewSize.height
        )
    }

    override open func hitTest(_ point: CGPoint, with event: UIEvent!) -> UIView? {
        if let superview = self.superview {
            let pointInWindow = self.convert(point, to: superview)
            let contains = self.frame.contains(pointInWindow)
            if contains && self.isUserInteractionEnabled {
                return self
            }
        }
        return nil
    }

    @objc func bringWindowToTop(_ notification: Notification) {
        if !(notification.object is ToastView) {
            isHidden = true
            isHidden = false
        }
    }

    @objc dynamic func statusBarOrientationWillChange() {
        self.isStatusBarOrientationChanging = true
    }

    @objc dynamic func statusBarOrientationDidChange() {
        let orientation = UIApplication.shared.statusBarOrientation
        self.handleRotate(orientation)
        self.isStatusBarOrientationChanging = false
    }

    @objc func applicationDidBecomeActive() {
        let orientation = UIApplication.shared.statusBarOrientation
        self.handleRotate(orientation)
    }

    func handleRotate(_ orientation: UIInterfaceOrientation) {
        let angle = self.angleForOrientation(orientation)
        if self.shouldRotateManually {
            self.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
        }

        if let window = UIApplication.shared.windows.first {
            if orientation.isPortrait || !self.shouldRotateManually {
                self.frame.size.width = window.bounds.size.width
                self.frame.size.height = window.bounds.size.height
            } else {
                self.frame.size.width = window.bounds.size.height
                self.frame.size.height = window.bounds.size.width
            }
        }

        self.frame.origin = .zero

        DispatchQueue.main.async {
            ToastCenter.default.currentToast?.view.setNeedsLayout()
        }
    }

    func angleForOrientation(_ orientation: UIInterfaceOrientation) -> Double {
        if orientation == .landscapeRight {
            //Log.d("orientation = landscapeRight")
        } else if orientation == .portrait {
            //Log.d("orientation = portrait")
        }

        switch orientation {
            // case .landscapeLeft: return -.pi / 2
            // case .landscapeRight: return .pi / 2
        // case .portraitUpsideDown: return .pi
        default: return 0
        }
    }
}
