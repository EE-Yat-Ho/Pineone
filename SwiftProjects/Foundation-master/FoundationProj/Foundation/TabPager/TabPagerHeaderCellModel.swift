//
//  PagerHeaderCellModel.swift
//  UPlusAR
//
//  Created by baedy on 2020/03/24.
//  Copyright © 2020 최성욱. All rights reserved.
//

import UIKit

public struct TabPagerHeaderCellModel {
    let title: String
    let selectedFont: UIFont? = nil
    let deSelectedFont: UIFont? = nil

    let titleSelectedColor: UIColor? = nil
    let titleDeSelectedColor: UIColor? = nil

    let indicatorColor: UIColor? = nil
    let indicatorHeight: CGFloat? = nil
    var displayNewIcon: Bool?
    var iconImage: UIImage?
    var iconSelectedImage: UIImage?
}
