# defer

함수를 종료할 때 swift 내부적으로 가장 마지막에 수행하는 명령들이 담기는 블록이다. 즉, defer로 묶인 코드는 그 위치가 어디에 있든, 함수 가장 마지막에 실행된다.

함수 내부에서 파일을 열었을 때 등 사용하면 좋은 기능이다.

+

defer는 함수가 종료할 때 실행된다고 했는데 그럼 guard에 의해서 함수가 종료할때는 어떻게 될까?

~~~
func priority(index: Int) {
    guard index > 0 else {
        print("index is lower than zero.")
        return
    }

    print("function work fine :)")

    defer {
        print("I am defer code")
    }
}
~~~


위 함수를 호출해보면서 우선순위를 확인할 수 있다.
~~~
priority(index: 5)  // > function work fine :)    
                    // > I am defer code

priority(index: -5) // > index is lower than zero.
~~~

결과에서 알 수 있듯이 guard에 의해 함수가 종료되면 defer가 실행되지 않는다.

