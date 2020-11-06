//
//  EventImage.swift
//  UPlusAR
//
//  Created by ILDO on 2020/05/26.
//  Copyright © 2020 최성욱. All rights reserved.
//

import CodableFirebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import UIKit

struct FDEventImage: Decodable {
    /// 팝업 제목
    let contentid: String?
    /// 노출여부
    let artype: ARType?
    /// 버튼 노출 여부
    let name: String?
    /// 팝업 노출 여부
    let url: String?

    enum ARType: String, Decodable {
        case uplus = "1"
        case gLens = "2"
    }
}
