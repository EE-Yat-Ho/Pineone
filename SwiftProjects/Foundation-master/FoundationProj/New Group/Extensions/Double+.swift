//
//  Double+Extenstion.swift
//  UPlusAR
//
//  Created by 최성욱 on 2020/04/24.
//  Copyright © 2020 최성욱. All rights reserved.
//

import Foundation

extension Double {
    func dateFormatted(withFormat format: String) -> String {
        let date = Date(timeIntervalSince1970: self / 1000.0)
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = format
         return dateFormatter.string(from: date)
    }

    func getJavaTimestampDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self / 1000.0))
    }
}
