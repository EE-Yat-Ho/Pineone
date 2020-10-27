# Deeplink

https://help.adbrix.io/hc/ko/articles/360039757433-%EB%94%A5%EB%A7%81%ED%81%AC-Deeplink-URI%EC%8A%A4%ED%82%B4-%EC%9C%A0%EB%8B%88%EB%B2%84%EC%85%9C-%EB%A7%81%ED%81%AC-%EC%95%B1%EB%A7%81%ED%81%AC-%EA%B5%AC%EB%B6%84%EA%B3%BC-%EC%9D%B4%ED%95%B4

간략하게 정리. 왠만하면 링크 타고 보는걸 추천.

인터넷에서 https:// 이런거랑 비슷한게 모바일에서는 딥링크임.

가장 처음 나온 방식은 URI 스킴 방식.
앱에 자신만의 URI scheme값을 등록하고, 이 값을 이용해서 어떤 앱을 실행하는지 구분.
예를들어 트위터 앱은 twitter:// 라는 스킴값.
그리고 스킴값 뒤에는 path값을 붙혀서 앱 내의 페이지를 구분함.
트위터의 회원가입 페이지는 twitter://signup.
Scheme://Path 로 이루어저있다 ㅇㅇ

iOS프로젝트 설정값에서 무슨 앱의 고유한값? 설정하는게 이거였음ㅇㅇㅇㅇ
Info - URL Types - URL Schemes 에 있넹

하지만 이 방식은 앱의 스킴값들이 중복되면서 한계를 맞이함..
특정 앱을 오픈할때, 어떤 앱으로 오픈할지 선택하는거 나오는거 그게 중복되서그런거임..

이 한계를 극복하기 위해 나온게
안드로이드는 앱링크
iOS는 유니버셜링크

인터넷에서 하던거처럼 고유한 주소 해시값?같은게 있고, 거기에 도메인을 씌움
http://naver.com 을 입력하면, 네이버 앱이 오픈되는 식.

Signing & Capabilities - Associated Domains 에서 설정할 수 있데.

근데 이건 아직 불완전하답니당.
구글에서 만든 안드로이드 앱, 애플에서 만든 iOS 앱만 잘 작동한다카네..
물론 2020 5월 포스팅 이긴함.
