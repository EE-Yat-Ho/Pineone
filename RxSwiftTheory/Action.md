# Action

 - 사용법 분석
 - var name = Action<A, B>(workFactory: Closure)
  1. A = Closure의 입력값 타입
  2. B = Closure의 리턴Observable의 타입
  3. workFactory = 이벤트 수신시 실행할 Closure
  4. name.inputs = 이벤트를 수신하는 옵저버
  5. name.execute(a:A) = Closure 단순 실행 방법
  6. name..elements = 이벤트 수신 후, 클로저가 리턴하는 값들을 이렇게 관찰할 수 있음
