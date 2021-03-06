//
//  DownloadView.swift
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

class DownloadView: UIBasePreviewTypeForSampling {
    // MARK: - Model type implemente
    typealias Model = Void

    var downloadList = BehaviorRelay<[RealmMyDownloadFile]>(value: [])
    let showDetailTrigger = PublishRelay<RealmMyDownloadFile>()
    let playContentTrigger = PublishRelay<RealmMyDownloadFile>()
    let buttonActionTrigger = PublishRelay<ARTableViewHeaderActionType>()
    let deleteItemsTrigger = PublishRelay<[IndexPath]>()
    let sortItemsTrigger = PublishRelay<DownloadSortingType>()

    // MARK: - init
    override init(naviType: ARNavigationShowType = .none) {
        super.init(naviType: naviType)
        print("DownloadView")
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - View

    // 해더뷰
    lazy var topView = ARTableViewHeaderView(type: .dropdownAndButton).then {
        $0.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 56)
        $0.dropdownButton.setTitle(R.String.Activity.sort_download_title, for: .normal)
        $0.dropdownButton.setTitle(R.String.Activity.sort_download_title, for: [.normal, .highlighted])
        $0.dropdownButton.setTitle(R.String.Activity.sort_allSize_title, for: .selected)
        $0.dropdownButton.setTitle(R.String.Activity.sort_allSize_title, for: [.selected, .highlighted])
        $0.headerViewAction.bind(to: buttonActionTrigger).disposed(by: rx.disposeBag)
    }

    // 다운로드 TableView
    lazy var tableView = UITableView().then {
        $0.rx.setDelegate(self).disposed(by: rx.disposeBag)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = #colorLiteral(red: 0.114654012, green: 0.1092678383, blue: 0.1311254203, alpha: 1)
        $0.estimatedRowHeight = 92
        $0.separatorStyle = .none
        $0.rowHeight = 92
        $0.backgroundView = ARTableViewEmptyView(type: .download)
        //$0.tableHeaderView = topView
        $0.register(DownloadTableViewCell.self, forCellReuseIdentifier: DownloadTableViewCell.reuseIdentifier())
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
        $0.rx.tap
            .throttle(.seconds(1), latest: false, scheduler: MainScheduler.instance)
            .map { _ -> [IndexPath] in return self.tableView.indexPathsForSelectedRows!.sorted() }.subscribe(onNext: showAlert).disposed(by: rx.disposeBag)
    }

    // MARK: - Methods
    func setupLayout() {
        backgroundColor = #colorLiteral(red: 0.114654012, green: 0.1092678383, blue: 0.1311254203, alpha: 1)
        bottomView.addSubviews([bottomDeleteButton])
        addSubviews([topView, tableView, bottomView], needTopMoveButton: true)

        topView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
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

        tableView.refreshControl = refreshControl

        tableView.rx.contentOffset.map({[weak self]  position -> Bool in
            guard let `self` = self else { return true }
            if position.y > self.tableView.frame.height {
                return false
            }
            return true
        }).bind(to: topMoveButton.rx.isHidden).disposed(by: rx.disposeBag)

        topMoveButton.rx.tap.on(next: {[weak self] _ in
            guard let `self` = self else { return }
            self.tableView.setContentOffset(CGPoint(x: 0, y: -(self.realSafeAreaInsetTop - 56)), animated: true)
        }).disposed(by: rx.disposeBag)
    }

    // 다운로드 데이터
    func setupDI(observable: BehaviorRelay<[RealmMyDownloadFile]>) {
        observable.asObservable().bind(to: downloadList).disposed(by: rx.disposeBag)
        // model Dependency Injection
        observable.asObservable().bind(to: tableView.rx.items(cellIdentifier: DownloadTableViewCell.reuseIdentifier(), cellType: DownloadTableViewCell.self)) { [weak self] _, element, cell in
            guard let `self` = self else { return }
            cell.isDeleteMode = ((self.topView).type == .checkAndButton) ? true : false
//            cell.isDeleteMode = ((self.tableView.tableHeaderView as! ARTableViewHeaderView).type == .checkAndButton) ? true : false
            cell.item = element
            cell.playButton
                .rx
                .tap
                .subscribe(onNext: { _ in
                    self.playContentTrigger.accept(element)
                })
                .disposed(by: cell.disposeBag)
        }.disposed(by: rx.disposeBag)

        // Table Header View 숨김 유무
        observable
            .asObservable()
            .map { $0.count == 0 }
            .bind(to: topView.rx.isHidden)
            .disposed(by: rx.disposeBag)

        observable.asObservable()
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

        // TableView Reloading
        tableView
            .rx
            .reloaded
            .filter { _ in self.tableView.allowsMultipleSelection == false }
            .subscribe(onNext: refreshControl.endRefresh)
            .disposed(by: rx.disposeBag)

        // TableView Select Cell(delete mode)
        tableView
            .rx
            .selectedRows
            .filter { _ in self.tableView.allowsMultipleSelection == true }
            .subscribe(onNext: showDeleteButton)
            .disposed(by: rx.disposeBag)

        // TableView Select Cell(not delete mode)
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] index in
            self?.tableView.deselectRow(at: index, animated: false)
        }).disposed(by: rx.disposeBag)

        tableView
            .rx
            .modelSelected(RealmMyDownloadFile.self)
            .filter { _ in self.tableView.allowsMultipleSelection == false }
            .bind(to: showDetailTrigger)
            .disposed(by: rx.disposeBag)

        // HeaderView Check Button Select
