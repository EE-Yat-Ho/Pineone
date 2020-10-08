//
//  ViewModelType.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/10/06.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import Foundation

protocol ViewModelType: ViewModel {
    // ViewModel
    associatedtype ViewModel: ViewModelType

    // Input
    associatedtype Input

    // Output
    associatedtype Output

    func transform(req: ViewModel.Input) -> ViewModel.Output
}
