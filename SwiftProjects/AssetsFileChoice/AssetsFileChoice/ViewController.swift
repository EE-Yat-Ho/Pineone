//
//  ViewController.swift
//  AssetsFileChoice
//
//  Created by 박영호 on 2020/11/05.
//

import UIKit

enum Languege: Int{
    case korea
    case thailand
}

class ViewController: UIViewController {
    // MARK:- Views
    let imageView = UIImageView()
    let koreaButton = UIButton()
    let thailandButton = UIButton()

    // MARK:- Method
    /// 언어, XML읽어온 딕셔너리, 라벨값까지 모두 세팅
    @objc func clickKoreaButton() {
        UserDefaults.standard.setValue(Languege.korea.rawValue, forKey: "Languege")
        setImageView(imageName: "고양이.jpg")
    }
    @objc func clickThailandButton() {
        UserDefaults.standard.setValue(Languege.thailand.rawValue, forKey: "Languege")
        setImageView(imageName: "고양이.jpg")
    }
    func setImageView(imageName: String) {
        var bundleName = ""
        switch Languege(rawValue: UserDefaults.standard.integer(forKey: "Languege")) {
        case .korea:
            bundleName = "korea.bundle/"
        case .thailand:
            bundleName = "thailand.bundle/"
        case .none:
            return
        }
        imageView.image = UIImage(named: bundleName+imageName)
    }
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupLayout()
        
        setImageView(imageName: "고양이.jpg")
    }

    func configure() {
        koreaButton.setTitle("한국어", for: .normal)
        thailandButton.setTitle("태국어", for: .normal)
        koreaButton.setTitleColor(.black, for: .normal)
        thailandButton.setTitleColor(.black, for: .normal)
        
        koreaButton.addTarget(self, action: #selector(clickKoreaButton), for: .touchUpInside)
        thailandButton.addTarget(self, action: #selector(clickThailandButton), for: .touchUpInside)
    }
    
    func setupLayout() {
        view.addSubview(imageView)
        view.addSubview(koreaButton)
        view.addSubview(thailandButton)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        koreaButton.translatesAutoresizingMaskIntoConstraints = false
        thailandButton.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.contentMode = .scaleAspectFit
        
        koreaButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30).isActive = true
        koreaButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -30).isActive = true
        koreaButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        thailandButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30).isActive = true
        thailandButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -30).isActive = true
        thailandButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
}

