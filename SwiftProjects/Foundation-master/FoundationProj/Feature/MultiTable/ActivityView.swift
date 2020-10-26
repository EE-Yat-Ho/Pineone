//
//  ActivityView.swift
//  UPlusAR
//
//  Created by baedy on 2020/03/08.
//  Copyright © 2020 최성욱. All rights reserved.
//

import RxCocoa
import RxSwift
import SnapKit
import Then
import UIKit

class ActivityView: UIBasePreviewTypeForSampling {
    // MARK: - Model type implemente
    typealias Model = EmptyModel

    // MARK: - init
    override init(naviType: ARNavigationShowType = .none) {
        super.init(naviType: naviType)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }

    // MARK: - View

    /// Tab View
    var tabPagerView: TabPagerView!

    // MARK: - Outlets

    // MARK: - Methods
    func setupLayout() {
        self.tabPagerView = TabPagerView()
        self.addSubview(tabPagerView)
        tabPagerView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.topMargin)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottomMargin)
            $0.left.right.equalToSuperview()
        }
    }
}

// MARK: - PreView
#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct Activity_Previews: PreviewProvider {
    static var previews: some View {
        //        Group {
        //            ForEach(UIView.previceSupportDevices, id: \.self) { deviceName in
        //                DebugPreviewView {
        //                    return ReplyView()
        //                }.previewDevice(PreviewDevice(rawValue: deviceName))
        //                    .previewDisplayName(deviceName)
        //                    .previewLayout(.sizeThatFits)
        //            }
        //        }
        Group {
            DebugPreviewView {
                let view = ActivityView()
                //                .then {
                //                    $0.setupDI(observable: Observable.just([]))
                //                }
                return view
            }
        }
    }
}
#endif
