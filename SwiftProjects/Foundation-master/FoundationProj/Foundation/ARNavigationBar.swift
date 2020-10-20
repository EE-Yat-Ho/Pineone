//
//  ARNavigationBar.swift
//  FoundationProj
//
//  Created by 박영호 on 2020/10/19.
//  Copyright © 2020 baedy. All rights reserved.
//

import BonMot
import RxCocoa
import RxSwift
import SnapKit
import UIKit

enum ARNavigationActionType {
    case search
    case back
    case imageAugment
}

enum ARNavigationShowType {
    case none // 없음
    case home // 홈
    case backTitle // 기본 왼쪽 back
    case backTitleRightCount // 왼쪽 back 우측 count
    //case conterTitleRightCancle // 센터 title 우측 X
    case centerTitle // 중간 title
    /// 중앙 숫자 오른쪽 X
    case centerConutRightX
    /// 오른쪽 X
    case onlyRightX
}


private let screenWidth = UIScreen.main.bounds.size.width

class ARNavigationBar: UIView {
    var type: ARNavigationShowType = .none
    let navigationAction = PublishRelay<ARNavigationActionType>()

    lazy var containerView = UIView().then {
        $0.backgroundColor = .clear
    }

    /// 로그 올리기 위해 5번 이상 버튼 누를경우를 체크하기 위함
    var logUploadCount = 0

    var title: String? {
        willSet {
            titleLabel.isHidden = false
            titleLabel.text = newValue
        }
    }

    lazy var homeLogoImageView: UIView = {
        #if !RELEASE
        return UIButton().then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.setImage(#imageLiteral(resourceName: "imgLogoNor"), for: .normal)
            $0.isHidden = true
            //$0.rx.tap.on(next: self.logAction).disposed(by: rx.disposeBag)
        }
        #else
        return UIImageView().then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.image = #imageLiteral(resourceName: "imgLogoNor")
            $0.isHidden = true
        }
        #endif
    }()

    lazy var backButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(#imageLiteral(resourceName: "icTopBackNor"), for: .normal)
        $0.setImage(#imageLiteral(resourceName: "icTopBackPre"), for: .highlighted)
        $0.isHidden = true
        $0.rx.tap.map { ARNavigationActionType.back }.bind(to: self.navigationAction).disposed(by: rx.disposeBag)
    }

    lazy var titleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .white
        $0.font = .notoSans(.medium, size: 20)
        $0.isHidden = true
    }

    lazy var searchButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(#imageLiteral(resourceName: "icTopSearchNor"), for: .normal)
        $0.setImage(#imageLiteral(resourceName: "icTopSearchPre"), for: .highlighted)
        $0.isHidden = true
        $0.rx.tap.map { ARNavigationActionType.search }.bind(to: self.navigationAction).disposed(by: rx.disposeBag)
    }

    lazy var imageAugmentationButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(#imageLiteral(resourceName: "icTopScanNor"), for: .normal)
        $0.setImage(#imageLiteral(resourceName: "icTopScanPre"), for: .highlighted)
        $0.isHidden = true
        $0.rx.tap.map { ARNavigationActionType.imageAugment }.bind(to: self.navigationAction).disposed(by: rx.disposeBag)
    }

    lazy var countLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isHidden = true
    }

    lazy var bottomLine = UIView().then {
        $0.backgroundColor = R.Color.default ~ 10%
        $0.isHidden = true
    }

    lazy var closeButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(#imageLiteral(resourceName: "icTopCloseNor"), for: .normal)
        $0.setImage(#imageLiteral(resourceName: "icTopClosePre"), for: .highlighted)
        $0.isHidden = true
        $0.rx.tap.map { ARNavigationActionType.back }.bind(to: self.navigationAction).disposed(by: rx.disposeBag)
    }

    lazy var navBarHeight: CGFloat = naviBarHeight()

    private func naviBarHeight() -> CGFloat {
        guard self.type != .home else { return 56 }
        return 56 + realSafeAreaInsetTop
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(type: ARNavigationShowType = .none) {
        self.type = type
        super.init(frame: .zero)
        setupView()
    }

    func setupView() {
        backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.1098039216, blue: 0.1294117647, alpha: 1)
        self.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(56)
            $0.top.greaterThanOrEqualToSuperview()
        }

        containerView.addSubviews([homeLogoImageView, backButton, titleLabel, searchButton, imageAugmentationButton, countLabel, bottomLine, closeButton])

        homeLogoImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.equalTo(60)
            $0.height.equalTo(22)
            $0.leading.equalToSuperview().offset(24)
        }

        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(42)
            $0.trailing.equalTo(imageAugmentationButton.snp.leading).offset(-6)
        }

        imageAugmentationButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(42)
            $0.trailing.equalToSuperview().offset(-16)
        }

        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(42)
            $0.leading.equalToSuperview().offset(15)
        }

        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(backButton.snp.trailing)
        }

        bottomLine.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }

        closeButton.snp.makeConstraints {
            $0.width.height.equalTo(42)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
        }

        countLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(22)
            $0.width.equalTo(100)
        }

        switch type {
        case .home:
            [homeLogoImageView, searchButton, imageAugmentationButton].forEach { $0.isHidden = false }
        case .backTitle:
            [backButton, titleLabel].forEach { $0.isHidden = false }
        case .backTitleRightCount:
            [backButton, titleLabel, countLabel].forEach { $0.isHidden = false }
            titleLabel.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalTo(backButton.snp.trailing)
                $0.trailing.equalTo(countLabel.snp.leading)
            }
        case .centerTitle:
            [titleLabel, bottomLine].forEach { $0.isHidden = false }
            titleLabel.snp.remakeConstraints {
                $0.centerX.centerY.equalToSuperview()
            }
        case .centerConutRightX:
            [titleLabel, closeButton].forEach { $0.isHidden = false }
            titleLabel.snp.remakeConstraints {
                $0.centerX.centerY.equalToSuperview()
            }
        case .onlyRightX:
            closeButton.isHidden = false
        case .none:
            break
        }
    }

    func setCurrentPage(currentIndex: Int, totalCount: Int) {
        let indexStyle = StringStyle(.font(.notoSans(size: 15)), .color(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)))
        let totalCountStyle = StringStyle(.font(.notoSans(size: 15)), .color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4)))
        countLabel.attributedText = NSAttributedString.composed(of: [
        String(currentIndex).styled(with: indexStyle), "/\(String(totalCount))".styled(with: totalCountStyle)])
        if let text = countLabel.attributedText {
            countLabel.snp.updateConstraints {
                $0.width.equalTo(text.width(withConstrainedHeight: 22))
            }
        }
    }
}

// FTP log Upload
//extension ARNavigationBar {
//    func logAction() {
//        #if !RELEASE
//        if !Log.isUploading {
//            if logUploadCount < 7 {
//                logUploadCount += 1
//            } else {
//                DispatchQueue.global(qos: .background).async {
//                    self.logUploadCount = 0
//                    Log.logAction()
//                }
//            }
//        }
//        #endif
//    }
//}
