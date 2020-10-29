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
import Lottie

class TripleCompactTableViewCell: UITableViewCell {
    // MARK: - 트리거 시작
    /// 셀 선택시 삭제모드 여부에 따라 체크, 검은색 UI 바꾸기
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if isDeleteMode {
            selectButton.isSelected = selected
            selectContentsView.alpha = selected ? 0.7 : 0.0
        } else {
            selectContentsView.alpha = 0.0
        }
    }
    /// 셀 삭제모드 여부. 세팅시 삭제 모드일때와 아닐때의 UI 바꾸기 작업
    var isDeleteMode: Bool = false {
        didSet {
            self.setupDeleteModeLayout()
        }
    }
    func setupDeleteModeLayout() {
        playButton.isHidden = isDeleteMode ? true : false
        if progressAnimationView.currentProgress == 0 || progressAnimationView.currentProgress == 1 {
            animatiomContainerView.isHidden = true
        } else {
            animatiomContainerView.isHidden = isDeleteMode ? true : false
        }
        selectButton.isHidden = isDeleteMode ? false : true
    }
    /// 외부에서 호출. 셀 정보와 삭제모드 여부를 매핑.
    func mappingData(item: CompactCellItem, isDeleteMode: Bool){
        self.item = item
        self.isDeleteMode = isDeleteMode
    }
    var item: CompactCellItem? {
        didSet {
            self.bindingData()
        }
    }
    private func bindingData() {
        guard let item = item else { return }
        // item이 세팅되면, ActivityBaseTableViewCell에서 정의한 뷰들에 데이터 넣어주기
        if let imageURL = item.image_url {
            thumbnailImageView.sd_setImage(with: URL(string: imageURL))
        }
        if let title = item.name {
            contentTitle.text = title
        }
        if let adult = item.adult_yn, adult == .Y{//, //ContentLockManager.current.currentLockState != .unlocked{
            adultView.isHidden = false
        } else {
            adultView.isHidden = true
        }
        if let adult = item.adult_yn, adult == .Y {
            adultBadgeImageView.isHidden = false
        } else {
            adultBadgeImageView.isHidden = true
        }
        if let endDt = item.end_dt?.getJavaTimestampDate(), endDt < Date(), isDeleteMode == false {
            expireContentsView.alpha = 0.9
        } else if let visible = item.visible_yn, visible == "N", isDeleteMode == false {
            expireContentsView.alpha = 0.9
        } else {
            expireContentsView.alpha = 0.0
        }
//
//        if let date = item.req_date {
//            let tempDate = Date(timeIntervalSince1970: date / 1000.0)
//            contentDate.text = Date().offset(from: tempDate)
//        }
//        if let playTime = item.playtime {
//            contentPlayTime.text = Int(playTime)?.getPlayTime()
//        }

        
        
    }
    
    // MARK: - 바인드 관리
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    /// 플레이 버튼 누를 시, VM으로 이벤트를 전달하기 위한 DI
    func setupDI(observable: PublishRelay<InputAction>) {
        // 셀의 플레이 버튼 누를시, 셀의 아이템을 전달
        playButton.rx
            .tap
            .map{ [weak self] in
                guard let item = self?.item else { return .error }
                return .cellPlay(item.key ?? "")
            }
            .bind(to: observable)
            .disposed(by:disposeBag)
    }
    
    // MARK: - Views
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

    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
