//
//  ActivityBaseTableViewCell.swift
//  UPlusAR
//
//  Created by 송석호 on 2020/06/02.
//  Copyright © 2020 최성욱. All rights reserved.
//

import Lottie
import RxSwift
import UIKit

class ActivityBaseTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()

    var isDeleteMode: Bool = false {
        didSet {
            self.deleteMode()
        }
    }

    lazy var baseView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.cornerRadius = 12.0
        $0.backgroundColor = #colorLiteral(red: 0.0715489015, green: 0.06627959758, blue: 0.07944276184, alpha: 1)
    }

    lazy var mainView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = #colorLiteral(red: 0.0715489015, green: 0.06627959758, blue: 0.07944276184, alpha: 1)
    }

    lazy var thumbnailImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = #colorLiteral(red: 0.0715489015, green: 0.06627959758, blue: 0.07944276184, alpha: 1)
    }

    lazy var adultView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.2, blue: 0.2156862745, alpha: 1)
        $0.isHidden = true
    }

    lazy var adultLockImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = #imageLiteral(resourceName: "imgLockS")
    }

    lazy var adultBadgeImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = #imageLiteral(resourceName: "badgeBullet19S")
    }

    lazy var contentsView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    lazy var contentTitle = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 2
        $0.lineBreakMode = .byTruncatingTail
        $0.font = .notoSans(.medium, size: 15)
        $0.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }

    lazy var contentDate = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .topLeft
        $0.numberOfLines = 0
        $0.font = .notoSans(.regular, size: 13)
        $0.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.alpha = 0.7
    }

    lazy var seperateView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = #colorLiteral(red: 0.301981926, green: 0.3019043207, blue: 0.3062297702, alpha: 1)
    }

    lazy var contentPlayTime = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .topLeft
        $0.numberOfLines = 0
        $0.font = .notoSans(.regular, size: 13)
        $0.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.alpha = 0.7
    }

    lazy var selectContentsView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = #colorLiteral(red: 0.05495867878, green: 0.05460015684, blue: 0.07199349254, alpha: 1)
        $0.alpha = 0
    }

    lazy var expireContentsView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = #colorLiteral(red: 0.05495867878, green: 0.05460015684, blue: 0.07199349254, alpha: 1)
        $0.alpha = 0
    }

    lazy var expireImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = #imageLiteral(resourceName: "icExpiration")
    }

    lazy var expireTextLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .notoSans(.medium, size: 15)
        $0.text = R.String.Activity.content_expired
        $0.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.alpha = 0.5
    }

    lazy var playButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(#imageLiteral(resourceName: "btnPlayOval02Nor"), for: .normal)
        $0.setImage(#imageLiteral(resourceName: "btnPlayOval02Dim"), for: .disabled)
    }

    lazy var selectButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isUserInteractionEnabled = false
        $0.setImage(#imageLiteral(resourceName: "icCheckP2Off"), for: .normal)
        $0.setImage(#imageLiteral(resourceName: "icCheckP2On"), for: .selected)
        $0.isHidden = true
    }

    lazy var progressAnimationView = AnimationView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.animation = Animation.named("loading_detail_download")
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
    }

    lazy var animatiomContainerView = UIView().then {
        $0.backgroundColor = .clear
        $0.isHidden = true
        $0.addSubview(progressAnimationView)
        progressAnimationView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    func deleteMode() {
        playButton.isHidden = isDeleteMode ? true : false
        if progressAnimationView.currentProgress == 0 || progressAnimationView.currentProgress == 1 {
            animatiomContainerView.isHidden = true
        } else {
            animatiomContainerView.isHidden = isDeleteMode ? true : false
        }

        selectButton.isHidden = isDeleteMode ? false : true
    }

    func setupLayout() {
        selectionStyle = .none
        contentView.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.1098039216, blue: 0.1294117647, alpha: 1)
        contentsView.addSubviews([contentTitle, contentDate, seperateView, contentPlayTime])
        mainView.addSubviews([contentsView, animatiomContainerView, playButton])
        expireContentsView.addSubviews([expireImageView, expireTextLabel])
        adultView.addSubviews([adultLockImageView])
        baseView.addSubviews([thumbnailImageView, adultView, adultBadgeImageView, mainView, expireContentsView, selectContentsView, selectButton])
        contentView.addSubviews([baseView])

        baseView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-10)
        }

        thumbnailImageView.snp.makeConstraints {
            $0.width.height.equalTo(82)
            $0.leading.top.bottom.equalToSuperview()
        }

        adultView.snp.makeConstraints {
            $0.width.height.equalTo(82)
            $0.leading.top.bottom.equalToSuperview()
        }

        adultLockImageView.snp.makeConstraints {
            $0.width.height.equalTo(37)
            $0.centerX.centerY.equalToSuperview()
        }

        adultBadgeImageView.snp.makeConstraints {
            $0.width.height.equalTo(22)
            $0.top.equalToSuperview().offset(4)
            $0.trailing.equalTo(thumbnailImageView.snp.trailing).offset(-4)
        }

        mainView.snp.makeConstraints {
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(0)
            $0.top.trailing.bottom.equalToSuperview()
        }

        contentsView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(14)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(-79)
        }

        contentTitle.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.bottom.equalTo(contentDate.snp.top).offset(0)
        }

        contentDate.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
            $0.height.equalTo(19)
        }

        seperateView.snp.makeConstraints {
            $0.height.equalTo(11)
            $0.width.equalTo(1)
            $0.leading.equalTo(contentDate.snp.trailing).offset(6)
            $0.centerY.equalTo(contentDate.snp.centerY).offset(0)
        }

        contentPlayTime.snp.makeConstraints {
            $0.leading.equalTo(seperateView.snp.trailing).offset(6)
            $0.height.equalTo(19)
            $0.bottom.equalToSuperview()
        }

        animatiomContainerView.snp.makeConstraints {
            $0.height.width.equalTo(38)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
        }

        playButton.snp.makeConstraints {
            $0.height.width.equalTo(38)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
        }

        selectContentsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        expireContentsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        expireImageView.snp.makeConstraints {
            $0.leading.equalTo(45)
            $0.width.height.equalTo(22)
            $0.centerY.equalToSuperview()
        }

        expireTextLabel.snp.makeConstraints {
            $0.leading.equalTo(expireImageView.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-45)
        }

        selectButton.snp.makeConstraints {
            $0.height.width.equalTo(25)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
}
