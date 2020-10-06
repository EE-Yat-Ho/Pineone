//
//  AppStepper.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/10/06.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import Foundation
import RxCocoa
import RxFlow

class AppStepper: Stepper {
    static let shared = AppStepper()
    
    var steps = PublishRelay<Step>()
    
    var initialStep: Step {
        AppStep.initialize
    }
    
    func readyToEmitSteps() {
    }
}
