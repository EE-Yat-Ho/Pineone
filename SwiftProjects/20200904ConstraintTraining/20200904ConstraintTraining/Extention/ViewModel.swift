//
//  ViewModel.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/10/06.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import Reusable
import UIKit

protocol ViewModel {
}

protocol ServicesViewModel: ViewModel {
    associatedtype Services
    var services: Services! { get set }
}

protocol ViewModelProtocol: AnyObject {
    associatedtype ViewModelType: ViewModel
    var viewModel: ViewModelType! { get set }
}

extension ViewModelProtocol where Self: UIViewController {
    static func instantiate<ViewModelType> (withViewModel viewModel: ViewModelType) -> Self where ViewModelType == Self.ViewModelType {
        let viewController = Self()
        viewController.viewModel = viewModel
        return viewController
    }
}

extension ViewModelProtocol where Self: StoryboardBased & UIViewController {
    static func instantiate<ViewModelType> (withViewModel viewModel: ViewModelType) -> Self where ViewModelType == Self.ViewModelType {
        let viewController = Self.instantiate()
        viewController.viewModel = viewModel
        return viewController
    }
}
