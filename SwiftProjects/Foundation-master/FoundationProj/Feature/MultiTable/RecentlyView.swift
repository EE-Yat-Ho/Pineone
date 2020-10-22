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
    /// 유저와 시스템의 모든 입력을 ViewModel에 전달해주는 릴레이
    private let inputAction = PublishRelay<InputAction>()
    
    /// 상단 새로고침 컨트롤
    let refreshControl = CustomRefreshControl()
    
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
    /// 상단 topView ( 쓰레기통, 체크박스, X버튼 )
    lazy var topView = ARTableViewHeaderView(type: .rightOneButton).then {
        $0.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 56)//56 trash
    }

    /// 테이블뷰
    lazy var tableView = UITableView().then {
        $0.rx.setDelegate(self).disposed(by: rx.disposeBag)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = #colorLiteral(red: 0.114654012, green: 0.1092678383, blue: 0.1311254203, alpha: 1)
        $0.estimatedRowHeight = 92
        $0.separatorStyle = .none
        $0.rowHeight = 92
        $0.backgroundView = ARTableViewEmptyView(type: .recently)
        $0.register(RecentlyTableViewCell.self, forCellReuseIdentifier: RecentlyTableViewCell.reuseIdentifier())
        $0.refreshControl = refreshControl
    }

    /// 삭제버튼을 포함하는 하단뷰
    lazy var bottomView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = #imageLiteral(resourceName: "bgButtonGra01")
        $0.isHidden = true
        $0.isUserInteractionEnabled = true
    }
    
    /// 하단 삭제 버튼
    lazy var bottomDeleteButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.titleLabel?.font = .notoSans(.bold, size: 17)
        $0.setTitle("", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.addGradientForButton()
        $0.isHidden = true
        $0.isUserInteractionEnabled = true
        $0.cornerRadius = 12.0
    }
    
    // MARK: - Layout
    func setupLayout() {
        backgroundColor = #colorLiteral(red: 0.114654012, green: 0.1092678383, blue: 0.1311254203, alpha: 1)
        bottomView.addSubviews([bottomDeleteButton])
        addSubviews([topView, tableView, bottomView], needTopMoveButton: true)

        topView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints {
            $0.height.equalTo(112)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
        bottomDeleteButton.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-15)
        }
    }
    
    // MARK: - Observe UserInputs
    func bindData() {
        // Inputs. Required Business Logic
        /// 삭제모드 아닐때 셀 선택시, cellDetail 전달. 성인이나 기간 판단은 ViewModel 에서!
        tableView
            .rx
            .modelSelected(RecentlyCellInfo.self)
            .filter { _ in self.tableView.allowsMultipleSelection == false }
            .map {.cellDetail($0)}
            .bind(to: inputAction)
            .disposed(by: rx.disposeBag)
        
        /// refreshController에서 refreshTrigger 발생시 VM에 .refreshData emit하기
        refreshControl
            .rx
            .refreshTrigger
            .map{ .refreshData}
            .bind(to: inputAction)
            .disposed(by: rx.disposeBag)
        
        
        // Inputs. Not Required Business Logic
        /// topView의 입력을 topViewEventProcessor로 emit
        topView
            .headerViewAction
            .subscribe(onNext: topViewEventProcessor)
            .disposed(by: rx.disposeBag)
        
        /// tableView가 삭제모드일때, 셀 선택시 하단 버튼처리
        tableView
            .rx
            .selectedRows
            .filter { _ in self.tableView.allowsMultipleSelection == true } // 삭제모드
            .subscribe(onNext: showDeleteButton)
            .disposed(by: rx.disposeBag)
        
        /// tableView의 모든 셀 선택시 topView의 체크버튼 선택
        tableView
            .rx
            .isAllSelectedItems
            .bind(to: self.topView.checkButton.rx.isSelected)
            .disposed(by: rx.disposeBag)

        /// 하단 삭제버튼 누르면, 테이블뷰의 선택된 셀들을 [IndexPath]로 넘겨주면서 알람띄우기
        bottomDeleteButton
            .rx
            .tap
            .map { _ -> [IndexPath] in return self.tableView.indexPathsForSelectedRows!.sorted() }
            .subscribe(onNext: showAlert)
            .disposed(by: rx.disposeBag)
        
        /// 테이블뷰이 리로드되면 refreshControl의 애니메이션이나 위치 조정. 삭제모드가 아니여야 하는 이유는 삭제모드에서 refreshControl이 없기때문
        tableView
            .rx
            .reloaded
            .filter { _ in self.tableView.allowsMultipleSelection == false }
            .subscribe(onNext: refreshControl.endRefresh)
            .disposed(by: rx.disposeBag)
    }
    
    // MARK: - setupDIes
    /// 입력을 전달해주는 inputAction을 ViewController에서 관찰하게하기
    func setupDI(inputAction: PublishRelay<InputAction>){
        self.inputAction.bind(to: inputAction).disposed(by: rx.disposeBag)
    }
    
    /// VM에서 온 옵저버블을 테이블이 관찰
    func setupDI(tableOv: Observable<[RecentlyCellInfo]>) {
        tableOv
            .bind(to: tableView.rx.items(cellIdentifier: RecentlyTableViewCell.reuseIdentifier(), cellType: RecentlyTableViewCell.self))
                { [weak self] _, element, cell in
                    guard let `self` = self else { return }
                    cell.mappingData(item: element, isDeleteMode: ((self.topView).type == .checkAndButton) ? true : false)
                    cell.setupDI(observable: self.inputAction)
                }.disposed(by: rx.disposeBag)
        
        tableOv
            .map { $0.count == 0 }
            .bind(to: topView.rx.isHidden)
            .disposed(by: rx.disposeBag)
        
        tableOv
            .map { $0.count == 0 }
            .subscribe(onNext: {[weak self]  needHidden in
            guard let `self` = self else { return }
            self.topView.snp.remakeConstraints {
                $0.top.equalToSuperview().offset(12)
                $0.leading.trailing.equalToSuperview()
                let height = needHidden ? 0.0 : 44.0
                $0.height.equalTo(height)
            }

            self.tableView.snp.remakeConstraints {
                if needHidden { $0.top.equalToSuperview() } else { $0.top.equalTo(self.topView.snp.bottom) }
                $0.leading.trailing.bottom.equalToSuperview()
            }
            self.tableView.backgroundView?.isHidden = !needHidden
        }).disposed(by: rx.disposeBag)
    }
    
    
    // MARK: - Methods for Events
    /// topView 이벤트들 처리
    func topViewEventProcessor(actionType: ARTableViewHeaderActionType){
        switch actionType {
        case .delete:
            tableView.reloadData()
            topView.type = .checkAndButton
            topView.checkButton.setTitle(R.String.selectAll, for: .normal)
            topView.checkButton.setTitle(R.String.selectAll, for: .selected)
            tableView.allowsMultipleSelection = true
            tableView.refreshControl = nil
        case .check:
            topView.checkButton.isSelected.toggle()
            topView.checkButton.isSelected ? tableView.selectRowAll(animated: false, scrollPosition: .none) : tableView.deSelectRowAll(animated: false)
            topView.checkButton.isSelected ? showDeleteButton(select: tableView.indexPathsForSelectedRows!.sorted()) : showDeleteButton(select: [])
        case .cancel:
            tableView.reloadData()
            topView.type = .rightOneButton
            topView.checkButton.isSelected = false
            tableView.allowsMultipleSelection = false
            tableView.refreshControl = refreshControl
            showDeleteButton(select: [])
        default:
            print("TopView Another Event Accept!")
        }
    }
    
    /// 하단 삭제 버튼 표시 유무
    func showDeleteButton(select indexPaths: [IndexPath]) {
        tableView.contentInset = (indexPaths.count > 0) ? UIEdgeInsets(top: 0, left: 0, bottom: 110, right: 0) : UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        bottomView.isHidden = (indexPaths.count > 0) ? false : true
        bottomDeleteButton.isHidden = bottomView.isHidden
        bottomDeleteButton.setTitle((indexPaths.count > 0) ? R.String.Activity.delete_count(indexPaths.count) : "", for: .normal)
    }
    
    /// 삭제 팝업
    func showAlert(indexPaths: [IndexPath]) {
        RxAlert<Content_Text>().show(
            AlertModel(content: Content_Text(message: R.String.Activity.alert_delete_count(indexPaths.count)).then {
                $0.message.numberOfLines = 0
            }, buttonText: [.cancel, .done], buttonCompletion: { actionResultModel in
                if actionResultModel.result == .done {
                    // 삭제 실행
                    self.inputAction.accept(.deleteItems(indexPaths))
                } else {
                    // 취소 dismiss
                }
            }
        ))
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        refreshControl.scrollViewDidScroll(scrollView)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        refreshControl.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
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
