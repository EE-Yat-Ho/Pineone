//
//  ContentsRecentlyLike.swift
//  UPlusAR
//
//  Created by SukHo Song on 2020/04/17.
//  Copyright © 2020 최성욱. All rights reserved.
//

import Foundation

enum ActivityActionType {
    case none
    case delete(Bool)
    case select([IndexPath])
    case allSelect(Bool)
}

enum ActivityStatusType {
    case none
    case deleteMode
    case select([IndexPath])
    case allSelect
}

enum DownloadSortingType {
    case download
    case size
}

/// 2.10 사용자 컨텐츠 조회 (시청/좋아요) - Response
struct ContentsRecentlyLike: Decodable {
    /// 페이징 처리 커서(게시일자)
    let next_cursor: String?
    /// cursor가 null인 경우에만 (최초 요청) 제공
    let total_cnt: Int?
    /// 컨텐츠 목록
    let contents_list: [RecentlyLikeList]?
}

/// 2.10 사용자 컨텐츠 조회 (시청/좋아요) - Response - 컨텐츠 목록
struct RecentlyLikeList: Decodable {
    /// 컨텐츠 유니크 키
    let key: Int?
    /// 컨텐츠 명
    let name: String?
    /// 컨텐츠 타입 (0:퍼포먼스형, 1:스티커형)
    let type: ContentType?
    /// 메인화면용 이미지 url
    let image_url: String?
    /// 컨텐츠 재생 길이(시간)
    let playtime: String?
    /// 컨텐츠 시청 시간
    let req_date: Double?
    /// 컨텐츠 노출 여부 (N:미노출, Y:노출)
    let visible_yn: String?
    /// score board 정보
    let sb_info: RecentlyLikeSbInfo?
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
}

/// 2.10 사용자 컨텐츠 조회 (시청/좋아요) - Response - score board 정보
struct RecentlyLikeSbInfo: Decodable {
    /// 조회 수
    let view_cnt: Int?
    /// 좋아요 수
    let like_cnt: Int?
    /// 댓글 수
    let reply_cnt: Int?
}
