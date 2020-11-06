//
//  EventCell.swift
//  UPlusAR
//
//  Created by baedy on 2020/03/27.
//  Copyright © 2020 최성욱. All rights reserved.
//

import Reusable
import SnapKit
import Then
import UIKit

class EventCell: UITableViewCell, Reusable {
    // MARK: View

    lazy var baseView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.cornerRadius = 12
        $0.backgroundColor = #colorLiteral(red: 0.0431372549, green: 0.0431372549, blue: 0.06274509804, alpha: 0.9)
    }

    lazy var eventImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleToFill
    }

    lazy var textView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = #colorLiteral(red: 0.0431372549, green: 0.0431372549, blue: 0.06274509804, alpha: 0.9)
    }

    lazy var titleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .notoSans(.medium, size: 15)
        $0.numberOfLines = 0
        $0.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        $0.text = R.String.MoreSee.arGameEvent
    }

    lazy var dateLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .notoSans(.regular, size: 13)
        $0.numberOfLines = 0
        $0.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        $0.text = "2020.04.01 ~ 2020.04.25"
    }

    lazy var endView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.cornerRadius = 12
        $0.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.65)
        $0.isHidden = true
    }

    lazy var eventStatusImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = #imageLiteral(resourceName: "badgeOngoing")
    }

    func setupLayout() {
        contentView.isHidden = true
        backgroundColor = #colorLiteral(red: 0.114654012, green: 0.1092678383, blue: 0.1311254203, alpha: 1)
        baseView.addSubviews([eventImageView, textView, endView, eventStatusImageView])
        textView.addSubviews([titleLabel, dateLabel])
        addSubviews([baseView])

        eventImageView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.width.equalTo(eventImageView.snp.height).multipliedBy(1.82)
            $0.bottom.equalTo(textView.snp.top).offset(0)
        }

        textView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
        }

        endView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        eventStatusImageView.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.width.equalTo(52)
            $0.leading.equalToSuperview().offset(12)
            $0.top.equalToSuperview().offset(12)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(dateLabel.snp.top).offset(-3)
        }

        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-20)
        }

        baseView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }

    // MARK: Model Mapping

    func dataMapping(event: FDEvent) {
        if let title = event.title {
            titleLabel.text = title
        }

        let locale = Locale(identifier: "ko_KR")
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy.MM.dd"
        dateFormat.locale = locale
        if let startDate = event.startAt?.dateValue(), let stopDate = event.stopAt?.dateValue() {
            let dateString = dateFormat.string(from: startDate) + " ~ " + dateFormat.string(from: stopDate)
            dateLabel.text = dateString
        }

        if let urlString = event.bannerFileURL, let imageURL = URL(string: urlString) {
            eventImageView.sd_setImage(with: imageURL)
        }

        eventStatusImageView.image = event.isRunningEvent() ? #imageLiteral(resourceName: "badgeOngoing") : #imageLiteral(resourceName: "badgeEnd")

        endView.isHidden = event.isRunningEvent()
    }

    func loadImageThenSetSize() {
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.selectionStyle = .none
    }
}
