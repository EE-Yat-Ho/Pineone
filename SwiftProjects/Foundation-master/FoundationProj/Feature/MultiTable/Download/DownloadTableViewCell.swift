//
//  DownloadTableViewCell.swift
//  UPlusAR
//
//  Created by 송석호 on 2020/06/02.
//  Copyright © 2020 최성욱. All rights reserved.
//

import UIKit

class DownloadTableViewCell: ActivityBaseTableViewCell {
    // 셀 item
    var item: RealmMyDownloadFile? {
        didSet {
            self.bindingData()
        }
    }
    var currentProgress: CGFloat = 0 {
        didSet {
            progressAnimationView.currentProgress = currentProgress
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectButton.isSelected = selected
        selectContentsView.alpha = selected ? 0.7 : 0.0
    }

    override func setupLayout() {
        super.setupLayout()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        if let downloadStatus = item?.downloadStatus, downloadStatus == .downloading {
            playButton.isEnabled = false
            animatiomContainerView.isHidden = false
        } else {
            playButton.isEnabled = true
            animatiomContainerView.isHidden = true
        }
    }
}

extension DownloadTableViewCell {
    func bindingData() {
        guard let item = item else { return }
        
        if let imageURL = item.image_url {
            thumbnailImageView.image = nil
            thumbnailImageView.sd_setImage(with: URL(string: imageURL))
        }
        if let title = item.name {
            contentTitle.text = title
        }
        contentDate.text = CGFloat(item.allDownloadFilesByte / 1024).getByteString()

        if item.adult_yn == .Y {//}, ContentLockManager.current.currentLockState != .unlocked {
            adultView.isHidden = false
        } else {
            adultView.isHidden = true
        }

        if item.adult_yn == .Y {
            adultBadgeImageView.isHidden = false
        } else {
            adultBadgeImageView.isHidden = true
        }

        if !isDeleteMode, item.downloadStatus != .completed {
            let progress = CGFloat(item.currentDownloadFilesByte) / CGFloat(item.allDownloadFilesByte)
            progressAnimationView.currentProgress = progress
            setDownloadControl(false)
        } else {
            setDownloadControl(true)
        }

        if let endDt = item.end_dt?.getJavaTimestampDate(), endDt < Date(), isDeleteMode == false {
            expireContentsView.alpha = 0.9
//        } else if let visible = item.visible_yn, visible == "N", isDeleteMode == false {
//            expireContentsView.alpha = 0.9
        } else {
            expireContentsView.alpha = 0.0
        }
        
        
    }

    func setDownloadControl(_ value: Bool) {
        playButton.isEnabled = value
        animatiomContainerView.isHidden = value
    }
}
