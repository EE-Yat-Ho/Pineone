//
//  BaseView.swift
//  UPlusAR
//
//  Created by baedy on 2020/09/07.
//  Copyright © 2020 Pineone. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import SnapKit
import Then
import UIKit

class BaseView: UIView{
    
}

class BaseViewForSampling: UIView {
    var naviType: ARNavigationShowType = .none
    lazy var naviBar = ARNavigationBar(type: self.naviType)
    lazy var topMoveButton = Button().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(#imageLiteral(resourceName: "btnFloatingTopNor"), for: .normal)
        $0.setImage(#imageLiteral(resourceName: "btnFloatingTopPre"), for: .highlighted)
        $0.setImage(#imageLiteral(resourceName: "btnFloatingTopDim"), for: .disabled)
        $0.isHidden = true
    }

    //lazy var networkErrorView = NetworkErrorView()
    
    //init() {}
    
    init(naviType: ARNavigationShowType) {
        super.init(frame: .zero)
        backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.1098039216, blue: 0.1294117647, alpha: 1)
        self.naviType = naviType

        if naviType != .none {
            addSubview(naviBar)
            naviBar.snp.makeConstraints {
                $0.top.leading.trailing.equalToSuperview()
                $0.height.equalTo(naviBar.navBarHeight)
            }
        }
        addSubview(topMoveButton)
        topMoveButton.snp.makeConstraints {
            $0.width.height.equalTo(56)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSafeAreaAuto(self).offset(-16)
        }

        //addSubview(networkErrorView)
    }

    func addSubview(_ view: UIView, needTopMoveButton: Bool = false) {
        addSubview(view)
        if needTopMoveButton {
            bringSubviewToFront(topMoveButton)
        }

        //bringSubviewToFront(networkErrorView)
    }

    func addSubviews(_ views: [UIView], needTopMoveButton: Bool = false) {
        addSubviews(views)
        if needTopMoveButton {
            bringSubviewToFront(topMoveButton)
        }

        //bringSubviewToFront(networkErrorView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
