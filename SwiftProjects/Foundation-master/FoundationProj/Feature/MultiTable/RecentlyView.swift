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
    typealias Model = RecentlyLikeList

    let refreshTrigger = PublishRelay<Void>()
    let showDetailTrigger = PublishRelay<RecentlyLikeList>()
    let playContentTrigger = PublishRelay<RecentlyLikeList>()
    let buttonActionTrigger = PublishRelay<ARTableViewHeaderActionType>()
    let deleteItemsTrigger = PublishRelay<[IndexPath]>()

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

    // 해더뷰
    // 얘 왜 위에 딱붙어서 안내려오냐 > 해결
    lazy var topView = ARTableViewHeaderView(type: .rightOneButton).then {
        $0.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 56)//56 trash
        $0.headerViewAction.bind(to: buttonActionTrigger).disposed(by: rx.disposeBag)
    }

    // 최근 본 테이블리스트
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

    // 상단 새로고침 컨트롤
    let refreshControl = CustomRefreshControl()
    
    // 삭제 버튼 배경
    lazy var bottomView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = #imageLiteral(resourceName: "bgButtonGra01")
        $0.isHidden = true
        $0.isUserInteractionEnabled = true
    }

    // 하단 삭제 버튼
    lazy var bottomDeleteButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.titleLabel?.font = .notoSans(.bold, size: 17)
        $0.setTitle("", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.addGradientForButton()
        $0.isHidden = true
        $0.isUserInteractionEnabled = true
        $0.cornerRadius = 12.0
//        $0.rx.tap
//            .throttle(.seconds(1), latest: false, scheduler: MainScheduler.instance)
//            .map { _ -> [IndexPath] in return self.tableView.indexPathsForSelectedRows!.sorted() }.subscribe(onNext: showAlert).disposed(by: rx.disposeBag)
    }

    // MARK: - Methods
    func setupLayout() {
        //networkErrorView.bindingViewModel()
        backgroundColor = #colorLiteral(red: 0.114654012, green: 0.1092678383, blue: 0.1311254203, alpha: 1)
        bottomView.addSubviews([bottomDeleteButton])
        addSubviews([topView, tableView, bottomView], needTopMoveButton: true)

        topView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }

        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }

        tableView.refreshControl = refreshControl

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

    func bindData() {
        //테이블뷰 스크롤로 내려간 길이가 테이블뷰의 프레임 높이보다 커지면 버튼 나오게하는 바인딩
        // 애매한데,,판단이 들어가긴했는데 모델까지 갈필요가..
        tableView.rx.contentOffset.map({[weak self]  position -> Bool in
            guard let `self` = self else { return true }
            if position.y > self.tableView.frame.height {
                return false
            }
            return true
        }).bind(to: topMoveButton.rx.isHidden)
        .disposed(by: rx.disposeBag)
        
        // 버튼 눌렀을때 반응하는 클로저랑 바인딩
        topMoveButton.rx.tap.on(next: {[weak self] _ in
            guard let `self` = self else { return }
            self.tableView.setContentOffset(CGPoint(x: 0, y: -(self.realSafeAreaInsetTop - 56)), animated: true)
        }).disposed(by: rx.disposeBag)
        
        // TableView Reloading
        tableView
            .rx
            .reloaded
            .filter { _ in self.tableView.allowsMultipleSelection == false } // 뭐지이게 으음? 아 삭제모드가 아닐때구나..?
            .subscribe(onNext: refreshControl.endRefresh)
            .disposed(by: rx.disposeBag)

        // TableView Select Cell(delete mode)
        tableView
            .rx
            .selectedRows // Rx+ 에 정의한 녀석
            .filter { _ in self.tableView.allowsMultipleSelection == true }
            .subscribe(onNext: showDeleteButton)
            .disposed(by: rx.disposeBag)

        // TableView Select Cell(not delete mode)
        tableView
            .rx
            .modelSelected(RecentlyLikeList.self) // 기본 RX에서 제공하는 MODELSELECTED로 처리
            .filter { _ in self.tableView.allowsMultipleSelection == false }
            .filter { item in item.visible_yn == "Y" }
            .filter { item in
                guard let endDt = item.end_dt else { return false }
                return endDt.getJavaTimestampDate() > Date()
            }
            .bind(to: showDetailTrigger)
            .disposed(by: rx.disposeBag)

        tableView
            .rx
            .isAllSelectedItems
            .bind(to: self.topView.checkButton.rx.isSelected)
            .disposed(by: rx.disposeBag)

        refreshControl
            .rx
            .refreshTrigger
            .bind(to: refreshTrigger)
            .disposed(by: rx.disposeBag)

        refreshTrigger.on(next: { [weak self] in
            self?.refreshControl.endRefresh()
        }).disposed(by: rx.disposeBag)
        
        //        networkErrorView
        //            .setupDI(refreshTrigger)
    }
    
    // 최근본 데이터 recentlyList
    func setupDI(observable: BehaviorRelay<[Model]>) {
        // model Dependency Injection
        observable.asObservable().bind(to: tableView.rx.items(cellIdentifier: RecentlyTableViewCell.reuseIdentifier(), cellType: RecentlyTableViewCell.self)) { [weak self] _, element, cell in
            guard let `self` = self else { return }
            cell.isDeleteMode = ((self.topView).type == .checkAndButton) ? true : false
            cell.item = element
            cell.setupDI(observable: self.playContentTrigger)
        }.disposed(by: rx.disposeBag)

        observable.asObservable()
            .map { $0.count == 0 } // 아 true일때만 실행되는게 아니라 얘를 가지고 판별하는거구나 오우;
            .subscribe(onNext: {[weak self] needHidden in
                guard let `self` = self else { return }// 이거 왜있는거임? 아 셀프에 물음표안하기 + topView.snp.bottom 에 as! 안넣기 와우아아아
                
                self.topView.isHidden = needHidden
                // 탑뷰 없어졌으면 테이블뷰 탑 콘스트레인트 맨위로 쭉
                self.tableView.snp.remakeConstraints {
                    if needHidden { $0.top.equalToSuperview() } else { $0.top.equalTo(self.topView.snp.bottom) }
                    $0.leading.trailing.bottom.equalToSuperview()
                }
                // ARTableViewEmptyView 띄우기
                self.tableView.backgroundView?.isHidden = !needHidden
            })
            .disposed(by: rx.disposeBag)

        

    }

    @discardableResult
    func setupDI<T>(relay: PublishRelay<T>) -> Self {
        if let r = relay as? PublishRelay<Void> {
            // refreshTrigger
            refreshTrigger
                .bind(to: r)
                .disposed(by: rx.disposeBag)
        } else if let r = relay as? PublishRelay<RecentlyLikeList> {
            // showDetailTrigger 컨텐츠 상세 화면 진입
            showDetailTrigger
                .bind(to: r)
                .disposed(by: rx.disposeBag)
        } else if let r = relay as? PublishRelay<ARTableViewHeaderActionType> {
            // ARTableViewHeaderActionType 헤더 버튼 동작
            buttonActionTrigger
                .bind(to: r)
                .disposed(by: rx.disposeBag)
        } else if let r = relay as? PublishRelay<[IndexPath]> {
            // 삭제 동작
            deleteItemsTrigger
                .bind(to: r)
                .disposed(by: rx.disposeBag)
        }
        return self
    }
    //아 위에랑 분리한이유가있네
    func setupDI(playRelay: PublishRelay<RecentlyLikeList>) {
        playContentTrigger.bind(to: playRelay).disposed(by: rx.disposeBag)
    }

    // 삭제 결과 데이터
    func updateDeleteItem(observable: BehaviorRelay<String>) {
        observable
            .asObservable()
            .subscribe(onNext: updateResultCode)
            .disposed(by: rx.disposeBag)
    }

    // UI 데이터
    func updateView(action: PublishRelay<ARTableViewHeaderActionType>) {
        action
            .asObservable()
            .subscribe(onNext: updateRecentlyView)
            .disposed(by: rx.disposeBag)
    }
}

