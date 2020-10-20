//
//  Enum.swift
//  FoundationProj
//
//  Created by 박영호 on 2020/10/19.
//  Copyright © 2020 baedy. All rights reserved.
//

import Unrealm
enum ContentType: String, Codable, RealmableEnumString {
    case performance = "0"
    case sticker = "1"
    case aosInstallGame = "2"// aosApplink형
    case iosInstallGame = "3"// iosApplink형
    case webGame = "4"
}

enum Contain3DContentType: String, Codable, RealmableEnumString {
    case Y = "Y"
    case N = "N"
}
