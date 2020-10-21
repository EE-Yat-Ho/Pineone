//
//  RecentlyView.swift
//  UPlusAR
//
//  Created by SukHo Song on 2020/04/09.
//  Copyright (c) 2020 최성욱. All rights reserved.
//

import RxCocoa
import RxSwift
import SnapKit
import Then
import UIKit

class RecentlyView: UIBasePreviewTypeForRecentrly {
    // MARK: - Model type implemente
    typealias Model = RecentlyCellInfo

    // MARK: - Properties
    private let userInputs = PublishRelay<UserInput>()
    private let systemInputs = PublishRelay<SystemInput>()
    private let systemOutputs = PublishRelay<SystemOutput>()

    // MARK: - init
    override init(naviType: ARNavigationShowType = .none) {
        super.init(naviType: naviType)
        setupLayout()
        bindData()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View
    lazy var topView = ARTableViewHeaderView(type: .rightOneButton).then {
        $0.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 56)//56 trash
    }

    // recently tableView
    lazy var tableView = UITableView().then {
        $0.rx.setDelegate(self).disposed(by: rx.disposeBag)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = #colorLiteral(red: 0.114654012, green: 0.1092678383, blue: 0.1311254203, alpha: 1)
        $0.estimatedRowHeight = 92
        $0.separatorStyle = .none
        $0.rowHeight = 92
        $0.backgroundView = ARTableViewEmptyView(type: .recently)
        $0.register(RecentlyTableViewCell.self, forCellReuseIdentifier: RecentlyTableViewCell.reuseIdentifier())
    }

    // MARK: - Methods
    func setupLayout() {
        backgroundColor = #colorLiteral(red: 0.114654012, green: 0.1092678383, blue: 0.1311254203, alpha: 1)
        addSubviews([topView, tableView], needTopMoveButton: true)

        topView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }

        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    // MARK: - Observe UserInputs
    func bindData() {
        /// topView Inputs start
//        topView
//            .headerViewAction
//            .bind(to: topViewInput)
//            .disposed(by: rx.disposeBag)
        
        
    }
    
    // MARK: - setupDIes
    /// topview input go to VC
//    func setupDI(topViewRelay: PublishRelay<ARTableViewHeaderActionType>) {
//        topViewInput
//            .bind(to: topViewRelay)
//            .disposed(by:rx.disposeBag)
//    }
    
    
    // DI for tableView
    func setupDI(observable: Observable<[Model]>) {
        // model Dependency Injection
//        observable.asObservable().bind(to: tableView.rx.items(cellIdentifier: RecentlyTableViewCell.reuseIdentifier(), cellType: RecentlyTableViewCell.self)) { [weak self] _, element, cell in
//            guard let `self` = self else { return }
//            // 탑뷰 타입을 체크하네 즉 타입을 바꾸고 테이블을 리로드하는식인듯
//            cell.isDeleteMode = ((self.topView).type == .checkAndButton) ? true : false
//            cell.item = element
//            cell.setupDI(observable: self.userInput)
//        }.disposed(by: rx.disposeBag)
//
//        observable.asObservable()
//            .map { $0.count == 0 } // 아 true일때만 실행되는게 아니라 얘를 가지고 판별하는거구나 오우;
//            .subscribe(onNext: {[weak self] needHidden in
//                guard let `self` = self else { return }// 이거 왜있는거임? 아 셀프에 물음표안하기 + topView.snp.bottom 에 as! 안넣기 와우아아아
//
//                self.topView.isHidden = needHidden
//                // 탑뷰 없어졌으면 테이블뷰 탑 콘스트레인트 맨위로 쭉
//                self.tableView.snp.remakeConstraints {
//                    if needHidden { $0.top.equalToSuperview() } else { $0.top.equalTo(self.topView.snp.bottom) }
//                    $0.leading.trailing.bottom.equalToSuperview()
//                }
//                // ARTableViewEmptyView 띄우기
//                self.tableView.backgroundView?.isHidden = !needHidden
//            })
//            .disposed(by: rx.disposeBag)
    }
}

extension RecentlyView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.1098039216, blue: 0.1294117647, alpha: 1)
        return headerView
    }
}

// MARK: - PreView
#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct Recently_Previews: PreviewProvider {
    static var previews: some View {
        //        Group {
        //            ForEach(UIView.previceSupportDevices, id: \.self) { deviceName in
        //                DebugPreviewView {
        //                    return RecentlyView()
        //                }.previewDevice(PreviewDevice(rawValue: deviceName))
        //                    .previewDisplayName(deviceName)
        //                    .previewLayout(.sizeThatFits)
        //            }
        //        }
        Group {
            DebugPreviewView {
                let view = RecentlyView()
                //                .then {
                //                    $0.setupDI(observable: Observable.just([]))
                //                }
                return view
            }
        }
    }
}
#endif
