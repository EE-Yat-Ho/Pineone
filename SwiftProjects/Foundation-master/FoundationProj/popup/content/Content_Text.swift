//
//  Content_Text.swift
//  UPlusAR
//
//  Created by 정지원 on 2020/03/23.
//  Copyright © 2020 정지원. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//
//@available(iOS 13.0, *)
//struct Content_Text_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            DebugPreviewView {
//                return Content_Text(message: "디폴트 메시지 테스트")
//            }
//        }
//    }
//}
//#endif

protocol WrapperView {
    var contentView: UIView { get set }
    var dismissInsideSubject: PublishSubject<ActionResultModel>? { get }
}

extension WrapperView {
    var dismissInsideSubject: PublishSubject<ActionResultModel>? {
        return nil
    }
// 사용법
//    button.rx.tap.map { ActionResultModel(result: .done, view: self.designationView) }.bind(to: subject).disposed(by: rx.disposeBag)

}

class ContentBaseView: UIView, WrapperView {
    typealias theme = DefaultStyle

    var contentView = UIView().then {
        $0.backgroundColor = theme.backgroundColor
    }

    func contentViewSetup() {
        /// setup 필수
        self.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    open func setupLayout() {
         contentViewSetup()
    }
}

class Content_Text: ContentBaseView {
    public lazy var subTitle = UILabel().then {
        $0.textAlignment = theme.textAlignment
        $0.textColor = theme.textFontColor
        $0.font = .notoSans(size: 15, weight: .bold)
        $0.numberOfLines = 0
    }

    public lazy var message = UILabel().then {
        $0.textAlignment = theme.textAlignment
        $0.textColor = theme.textFontColor
        $0.font = theme.textFont
        $0.numberOfLines = 0
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 사이즈 지정을 위해서는 frame 말고 메세지를 이용해주세요
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout(defaultRect)
    }

    let defaultRect = CGRect(x: 0, y: 0, width: 248, height: 59)

    init(subTitle: String = .empty, message: String, _ frame: CGRect? = nil) {
        super.init(frame: .zero)
        self.subTitle.text = subTitle
        self.message.text = message
        if !subTitle.isEmpty {
            self.message.font = .notoSans(size: 14, weight: .regular)
        }
        setupLayout(frame ?? defaultRect)
    }

    func setupLayout(_ frame: CGRect) {
        super.setupLayout()

        self.backgroundColor = UIColor.white

        // contentView에 뷰 구성
        contentView.addSubviews([subTitle, message])

        subTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(26)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.bottom.equalTo(message.snp.top).offset(subTitle.text == .empty ? 0 : -6)
            $0.width.equalTo(frame.width)
            if subTitle.text == .empty {
                $0.height.equalTo( 0)
            }
        }
        message.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.bottom.equalToSuperview()
//            $0.height.equalTo(frame.height)
            $0.width.equalTo(frame.width)
        }
    }
}
