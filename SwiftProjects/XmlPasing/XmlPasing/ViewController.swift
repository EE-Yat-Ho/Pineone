//
//  ViewController.swift
//  XmlPasing
//
//  Created by 박영호 on 2020/11/04.
//

import UIKit
//클래스로 싱글톤 리소스를 만들고,
//그거가지고 맨처음 실행될때 그 프리퍼런스를 접근하고
//해당 데이터들의 딕셔너리 형태로 구성이된 다음
//그걸 바로 쓸수있게 하는게 깔끔

//함수가 키값만 넘겨야함 키값이랑 스트링 배열들로 배열로 하기힘들면 ...쓰면 하나씩 뺴올수있음 있으면 뺴오고 없으면 말고하는ㅂ 아법
//xml파일이랑 리소스 파일만 있으면 함수 호출해서 쫙 할수있도록 ㅇㅋㅇㅋ
//enum은 뭐지 왜지 왜있지

//Resource에 파서 딜리게이트 넣고
//값 받는 함수는 하나로. UserDefault로 구분.
//앱 껏다 켰을때 알아서 뿌려지게 ㅇㅋ

//<font> 무시가 아니라 그냥 없애고
//Resource파일에 summary 달기

class ViewController: UIViewController {
    
    // MARK:- Views
    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    let label4 = UILabel()
    let label5 = UILabel()
    let label6 = UILabel()
    let koreaButton = UIButton()
    let thailandButton = UIButton()

    // MARK:- Method
    /// 언어, XML읽어온 딕셔너리, 라벨값까지 모두 세팅
    @objc func clickKoreaButton() {
        UserDefaults.standard.setValue(Languege.korea.rawValue, forKey: "Languege")
        Resource.shared.setResourceDictionary()
        setLabelText()
    }
    @objc func clickThailandButton() {
        UserDefaults.standard.setValue(Languege.thailand.rawValue, forKey: "Languege")
        Resource.shared.setResourceDictionary()
        setLabelText()
    }
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupLayout()
        
        /// 처음 켰을때도 UserDefault로 딕셔너리 세팅
        Resource.shared.setResourceDictionary()
        setLabelText()
    }
    
    func setLabelText() {
        /// \n처리 확인
        label1.text = Resource.shared.getTextFromKey(key: .dialog_play_next_setting_change)
        /// 제일 앞쪽 공백 처리 확인, \n 처리 확인
        label2.text = Resource.shared.getTextFromKey(key: .buffering_info)
        /// <![CDATA[]>, <font>, <br> 처리 확인
        label3.text = Resource.shared.getTextFromKey(key: .qlone_tutorial_need_mat)
        /// %d 처리 확인
        label4.text = Resource.shared.getTextFromKey(key: .search_result, arguments: 777)
        /// %1$s, \'  처리 확인
        label5.text = Resource.shared.getTextFromKey(key: .search_result_null, arguments: "가aป")
        /// %s 두개 처리 확인
        label6.text = Resource.shared.getTextFromKey(key: .setting_update_agreement, arguments: "나bง",  "다cข้")
    }
    
    func configure() {
        label1.setOptions()
        label2.setOptions()
        label3.setOptions()
        label4.setOptions()
        label5.setOptions()
        label6.setOptions()
        
        koreaButton.setTitle("한국어", for: .normal)
        thailandButton.setTitle("태국어", for: .normal)
        koreaButton.setTitleColor(.black, for: .normal)
        thailandButton.setTitleColor(.black, for: .normal)
        
        koreaButton.addTarget(self, action: #selector(clickKoreaButton), for: .touchUpInside)
        thailandButton.addTarget(self, action: #selector(clickThailandButton), for: .touchUpInside)
    }
    
    func setupLayout() {
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        view.addSubview(label6)
        view.addSubview(koreaButton)
        view.addSubview(thailandButton)
        
        koreaButton.translatesAutoresizingMaskIntoConstraints = false
        thailandButton.translatesAutoresizingMaskIntoConstraints = false
        
        label1.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10).isActive = true
        label1.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10).isActive = true
        label1.topAnchor.constraint(equalTo: view.topAnchor,constant: 20).isActive = true
        
        label2.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10).isActive = true
        label2.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10).isActive = true
        label2.topAnchor.constraint(equalTo: label1.bottomAnchor,constant: 20).isActive = true
        
        label3.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10).isActive = true
        label3.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10).isActive = true
        label3.topAnchor.constraint(equalTo: label2.bottomAnchor,constant: 20).isActive = true
        
        label4.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10).isActive = true
        label4.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10).isActive = true
        label4.topAnchor.constraint(equalTo: label3.bottomAnchor,constant: 20).isActive = true
        
        label5.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10).isActive = true
        label5.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10).isActive = true
        label5.topAnchor.constraint(equalTo: label4.bottomAnchor,constant: 20).isActive = true
        
        label6.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10).isActive = true
        label6.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10).isActive = true
        label6.topAnchor.constraint(equalTo: label5.bottomAnchor,constant: 20).isActive = true
        
        koreaButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30).isActive = true
        koreaButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -30).isActive = true
        koreaButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        thailandButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30).isActive = true
        thailandButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -30).isActive = true
        thailandButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
}




