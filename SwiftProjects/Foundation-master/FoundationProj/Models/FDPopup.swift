//
//  FDPopup.swift
//  UPlusAR
//
//  Created by baedy on 2020/03/17.
//  Copyright © 2020 최성욱. All rights reserved.
//

import CodableFirebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import UIKit

struct FDPopup: Codable {
    ///iOS용
    var id: String?

    let isTargetIOS: Bool?
    /// 팝업 제목
    let title: String?
    /// 노출여부
    let show: Bool?
    /// 버튼 노출 여부
    let showButton: Bool?
    /// 팝업 노출 여부
    let turnOffType: Turn?
    /// 시작일
    let startAt: Timestamp?
    /// 종료일
    let stopAt: Timestamp?
    /// 링크 타입 (deep, web)
    let linkType: FirebaseLinkType?
    /// 링크 주소
    let link: String?
    /// 팝업상태(삭제시 DB에만 로그)
    let status: String?
    /// 순서
    let order: Int?
    /// 작성자
    let writer: String?
    /// 팝업 이미지 링크
    let popupFileURL: String?
    /// 생성일
    let createdAt: Timestamp?
    /// 수정일
    let updatedAt: Timestamp?
    /// 버튼 이름
    let buttonName: String?

    enum Turn: String, Codable {
        case never = "NEVER"
        case today = "TODAY"
    }

    var isShowing: Bool {
        if let startTimestamp = self.startAt, let stopTimestamp = self.stopAt, let show = self.show {
            let now = Date()
            let startDate = Date(timeIntervalSince1970: TimeInterval(startTimestamp.seconds))
            let stopDate = Date(timeIntervalSince1970: TimeInterval(stopTimestamp.seconds))
            return (startDate <= now && now <= stopDate) && show
        }
        return false
    }
}
