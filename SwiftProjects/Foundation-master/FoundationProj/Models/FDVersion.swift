//
//  FDVersion.swift
//  UPlusAR
//
//  Created by baedy on 2020/03/18.
//  Copyright © 2020 최성욱. All rights reserved.
//

import CodableFirebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import UIKit

struct FDVersion: Codable {
    /// 변경 내용
    let changes: String?
    /// 중요도
    let type: VersionType?
    /// 앱버전
    let version: String?
    /// 작성자
    let writer: String?
    /// 생성일
    let createdAt: Timestamp

    let isTargetIOS: Bool?

    enum VersionType: String, Codable {
        case major = "MAJOR"
        case minor = "MINOR"
    }

    var compareVersion: [Int] {
        guard let version = version else { return [0, 0, 0] }
        return version.components(separatedBy: ".").map { Int($0) ?? 0 }
    }
}
