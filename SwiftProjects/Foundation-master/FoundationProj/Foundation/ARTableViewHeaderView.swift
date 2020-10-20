//
//  ARTableViewHeaderView.swift
//  UPlusAR
//
//  Created by 송석호 on 2020/06/04.
//  Copyright © 2020 최성욱. All rights reserved.
//

import Reusable
import RxCocoa
import RxSwift
import UIKit

enum ARTableViewHeaderActionType {
    case text                       // Text Button Tap
    case delete                     // Delete Button Tap
    case share                      // Share Button Tap
    case check                      // Check Button Tap
    case cancel                     // Cancel Button Tap
    case dropdown                   // Dropdown Button Tap
}

enum ARTableViewHeaderShowType {
    case none
    case leftText                   // 01-1. 왼쪽 정렬 Text
    case centerText                 // 01-2. 가운데 정렬 Text
    case leftTextAndNumber          // 01-3. Text + N
    case titleAndButton             // 02-1. Text 버튼이 있을 경우
    case rightOneButton             // 02-2. 버튼 1개일 경우
    case rightTwoButton             // 02-3. 버튼 2개일 경우
    case checkAndButton             // 03-1. Check 버튼 있는 경우
    case dropdownAndButton          // 03-2. Dropdown 버튼이 있을 경우
}

class ARTableViewHeaderView: UICollectionReusableView, Reusable {
    var type: ARTableViewHeaderShowType = .leftText {
        didSet {
            self.setupView()
        }
    }

    let headerViewAction = PublishRelay<ARTableViewHeaderActionType>()
    let typeRelay = PublishRelay<ARTableViewHeaderShowType>()

    func setupDI(type: Observable<ARTableViewHeaderShowType>) {
        type.bind(to: self.typeRelay)
            .disposed(by: rx.disposeBag)
    }

    lazy var tableHeaderView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addSubviews([titleLabel, countLabel, textButton, deleteButton, shareButton, checkButton, cancelButton, dropdownButton])

