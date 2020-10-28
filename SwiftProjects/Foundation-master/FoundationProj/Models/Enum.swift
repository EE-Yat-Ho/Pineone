//
//  Enum.swift
//  UPlusAR
//
//  Created by 최성욱 on 2020/03/17.
//  Copyright © 2020 최성욱. All rights reserved.
//
import Unrealm

enum PermissionType {
    case camera
    case photos
    case mic
}

enum DecoType: String, Codable, RealmableEnumString {
    case sticker = "1"
    case filter = "2"
}

enum Tester: String, Codable {
    case yes = "Y"
    case no = "N"
}

enum ContentType: String, Codable, RealmableEnumString {
    case performance = "0"
    case sticker = "1"
    case aosInstallGame = "2"// aosApplink형
    case iosInstallGame = "3"// iosApplink형
    case webGame = "4"
}

enum ContentItemFileType: String, Codable, RealmableEnumString {
    case performance = "0"
    case sticker = "1"
    case performance3D = "2"
    case sticker3D = "3"
    case animation_performance = "4"
    case animation_sticker = "5"
}

enum RequestContentType: String, Codable {
    case keywordCategory = "1"
    case hot = "2"
    case new = "3"
}

enum LinkType: String, Codable {
    case content = "1"
    case inAppWebView = "2"
    case inAppPage = "3"
    case outLink = "4"
    case otherApp = "5"
}

enum LinkSubType: String, Codable {
    case none = "0"
    case contentDetail = "1"
    case thema = "2"
    case themaDetail = "3"
    case genre = "4"
    case genreDetail = "5"
    case event = "6"
    case eventDetail = "7"
    case notice = "8"
}

enum FileType: String, Codable {
    case image = "1"
    case gif = "2"
    case movie = "3"
}

enum BlockingModeType: String, Codable {
    case off = "0"
    case on = "1"
}

enum ContenLikeType: String, Codable, RealmableEnumString {
    case n = "0"
    case y = "1"
}

enum OtherCompaniesPermitContents: String, Codable, RealmableEnumString {
    case Y
    case N
}

enum UserContentsType: String, Codable {
    case view = "1"
    case like = "2"
    case share = "3"
}

enum ReplyType: String, Codable {
    case contentReply = "1"
    case myReply = "2"
}

/**
advertising: 광고성 게시물
lewdness : 음란성 게시물
defamation: 명예훼손 및 사생황 침해 게시물
copyright_infringement: 저작권 침해
*/
enum ReplyReportType: String, Codable {
    case advertising = "1"
    case lewdness = "2"
    case defamation = "3"
    case copyright_infringement = "4"
}

enum TermsType {
    case all
    case marketing
}

enum AdultType: String, Codable, RealmableEnumString {
    case Y
    case N
}

enum CurrentLockState {
    case none
    case unlocked
    case locked
}

enum SearchThemeOrderType {
    case famous
    case recently
}

enum NewContentHeightType: String, Codable {
    case rectangle  //직사각형 타입
    case square     //정사각형 타입
}

enum ThumbNailHeightType {
    case vRectangle  //세로 직사각형 타입
    case hRectangle  //가로 직사각형 타입
    case square

    var thumbSize: CGSize {
        var size: CGSize
        switch self {
        case .square:
            size = CGSize(width: 160, height: 160)
        case .vRectangle:
            size = CGSize(width: 160, height: 240)
        case .hRectangle:
            size = CGSize(width: 286, height: 160)
        }
        return size
    }

    var thumbRadius: CGFloat {
        var radius: CGFloat
        switch self {
        case .square:
            radius = 20
        case .vRectangle:
            radius = 18.2
        case .hRectangle:
            radius = 20
        }
        return radius
    }
}

enum DetailThumbType {
    case normal(String)   //사이즈 계산해야되는 타입
    case square(String)   //정사각형 타입
    case vertical(String) //세로 직사각형 타입

    var url: String {
        switch self {
        case .vertical(let url), .normal(let url), .square(let url):
            return url
        }
    }
}

enum Contain3DContentType: String, Codable, RealmableEnumString {
    case Y = "Y"
    case N = "N"
}

enum NetWorkType {
    case type_noNetwork
    case type_unknown
    case type_2G
    case type_3G
    case type_LTE
    case type_wifi
    case type_5G // 추후 체크가 가능하다면 DeviceManager getNetworkConnectionType() func에서 요놈 타입도 선언 해줘야함

    var headerString: String {
        switch self {
        case .type_noNetwork, .type_unknown, .type_2G: return "ETC"
        case .type_3G: return "3G"
        case .type_LTE: return "4G"
        case .type_wifi: return "WIFI"
        case .type_5G: return "5G"
        }
    }

    var isStreamingAble: Bool {
        switch self {
        case .type_wifi, .type_5G:
            return true
        default:
            return false
        }
    }
}

enum FirebaseLinkType: String, Codable {
    case web = "WEB"
    case deep = "DEEP"
}

/// 10월 27일 요금제 코드 강제 하드코딩으로 앱에서 들고 있기로 함.
/// 추후 서버에서 해당 목록 받는 걸로 진행 해야함(요금제가 없어질 수도 새로 생길 가능성 있기때문..)
enum feeCode5G: String, CaseIterable {
    case LPZ0000355 //5G 프리미어 슈퍼 GFN
    case LPZ0000356 //5G 프리미어 플러스 GFN
    case LPZ0000369 //5G 시그니처
    case LPZ0000370 //5G 프리미어 슈퍼
    case LPZ0000371 //5G 프리미어 플러스
    case LPZ0000372 //5G 라이트 시니어
    case LPZ0000374 //5G 라이트 청소년
    case LPZ0000380 //5G 슈퍼 플래티넘
    case LPZ0000381 //5G 프리미엄
    case LPZ0000382 //5G 스탠다드
    case LPZ0000383 //5G 스페셜
    case LPZ0000385 //5G 라이트
    case LPZ0000388 //5G 다이렉트
    case LPZ0000391 //5G 플래티넘
    case LPZ0000393 //5G 프리미엄
    case LPZ0000413 //5G 프리미어 레귤러
    case LPZ0000414 //5G 스마트
    case LPZ0000415 //5G 스탠다드
    case LPZ0000416 //5G 라이트
    case LPZ0000417 //5G 라이트 청소년
    case LPZ0000418 //5G 라이트 시니어
    case LPZ0000424 //5G 시그니처(키즈)
    case LPZ0000425 //5G 태블릿 4GB+데이터 나눠쓰기
    case LPZ0000433 //5G 프리미어 레귤러
    case LPZ0001199 //LG U+ 업무용 (5G)
    case LPZ0002534 //5G 시그니처 Netflix
    case LPZ0002535 //5G 프리미어 슈퍼 Netflix
    case LPZ0002536 //5G 프리미어 플러스 Netflix
    case LPZ0002540 //5G 시그니처 클라우드게임 팩
    case LPZ0002555 //5G 시그니처 스마트기기팩
    case LPZ0002556 //5G 프리미어 슈퍼 리얼글래스 50% 할인
    case LPZ0002557 //5G 프리미어 플러스 리얼글래스 50% 할인

    static var codeList: [String] {
        return feeCode5G.allCases.map { $0.rawValue }
    }
}
