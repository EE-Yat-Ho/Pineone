//
//  MenuSortView.swift
//  UPlusAR
//
//  Created by 송석호 on 2020/06/25.
//  Copyright © 2020 최성욱. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ActionSheetView: UIView {
    let action = PublishRelay<String>()
}

class MenuSortView: ActionSheetView, UITableViewDelegate {
    let stackView = UIStackView.default(axis: .vertical).then {
        $0.backgroundColor = .clear
        $0.distribution = .fillProportionally
    }
    // 336
    let tableView = UITableView(frame: .zero, style: .plain).then {
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.estimatedRowHeight = 48
        $0.bounces = false
        $0.isScrollEnabled = false
        $0.rowHeight = UITableView.automaticDimension
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(MenuSortListCell.self, forCellReuseIdentifier: MenuSortListCell.reuseIdentifier())
    }

    let disposeBag = DisposeBag()

    init(_ menu: [String]) {
        super.init(frame: .zero)
        setupLayout(menu.count)
        bindView(menu)
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout(_ count: Int) {
        backgroundColor = .white

        self.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(count * 60)
        }
    }

    func bindView(_ menu: [String]) {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        Observable.of(menu).bind(to: tableView.rx.items) { tableView, indexPath, element in
            if let cell = tableView.dequeueReusableCell(withIdentifier: MenuSortListCell.reuseIdentifier()) as? MenuSortListCell {
                cell.title.text = element
                cell.selectionStyle = .none
                cell.divider.isHidden = indexPath == (menu.count - 1) ? true : false
                return cell
            }
            return UITableViewCell()
        }.disposed(by: disposeBag)

        tableView.rx.modelSelected(String.self).map { $0 }.bind(to: action).disposed(by: disposeBag)
    }
}

class MenuSortListCell: UITableViewCell {
    var title = UILabel().then {
        $0.textColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.font = .notoSans(.regular, size: 19)
    }

    var bg = UIView().then {
        $0.backgroundColor = .white
    }
    var divider = UIView().then {
        $0.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.15)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func layoutView() {
        addSubviews([bg, title, divider])

        bg.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(60)
        }
        title.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        divider.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bg.snp.bottom)
            $0.height.equalTo(1)
        }
    }
}

extension Reactive where Base: ActionSheetView {
    var didSelect: Observable<String> {
        return base.action.asObservable()
    }
}
