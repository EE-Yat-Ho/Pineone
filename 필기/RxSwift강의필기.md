## 1. Hello RxSwift
? 뭐지 내가 만든 프로젝트에선 안됨
? 걍 안되는데 머냐
뭐고 RxBlocking 이랑 RxTest 까니까 코딩 안해도 실행시 터지네
흠. https://github.com/ReactiveX/RxSwift 보니까 블로킹이랑 테스트는 아에 다른 프로젝트인듯

두개 빼고 진행 ㄱ

## 2. Observables and  Observers #1
옵저버블은 옵저버에게 이벤트를 전달
옵저버는 옵저버블을 구독

이벤트는 
Next( = Emission )
Error : 옵저버블 비정상 종료 ( = Notification )
Completed : 옵저버블 정상 종료 ( = Notification )

Marble Diagram : 옵저버블과 연산자의 동작을 시각적으로 표현한 그림
-ㅇ-ㅇ--ㅇ---|-> 이런거
 ㅇ : 넥스트, 전달하는 아이템들
 | : complete
 X : error

마블 다이어그램 GUI로 다양한 시도를 해볼수있는 어플이 깃허브에 있음 RxMarbleDiagram

옵저버블을 생성하는 방법 2가지 : create로 옵저버블의 동작을 직접 구현, from으로 미리정의된 규칙에 따라 이벤트를 전달
create : 옵저버블 프로타입 프로토콜에 선언되어있는 타입메소드 . RxSwift에선 이런걸 연산자라고 부름
하나의 클로저를 파라미터로 받음
from : 배열에 들어있는 애를 순차대로 방출해하고 종료

옵저버블은 이벤트가 어떤 순으로 전달될지 정해둔 것 뿐 실제로 전달되지않음
옵저버가 옵저버블을 구독하는 시점에 이벤트가 전달됨
즉 구독하면 create로 만든 클로저가 실행되거나 from문이 실행됨

## 3. Publish Subject
Publish Subject : 서브젝트로 전달되는 이벤트를 옵저버에게 전달하는 가장 기본적인 서브젝트다..ㅠㅜ
서브젝트는 옵저버블인 동시에 옵저버다
옵저버블로 부터 이벤트를 받을 수 있고, 옵저버에게 이벤트를 전달 할 수 있다
구독한 이후에 발생한 이벤트만 옵저버에게 전달
구독 이전 것들을 살리고싶으면 리플레이 서브젝트나 콜드 옵저버블 사용

## 4. just, of, from
just : 옵저버블 타입 프로토콜의 타입 메소드
하나의 요소를 받아서 그 요소를 방출하는 옵저버블을 리턴함.

of : 옵저버블 타입 프로토콜의 타입 메소드
가변 파라미터로 방출할 요소를 원하는 만큼 받고 그 요소들을 차레로 방출하는 옵저버블을 리턴

from : 마찬가지
파라미터로 배열을 받고, 배열의 요소들을 하나씩 차례로 방출

뭐이리 더럽게 나눠놨누;

## 5. filter Operator
옵저버블이 방출하는 요소를 필터링하쟈
필터는 클로저(predicate)를 파라미터로 받고,
predicate에서 트루를 리턴하는 요소가 리턴되는 옵저버블에 포함됨.


## 6. Flat Map
원본 옵저버블이 항목을 방출하면 FlatMap 연산자가 변환 함수를 실행함
변환 함수는 방출된 항목을 옵저버블로 변환함

원본 옵저버블이 빨간 동그라미를 방출하면
Flat Map이 빨간 다이아를 방출하는 옵저버블로 변환함

원본 옵저버블의 값이 업데이트되면 자동으로 Flat Map은 새로운 값으로 된 옵저버블을 방출함

흠.. 개별 옵저버블 3개를 (동그라미 3개)
개별 옵저버블 3개로 변환 (다이아 3개)
그리고 3개를 합쳐서 하나의 옵저버블로 변환한다함.. 어려뜨아

ㅡㅡㅡㅡ브레이크 삐이이이익
목요일에 스위프트 시험친다고 하심;; ㄸㄸㄸㄸㄸㄷ 아는식으로 다 쓰시오 ㅋㅋㅋㅋㅋ젤어ㅕㄹ운 방식 ㅁㅊ

