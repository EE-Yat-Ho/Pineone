//
//  Server.swift
//  FoundationProj
//
//  Created by 박영호 on 2020/10/19.
//  Copyright © 2020 baedy. All rights reserved.
//

import UIKit
import RxSwift

struct Server {
    static var shared = Server()
    
//    var testRecentlyCellInfos: [RecentlyCellInfo] = []
    private var recentlyCellInfos = [
        RecentlyCellInfo(
            key: 0,
            name: "performance,adultN,dwonN",
            type: .performance,
            image_url: nil,
            playtime: "10:00",
            req_date: 10,
            visible_yn: "Y",
            sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),
            type_badge_url: nil,
            event_badge_url: nil,
            start_dt: 1,
            end_dt: 200000000000000000,
            adult_yn: "N",
            downloadable: .N),
        RecentlyCellInfo(
            key: 1,
            name: "andGame,adultY,dwonN",
            type: .aosInstallGame,
            image_url: nil,
            playtime: "10:00",
            req_date: 10,
            visible_yn: "Y",
            sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),
            type_badge_url: nil,
            event_badge_url: nil,
            start_dt: 1,
            end_dt: 200000000000000000,
            adult_yn: "Y",
            downloadable: .N),
        RecentlyCellInfo(
            key: 2,
            name: "iosGame,adultY,dwonY",
            type: .iosInstallGame,
            image_url: nil,
            playtime: "10:00",
            req_date: 10,
            visible_yn: "Y",
            sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),
            type_badge_url: nil,
            event_badge_url: nil,
            start_dt: 1,
            end_dt: 200000000000000000,
            adult_yn: "Y",
            downloadable: .Y)
    ]
    
    func getUserRecentlyContents() -> [RecentlyCellInfo] {
        return recentlyCellInfos
    }
    
    mutating func deleteUserContents(indexPathString: String) {
        let splitedIndexPathString = indexPathString.split(separator: ",").map(String.init) // "1", "2"
        let keys = splitedIndexPathString.map({
            (string:String) -> Int in
                if let index = Int(string) {
                    return recentlyCellInfos[index].key ?? -1
                }
                return -1
            })
        recentlyCellInfos = recentlyCellInfos.filter{!keys.contains($0.key ?? -1)}
    }
    
}
