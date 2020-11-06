////
////  ActivityFlow.swift
////  UPlusAR
////
////  Created by baedy on 2020/03/05.
////  Copyright © 2020 최성욱. All rights reserved.
////
//
//import RxCocoa
//import RxFlow
//import RxSwift
//import UIKit
//
/// 내 활동 화면 탭 타이틀 정의
enum ActivityDetail: Int {
    case recently = 0
    case download = 1
    case like = 2
    case reply = 3

    var title: String {
        get {
            switch self {
            case .recently:
                return R.String.Activity.recently_title
            case .download:
                return R.String.Activity.donwload_title
            case .like:
                return R.String.Activity.like_title
            case .reply:
                return R.String.Activity.reply_title
            }
        }
    }
}

enum MoreSeeDetail: Int {
    case event
    case notice
    case faq
    case question
    case etc

    var title: String {
        get {
            switch self {
            case .event:
                return R.String.MoreSee.eventTabTitle
            case .notice:
                return R.String.MoreSee.noticeTabTitle
            case .faq:
                return R.String.MoreSee.FAQTabTitle
            case .question:
                return R.String.MoreSee.questionTabTitle
            case .etc:
                return R.String.MoreSee.etcTabTitle
            }
        }
    }
}
