//
//  UIFont+Extension.swift
//  UPlusAR
//
//  Created by 최성욱 on 2020/05/28.
//  Copyright © 2020 최성욱. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    enum Style: String {
        case regular = "NotoSansKR-Regular"
        case light = "NotoSansKR-Light"
        case medium = "NotoSansKR-Medium"
        case bold = "NotoSansKR-Bold"
    }

    public func textWidth(_ text: String?) -> CGFloat {
        if let width = text?.size(withAttributes: [NSAttributedString.Key.font: self]).width {
            return width
        }
        return 0
    }

    static func notoSans(_ style: Style = .regular, size: CGFloat) -> UIFont {
        return UIFont(name: style.rawValue, size: size)!
    }

    static func notoSans(size: CGFloat, weight: Style) -> UIFont {
        return UIFont(name: weight.rawValue, size: size)!
    }
}
