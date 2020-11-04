# CString 처리
하.. 삽질 오진다..
%d나 %s의 영어는 가능한데,
한글로 가니까 자꾸 꺠짐.. 결국 어쩔수없이 %s는 %@로. 즉, Swift스트링 처리로 바꿈
~~~
//label4.text = String(format: Resource.shared.koreaDictionary["setting_app_version"] ?? "", arguments: ["abc"])
//        var a: [CChar] = []
//        "abc".getCString(&a, maxLength: 10, encoding: .utf8)
//        label4.text = String(format: "%s", arguments: [a])

//        label4.text = String(format: "%s", arguments: "abc".cString(using: .utf8) ?? 0])
//        label4.text = String(format: "%s", arguments: [CChar("abc")] as! [[CChar]])
//label5.text = String(format: "AAA%@BBB", "abc".cString(using: .utf8) as! CVarArg)
//label5.text = String(format: "AAA%sBBB", "abc".utf8CString as! CVarArg)
//        label4.text = String(format: Resource.shared.koreaDictionary["setting_app_version"]?.replacingOccurrences(of: "%s", with: "%@") ?? "", "abc")
//        label5.text = Resource.shared.koreaDictionary["agreement_private_info"]
label4.text = String(format: Resource.shared.koreaDictionary["search_result"] ?? "Error %d", 777)
label5.text = String(format: Resource.shared.koreaDictionary["search_result_null"] ?? "Error %s", "한글abc")
//label5.text = "a한b글c".withCString(encodedAs: UTF16.self){
 //   String(format: Resource.shared.koreaDictionary["search_result_null"] ?? "Error %s", $0)
//            String(format: "\'%1$S\'에 대한 검색 결과가 없습니다.\n다른 검색어를 입력해보세요.", $0)
//}
label6.text = Resource.shared.koreaDictionary["qlone_tutorial_need_mat"]
~~~
