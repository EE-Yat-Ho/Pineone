//
//  Utilities.swift
//  UPlusAR
//
//  Created by 최성욱 on 2020/03/24.
//  Copyright © 2020 최성욱. All rights reserved.
//

import UIKit

protocol ReuseIdentifiable {
    static func reuseIdentifier() -> String
}

extension ReuseIdentifiable {
    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifiable {}
extension UICollectionViewCell: ReuseIdentifiable {}
extension UICollectionReusableView: ReuseIdentifiable {}
