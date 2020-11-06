//
//  EventView.swift
//  UPlusAR
//
//  Created by baedy on 2020/03/23.
//  Copyright © 2020 최성욱. All rights reserved.
//

import RxCocoa
import RxSwift
import SnapKit
import Then
import UIKit

class EventView: UIBasePreviewType {
    typealias Model = FDEvent

    // MARK: init
    override init(naviType: ARNavigationShowType = .none) {
        super.init(naviType: naviType)
        setupLayout()
        bindingView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
        bindingView()
    }

    // MARK: View

    lazy var topView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = #colorLiteral(red: 0.114654012, green: 0.1092678383, blue: 0.1311254203, alpha: 1)
        $0.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 15)
    }

    lazy var eventTableView = UITableView().then {
        $0.rx.setDelegate(self).disposed(by: rx.disposeBag)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = #colorLiteral(red: 0.114654012, green: 0.1092678383, blue: 0.1311254203, alpha: 1)
        $0.register(EventCell.self, forCellReuseIdentifier: EventCell.reuseIdentifier())
        $0.separatorStyle = .none
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 200
        $0.tableHeaderView = topView
        $0.showsVerticalScrollIndicator = false
    }

    let refreshControl = CustomRefreshControl()

    func setupLayout() {
        backgroundColor = #colorLiteral(red: 0.114654012, green: 0.1092678383, blue: 0.1311254203, alpha: 1)
        addSubview(eventTableView, needTopMoveButton: true)
        eventTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        eventTableView.refreshControl = refreshControl

        eventTableView.rx.contentOffset.map({[weak self]  position -> Bool in
            guard let `self` = self else { return true }
            if position.y > self.eventTableView.frame.height {
                return false
            }
            return true
        }).bind(to: topMoveButton.rx.isHidden).disposed(by: rx.disposeBag)

        topMoveButton.rx.tap.on(next: {[weak self] _ in
            guard let `self` = self else { return }
            self.eventTableView.setContentOffset(CGPoint(x: 0, y: -(self.realSafeAreaInsetTop - 56)), animated: true)
        }).disposed(by: rx.disposeBag)
    }

    func bindingView() {
        eventTableView
            .rx
            .reloaded
            .subscribe(onNext: refreshControl.endRefresh)
            .disposed(by: rx.disposeBag)
    }

    func setupDI(observable: Observable<[FDEvent]>) {
        observable.bind(to: eventTableView.rx.items(cellIdentifier: EventCell.reuseIdentifier(), cellType: EventCell.self)) { _, element, cell in
            cell.dataMapping(event: element)
            cell.layoutIfNeeded()
        }.disposed(by: rx.disposeBag)
    }
}

extension EventView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.1098039216, blue: 0.1294117647, alpha: 1)
        return headerView
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        refreshControl.scrollViewDidScroll(scrollView)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        refreshControl.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct EventView_Previews: PreviewProvider {
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
                let view = EventView()
                //                .then {
                //                    $0.setupDI(observable: Observable.just([]))
                //                }
                return view
            }
        }
    }
}
#endif
