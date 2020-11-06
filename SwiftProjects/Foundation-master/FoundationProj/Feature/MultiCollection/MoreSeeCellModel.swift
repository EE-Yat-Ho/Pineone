//
//  ETCCellModel.swift
//  UPlusAR
//
//  Created by baedy on 2020/04/02.
//  Copyright © 2020 최성욱. All rights reserved.
//

import Action
import Foundation
import RxFlow

struct MoreSeeCellModel {
    let variety: Variety
    var onoff: Bool = false

    enum CellType {
        case none
        case arrow
        case switchUse
    }

    enum Variety {
        case nickname
        case password
        case adultblock
        case adultlock
        case benefit
        case forward
        case storage
        case version
        case opensource
        case terms
        case policy
        case useApp
        case chargeData
        case content
        case event
        case etc
        case certification
        case improvement
        #if ISINSPECTING
        case inspecting
        #endif

        func getCellType() -> CellType {
            switch self {
            case .nickname, .password:
                return .none
            case .adultblock, .adultlock, .benefit, .forward:
                return .switchUse
            case .storage, .version, .opensource, .terms, .policy, .useApp, .chargeData, .content, .event, .etc, .certification, .improvement:
                return .arrow
            #if ISINSPECTING
            case .inspecting:
                return .arrow
            #endif
            }
        }

        func getTitle() -> String {
            switch self {
            case .nickname:
                return R.String.MoreSee.nickNameChange
            case .password:
                return R.String.MoreSee.passwordChange
            case .adultblock:
                return R.String.MoreSee.adultBlock
            case .adultlock:
                return R.String.MoreSee.adultLock
            case .benefit:
                return R.String.MoreSee.benefitAlert
            case .forward:
                return R.String.MoreSee.forwardPlay
            case .storage:
                return R.String.MoreSee.storageLocation
            case .version:
                return "test"//R.String.MoreSee.version(AppUpdateManager.shared.latestVersionString)
            case .opensource:
                return R.String.MoreSee.openSource
            case .terms:
                return R.String.MoreSee.terms
            case .policy:
                return R.String.MoreSee.privacyPolicy
            case .useApp:
                return R.String.MoreSee.appUse
            case .chargeData:
                return R.String.MoreSee.chargeData
            case .content:
                return R.String.MoreSee.content
            case .event:
                return R.String.MoreSee.event
            case .etc:
                return R.String.MoreSee.etc
            case .improvement:
                return R.String.MoreSee.improvement
            case .certification:
                return R.String.MoreSee.certification
            #if ISINSPECTING
            case .inspecting:
                return "test"//R.String.Inspecting.inspectingMainTitle
            #endif
            }
        }

        func hasSubTitle() -> Bool {
            switch self {
            case .password, .adultblock, .adultlock, .benefit, .forward, .version:
                return true
            default:
                return false
            }
        }

        func getSubTitle() -> String {
            switch self {
            case .password:
                return R.String.MoreSee.passwordChangeSub
            case .adultblock:
                return R.String.MoreSee.adultBlockSub
            case .adultlock:
                return R.String.MoreSee.adultLockSub
            case .benefit:
                return R.String.MoreSee.benefitSub
            case .forward:
                return R.String.MoreSee.forwardSub
            case .version:
                return R.String.MoreSee.versionSub(R.String.MoreSee.currentVersion)
            default:
                return ""
            }
        }
    }
}

struct MoreSeeList {
    #if ISINSPECTING
    static var etcList = [
        MoreSeeCellModel(variety: .nickname),
        MoreSeeCellModel(variety: .password),
        MoreSeeCellModel(variety: .adultblock),
        MoreSeeCellModel(variety: .adultlock),
        MoreSeeCellModel(variety: .benefit),
        MoreSeeCellModel(variety: .forward),
        MoreSeeCellModel(variety: .version),
        MoreSeeCellModel(variety: .opensource),
        MoreSeeCellModel(variety: .terms),
        MoreSeeCellModel(variety: .policy),
        MoreSeeCellModel(variety: .certification),
        MoreSeeCellModel(variety: .inspecting)
    ]
    #else
    static var etcList = [
        MoreSeeCellModel(variety: .nickname),
        MoreSeeCellModel(variety: .password),
        MoreSeeCellModel(variety: .adultblock),
        MoreSeeCellModel(variety: .adultlock),
        MoreSeeCellModel(variety: .benefit),
        MoreSeeCellModel(variety: .forward),
        MoreSeeCellModel(variety: .version),
        MoreSeeCellModel(variety: .opensource),
        MoreSeeCellModel(variety: .terms),
        MoreSeeCellModel(variety: .policy),
        MoreSeeCellModel(variety: .certification)
    ]
    #endif
    static var directQuestionList = [
        MoreSeeCellModel(variety: .useApp),
        MoreSeeCellModel(variety: .chargeData),
        MoreSeeCellModel(variety: .content),
        MoreSeeCellModel(variety: .event),
        MoreSeeCellModel(variety: .etc),
        MoreSeeCellModel(variety: .improvement)
    ]
}
