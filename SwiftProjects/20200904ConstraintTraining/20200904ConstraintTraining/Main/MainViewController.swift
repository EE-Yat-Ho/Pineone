//
//  ViewController.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/09/04.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
import SnapKit
import Then

class MainViewController: UIViewController, ViewModelProtocol {
    typealias ViewModel = MainViewModel
    
    // MARK: - ViewModelProtocol
    var viewModel = ViewModel()
    
    // MARK: - Parameters
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 탭바 상단 위치, 폰트 조절
        let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        UITabBarItem.appearance().titlePositionAdjustment.vertical = -8.5
        
        setupLayout() // 레이아웃
        bindingViewModel()
    }
    
    func bindingViewModel(){
        // 테이블 바인딩
        viewModel.mainRelay.bind(to: subView.table.rx.items(cellIdentifier: "MainCell", cellType: MainCell.self)) {
            index, data, cell in
            cell.label.text = data.getTitle()
        }.disposed(by: disposeBag)
        
        // 테이블 셀 선택 바인딩
        subView.table.rx.modelSelected(Screen.self).subscribe(onNext: {
            screen in
            let qusetionTabBarConstroller = QuestionTabBarController()
            qusetionTabBarConstroller.screen = screen
            self.navigationController?.pushViewController(qusetionTabBarConstroller, animated: true)
        }).disposed(by: disposeBag)
        
        // VM 호출해서 테이블에 값 뿌리기
        viewModel.transform(req: MainViewModel.ViewModel.Input())
    }
    
    let subView = MainView()
    
    func setupLayout() {
        self.view.addSubview(subView)
        subView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        
    }
}

