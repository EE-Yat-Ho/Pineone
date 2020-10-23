//
//  ARTableViewEmptyView.swift
//  UPlusAR
//
//  Created by 송석호 on 2020/06/05.
//  Copyright © 2020 최성욱. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

enum ARTableViewEmptyViewShowType {
    case recently
    case download
    case like
    case reply
    case media
}

class ARTableViewEmptyView: UIView {
    var type: ARTableViewEmptyViewShowType = .recently

    lazy var emptyView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = #colorLiteral(red: 0.114654012, green: 0.1092678383, blue: 0.1311254203, alpha: 1)
        $0.addSubviews([emptyImageView, emptyLabel])

        emptyImageView.snp.makeConstraints {
            $0.width.height.equalTo(64)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(emptyLabel.snp.top).offset(-20)
            $0.top.equalToSuperview()
        }

        emptyLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(37)
            $0.trailing.equalToSuperview().offset(-37)

            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    lazy var emptyImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = #imageLiteral(resourceName: "imgEmpty")
    }

    lazy var emptyLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .notoSans(.medium, size: 16)
        $0.textAlignment = .center
        $0.alpha = 0.5
        $0.textColor = .white
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let _ = superview {
            self.snp.makeConstraints {
                $0.edges.equalToSuperview()
                $0.center.equalToSuperview()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(type: ARTableViewEmptyViewShowType = .recently) {
        self.type = type
        super.init(frame: .zero)
        setupView()
    }

    func setupView() {
        backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.1098039216, blue: 0.1294117647, alpha: 1)
        addSubview(emptyView)
        emptyView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
//            $0.leading.trailing.top.bottom.equalToSuperview()
        }

        switch type {
        case .recently:
            emptyLabel.text = R.String.Activity.empty_content_recently
        case .download:
            emptyLabel.text = R.String.Activity.empty_content_download
        case .like:
            emptyLabel.text = R.String.Activity.empty_content_like
        case .reply:
            emptyLabel.text = R.String.Activity.empty_content_reply
        case .media:
            emptyLabel.text = R.String.Album.empty_content_media
        }
    }
}
