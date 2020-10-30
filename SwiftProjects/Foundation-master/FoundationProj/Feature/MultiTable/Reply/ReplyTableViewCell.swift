//
//  ReplyTableViewCell.swift
//  UPlusAR
//
//  Created by SukHo Song on 2020/04/16.
//  Copyright © 2020 최성욱. All rights reserved.
//

import UIKit

class ReplyTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectButton.isSelected = selected
        selectContentsView.alpha = selected ? 0.04 : 0.0
    }

    // 삭제모드 진입 체크
    var isDeleteMode: Bool = false {
        didSet {
            self.deleteMode()
        }
    }

    // 셀 item
    var item: ReplyList? {
        didSet {
            self.configure()
        }
    }

    lazy var contentsView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    lazy var contentReply = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 2
        $0.lineBreakMode = .byTruncatingTail
        $0.font = .notoSans(.regular, size: 16)
        $0.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.alpha = 0.9
    }

    lazy var contentDate = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .topLeft
        $0.numberOfLines = 0
        $0.font = .notoSans(.regular, size: 12)
        $0.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.alpha = 0.5
    }

    lazy var seperateView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = #colorLiteral(red: 0.301981926, green: 0.3019043207, blue: 0.3062297702, alpha: 1)
    }

    lazy var contentTitle = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .topLeft
        $0.numberOfLines = 0
        $0.font = .notoSans(.regular, size: 12)
        $0.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.alpha = 0.5
    }

    lazy var selectContentsView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.alpha = 0.0
    }

    lazy var selectButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isUserInteractionEnabled = false
        $0.setImage(#imageLiteral(resourceName: "icCheckP2Off"), for: .normal)
        $0.setImage(#imageLiteral(resourceName: "icCheckP2On"), for: .selected)
        $0.isHidden = true
    }

    lazy var vLine = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.03)
    }

    private func setupLayout() {
        selectionStyle = .none
        separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        contentView.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.1098039216, blue: 0.1294117647, alpha: 1)
        contentsView.addSubviews([contentReply, contentDate, seperateView, contentTitle])
        contentView.addSubviews([contentsView, selectContentsView, selectButton, vLine])

        contentsView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
            $0.top.equalToSuperview().offset(13)
            $0.bottom.equalToSuperview().offset(-13)
            $0.trailing.equalToSuperview().offset(-20)
        }

        contentReply.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.bottom.equalTo(contentDate.snp.top).offset(-4)
        }

        contentDate.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
        }

        seperateView.snp.makeConstraints {
            $0.height.equalTo(11)
            $0.width.equalTo(1)
            $0.leading.equalTo(contentDate.snp.trailing).offset(6)
            $0.centerY.equalTo(contentDate.snp.centerY).offset(0)
        }

        contentTitle.snp.makeConstraints {
            $0.leading.equalTo(seperateView.snp.trailing).offset(6)
            $0.bottom.equalToSuperview()
            $0.top.equalTo(contentReply.snp.bottom).offset(4)
        }

        selectContentsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        selectButton.snp.makeConstraints {
            $0.height.width.equalTo(25)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-30)
        }

        vLine.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
        }
    }
}

extension ReplyTableViewCell {
    private func configure() {
        self.bindingData()
    }

    private func bindingData() {
        guard let item = item else { return }

        if let text = item.reply_text {
            contentReply.text = text
        }
        if let date = item.mod_date {
            contentDate.text = Date(timeIntervalSince1970: date / 1000.0).string(withFormat: "yyyy.MM.dd")
        }
        if let contentsInfo = item.contents_info, let title = contentsInfo.name {
            contentTitle.text = title
        }
    }

    // 삭제/취소 버튼 탭 시, 체크박스 숨김/표시 처리
    func deleteMode() {
        selectButton.isHidden = isDeleteMode ? false : true
        if isDeleteMode {
            contentsView.snp.remakeConstraints {
                $0.leading.equalToSuperview().offset(20)
                $0.centerY.equalToSuperview()
                $0.top.equalToSuperview().offset(13)
                $0.bottom.equalToSuperview().offset(-13)
                $0.trailing.equalTo(selectButton.snp.leading).offset(-16)
            }
        } else {
            contentsView.snp.remakeConstraints {
                $0.leading.equalToSuperview().offset(20)
                $0.centerY.equalToSuperview()
                $0.top.equalToSuperview().offset(13)
                $0.bottom.equalToSuperview().offset(-13)
                $0.trailing.equalToSuperview().offset(-20)
            }
        }
    }
}
