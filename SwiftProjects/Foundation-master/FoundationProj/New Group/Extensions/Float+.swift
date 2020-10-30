//
//  Float+Extension.swift
//  UPlusAR
//
//  Created by 최성욱 on 2020/04/23.
//  Copyright © 2020 최성욱. All rights reserved.
//

import CoreGraphics
import Foundation

extension CGFloat {
    func getByteString(hasSapce: Bool = true) -> String {
        var kBytes: CGFloat = self

        if kBytes < 1024 {
            return String(describing: Int(floor(kBytes))) + (hasSapce ? " KB" : "KB")
        }
        kBytes /= 1024
        if kBytes < 1024 {
            return String(describing: Int(floor(kBytes))) + (hasSapce ? " MB" : "MB")
        }
        kBytes /= 1024
        return String(describing: floor(kBytes * 10) / 10) + (hasSapce ? " GB" : "GB")
        //return String(format: "%.1fGB", floor(kBytes))
    }
}
