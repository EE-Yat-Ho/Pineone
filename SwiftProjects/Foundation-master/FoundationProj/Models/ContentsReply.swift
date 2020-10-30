//
//  Reply.swift
//  UPlusAR
//
//  Created by 최성욱 on 2020/04/14.
//  Copyright © 2020 최성욱. All rights reserved.
//

import Foundation

/// 2.13 댓글 조회 - Response
struct ContentsReply: Decodable {
    /// 페이징 처리 커서 (댓글 유니크 키)
    let next_cursor: String?
    /// cursor가 null인 경우에만 (최초 요청) 제공
    let total_cnt: Int?
    /// 댓글 리스트
    let reply_list: [ReplyList]?
}

/// 2.13 댓글 조회 - Response - 댓글 리스트
struct ReplyList: Decodable {
    /// 댓글 유니크 키
    let key: Int?
    /// 댓글 등록 유저 키
    let user_key: Int?
    /// 댓글 작성자
    let user_name: String?
    /// 댓글 내용
    let reply_text: String?
    /// 댓글 신고상태 (0:정상, 1:신고)
    let reply_status: String?
    /// 수정일자
    let mod_date: Double?
    /// 컨텐츠 정보 (내가 쓴 댓글 조회시에만 제공)
    let contents_info: ReplyContentsInfo?
}

/// 2.13 댓글 조회 - Response - 댓글 리스트 - 컨텐츠 정보 (내가 쓴 댓글 조회시에만 제공)
struct ReplyContentsInfo: Decodable {
    /// 컨텐츠 유니크 키
    let key: String?
    /// 컨텐츠 명
    let name: String?
    /// 게시 시작일자
    let start_dt: Double?
    /// 게시 종료일자
    let end_dt: Double?
}

struct ReplyAdd: Decodable {
    let reply_key: Int
}
