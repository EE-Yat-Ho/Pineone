//
//  Int+Extension.swift
//  UPlusAR
//
//  Created by 최성욱 on 2020/04/13.
//  Copyright © 2020 최성욱. All rights reserved.
//

import Foundation

extension Int {
    func getContentsDetailCount() -> String {
        if self >= 1000 && self < 10_000 {
            return String("\(self / 1000).\(Int(round(Double(self % 1000 / 100))))천")
        } else if self >= 10_000 && self < 100_000 {
            return String("\(self / 10_000).\(Int(round(Double(self % 10_000 / 1000))))만")
        } else if self >= 100_000 && self < 100_000_000 {
            return String("\(self / 10_000)만")
        } else if self >= 100_000_000 {
            return String("\(self / 100_000_000)억")
        }
        return String(self)
    }

    func getPlayTime() -> String {
        let (h, m, s) = (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
        if h > 0 {
            return String(format: "%02d", h) + ":" + String(format: "%02d", m) + ":" + String(format: "%02d", s)
        } else {
            return String(format: "%02d", m) + ":" + String(format: "%02d", s)
        }
    }
}