        titleLabel.snp.remakeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.top.bottom.equalToSuperview()
        }

        countLabel.snp.remakeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.trailing).offset(5)
            $0.top.bottom.equalToSuperview()
        }

        textButton.snp.remakeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
        }

        deleteButton.snp.remakeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(44)
            $0.trailing.equalTo(shareButton.snp.leading).offset(2)
        }

        shareButton.snp.remakeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(44)
            $0.trailing.equalToSuperview().offset(-20)
        }

        checkButton.snp.remakeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.top.bottom.equalToSuperview()
        }

        cancelButton.snp.remakeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(44)
            $0.trailing.equalToSuperview().offset(-20)
        }

        dropdownButton.snp.remakeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.top.bottom.equalToSuperview()
        }
    }

    lazy var titleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .white
        $0.font = .notoSans(.medium, size: 16)
        $0.contentMode = .center
        $0.isHidden = true
    }

    lazy var countLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .white
        $0.font = .notoSans(.medium, size: 16)
        $0.alpha = 0.4
        $0.isHidden = true
    }

    lazy var textButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .notoSans(.regular, size: 13)
        $0.alpha = 0.6
        $0.isHidden = true
    }

    lazy var deleteButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(#imageLiteral(resourceName: "icDeleteNor"), for: .normal)
        $0.setImage(#imageLiteral(resourceName: "icDeletePre"), for: .highlighted)
        $0.isHidden = true
        $0.rx.tap.map { ARTableViewHeaderActionType.delete }.bind(to: self.headerViewAction).disposed(by: rx.disposeBag)
//        $0.rx.tap.on(next: { [weak self] in self?.headerViewAction.accept(.delete) }).disposed(by: rx.disposeBag)
    }

    lazy var shareButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(#imageLiteral(resourceName: "icShareNor"), for: .normal)
        $0.setImage(#imageLiteral(resourceName: "icSharePre"), for: .highlighted)
        $0.isHidden = true

        $0.rx.tap.map { ARTableViewHeaderActionType.share }.bind(to: self.headerViewAction).disposed(by: rx.disposeBag)
//        $0.rx.tap.on(next: { [weak self] in self?.headerViewAction.accept(.share) }).disposed(by: rx.disposeBag)
    }

    lazy var checkButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(#imageLiteral(resourceName: "icCheckWOff"), for: .normal)
        $0.setImage(#imageLiteral(resourceName: "icCheckWOn"), for: .selected)
        $0.titleLabel?.font = .notoSans(.bold, size: 16)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 7)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: -7)

        $0.isHidden = true
        $0.rx.tap.map { ARTableViewHeaderActionType.check }.bind(to: self.headerViewAction).disposed(by: rx.disposeBag)
//        $0.rx.tap.on(next: { [weak self] in self?.headerViewAction.accept(.check) }).disposed(by: rx.disposeBag)
    }

    lazy var cancelButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(#imageLiteral(resourceName: "icCloseNor"), for: .normal)
        $0.setImage(#imageLiteral(resourceName: "icClosePre"), for: .highlighted)
        $0.isHidden = true
        $0.rx.tap.map { ARTableViewHeaderActionType.cancel }.bind(to: self.headerViewAction).disposed(by: rx.disposeBag)
//        $0.rx.tap.on(next: { [weak self] in self?.headerViewAction.accept(.cancel) }).disposed(by: rx.disposeBag)
    }

    lazy var dropdownButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(#imageLiteral(resourceName: "icDropdownOpenNor"), for: .normal)
        $0.setImage(#imageLiteral(resourceName: "icDropdownOpenNor"), for: .selected)
        $0.titleLabel?.font = .notoSans(.bold, size: 16)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.titleLabel?.contentMode = .left
        $0.isHidden = true
        $0.rx.tap.map { ARTableViewHeaderActionType.dropdown }.bind(to: self.headerViewAction).disposed(by: rx.disposeBag)
//        $0.rx.tap.on(next: { [weak self] in self?.headerViewAction.accept(.dropdown) }).disposed(by: rx.disposeBag)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(type: ARTableViewHeaderShowType = .leftText) {
        self.type = type
        super.init(frame: .zero)
        setupView()
        bind()
    }

    func bind() {
        typeRelay.on(next: { self.type = $0 }).disposed(by: rx.disposeBag)
    }

    func setupView() {
        // constraints 중복 적용 되는 현상 수정
        tableHeaderView.removeFromSuperview()
        tableHeaderView.snp.removeConstraints()

        Log.d("ARTableViewHeaderView = setupView()")
        backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.1098039216, blue: 0.1294117647, alpha: 1)
        addSubview(tableHeaderView)
        tableHeaderView.snp.remakeConstraints {
            $0.width.leading.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(44)
        }
        _ = [titleLabel, countLabel, textButton, deleteButton, shareButton, checkButton, cancelButton, dropdownButton].map { $0.isHidden = true }

        switch type {
        case .none:
            break
        case .leftText:
            _ = [titleLabel].map { $0.isHidden = false }
        case .centerText:
            _ = [titleLabel].map { $0.isHidden = false }
            titleLabel.snp.remakeConstraints {
                $0.centerY.centerX.equalToSuperview()
                $0.top.bottom.equalToSuperview()
            }
        case .leftTextAndNumber:
            _ = [titleLabel, countLabel].map { $0.isHidden = false }
        case .titleAndButton:
            _ = [titleLabel, textButton].map { $0.isHidden = false }
        case .rightOneButton:
            _ = [deleteButton].map { $0.isHidden = false }
            deleteButton.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.width.height.equalTo(44)
                $0.trailing.equalToSuperview().offset(-20)
            }
        case .rightTwoButton:
            _ = [deleteButton, shareButton].map { $0.isHidden = false }
        case .checkAndButton:
            _ = [checkButton, cancelButton].map { $0.isHidden = false }
        case .dropdownAndButton:
            _ = [dropdownButton, deleteButton].map { $0.isHidden = false }
            deleteButton.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.width.height.equalTo(44)
                $0.trailing.equalToSuperview().offset(-20)
            }
        }
    }

    func setupDI(actionRelay: PublishRelay<ARTableViewHeaderActionType>) {
        self.headerViewAction
        .throttle(.milliseconds(500), latest: false, scheduler: MainScheduler.instance)
            .bind(to: actionRelay).disposed(by: rx.reusableDisposeBag)
    }
}
