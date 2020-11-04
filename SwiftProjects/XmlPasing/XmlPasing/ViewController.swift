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

enum Languege {
    case korea
    case thailand
}

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

    // MARK:- Prometers
    var dictionaryKey = Keys.trash
    var nowParserLanguege: Languege = Languege.korea
    
    @objc func clickKoreaButton() {
        /// \n처리 확인
        label1.text = Resource.shared.getKoreaValue(key: .content_basic_info)
        
        /// 제일 앞쪽 공백 처리 확인, \n 처리 확인
        label2.text = Resource.shared.getKoreaValue(key: .buffering_info)

        /// <![CDATA[나 <font color... 처리 확인
        label3.text = Resource.shared.getKoreaValue(key: .qlone_tutorial_need_mat)

        /// %d 처리 확인
        label4.text = Resource.shared.getKoreaValue(key: .search_result, arguments: 777)

//        /// %1$s, \'  처리 확인
        label5.text = Resource.shared.getKoreaValue(key: .search_result_null, arguments: "가aป")

//        /// %s 두개 처리 확인
        label6.text = Resource.shared.getKoreaValue(key: .setting_update_agreement, arguments: "가aป",  "나bว")
    }

    @objc func clickThailandButton() {
        label1.text = Resource.shared.getThailandValue(key: .content_basic_info)
        label2.text = Resource.shared.getThailandValue(key: .buffering_info)
        label3.text = Resource.shared.getThailandValue(key: .qlone_tutorial_need_mat)
        label4.text = Resource.shared.getThailandValue(key: .search_result, arguments: 777)
        label5.text = Resource.shared.getThailandValue(key: .search_result_null, arguments: "가aป")
        label6.text = Resource.shared.getThailandValue(key: .setting_update_agreement, arguments: "가aป",  "나bว")
    }
    
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setDictionary()
        setupLayout()
    }
    
    func setDictionary(){
        /// 한국어 xml 파싱
        nowParserLanguege = .korea
        if let path = Bundle.main.url(forResource: "strings_kr", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
        /// 태국어  xml 파싱
        nowParserLanguege = .thailand
        if let path = Bundle.main.url(forResource: "strings_th", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
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

extension ViewController: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        /// 딕셔너리 키가 쓰레기인 경우는 무시할 것임.
        dictionaryKey = Keys(rawValue: attributeDict["name"] ?? "trash") ?? .trash
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        /// 딕셔너리 키가 쓰레기인 경우는 무시
        if dictionaryKey == .trash { return }
        
        /// 이미 xml파일에 \처리가 되어있는데 parser에서 또 추가하기때문에 제거해주기 ( 역슬래시 2개를 1개로 바꾸는 시도를 했지만.. 실패.. )
        var string = string.replacingOccurrences(of: "\\n", with: "\n")
        string = string.replacingOccurrences(of: "\\'", with: "\'")
        
        /// C스트링 처리포맷을 Swift스트링 포맷으로 바꾸는 작업 ( C스트링 포맷은 한글이 자꾸 깨짐.. )
        string = string.replacingOccurrences(of: "%s", with: "%@")
        string = string.replacingOccurrences(of: "%1$s", with: "%1$@")
        
        /// CDATA 내부 태그 처리
        string = string.replacingOccurrences(of: "<br>", with: "\n")
        
        /// 현재 언어가 한국어, 태국어인지 따라 딕셔너리 분류
        switch nowParserLanguege {
        case .korea:
            /// 문자열을 읽는데 한번에 읽지않고 끊어 읽는 경우가 있기 때문에, 이어붙히는 작업을 해줘야함.
            if let targetValue = Resource.shared.koreaDictionary[dictionaryKey] { /// 이미 있는 경우 : 이어붙히기
                Resource.shared.koreaDictionary[dictionaryKey] = targetValue + string
            } else { /// 처음 넣는 경우 : 그냥 넣기
                Resource.shared.koreaDictionary[dictionaryKey] = string
            }
        case .thailand:
            if let targetValue = Resource.shared.thailandDictionary[dictionaryKey] { /// 이미 있는 경우 : 이어붙히기
                Resource.shared.thailandDictionary[dictionaryKey] = targetValue + string
            } else { /// 처음 넣는 경우 : 그냥 넣기
                Resource.shared.thailandDictionary[dictionaryKey] = string
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        /// 태그가 닫힌 후, 완성된 문자열의 시작과 끝부분의 공백, 탭, 줄바꿈 없애기
        switch nowParserLanguege {
        case .korea:
            Resource.shared.koreaDictionary[dictionaryKey] = Resource.shared.koreaDictionary[dictionaryKey]?.trimmingCharacters(in: .whitespacesAndNewlines)
        case .thailand:
            Resource.shared.thailandDictionary[dictionaryKey] = Resource.shared.thailandDictionary[dictionaryKey]?.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        /// 태그가 닫힌 후, 읽히는 문자열은 무시하기 위한 처리
        dictionaryKey = .trash
    }
}


