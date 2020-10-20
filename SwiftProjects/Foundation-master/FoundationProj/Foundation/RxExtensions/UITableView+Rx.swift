//
//  UITableView+Rx.swift
//  UPlusAR
//
//  Created by baedy on 2020/03/31.
//  Copyright © 2020 최성욱. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: UITableView {
    var reloaded: Observable<()> {
        let reloadData = sentMessage(#selector(base.reloadData))
        return Observable.create { observer in
            let reloadDataDisposable = reloadData.subscribe(onNext: { _ in
                DispatchQueue.main.async {
                    observer.on(.next(()))
                }
            })
            return Disposables.create([reloadDataDisposable])
        }
    }

    var multiSelectionObserable: Observable<Bool> {
        return self.observe(Bool.self, "allowsMultipleSelection").compactMap { $0 }
    }

    var allowMultipleSelection: RxCocoa.Binder<Bool> {
        return Binder(self.base) { _, selection in
            self.base.allowsMultipleSelection = selection
        }
    }

    var selectRows: Observable<[IndexPath]> {
        return delegate.methodInvoked(#selector(UITableViewDelegate.tableView(_:didSelectRowAt:)))
            .map { _ in
                guard let items = self.base.indexPathsForSelectedRows else {
                    return []
                }
                return items
            }
    }

    var deSelectRows: Observable<[IndexPath]> {
        return delegate.methodInvoked(#selector(UITableViewDelegate.tableView(_:didDeselectRowAt:)))
            .map { _ in
                guard let items = self.base.indexPathsForSelectedRows else {
                    return []
                }
                return items
            }
    }

    var selectedRows: Observable<[IndexPath]> {
        let selected = delegate.methodInvoked(#selector(UITableViewDelegate.tableView(_:didSelectRowAt:)))
        let deSelected = delegate.methodInvoked(#selector(UITableViewDelegate.tableView(_:didDeselectRowAt:)))

        return Observable.of(selected, deSelected).merge().map { _ in
            guard let items = self.base.indexPathsForSelectedRows else {
                return []
            }
            return items.sorted()
        }
    }

    var isAllSelectedItems: Observable<Bool> {
        base.rx.selectedRows.map {
            let result = $0.count == self.base.numberOfRows(inSection: 0)
            return result
        }
    }
}

extension UITableView {
    @objc func selectRowAll(animated: Bool, scrollPosition: ScrollPosition) {
        (0 ..< self.numberOfSections).forEach { section in
            (0 ..< self.numberOfRows(inSection: section)).forEach { item in
                self.selectRow(at: IndexPath(item: item, section: section), animated: animated, scrollPosition: scrollPosition)
            }
        }
    }

    @objc func deSelectRowAll(animated: Bool) {
        (0..<self.numberOfSections).forEach { section in
            (0..<self.numberOfRows(inSection: section)).forEach { item in
                self.deselectRow(at: IndexPath(item: item, section: section), animated: animated)
            }
        }
    }
}
