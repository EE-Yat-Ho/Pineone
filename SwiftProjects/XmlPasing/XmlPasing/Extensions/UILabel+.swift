//
//  UILabel+.swift
//  XmlPasing

//  Created by 박영호 on 2020/11/04.
//

import UIKit

extension UILabel {
    func setOptions() {
        translatesAutoresizingMaskIntoConstraints = false
        text = "default"
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
    }
}
