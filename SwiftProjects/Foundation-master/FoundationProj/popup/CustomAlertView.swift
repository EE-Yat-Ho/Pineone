//
//  CustomAlertView.swift
//  UPlusAR
//
//  Created by 정지원 on 2020/03/21.
//  Copyright © 2020 정지원. All rights reserved.
//

import NSObject_Rx
import RxCocoa
import RxOptional
import RxSwift
import SnapKit
import Then
import UIKit

public class CustomAlertBaseView: UIView {
    lazy var title = UILabel.default()
    lazy var buttonsStackView = UIStackView.default(axis: .horizontal)
    lazy var customView = UIView().then {
        $0.alpha = 1
    }
    var hasButton: Bool {
        guard buttonsStackView.isDescendant(of: self) else { return false }
        return buttonsStackView.arrangedSubviews.isNotEmpty
    }

    func layout() {
        clipsToBounds = true
//        layer.cornerRadius = 6
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 20
    }
}

class CustomAlertView<T>: CustomAlertBaseView where T: ContentBaseView {
    var model: AlertModel<T>!
    var buttonHeight: CGFloat = 61
    let visibleTitleView: Bool!
    let isExistNeverShowingCheck: Bool!
    let dismissTrigger = PublishSubject<Void>()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }

    init(_ model: AlertModel<T>?, _ title: Bool, _ isExistNeverShowingCheck: Bool) {
        self.visibleTitleView = title
        self.model = model
        self.isExistNeverShowingCheck = isExistNeverShowingCheck
        super.init(frame: .zero)

        layout()
    }

    override func layout() {
        super.layout()

        if visibleTitleView {
            addSubview(title)
        }
        addSubviews([customView, buttonsStackView])

        config()

        if visibleTitleView {
            self.title.snp.makeConstraints {
                $0.top.left.right.equalToSuperview()
                $0.centerX.equalToSuperview()
                //$0.width.equalTo(300)
                $0.height.equalTo(50)
                $0.bottom.equalTo(self.customView.snp.top)
            }
        }
        self.customView.snp.makeConstraints {
            _ = visibleTitleView ? $0.top.equalTo(self.title.snp.bottom) : $0.top.equalToSuperview()
//            $0.left.right.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            //$0.width.equalTo(300)
            //$0.height.equalTo(300)
            $0.bottom.equalTo(self.buttonsStackView.snp.top).offset(self.isExistNeverShowingCheck ? 0 : -11)
        }

        self.buttonsStackView.snp.makeConstraints {
//            $0.top.equalTo(self.customView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(model.buttonText.count > 0 ? buttonHeight : 0)
            $0.bottom.equalToSuperview()
        }
    }

    func config() {
        title.text = model.title
        setContentView(model.content)

        for text in model.buttonText {
            buttonsStackView.addArrangedSubview(CustomAlertButton.default(withContainer: text, block: { [weak self] action in
                guard let `self` = self else { return }

                if let _ = (self.model.buttonText.firstIndex(of: action)) {
                    if let subject = self.model.buttonObservable {
                        subject.on(.next(ActionResultModel(result: action, view: self.model.content, alertViewController: self.parentViewController)))
                        //subject.on(.next(model.content))
                        //subject.onCompleted()
                    }
                    if let block = self.model.buttonCompletion {
                        block(ActionResultModel(result: action, view: self.model.content, alertViewController: self.parentViewController))
                    }
                }
            }))
        }
        updateConstraintsIfNeeded()
    }

    func setContentView(_ view: T) {
        self.customView.addSubview(view) { [weak self] in
            view.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            self?.updateConstraints()
        }
    }
}
