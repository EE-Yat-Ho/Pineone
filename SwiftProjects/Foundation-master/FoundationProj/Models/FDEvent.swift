//
//  FDEvent.swift
//  UPlusAR
//
//  Created by baedy on 2020/03/18.
//  Copyright © 2020 최성욱. All rights reserved.
//

import CodableFirebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import UIKit

struct FDEvent: Codable {
    /// 이벤트 순서
    let order: Int?
    /// 이벤트 제목
    let title: String?
    /// 이벤트 내용
    let contents: String?
    /// 이벤트 이미지 URL
    let contentsFileURL: String?
    /// 배너 이미지 URL
    let bannerFileURL: String?
    /// 상단 고정
    let is_fixed: Bool?
    /// 노출여부
    let show: Bool?
    /// 링크 타입 (web, deep)
    let linkType: FirebaseLinkType?
    /// 링크 주소
    let link: String?
    /// 링크 주소2
    let link2: String?
    /// 버튼 1 노출여부
    let showButton: Bool?
    /// 버튼 1 타이틀
    let buttonName: String?
    /// 버튼 2 노출여부
    let showButton2: Bool?
    /// 버튼 2 타이틀
    let buttonName2: String?
    /// 이벤트 상태(진행중, 삭제)
    let status: String?
    /// 작성자
    let writer: String?
    /// 시작일
    let startAt: Timestamp?
    /// 종료일
    let stopAt: Timestamp?
    /// 생성일
    let createdAt: Timestamp?
    /// 수정일
    let updatedAt: Timestamp?
    /// 딥링크 스키마
    var deepLinkUrlScheme: URLScheme? {
        get {
            self.linkType == .some(.deep) ? URLScheme.urlParse(self.link) : nil
        }
    }

    func isRunningEvent() -> Bool {
        let isStarted = (startAt?.dateValue().compare(Date()) == .some(.orderedAscending))
        let isNotStoped = stopAt?.dateValue().compare(Date()) == .some(.orderedDescending)

        return isStarted && (show ?? false) && isNotStoped
    }

    func isFixedEvent() -> Bool {
        return self.isRunningEvent() && (is_fixed ?? false)
    }
}
