//
//  UIScrollView+Extension.swift
//  UPlusAR
//
//  Created by 최성욱 on 2020/03/26.
//  Copyright © 2020 최성욱. All rights reserved.
//

import UIKit

extension UIScrollView {
    func  isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        return self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
}
