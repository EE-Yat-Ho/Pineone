# Observable과 Subject의 차이

Observable -unicast-> Observer

Subject ㅡmulticast-> Observer
             ㅏmulticast-> Observer
             ㄴ-multicast-> Observer
             
ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

옵저버블 : 그저 하나의 함수임. 어떤 상태도 없음. 
때문에 모든 새로운 Observer에 대해 create 코드를 반복실행. 버그와 비효율의 원인.
하나의 옵저버에대한 간단한 옵저버블이 필요할때 사용할 것.
~~~
// --- Observable ---
    let randomNumGenerator1 = Observable<Int>.create{ observer in
        observer.onNext(Int.random(in: 0 ..< 100))
        return Disposables.create()
    }
    
    randomNumGenerator1.subscribe(onNext: { (element) in
        print("observer 1 : \(element)")
    })
    randomNumGenerator1.subscribe(onNext: { (element) in
        print("observer 2 : \(element)")
    })
    
    --------------------print------------------
// 랜덤값을 이밋하는 시퀀스를 2개 생성
observer 1 : 54
observer 2 : 69
~~~

  
서브젝트 : Observer의 세부 정보를 저장하고, 한번의 실행으로 모든 관찰자에게 결과를 제공.
자주 데이터를 저장 및 수정할 때,
여러 옵저버가 관찰할 때,
옵저버와 옵저버블 사이의 프록시 역할을 할 때 사용할 것.
~~~
// ------ BehaviorSubject/ Subject
  let randomNumGenerator2 = BehaviorSubject(value: 0)
  randomNumGenerator2.onNext(Int.random(in: 0..<100))
  
  randomNumGenerator2.subscribe(onNext: { (element) in
      print("observer subject 1 : \(element)")
  })
  randomNumGenerator2.subscribe(onNext: { (element) in
      print("observer subject 2 : \(element)")
  })

  --------------------print------------------
// 랜덤값을 이밋하는 시퀀스 1개로 옵저버 두개를 처리
observer subject 1 : 92
observer subject 2 : 92
~~~