//        tableView
//            .rx
//            .isAllSelectedItems
//            .bind(to: (self.tableView.tableHeaderView as! ARTableViewHeaderView).checkButton.rx.isSelected)
//            .disposed(by: rx.disposeBag)
        tableView
            .rx
            .isAllSelectedItems
            .bind(to: self.topView.checkButton.rx.isSelected)
            .disposed(by: rx.disposeBag)
    }

    // 삭제 결과 데이터
    func updateDeleteItem(observable: Observable<Void>) {
        observable
            .asObservable()
            .subscribe(onNext: updateResultCode)
            .disposed(by: rx.disposeBag)
    }

    // UI 데이터
    func updateView(action: PublishRelay<ARTableViewHeaderActionType>) {
        action
            .asObservable()
            .on(next: updateRecentlyView)
            .disposed(by: rx.disposeBag)
    }

    func initializePlayButton(noti: Notification) {
        if let taskInfo = noti.object as? DownloadTaskInfo {
            if let index = self.downloadList.value.firstIndex(where: { $0.key == String(taskInfo.contentKey) }) {
                let indexPath = IndexPath(row: index, section: 0)
                if let cell = tableView.cellForRow(at: indexPath) as? DownloadTableViewCell {
//                    cell.playButton.setImage(#imageLiteral(resourceName: "ic_view_s"), for: .normal)
//                    cell.playButton.setTitle("", for: .normal)
                    //cell.playButton.isHidden = true
                    cell.playButton.isEnabled = true
                    cell.animatiomContainerView.isHidden = true
                }
            }
        }
    }

        func cancelPlayButton(noti: Notification) {
            if let taskInfo = noti.object as? DownloadTaskInfo {
                if let index = self.downloadList.value.firstIndex(where: { $0.key == String(taskInfo.contentKey) }) {
                    let indexPath = IndexPath(row: index, section: 0)
                    if let cell = tableView.cellForRow(at: indexPath) as? DownloadTableViewCell {
    //                    cell.playButton.setImage(#imageLiteral(resourceName: "ic_view_s"), for: .normal)
    //                    cell.playButton.setTitle("", for: .normal)
                        //cell.playButton.isHidden = true
                        cell.playButton.isEnabled = false
                        cell.animatiomContainerView.isHidden = true
                    }
                }
            }
        }

    func reloadPlayButton(noti: Notification) {
        if let taskInfo = noti.object as? DownloadTaskInfo {
            if let index = self.downloadList.value.firstIndex(where: { $0.key == String(taskInfo.contentKey) }) {
                let indexPath = IndexPath(row: index, section: 0)
                if let cell = tableView.cellForRow(at: indexPath) as? DownloadTableViewCell {
                    //cell.playButton.isHidden = false
                    //cell.playButton.setImage( #imageLiteral(resourceName: "btnPlayOval02Dim"), for: .normal)
                    //cell.playButton.setTitle("다운로드중", for: .normal)
                    cell.playButton.isEnabled = false
                    cell.progressAnimationView.isHidden = false
                    cell.currentProgress = taskInfo.progress
                }
            }
        }
    }

    func setupDI(relay: PublishRelay<Notification>) {
//        relay.observeOn(MainScheduler.asyncInstance).filter { noti in
//            noti.name == .DownloadManagerUpdateProgress
//        }.subscribe(onNext: reloadPlayButton).disposed(by: rx.disposeBag)
//
//        relay.observeOn(MainScheduler.asyncInstance).filter { noti in
//            noti.name == .DownloadManagerDidFinish
//        }.subscribe(onNext: initializePlayButton).disposed(by: rx.disposeBag)
//
//        relay.observeOn(MainScheduler.asyncInstance).filter { noti in
//            noti.name == .DownloadManagerDidCancel
//        }.subscribe(onNext: cancelPlayButton).disposed(by: rx.disposeBag)
//
//        relay.observeOn(MainScheduler.asyncInstance).filter { noti in
//            noti.name == .DownloadManagerDidStart// || noti.name == .DownloadManagerDidCancel
//        }.subscribe(onNext: { [weak self] _ in
//            guard let `self` = self else { return }
//            //self.sortButton.isSelected ? self.sortItemsTrigger.accept(.size) : self.sortItemsTrigger.accept(.download)
//            self.refreshControl.rx.refreshTrigger.onNext(())
//        }).disposed(by: rx.disposeBag)
    }

    func setupDI(sortType: PublishRelay<DownloadSortingType>) {
        sortType
            .map { $0 == .size }
            .bind(to: topView.dropdownButton.rx.isSelected)
            .disposed(by: rx.disposeBag)
    }
}

