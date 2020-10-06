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

class MainViewController: UIBaseViewController, ViewModelProtocol {
    typealias ViewModel = MainViewModel
    // MARK: - ViewModelProtocol
    var viewModel: ViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 탭바 상단 위치, 폰트 조절
        let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        UITabBarItem.appearance().titlePositionAdjustment.vertical = -8.5
        
        setupLayout() // 레이아웃
        bindingViewModel()
        stateBind()
        addNotification()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.orientationChange(_:)), name: Notification.Name("CMOrientationChange"), object: nil)
    }
    
    @objc func orientationChange(_ noti: Notification){
        guard let orient = noti.userInfo?["UIDeviceOrientation"] as? UIDeviceOrientation else {
            return
        }
        
        print("orientaion : \(orient.rawValue)")
    }
    
    func stateBind() {
        viewModel.stateBind(state: ViewModel.State(viewLife: self.viewState))
    }
    
    func bindingViewModel(){
        //화면 전환용
        let res = viewModel.transform(req: ViewModel.Input(selectItem: subView.table.rx.modelSelected(Screen.self).asObservable()))
        subView.setupDI(observable: res.itemList)
        
        
        
        print("binding complete")
    }
    
    let subView = MainView()
    
    func setupLayout() {
        self.view.addSubview(subView)
        subView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}

