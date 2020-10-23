//
//  UILabel+Extension.swift
//  UPlusAR
//
//  Created by baedy on 2020/04/02.
//  Copyright © 2020 최성욱. All rights reserved.
//

import Then
import UIKit

extension UILabel {
    static func `default`() -> UILabel {
        return UILabel().then {
            $0.numberOfLines = 0
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.lineBreakMode = .byWordWrapping
            $0.textColor = .black
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 16)
            $0.backgroundColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
            $0.text = R.String.guide
        }
    }
}
