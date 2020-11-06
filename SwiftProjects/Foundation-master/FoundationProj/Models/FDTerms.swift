//
//  FDTerms.swift
//  UPlusAR
//
//  Created by baedy on 2020/03/18.
//  Copyright © 2020 최성욱. All rights reserved.
//

import CodableFirebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import UIKit

struct FDTerms: Codable {
    /// 내용
    let contents: String?
    /// 필수 여부
    let required: Bool?
    /// 약관 타입 - 정의가 없음..
    var type: TermType?
    /// 생성일
    let createdAt: Timestamp?
    /// 업데이트
    let updatedAt: Timestamp?

    func setType(type: TermType) -> FDTerms {
        var temp = self
        temp.type = type

        return temp
    }

    var getNoneStyleContents: NSAttributedString? {
        get {
            self.contents?.replaceRegex(regex: " style[^>]*")?.htmlToAttributedString
        }
    }
}

enum TermType: String, Codable {
    case useAgreement
    case personalInfoCollection
    case openSourceLicenseIOS
    case openSourceLicense
    case personalInfoProcessing
    case privacyPolicy

    func title() -> String {
        switch self {
        case .useAgreement:
            return R.String.Terms.useAgreement
        case .personalInfoCollection:
            return R.String.Terms.personalInfoCollection
        case .personalInfoProcessing:
            return R.String.Terms.personalInfoProcessing
        case .openSourceLicense, .openSourceLicenseIOS:
            return R.String.Terms.openSourceLicense
        case .privacyPolicy:
            return R.String.Terms.privacyPolicy
        }
    }
}
