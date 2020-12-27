# 폰트 일부분 NSMutableAttributedString
~~~
/// 전체폰트 + 부분폰트 지정
let bigNumFont = UIFont.boldSystemFont(ofSize: 20)
let normalFont = UIFont(name: "NotoSansKannada-Regular", size: 17)

let attributedStr = NSMutableAttributedString(string: question.text)
attributedStr.addAttribute(.font,
                           value: normalFont,
                           range: (question.text! as NSString).range(of: question.text))
attributedStr.addAttribute(.font,
                           value: bigNumFont,
                           range: (question.text! as NSString).range(of: "\(index + 1)."))
question.attributedText = attributedStr
~~~
무슨 원하는 텍스트 찾는거를 인덱싱도 아니고 텍스트 그 자체로 찾고앉아있네

그리고 기본 폰트도 겁나 작아서 모든 텍스트에 폰트 적용해줘야하는데
그와중에 1. 앞에서 굵게해버리면 뒤에 1은 인식이 안되니
전체를 조금 굵게한 이후에 1.을 따버리니까 되네 굳

