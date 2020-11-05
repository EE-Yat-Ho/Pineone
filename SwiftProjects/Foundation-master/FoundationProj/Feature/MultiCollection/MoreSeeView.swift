//
//  MoreSeeView.swift
//  UPlusAR
//
//  Created by baedy on 2020/03/08.
//  Copyright © 2020 최성욱. All rights reserved.
//

import SnapKit
import Then
import UIKit

class MoreSeeView: UIBasePreviewTypeForSampling {
    /// 모델 없음
    typealias Model = EmptyModel

    // MARK: init
    override init(naviType: ARNavigationShowType = .none) {
        super.init(naviType: naviType)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }

    // MARK: View

    var pagerView: TabPagerView!

    func setupLayout() {
        self.pagerView = TabPagerView()
        self.addSubview(pagerView)
        pagerView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.topMargin)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottomMargin)
            $0.left.right.equalToSuperview()
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct MoreSeeView_Previews: PreviewProvider {
    static var previews: some View {
//        Group {
//            ForEach(UIView.previceSupportDevices, id: \.self) { deviceName in
//                DebugPreviewView {
//                    return ActivityView()
//                }.previewDevice(PreviewDevice(rawValue: deviceName))
//                    .previewDisplayName(deviceName)
//                    .previewLayout(.sizeThatFits)
//            }
//        }

        Group {
            DebugPreviewView {
                let view = MoreSeeView()
                //                .then {
                //                    $0.setupDI(observable: Observable.just([]))
                //                }
                return view
            }
        }
    }
}
#endif
