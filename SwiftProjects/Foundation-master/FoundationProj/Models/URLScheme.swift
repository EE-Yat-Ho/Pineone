//
//  URLScheme.swift
//  UPlusAR
//
//  Created by baedy on 2020/06/23.
//  Copyright © 2020 최성욱. All rights reserved.
//

import UIKit

struct URLScheme: Codable {
    let scheme: ARScheme
    let parameter1: ViewType
    let parameter2: String?
    let parameter3: String?
    let parameter4: Referral?

    private static func initail(dict: [String: String]) -> URLScheme? {
        guard let schemeString = dict[CodingKey.scheme.rawValue], let scheme = ARScheme(rawValue: schemeString) else { return nil }
        guard let parameter1String = dict[CodingKey.parameter1.rawValue], let parameter1 = ViewType(rawValue: parameter1String) else {
            return nil
        }

        if let parameter2String = dict[CodingKey.parameter2.rawValue], let referral = Referral(rawValue: parameter2String) {
            return URLScheme(scheme: scheme,
                      parameter1: parameter1,
                      parameter2: nil,
                      parameter3: nil,
                      parameter4: referral)
        }

        if let parameter4String = dict[CodingKey.parameter4.rawValue], let referral = Referral(rawValue: parameter4String) {
            return URLScheme(scheme: scheme,
                      parameter1: parameter1,
                      parameter2: dict[CodingKey.parameter2.rawValue],
                      parameter3: dict[CodingKey.parameter3.rawValue],
                      parameter4: referral)
        }

        return URLScheme(scheme: scheme,
                         parameter1: parameter1,
                         parameter2: dict[CodingKey.parameter2.rawValue],
                         parameter3: dict[CodingKey.parameter3.rawValue],
                         parameter4: nil)
    }

    public static func urlParse(_ wrapingStr: String?) -> URLScheme? {
        guard let unwarppingUrlStr = wrapingStr else {
            return nil
        }

        var dict = [String: String]()
        guard let utf8String = unwarppingUrlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: utf8String), let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }

        guard let queryItems = components.queryItems else { return nil }

        for item in queryItems {
            guard let value = item.value else {
                continue
            }
            dict[item.name] = value
        }

        guard let linkString = dict["link"]?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let linkURL = URL(string: linkString), let host = linkURL.host else { return nil }

        guard let linkConponents = URLComponents(url: linkURL, resolvingAgainstBaseURL: false), let query = linkConponents.queryItems else { return nil }

        var parameter = [String]()
        for item in query {
            guard let data = item.value else {
                continue
            }
            parameter.append(data)
        }

//        print(parameter)
        if parameter.count > 0, let data = parameter.first?.removingPercentEncoding {
            let items = data.components(separatedBy: [":", ",", "{", "}"]).filter { $0 != .empty }
            var keys = [String]()
            var values = [String]()

            for (index, item) in items.enumerated() {
                index % 2 != 0 ? values.append(item) : keys.append(item)
            }

            var structDict = [String: String]()
            structDict["scheme"] = host

            for (index, key) in keys.enumerated() {
                structDict[key] = values[index]
            }

            return URLScheme.initail(dict: structDict)
        }

        return nil
    }

    public static func urlschemeToString(scheme: URLScheme) -> String {
        var strLink = "https://"

        strLink.append(scheme.scheme.rawValue + "?parameter={parameter1:" + scheme.parameter1.rawValue)

        if let parameter2 = scheme.parameter2 {
            strLink.append(",parameter2:\(parameter2)")
        }
        if let parameter3 = scheme.parameter3 {
            strLink.append(",parameter3:\(parameter3)")
        }
        strLink.append("}")
        return strLink
    }
}

extension URLScheme {
    enum CodingKey: String {
        case scheme
        case parameter1
        case parameter2
        case parameter3
        case parameter4
    }

    enum ARScheme: String, Codable {
        case main
        case search
        case album
        case detail
        case keyword
        case my
        case setting
        case genre
        /// AR 인식
        case recognizing
    }

    enum ViewType: String, Codable {
        case view
        case view_detail
        case view_result
        // 검색
        case theme
        case theme_detail
        case genre_detail
        // 내 활동
        case recent
        case download
        case like
        case comment
        // 더보기
        case event
        case event_detail
        case notice
        case faq
        case dm
        case etc
        case terms
        case privacy

        // AR 인식
        case uplusar
        case google

        var myActivityIndex: Int {
            switch self {
            case .recent: return 0
            case .download: return 1
            case .like: return 2
            case .comment: return 3
            default: return 0
            }
        }

        var moreSeeIndex: Int {
            switch self {
            case .event, .event_detail: return 0
            case .notice: return 1
            case .faq: return 2
            case .dm: return 3
            case .etc: return 4
            default: return 0
            }
        }
    }

    /// 로그 전송 용
    enum Referral: String, Codable {
        /// firebase push
        case P001
        /// mms
        case P002
        /// 공연 앱 연동
        case P003
        /// 기타 외부 노출 페이지
        case P005
    }
}
