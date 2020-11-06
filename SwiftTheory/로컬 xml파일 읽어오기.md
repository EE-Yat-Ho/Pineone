# 로컬 xml파일 읽어오기
하.. 삽질 오진다..
URL, Data, FileManager......
그냥 xcode에 xml파일 넣어주고,
if let path = Bundle.main.url(forResource: "strings_kr", withExtension: "xml") {
    if let parser = XMLParser(contentsOf: path) {
        parser.delegate = self
        parser.parse()
    }
}
이거하면 됨

~~~
//        let result = FileManager.changeCurrentDirectoryPath("/Users/bag-yeongho/Downloads/xml")
//        guard let koreaData = try? Data(contentsOf: URL(fileURLWithPath: "/Users/bag-yeongho/Downloads/xml/strings_kr.xml")) else {
//            print("koreaData is nil!")
//            return
//        }
//        guard let thailandData = fileManager.contents(atPath: "/Users/bag-yeongho/Downloads/xml/strings_th.xml") else {
//            print("thailandData is nil!")
//            return
//        }
//        let koreaURL = URL(fileURLWithPath: "/Users/bag-yeongho/Downloads/xml/strings_kr.xml")
            
//        guard let thailandURL = URLComponents(string: "/Users/bag-yeongho/Downloads/xml/strings_th.xml")?.url else {
//            print("thailandURL is nil!")
//            return
//        }
//        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
//            return
//        }
//        let koreaURL = dir.appendingPathComponent("strings_kr.xml")
//
////        let koreaParser = XMLParser(data: koreaData)
//        let koreaParser = XMLParser(contentsOf: koreaURL)
////        let thailandParser = XMLParser(data: thailandData)
//
//        koreaParser?.delegate = self
////        thailandParser.delegate = self
//
//        koreaParser?.parse()
        /// ㅋㅋㅋㅋ아나 진짜ㅏㅏㅏㅏㅏㅏㅏ
        if let path = Bundle.main.url(forResource: "strings_kr", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
~~~
