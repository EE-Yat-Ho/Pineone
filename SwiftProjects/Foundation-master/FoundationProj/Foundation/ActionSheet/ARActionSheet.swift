//
//  ARActionSheet.swift
//  UPlusAR
//
//  Created by 송석호 on 2020/06/25.
//  Copyright © 2020 최성욱. All rights reserved.
//

import Foundation
import RxSwift

enum ActionSheetResult {
    case close
    case text(String)
}

class ARActionSheet {
    let disposeBag = DisposeBag()
    private static var current: ARActionSheet?
    var completion: ((ActionSheetResult) -> Void)?

    let alertController: UIAlertController

    lazy var cancelButton = UIButton().then {
        $0.setTitle(R.String.cancel, for: .normal)
        $0.setTitleColor(#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), for: .normal)
        $0.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        $0.cornerRadius = 13
        $0.titleLabel?.font = .notoSans(.medium, size: 19)
        $0.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
    }

    let bodyView = UIView().then {
        $0.layer.cornerRadius = 13
        $0.layer.masksToBounds = true
        $0.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    init() {
        alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        setupLayout()
        Self.current = self
    }

    func setupLayout() {
        alertController.view.addSubviews([bodyView, cancelButton])

        bodyView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().offset(-14)
            $0.top.equalToSuperview()
        }

        cancelButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().offset(-14)
            $0.bottom.equalToSuperview().offset(alertController.view.safeAreaInsets.bottom)
            $0.height.equalTo(60)
            $0.top.equalTo(bodyView.snp.bottom).offset(8)
        }
    }

    func addView(view: UIView) -> Self {
        bodyView.addSubview(view)
        view.snp.makeConstraints {
            $0.top.bottom.centerX.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        let buttons: [UIButton] = view.getSubviewsOf(view: view)
        for button in buttons {
            button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        }
        if let view = view as? ActionSheetView {
            view.rx.didSelect.subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                self.dismiss(self.createResult($0))
            }).disposed(by: disposeBag)
        }
        return self
    }

    func show(completion: @escaping (ActionSheetResult) -> Void) {
        self.completion = completion
        let cancelAction = UIAlertAction(title: "", style: .cancel) { [weak self] _ in
            guard let `self` = self else { return }
            self.alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(cancelAction)
        alertController.view.updateConstraints()
        if let parentVC = UIApplication.shared.topViewController {
            parentVC.present(alertController, animated: true, completion: nil)
        }

        if let view = alertController.view.subviews.first {
            for innerView in view.subviews {
                for findView in innerView.subviews {
                    findView.layer.isHidden = true
                }
            }
        }
    }

    @objc func buttonAction(_ button: UIButton) {
        var result: ActionSheetResult = .close
        if button != cancelButton {
            if let text = button.titleLabel?.text {
                result = .text(text)
            }
        }

        self.dismiss(result)
    }

    func createResult(_ object: Any) -> ActionSheetResult {
        var result: ActionSheetResult = .close
        if let text = object as? String {
            result = .text(text)
        }
        return result
    }

    func dismiss(_ result: ActionSheetResult) {
        alertController.dismiss(animated: true, completion: nil)
        completion?(result)
        completion = nil
        Self.current = nil
    }
}
