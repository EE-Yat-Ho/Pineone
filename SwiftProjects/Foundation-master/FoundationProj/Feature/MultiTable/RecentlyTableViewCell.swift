//
//  RecentlyTableViewCell.swift
//  UPlusAR
//
//  Created by SukHo Song on 2020/04/17.
//  Copyright © 2020 최성욱. All rights reserved.
//

import RxCocoa
import UIKit

class RecentlyTableViewCell: ActivityBaseTableViewCell {
    // 셀 item
    var item: RecentlyLikeList? {
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
}
