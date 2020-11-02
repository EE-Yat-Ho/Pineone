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
    
    // MARK: - 처음에 서버에 데이터 세팅하기!
    mutating func setServerData(dataAmount: Int) {
        for i in 0..<dataAmount { // req_date 86400000 당 하루
            recentlyList.append(RecentlyLikeList(key: i,name: "최근" + String(i),type: .performance,image_url: nil,playtime: String(i),req_date: Double((i - 1) * 86400000),visible_yn: i % 4 != 0 ? "Y" : "N",sb_info: RecentlyLikeSbInfo(view_cnt: i, like_cnt: i * 2, reply_cnt: i * 3),type_badge_url: nil,event_badge_url: nil,start_dt: Double(i),end_dt: 200000000000000000,adult_yn: i % 2 == 0 ? .N : .Y,downloadable: i % 2 == 0 ? .N : .Y))
            likeList.append(RecentlyLikeList(key: i * 10,name: "찜" + String(i * 10),type: .performance,image_url: nil,playtime: String(i * 10),req_date: Double((i - 1) * 86400000 * 31),visible_yn: i % 5 != 0 ? "Y" : "N",sb_info: RecentlyLikeSbInfo(view_cnt: i * 10, like_cnt: i * 20, reply_cnt: i * 30),type_badge_url: nil,event_badge_url: nil,start_dt: Double(i),end_dt: 200000000000000000,adult_yn: i % 2 != 0 ? .N : .Y,downloadable: i % 2 != 0 ? .N : .Y))
            replyList.append(ReplyList(key: i, user_key: i * 10000, user_name: "유저" + String(i), reply_text: "댓글내용" + String(i), reply_status: "댓글상태" + String(i), mod_date: Double((i - 1) * 86400000), contents_info: ReplyContentsInfo(key: String(i), name: "컨텐츠이름"+String(i), start_dt: Double(i), end_dt: 200000000000000000)))
        }
    }
    
    // MARK: - Get Server Data
    /// 현재 서버가 가진 데이터를 반환
    func getUserRecentlyContents() -> [RecentlyLikeList] {
        return recentlyList
    }
    func getUserLikeContents() -> [RecentlyLikeList] {
        return likeList
    }
    func getUserReplyContents() -> [ReplyList] {
        return replyList
    }
    
    // MARK: - Delete Server Data
    /// 원하는 데이터를 삭제
    mutating func deleteUserRecentlyContents(indexPathString: String) {
        let splitedIndexPathString = indexPathString.split(separator: ",").map(String.init) // "1", "2"
        let keys = splitedIndexPathString.map({
            (string:String) -> Int in
                if let index = Int(string) {
                    return recentlyList[index].key ?? -1
                }
                return -1
            })
        recentlyList = recentlyList.filter{!keys.contains($0.key ?? -1)}
    }
    
    mutating func deleteUserLikeContents(indexPathString: String) {
        let splitedIndexPathString = indexPathString.split(separator: ",").map(String.init) // "1", "2"
        let keys = splitedIndexPathString.map({
            (string:String) -> Int in
                if let index = Int(string) {
                    return likeList[index].key ?? -1
                }
                return -1
            })
        likeList = likeList.filter{!keys.contains($0.key ?? -1)}
    }
    
    mutating func deleteUserReplyContents(indexPathString: String) {
        let splitedIndexPathString = indexPathString.split(separator: ",").map(String.init) // "1", "2"
        let keys = splitedIndexPathString.map({
            (string:String) -> Int in
                if let index = Int(string) {
                    return replyList[index].key ?? -1
                }
                return -1
            })
        replyList = replyList.filter{!keys.contains($0.key ?? -1)}
    }
    
    // MARK: - Server's Dataes
    /// 현재 서버가 가진 Recently 데이터
    private var recentlyList: [RecentlyLikeList] = [
//        RecentlyLikeList(key: 0,name: "최근0",type: .performance,image_url: nil,playtime: "0",req_date: 0,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 0,end_dt: 200000000000000000,adult_yn: .N,downloadable: .N),
//        RecentlyLikeList(key: 1,name: "최근1",type: .performance,image_url: nil,playtime: "1",req_date: 1,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: .Y,downloadable: .Y),
//        RecentlyLikeList(key: 2,name: "최근2",type: .performance,image_url: nil,playtime: "2",req_date: 2,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 2,end_dt: 200000000000000000,adult_yn: .N,downloadable: .N),
//        RecentlyLikeList(key: 3,name: "최근3",type: .performance,image_url: nil,playtime: "3",req_date: 3,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 3,end_dt: 200000000000000000,adult_yn: .Y,downloadable: .Y),
//        RecentlyLikeList(key: 4,name: "최근4",type: .performance,image_url: nil,playtime: "4",req_date: 4,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 4,end_dt: 200000000000000000,adult_yn: .N,downloadable: .N)
    ]
    
    /// 현재 서버가 가진 Like 데이터
    private var likeList: [RecentlyLikeList] = [
//        RecentlyLikeList(key: 0,name: "찜0",type: .performance,image_url: nil,playtime: "10:00",req_date: 0,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 0,end_dt: 200000000000000000,adult_yn: .N,downloadable: .N),
//        RecentlyLikeList(key: 1,name: "찜1",type: .performance,image_url: nil,playtime: "10:00",req_date: 1,visible_yn: "Y",sb_info: RecentlyLikeSbInfo(view_cnt: 1, like_cnt: 2, reply_cnt: 3),type_badge_url: nil,event_badge_url: nil,start_dt: 1,end_dt: 200000000000000000,adult_yn: .Y,downloadable: .N)
    ]
    /// 현재 서버가 가진 Reply 데이터
    private var replyList: [ReplyList] = [
//        ReplyList(key: 0, user_key: 0, user_name: "유저0", reply_text: "댓글내용0", reply_status: "댓글상태0", mod_date: 0, contents_info: ReplyContentsInfo(key: "0", name: "컨텐츠이름0", start_dt: 0, end_dt: 200000000000)),
//        ReplyList(key: 1, user_key: 0, user_name: "유저1", reply_text: "댓글내용1", reply_status: "댓글상태1", mod_date: 1, contents_info: ReplyContentsInfo(key: "0", name: "컨텐츠이름1", start_dt: 1, end_dt: 200000000000)),
//        ReplyList(key: 2, user_key: 0, user_name: "유저2", reply_text: "댓글내용2", reply_status: "댓글상태2", mod_date: 2, contents_info: ReplyContentsInfo(key: "0", name: "컨텐츠이름2", start_dt: 2, end_dt: 200000000000)),
//        ReplyList(key: 3, user_key: 0, user_name: "유저3", reply_text: "댓글내용3", reply_status: "댓글상태3", mod_date: 3, contents_info: ReplyContentsInfo(key: "0", name: "컨텐츠이름3", start_dt: 3, end_dt: 200000000000))
    ]
}
