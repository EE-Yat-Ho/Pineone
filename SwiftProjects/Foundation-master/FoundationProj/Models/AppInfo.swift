//
//  AppInfo.swift
//  UPlusAR
//
//  Created by 최성욱 on 2020/04/09.
//  Copyright © 2020 최성욱. All rights reserved.
//

struct AppInfo: Codable {
    let hot_keyword_list: [String]?
    let blocking_info: BlockingInfo?
}

struct BlockingInfo: Codable {
    let blocking_mode: BlockingModeType?
    let preview_time: String?
}

