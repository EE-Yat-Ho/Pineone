//
//  MainViewController.swift
//  FondationProj
//
//  Created by baedy on 2020/05/06.
//  Copyright (c) 2020 baedy. All rights reserved.
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
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupLayout()
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
    
    // MARK: - Binding
    func stateBind(){
        viewModel.stateBind(state: ViewModel.State(viewLife: self.viewState))
    }
    
    func bindingViewModel() {
        // transform은 VM의 Input(Observable<Screen>) -> Output(Observable<[Screen]>)
        // VM안에 있는 Input구조체의 멤버와이즈 생성자 이용
        // modelSelected(Screen.self).asObservable() 로
        // Input안에는 Observable<Screen>이 설정됨
        
        // subView의 테이블을 선택할 때, Screen인스턴스를 발생시키는 옵저버블을 가지고 있는 VM의 Input을
        // transform에 넘겨주고, 그 옵저버블과, step을 안에서 바인드함. 
        // res : 화면들과 엮인 Observable<[Screen]>를 가진 Output 인스턴스
        let res = viewModel.transform(req: ViewModel.Input(selectItem: subView.table.rx.modelSelected(Screen.self).asObservable()))
        
        // 의존성 주입..?
        // 흠 바인드한 결과랑 상관은 없어보이는데 여튼 모든 액션들을 받은
        // 화면들과 엮인 Observable<[Screen]>를 가지고
        subView.setupDI(observable: res.itemList)
        
        print("binding complete")
    }
    
    // MARK: - View
    let subView = MainView()
    
    func setupLayout() {
        self.view.addSubview(subView)
        subView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
}
