//
//  CustomAlertViewController.swift
//  UPlusAR
//
//  Created by 정지원 on 2020/03/21.
//  Copyright © 2020 정지원. All rights reserved.
//
import Foundation
import RxCocoa
import RxSwift
import SnapKit
import Then
import UIKit

typealias CustomAlert = CustomAlertViewController

class CustomAlertViewController<T>: UIViewController where T: ContentBaseView {
    var alertView: CustomAlertView<T>
    var alertModel: AlertModel<T>
    var completion: ((ActionResultModel) -> Void)?
    var eventPopupData: FDPopup?
    var isExistNeverShowingCheck: Bool = false
    public var autoDismiss = false

    lazy var checkButton = Button().then {
        $0.setImage(#imageLiteral(resourceName: "icCheckPSOff"), for: .normal)
        $0.setImage(#imageLiteral(resourceName: "icCheckPSOn"), for: .selected)
    }

    lazy var eventExitButton = Button().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(#imageLiteral(resourceName: "btnPopTxtCloseNor"), for: .normal)
        $0.setImage(#imageLiteral(resourceName: "btnPopTxtClosePre"), for: .highlighted)
        $0.setImage(#imageLiteral(resourceName: "btnPopTxtCloseDim"), for: .disabled)
        $0.rx.tap.on(next: {[weak self] _ in
            guard let `self` = self else { return }
            self.dismiss()
            self.completion?(ActionResultModel(result: .close, view: self.alertView, alertViewController: self))
        }).disposed(by: rx.disposeBag)
    }

    lazy var eventTurnoffTitle = UILabel().then {
        $0.text = R.String.Popup.notShowingTodayTitle
        $0.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        $0.font = .notoSans(size: 17)
    }
    lazy var eventBottomArea = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addSubviews([checkButton, eventTurnoffTitle, eventExitButton])

        checkButton.snp.makeConstraints {
            $0.width.height.equalTo(22)
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        eventTurnoffTitle.snp.makeConstraints {
            $0.leading.equalTo(checkButton.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        eventExitButton.snp.makeConstraints {
            $0.width.equalTo(53)
            $0.height.equalToSuperview()
            $0.top.trailing.bottom.equalToSuperview()
        }
        checkButton.rx.tap.on(next: {[weak self] in
            guard let `self` = self else { return }
            self.checkButton.isSelected.toggle()
        }).disposed(by: rx.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(alertModel: AlertModel<T>, need title: Bool = true, isExistNeverShowingCheck: Bool = false, eventPopupData: FDPopup?) {
        self.alertModel = alertModel
        self.alertView = CustomAlertView<T>(alertModel, title, isExistNeverShowingCheck)
        self.isExistNeverShowingCheck = isExistNeverShowingCheck
        self.eventPopupData = eventPopupData
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        configKeyboard()
    }

    @discardableResult
    func layout() -> CustomAlertViewController {
        transitioningDelegate = AlertPresentManager.shared

        bindObservable()
        viewDismissTriggerBind()
        bindBlock()
        handleDismiss()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8)
        if isExistNeverShowingCheck {
            let eventWholeView = UIView().then {
                $0.addSubviews([alertView, eventBottomArea])
                alertView.snp.makeConstraints {
                    $0.top.leading.trailing.equalToSuperview()
                }
                eventBottomArea.snp.makeConstraints {
                    $0.top.equalTo(alertView.snp.bottom).offset(12)
                    $0.height.equalTo(30)
                    $0.leading.trailing.bottom.equalToSuperview()
                }
            }
            view.addSubview(eventWholeView)
            eventWholeView.snp.makeConstraints {
                $0.center.equalToSuperview()
            }

            if let eventPopupData = eventPopupData, let turnoff = eventPopupData.turnOffType {
                eventTurnoffTitle.text = turnoff == .never ? R.String.dontShowMe : R.String.Popup.notShowingTodayTitle
            } else {
                eventTurnoffTitle.text = R.String.Popup.notShowingWeekTitle
            }
        } else {
            view.addSubview(alertView)
            alertView.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        }

        if autoDismiss {
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToDismiss))
            tapRecognizer.cancelsTouchesInView = false
            self.view.addGestureRecognizer(tapRecognizer)
        }

        return self
    }

    func viewDismissTriggerBind() {
        alertView.dismissTrigger.subscribe(onNext: { _ in
            self.dismiss()
        }).disposed(by: rx.disposeBag)
    }

    func bindObservable() {
        alertModel.buttonObservable?.subscribe(onNext: { [weak self] _ in
            self?.dismiss()
        }).disposed(by: rx.disposeBag)
    }

    func bindBlock() {
        if let completion = alertModel.buttonCompletion {
            self.completion = completion
            alertModel.buttonCompletion = { [weak self] actionResult -> Void in
                guard let `self` = self else { return }
                if self.alertModel.isButtonAutoClose {
                    self.dismiss()
                }
                self.completion?(actionResult)
            }
        }
    }

    func handleDismiss() {
        if alertModel.buttonCompletion == nil, alertModel.buttonObservable == nil {
            alertModel.buttonCompletion = { [weak self] actionResult -> Void in
                guard let `self` = self else { return }
                self.dismiss()
            }
        }
    }

    @objc func tapToDismiss(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: self.view)

        if !alertView.frame.contains(point) {
            self.dismiss()
        }
    }

    func dismiss() {
        AlertService.shared.dismiss()
    }

    // MARK: - Keyboard Notification
    func configKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.alertView.addGestureRecognizer(tap)

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

    @objc func keyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 2, animations: {
                self.alertView.snp.remakeConstraints {
                    $0.centerY.equalToSuperview().offset( -keyboardSize.height / 2)
                    $0.centerX.equalToSuperview()
                }

                self.view.layoutIfNeeded()
            })
        }
    }

    @objc func keyboardHide(notification: NSNotification) {
        UIView.animate(withDuration: 2, animations: {
            self.alertView.snp.remakeConstraints {
                $0.center.equalToSuperview()
            }
            self.view.layoutIfNeeded()
        })
    }
}
