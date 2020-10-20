//
//  String+Extension.swift
//  UPlusAR
//
//  Created by 최성욱 on 2020/03/27.
//  Copyright © 2020 최성욱. All rights reserved.
//

import Foundation
import UIKit

extension String {
    static let empty = ""

    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    var fileUrlRemoveScheme: String {
        guard self.hasPrefix("file://") else { return self }
        return self.substring(from: 7)
    }

    /// 첫글자 제외하고, * 처리
    var textMasking: String {
        var text: String = .empty
        for (index, char) in self.enumerated() {
            text += index == 0 ? char.description : "*"
        }
        return text
    }
}

enum CommonLabelStyle {
    case letterSpace(Float)
    case font(UIFont)
    case color(UIColor)

    func key() -> NSAttributedString.Key {
        switch self {
        case .letterSpace:
            return .kern
        case .font:
            return .font
        case .color:
            return .foregroundColor
        }
    }

    func value() -> Any {
        switch self {
        case .letterSpace(let value):
            return value
        case .font(let value):
            return value
        case .color(let value):
            return value
        }
    }
}

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

    func styling(_ styles: CommonLabelStyle...) -> NSMutableAttributedString {
        styles.reduce(NSMutableAttributedString(string: self), { result, duce in
            result.setAttributes([duce.key(): duce.value()], range: NSRange(location: 0, length: result.length))
            return result
        })
    }
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        let font = UIFont.systemFont(ofSize: 14, weight: .medium)
        let displayHtml = "<span style=\"font-family: \(font.fontName); font-size: \(font.pointSize); color: #FFFFFF \">" + self + "</span>"

        guard let data = displayHtml.data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }

    var htmlToAttributedStringDefaultStyle: NSAttributedString? {
        let displayHtml = self

        guard let data = displayHtml.data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }

    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }

    func getArrayAfterRegex(regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            let results = regex.matches(in: self,
                                        range: NSRange(self.startIndex..., in: self))
            let mapping = results.map {
                String(self[Range($0.range, in: self)!])
            }

            return mapping
        } catch {
            Log.d("invalid regex: \(error.localizedDescription)")
            return []
        }
    }

    func replaceRegex(regex: String, replaceString: String = "") -> String? {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])

            let range = NSRange(location: 0, length: self.count)
            return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replaceString)
        } catch {
            Log.d("invalid regex: \(error.localizedDescription)")
            return nil
        }
    }
}

extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingBox.width)
    }
}