extension RecentlyView {
    // 하단 삭제 버튼 표시 유무
    func showDeleteButton(select indexPaths: [IndexPath]) {
        tableView.contentInset = (indexPaths.count > 0) ? UIEdgeInsets(top: 0, left: 0, bottom: 110, right: 0) : UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        bottomView.isHidden = (indexPaths.count > 0) ? false : true
        bottomDeleteButton.isHidden = bottomView.isHidden
        bottomDeleteButton.setTitle((indexPaths.count > 0) ? R.String.Activity.delete_count(indexPaths.count) : "", for: .normal)
    }

    // 삭제 팝업
//    func showAlert(indexPaths: [IndexPath]) {
//        RxAlert<Content_Text>().show(
//            AlertModel(content: Content_Text(message: R.String.Activity.alert_delete_count(indexPaths.count)).then {
//                $0.message.numberOfLines = 0
//            }, buttonText: [.cancel, .done], buttonCompletion: { actionResultModel in
//                if actionResultModel.result == .done {
//                    // 삭제 실행
//                    self.deleteItemsTrigger.accept(indexPaths)
//                } else {
//                    // 취소 dismiss
//                }
//            }
//        ))
//    }

    // 삭제 결과 Code 동작
    func updateResultCode(code: String) {
        let resultCode = ServerApiProvider.ResultCode(rawValue: code.lowercased()) ?? .ar_00000000
        if resultCode == .ar_20000000 {
            buttonActionTrigger.accept(.cancel)
            refreshControl.rx.refreshTrigger.onNext(())
            //Toast.show(R.String.Activity.toast_delete_success)
        }
    }

    // View 상태 업데이트
    func updateRecentlyView(status: ARTableViewHeaderActionType) {
        let tableHeaderView = topView
        switch status {
        case .delete:               // 삭제 모드
            tableView.reloadData()
            tableHeaderView.type = .checkAndButton
            tableHeaderView.checkButton.setTitle(R.String.selectAll, for: .normal)
            tableHeaderView.checkButton.setTitle(R.String.selectAll, for: .selected)
            tableView.allowsMultipleSelection = true
            tableView.refreshControl = nil
        case .check:                // 전체선택/해제 모드
            tableHeaderView.checkButton.isSelected.toggle()
            tableHeaderView.checkButton.isSelected ? tableView.selectRowAll(animated: false, scrollPosition: .none) : tableView.deSelectRowAll(animated: false)
            tableHeaderView.checkButton.isSelected ? showDeleteButton(select: tableView.indexPathsForSelectedRows!.sorted()) : showDeleteButton(select: [])
        case .cancel:               // 삭제 모드 취소
            tableView.reloadData()
            tableHeaderView.type = .rightOneButton
            tableHeaderView.checkButton.isSelected = false
            tableView.allowsMultipleSelection = false
            tableView.refreshControl = refreshControl
            showDeleteButton(select: [])
        default:
            break
        }
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