extension DownloadView {
    // 하단 삭제 버튼 표시 유무
    func showDeleteButton(select indexPaths: [IndexPath]) {
        tableView.contentInset = (indexPaths.count > 0) ? UIEdgeInsets(top: 0, left: 0, bottom: 110, right: 0) : UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        bottomView.isHidden = (indexPaths.count > 0) ? false : true
        bottomDeleteButton.isHidden = bottomView.isHidden
        bottomDeleteButton.setTitle((indexPaths.count > 0) ? R.String.Activity.delete_count(indexPaths.count) : "", for: .normal)
    }

    // 삭제 팝업
    func showAlert(indexPaths: [IndexPath]) {
        RxAlert<Content_Text>().show(
            AlertModel(content: Content_Text(message: R.String.Activity.alert_delete_count(indexPaths.count)).then {
                $0.message.numberOfLines = 0
            }, buttonText: [.cancel, .done], buttonCompletion: { actionResultModel in
                if actionResultModel.result == .done {
                    // 삭제 실행
                    self.deleteItemsTrigger.accept(indexPaths)
                } else {
                    // 취소 dismiss
                }
            }
        ))
    }

    // 삭제 결과 Code 동작
    func updateResultCode() {
        buttonActionTrigger.accept(.cancel)
        refreshControl.rx.refreshTrigger.onNext(())
        //Toast.show(R.String.Activity.toast_delete_success)
    }

    // View 상태 업데이트
    func updateRecentlyView(status: ARTableViewHeaderActionType) {
        let tableHeaderView = topView
//        let tableHeaderView = tableView.tableHeaderView as! ARTableViewHeaderView
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
            tableHeaderView.type = .dropdownAndButton
            tableHeaderView.checkButton.isSelected = false
            tableView.allowsMultipleSelection = false
            tableView.refreshControl = refreshControl
            showDeleteButton(select: [])
        case .dropdown:
            showCustomAlertViewController()
        default:
            break
        }
    }

    // ActionSheet 표시
    func showCustomAlertViewController() {
        let tableHeaderView = topView
//        let tableHeaderView = tableView.tableHeaderView as! ARTableViewHeaderView
        let view = MenuSortView([R.String.Activity.sort_download_title, R.String.Activity.sort_allSize_title])
        ARActionSheet()
            .addView(view: view)
            .show { [weak self] in
                guard let `self` = self else { return }
                switch $0 {
                case .text(let text):
                    if text == R.String.Activity.sort_download_title {
                        self.sortItemsTrigger.accept(.download)
                        tableHeaderView.dropdownButton.isSelected = false
                        self.tableView.reloadData()
                    } else {
                        self.sortItemsTrigger.accept(.size)
                        tableHeaderView.dropdownButton.isSelected = true
                        self.tableView.reloadData()
                    }
                    break
                default:
                    break
                }
            }
    }
}

extension DownloadView: UITableViewDelegate {
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
struct Download_Previews: PreviewProvider {
    static var previews: some View {
        //        Group {
        //            ForEach(UIView.previceSupportDevices, id: \.self) { deviceName in
        //                DebugPreviewView {
        //                    return DownloadView()
        //                }.previewDevice(PreviewDevice(rawValue: deviceName))
        //                    .previewDisplayName(deviceName)
        //                    .previewLayout(.sizeThatFits)
        //            }
        //        }
        Group {
            DebugPreviewView {
                let view = DownloadView()
                //                .then {
                //                    $0.setupDI(observable: Observable.just([]))
                //                }
                return view
            }
        }
    }
}
#endif
