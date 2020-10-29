//
//  CompactItem.swift
//  FoundationProj
//
//  Created by 박영호 on 2020/10/29.
//  Copyright © 2020 baedy. All rights reserved.
//

import UIKit

struct CompactCellItem: Decodable {
    /// 컨텐츠 유니크 키
    let key: String?
    /// 컨텐츠 명
    let name: String?
    /// 컨텐츠 타입 (0:퍼포먼스형, 1:스티커형)
    let type: ContentType?
    /// 메인화면용 이미지 url
    let image_url: String?
    /// 컨텐츠 재생 길이(시간)
    //let playtime: String?
    /// 컨텐츠 시청 시간
    //let req_date: Double?
    /// 컨텐츠 노출 여부 (N:미노출, Y:노출)
    let visible_yn: String?
    /// score board 정보
    //let sb_info: RecentlyLikeSbInfo?
    /// 컨텐츠 타입 뱃지 url
    let type_badge_url: String?
    /// 이벤트 뱃지 url
    let event_badge_url: String?
    /// 컨텐츠 게시 시작 일자
    let start_dt: Double?
    /// 컨텐츠 게시 종료 일자
    let end_dt: Double?
    /// Y=성인인증필요 컨텐츠, N=성인비인증 컨텐츠
    let adult_yn: AdultType?
    /// Y=3d콘텐츠가 있음, N=없음
    let downloadable: Contain3DContentType?
    
    let downloadStatus: DownloadItemStatus?
    let reply_text: String?
    let mod_date: Double?
    let contents_info: ReplyContentsInfo?
    
    init(recentlyLike: RecentlyLikeList) {
        key = String(recentlyLike.key ?? -1)
        name = recentlyLike.name
        type = recentlyLike.type
        image_url = recentlyLike.image_url
        visible_yn = recentlyLike.visible_yn
        type_badge_url = recentlyLike.type_badge_url
        event_badge_url = recentlyLike.event_badge_url
        start_dt = recentlyLike.start_dt
        end_dt = recentlyLike.end_dt
        adult_yn = recentlyLike.adult_yn
        downloadable = recentlyLike.downloadable
        downloadStatus = nil
        reply_text = nil
        mod_date = nil
        contents_info = nil
    }
    
    init(download: RealmMyDownloadFile){
        key = download.key
        name = download.name
        type = download.type
        image_url = download.image_url
        visible_yn = download.visible_yn
        type_badge_url = download.type_badge_url
        event_badge_url = download.event_badge_url
        start_dt = download.start_dt
        end_dt = download.end_dt
        adult_yn = download.adult_yn
        downloadable = download.downloadable
        downloadStatus = download.downloadStatus
        reply_text = nil
        mod_date = nil
        contents_info = nil
    }
    
    init(reply: ReplyList){
        key = String(reply.key ?? -1)
        name = nil
        type = nil
        image_url = nil
        visible_yn = nil
        type_badge_url = nil
        event_badge_url = nil
        start_dt = nil
        end_dt = nil
        adult_yn = nil
        downloadable = nil
        downloadStatus = nil
        reply_text = reply.reply_text
        mod_date = reply.mod_date
        contents_info = reply.contents_info
    }
}
