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
    /// 현재 서버가 가진 데이터
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
            downloadable: .Y),
        RecentlyCellInfo(key: 3,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 4,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 5,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 6,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 7,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 8,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 9,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 10,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 11,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 12,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 13,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 14,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 15,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 16,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 17,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 18,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 19,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 20,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 21,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 22,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 23,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 24,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 25,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 26,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 27,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 28,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y),
        RecentlyCellInfo(key: 29,name: "iosGame,adultY,dwonY",type: .iosInstallGame,image_url: nil,playtime: "10:00",req_date: 10,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: "Y",downloadable: .Y)
        
    ]
    /// 현재 서버가 가진 데이터를 반환
    func getUserRecentlyContents() -> [RecentlyCellInfo] {
        return recentlyCellInfos
    }
    
    /// 원하는 데이터를 삭제
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
