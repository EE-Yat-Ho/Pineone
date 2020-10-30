//
//  ActivityViewModel.swift
//  UPlusAR
//
//  Created by baedy on 2020/03/06.
//  Copyright © 2020 최성욱. All rights reserved.
//

import RxCocoa
import RxFlow
import RxSwift
import UIKit

class ActivityViewModel: ViewModelType, Stepper {
    // MARK: Stepper
    var steps = PublishRelay<Step>()

    // MARK: ViewModelType Protocol
    typealias ViewModel = ActivityViewModel

    struct Input {
    }

    struct Output {
    }

    func transform(req: ViewModel.Input) -> ViewModel.Output {
        return Output()
    }
}
