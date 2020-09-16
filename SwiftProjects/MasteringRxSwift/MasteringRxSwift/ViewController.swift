//
//  ViewController.swift
//  MasteringRxSwift
//
//  Created by 박영호 on 2020/09/15.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1
//        let disposeBag = DisposeBag()
//        Observable.just("Hello, RxSwift")
//            .subscribe{print($0)}
//            .disposed(by: disposeBag)
        
        
        // 2
        // 옵저버블 생성 #1
//        Observable<Int>.create { (observer) -> Disposable in
//            observer.on(.next(0))
//            observer.onNext(1)
//            observer.onCompleted()
//
//            return Disposables.create()
//        }
//
//        // 옵저버블 생성 #2
//        Observable.from([0, 1])
        
        
        // 3
//        let disposeBag = DisposeBag()
//        enum MyError: Error {
//            case error
//        }
//        let subject = PublishSubject<String>()
//        subject.onNext("Hello") // 서브젝트에서 Hello 발싸 하지만 구독자가 없어서 걍 묻힘..
//
//        let observer1 = subject.subscribe{print(">>1", $0)}
//        observer1.disposed(by: disposeBag)
//        subject.onNext("RxSwift") // observer1에서 받아서 출력해줌!
//
//        let observer2 = subject.subscribe{print(">>2", $0)}
//        observer2.disposed(by: disposeBag)
//        subject.onNext("subject") // observer1, observer2에서 받아서 출력해줌!
//
//        //subject.onCompleted() // 1, 2에서 컴플리트가 짜잔
//        subject.onError(MyError.error)
//
//        let observer3 = subject.subscribe{print(">>3", $0)}
//            // 컴플리트 이후 구독하는 애한테는 컴플리트 전달 짜잔
//            // 에러 이후 구독하는 애한테도 에러 짜잔
//        observer3.disposed(by: disposeBag)
//       // 구독한 이후에 발생한 이벤트만 옵저버에게 전달
//       // 구독 이전 것들을 살리고싶으면 리플레이 서브젝트나 콜드 옵저버블 사용
        
        
        //4
//        let disposeBag = DisposeBag()
//        let element = "Smile~"
//
//        Observable.just(element) // element를 방출하는 옵저버블 생성
//            .subscribe{event in print(event)} // 그걸 출력하는 옵저버로? 구독. 구독하면 옵저버블을 이벤트를 슝슝 그래서 출력함
//            .disposed(by: disposeBag)
//
//        Observable.just([1,2,3])
//            .subscribe{event in print(event)} // 마찬가지로 출력함. 배열 자체를 출력함 from이랑 혼동 ㄴㄴ
//            .disposed(by: disposeBag)
//
//        Observable.of("apple", "banana", "orange")
//            .subscribe{event in print(event)} // 마찬가지로 출력함. 여러개를 받고 차례로 방출
//            .disposed(by: disposeBag)
//
//        Observable.from(["123", "456", "789"])
//        .subscribe{event in print(event)} // 마찬가지로 출력함. 하나의 배열을 받고, 배열에 있는걸 차례로 방출
//        .disposed(by: disposeBag)
//
//        //아따 더럽게도 나눠놨네
        
        
        //5
        let disposeBag = DisposeBag()
        let numbers = [1,2,3,4,5,6,7,8,9,10]
        
        Observable.from(numbers) // 1~10까지 방출하는 옵저버블 완썽
            .filter{$0.isMultiple(of: 2)} // 하지만 여기서 홀수가 제거된 옵저버블이 되버림
            .subscribe{print($0)}
            .disposed(by: disposeBag)
        
        
        //6
        
    }
}

