//
//  DownloadManager.swift
//  FoundationProj
//
//  Created by 박영호 on 2020/10/28.
//  Copyright © 2020 baedy. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit
import Unrealm
import Zip

enum DownloadType: String, RealmableEnumString {
    case content
    case streaming
    case deco
}
