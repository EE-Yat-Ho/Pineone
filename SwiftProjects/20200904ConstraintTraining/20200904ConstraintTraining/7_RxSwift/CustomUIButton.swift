//
//  ㄴㅁㅊㄴ.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/09/25.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

open class CustomUIButton : UIButton {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        print("init UIButton")
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("deinit UIButton")
    }
}
