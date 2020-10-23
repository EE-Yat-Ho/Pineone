//
//  CustomAlertButton.swift
//  UPlusAR
//
//  Created by 정지원 on 2020/03/21.
//  Copyright © 2020 정지원. All rights reserved.
//

import SnapKit
import UIKit

typealias CustomAlertButtonCompleteion = ((ActionResult) -> Void)

class CustomAlertButton: UIButton {
    var completion: CustomAlertButtonCompleteion?
    var action: ActionResult?

//    var cornerRadius: CGFloat = 6
//    var borderColor: CGColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
//    var borderWidth: CGFloat = 1

    static func `default`(action: ActionResult, block: CustomAlertButtonCompleteion? = nil) -> CustomAlertButton {
        return CustomAlertButton(type: .system).then { button in
            button.setTitle(action.rawValue, for: .normal)
            button.completion = block
            button.action = action
            button.titleLabel?.font = DefaultStyle.buttonFont
            button.tintColor = .white
            button.setTitleColor(action.buttonColor(), for: .normal)

            //$0.layer.cornerRadius = $0.cornerRadius
//            $0.borderColor = $0.borderColor
//            $0.layer.borderWidth = $0.borderWidth

            button.frame = CGRect(x: 0, y: 0, width: button.titleLabel?.frame.width ?? 31 + 96, height: 37)
            button.snp.makeConstraints { make in
                make.width.equalTo(button.titleLabel?.frame.width ?? 31 + 96)
                make.height.equalTo(37)
            }

            button.setBackgroundImage(UIImage(color: .blue), for: .highlighted)
           // $0.addTarget(self, action: #selector(findPWButtonTab), for: .touchUpInside)
            button.addTarget(button, action: #selector(buttonAction(_:)), for: .touchUpInside)
        }
    }

    static func `default`(withContainer action: ActionResult, block: CustomAlertButtonCompleteion? = nil) -> UIView {
        let button = CustomAlertButton(type: .custom).then { button in
            button.setTitle(action.rawValue, for: .normal)
            button.completion = block
            button.action = action
            button.titleLabel?.font = DefaultStyle.buttonFont
            button.tintColor = .white
            button.setTitleColor(action.buttonColor(), for: .normal)

            button.setBackgroundImage(UIImage(color: #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)), for: .highlighted)

            button.addTarget(button, action: #selector(buttonAction(_:)), for: .touchUpInside)
            button.layer.cornerRadius = 18.5
            button.contentEdgeInsets = UIEdgeInsets(top: 6, left: 48, bottom: 6, right: 48)
            button.clipsToBounds = true
        }

        let container = UIView()
        container.addSubview(button)
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        return container
    }

    @objc func buttonAction(_ button: UIButton) {
        if let action = action {
            completion?(action)
        }
    }
}
