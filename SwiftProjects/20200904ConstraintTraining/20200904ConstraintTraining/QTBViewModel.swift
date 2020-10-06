//
//  QTBViewModel.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/10/06.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxFlow

class QTBViewModel: ViewModelType, Stepper {
    // MARK: - Stepper
    var steps = PublishRelay<Step>()
    
    // MARK: - ViewModelType Protocol
    typealias ViewModel = QTBViewModel
    
    struct Input {
    }
    
    struct Output {
    }
    
    func transform(req: ViewModel.Input) -> ViewModel.Output {
        return Output()
    }
}
