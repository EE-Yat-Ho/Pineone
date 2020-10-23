//
//  RxAlertView.swift
//  UPlusAR
//
//  Created by 정지원 on 2020/03/22.
//  Copyright © 2020 정지원. All rights reserved.
//

/**
* Usage
 1. observable
    let buttonSubject = PublishSubject<ActionResultModel>()
    map { _ in
        return AlertModel(content: Content_Text(message: "디폴트 메시지 이거1"), buttonObservable: self.buttonSubject)
    }
    .bind(to: RxAlert<Content_Text>().alertTrigger)
 
 2. block
    map { _ in
        return AlertModel(content: content, buttonCompletion: { actionResultModel in
            Toast(text: "alert view block \(actionResultModel.result), \(actionResultModel.view.message) @@").show()
        })
    }
    .bind(to: RxAlert<Content_Text>().alertTrigger)
 
 3. method
     RxAlert<Content_Text>().show(
         AlertModel(content: Content_Text(message: "디폴트 메시지 이거"), buttonCompletion: { actionResultModel in
             Toast(text: "alert view block \(actionResultModel.result), \(actionResultModel.view) @@").show()
         }
     ))
*/

import RxCocoa
import RxSwift
import Then
import UIKit

public enum ActionResult: String {
    /// 취소
    case cancel = "취소"
    /// 확인
    case done = "확인"
    /// 닫기
    case close = "닫기"
    /// 거부
    case refuse = "거부"
    /// 허용
    case allow = "허용"
    /// 다시 보지않기
    case noMore = "다시 보지않기"
    /// 잠금 설정
    case lockSetting = "잠금 설정"
    /// 잠금 해제
    case unlock = "잠금 해제"
    /// 저장
    case save = "저장"
    /// 입력 완료
    case fieldCompleted = "입력 완료"
    /// 삭제
    case delete = "삭제"
    /// 등록
    case registration = "등록"
    /// 나중에
    case after  = "나중에"
    /// 업데이트
    case update = "업데이트"
    /// 복사하기
    case copyFCMid = "복사하기"
    /// 다운로드
    case download = "다운로드"
    /// 설치하기
    case install = "설치하기"
    /// 네
    case yes = "네"
    /// 아니오
    case no = "아니오"
    /// 이벤트 자세히 보기
    case detailEvent = "이벤트 자세히 보기"
    /// 휴대폰 본인인증
    case verifyCTN = "휴대폰 본인인증"
    /// 앱 종료
    case exitApp = "종료"
    /// 다운로드 후 시청
    case afterDownload = "다운로드 후 시청"
    /// 계속 시청
    case keepShowing = "계속 시청"
    /// 초기화
    case reset = "초기화"
    /// 바닥고정 ON
    case fixGroundOn = "바닥고정ON"

    func buttonColor() -> UIColor {
        switch self {
        case .cancel, .close, .noMore, .refuse, .unlock, .after, .no, .exitApp, .keepShowing:
            return .black
        case .allow, .done, .lockSetting, .save, .fieldCompleted, .delete, .registration, .update, .copyFCMid, .download, .install, .yes, .detailEvent, .verifyCTN, .afterDownload, .reset, .fixGroundOn:
            return R.Color.base
        }
    }
}

struct ActionResultModel {
    let result: ActionResult
    let view: UIView?
    let alertViewController: UIViewController?
}

class AlertModel<T: UIView> {
    typealias ActionTrigger = ((ActionResultModel) -> Void)

    let title: String
    let content: T
    let buttonText: [ActionResult]

    var buttonObservable: PublishSubject<(ActionResultModel)>?
    var buttonCompletion: ActionTrigger?
    var isButtonAutoClose: Bool

    init(title: String = R.String.notice,
         content: T,
         buttonText: [ActionResult] = [],
         buttonObservable: PublishSubject<ActionResultModel>? = nil,
         isButtonAutoClose: Bool = true ,
         buttonCompletion: ActionTrigger? = nil) {
        //
        self.title = title
        self.content = content
        self.buttonText = buttonText
        self.buttonObservable = buttonObservable
        self.buttonCompletion = buttonCompletion
        self.isButtonAutoClose = isButtonAutoClose
    }
}

extension RxAlert: Then {}

class RxAlert<T: ContentBaseView> {
    public let alertTrigger = PublishSubject<AlertModel<T>?>()
    var disposeBag = DisposeBag()
    let isSupportTabToDismiss: Bool!
    let title: Bool!
    let isExistNeverShowingCheck: Bool!
    let eventPopupData: FDPopup?

    init(tapTodismiss: Bool = false, need title: Bool = false, isExistNeverShowingCheck: Bool = false, eventPopupData: FDPopup? = nil) {
        self.isSupportTabToDismiss = tapTodismiss
        self.title = title
        self.isExistNeverShowingCheck = isExistNeverShowingCheck
        self.eventPopupData = eventPopupData
        alertTrigger
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: {
                self.composite(model: $0)
            }).disposed(by: disposeBag)
    }

    fileprivate func composite(model: AlertModel<T>?) {
        if let model = model {
            let alert = CustomAlertViewController<T>(alertModel: model, need: title, isExistNeverShowingCheck: isExistNeverShowingCheck, eventPopupData: eventPopupData).then {
                $0.modalPresentationStyle = .overFullScreen
                $0.autoDismiss = isSupportTabToDismiss
               // $0.alertModel = model
            }
            AlertService.shared.enqueue(alert: alert)
        }
    }

    func show(_ model: AlertModel<T>) {
        alertTrigger.on(.next(model))
    }
}
