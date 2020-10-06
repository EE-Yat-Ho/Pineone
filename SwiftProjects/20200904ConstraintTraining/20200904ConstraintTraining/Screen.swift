//
//  Screen.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/10/06.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import Foundation

enum Screen {
    case storyBoard
    case nSLayout
    case visualFormat
    case nSLayout_VisualFormat
    case anchor
    case snapKit
    case rxSwift
    case mVVM
    
    func getTitle() -> String{
        switch self {
        case .storyBoard:
            return "StoryBoard"
        case .nSLayout:
            return "NSLayout"
        case .visualFormat:
            return "VisualFormat"
        case .nSLayout_VisualFormat:
            return "NSLayout_VisualFormat"
        case .anchor:
            return "Anchor"
        case .snapKit:
            return "SnapKit"
        case .rxSwift:
            return "RxSwift"
        case .mVVM:
            return "MVVM"
        }
    }
}
