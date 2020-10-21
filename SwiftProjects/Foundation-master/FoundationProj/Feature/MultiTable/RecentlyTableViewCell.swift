//
//  RecentlyTableViewCell.swift
//  UPlusAR
//
//  Created by SukHo Song on 2020/04/17.
//  Copyright © 2020 최성욱. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class RecentlyTableViewCell: ActivityBaseTableViewCell {
    // 셀 item
    var item: RecentlyCellInfo? {
        didSet {
            self.bindingData()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if isDeleteMode {
            selectButton.isSelected = selected
            selectContentsView.alpha = selected ? 0.7 : 0.0
        } else {
            selectContentsView.alpha = 0.0
        }
    }
}

extension RecentlyTableViewCell {
    func bindingData() {
        guard let item = item else { return }
        // item에서 꺼내와서 base에서 정의한 뷰들에 데이터 매핑
        if let imageURL = item.image_url {
            thumbnailImageView.sd_setImage(with: URL(string: imageURL))
        }
        if let title = item.name {
            contentTitle.text = title
        }
        if let date = item.req_date {
            let tempDate = Date(timeIntervalSince1970: date / 1000.0)
            contentDate.text = Date().offset(from: tempDate)
        }
        if let playTime = item.playtime {
            contentPlayTime.text = Int(playTime)?.getPlayTime()
        }

        if let endDt = item.end_dt?.getJavaTimestampDate(), endDt < Date(), isDeleteMode == false {
            expireContentsView.alpha = 0.9
        } else if let visible = item.visible_yn, visible == "N", isDeleteMode == false {
            expireContentsView.alpha = 0.9
        } else {
            expireContentsView.alpha = 0.0
        }
        if let adult = item.adult_yn, adult == "Y" {//, //ContentLockManager.current.currentLockState != .unlocked{
            adultView.isHidden = false
        } else {
            adultView.isHidden = true
        }
        if let adult = item.adult_yn, adult == "Y" {
            adultBadgeImageView.isHidden = false
        } else {
            adultBadgeImageView.isHidden = true
        }
    }
    
    func setupDI(observable: PublishRelay<UserInput>) {
        // 셀의 플레이 버튼 누를시, 셀의 아이템을 전달
        playButton.rx
            .tap
            .map{ [weak self] in
                .cellPlay((self?.item) ?? RecentlyCellInfo(key: 0, name: "0", type: .aosInstallGame, image_url: "0", playtime: "0", req_date: 0, visible_yn: .none, sb_info: .none, type_badge_url: "0", event_badge_url: "0", start_dt: 0, end_dt: 0, adult_yn: "0", downloadable: .N) )
                // 아 개 맘에 안들어 진짜
            }
            .bind(to: observable)
            .disposed(by:rx.disposeBag)
    }
}
