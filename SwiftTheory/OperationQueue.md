# Operation Queue
작업을 객체로 만든다

### 오퍼레이션 이점
오퍼레이션 사이에 의존성을 추가하여 실행 순서 제어  
실행취소(cancel) 기능을 구현하고, 컴플리션 핸들러(completion handler)를 추가하는데 필요한 API 사용 가능  
오퍼레이션 상태를 감시할 때는 KVO를 활용하거나 오퍼레이션 클래스가 제공하는 속성을 사용 가능  

### 오퍼레이션 특징
Single-Shot Object : 실행이 완료된 인스턴스를 다시 실행 못함  
반복 작업인 경우 매번 새로운 인스턴스 생성  
우선순위 설정이 가능  

### 오퍼레이션의 4가지 상태
Ready : 작업을 실행할 수 있는 상태  
Executing : 작업이 시작되어 실행중인 상태  
Finished : 정상 종료된 상태  
Cancelled : 작업을 취소한 상태   
 ( Finiched , Cancelled 에서 Ready로 돌아가기 불가능 )

### 오퍼레이션 동작 방식
API를 통해 실행  
기본적으로 동기 방식 실행  
오퍼레이션을 직접 실행하는 것 보다 오퍼레이션 큐에 추가하는것을 추천  
오퍼레이션 큐는 우선순위나 의존성에 따라 오퍼레이션을 최대한 빠르게 실행  
실행 완료된 오퍼레이션은 큐에서 제거  
시작되지 않은 작업은 언제든 취소 가능, 실행중인 작업은 취소 기능이 구현된 경우만 취소 가능  

### 오퍼레이션 우선순위
#### QueuePriority
동일한 큐에 추가되어 있는 오퍼레이션 사이의 우선순위  
veryHigh > high > normal > low > veryLow 가 있으며, 기본값은 normal  

#### QualityOfService (QoS)
리소스 사용 우선순위  
userInteractive > userInitiated > utility > background 가 있으며, 기본값은 background  
높을수록 CPU, 네트워크, 디스크 등을 빨리 점유하고 오래 사용가능  

### 오퍼레이션 사용 방법
~~~
// UI를 업데이트하는 오퍼레이션은 메인에 추가해야함
let mainQueue = OperationQueue.main

// 백그라운드 큐에서 작업을 실행하는 오퍼레이션 큐
let queue = OperationQueue()
~~~
오퍼레이션은 메모리 관리를 직접 처리해주지 않습니다. 그러므로 블록이나 커스텀 오퍼레이션에는 autoreleasepool 을 직접 추가해야 합니다
~~~
// 블록 형태로 바로 큐에 추가하는 방법
queue.addOperation {
    autoreleasepool {
        for _ in 1..<100 {
            print("🌸")
        }
    }
}

// 인스턴스를 생성하여 추가하는 방법
let op = BlockOperation {
    autoreleasepool {
        for _ in 1..<100 {
            print("🌼")
        }
    }
}
queue.addOperation(op)
~~~
하나의 오퍼레이션에 두 개 이상의 블록을 추가할 수 있습니다  
이렇게 추가한 블록은 나머지 블록과 동시에 실행됩니다. 아직 실행되지 않았거나 실행중인 블록에 새로운 블록을 추가하는 것은 문제가 전혀 없습니다. 그러나 실행이 완료된 경우에는 예외가 발생하므로 주의해야 합니다.
~~~
op.addExecutionBlock {
    autoreleasepool {
        for _ in 1..<100 {
            print("🌺")
        }
    }
}
~~~
커스텀 오퍼레이션 만들기
~~~
class CustomOperation: Operation {
    let flower: String

    init(flower: String) {
        self.flower = flower
    }

    // main에 실제로 실행할 작업을 구현합니다.
    override func main() {
        autoreleasepool {
            for _ in 1..<100 {
                // 취소 상태를 체크하여 작업을 취소
                guard !isCancelled else { return }
                print(flower)
            }
        }
    }
}

let op2 = CustomOperation(flower: "🌹")
queue.addOperation(op2)
~~~
커스텀 오퍼레이션에 취소 상태(isCancelled)를 계속 체크하여 취소될 경우 작업이 중지될 수 있도록 구현  
블록으로 큐에 추가하는 경우에는 isCancelled 속성에 접근할 수가 없기 때문에 상태를 체크할 수 있는 변수를 직접 정의하여 사용합니다.
~~~
var isCancelled = false

queue.addOperation {
    autoreleasepool {
        for _ in 1..<100 {
            guard !self.isCancelled else { return }
            print("🌸")
        }
    }
}

isCancelled = true
queue.cancelAllOperations()
~~~
컴플리션 핸들러도 추가할 수 있습니다.  
컴플리션 블록(completionBlock)은 오퍼레이션에 구현된 작업이 완료된 후에 호출되게 됩니다.
~~~
op.completionBlock = {
    print("Complete!")
}
~~~
