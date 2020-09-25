//
//  UIImagePickerController+RxCreate.swift
//  RxExample
//
//  Created by Krunoslav Zaher on 1/10/16.
//  Copyright © 2016 Krunoslav Zaher. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa

// 이 소스 하나 넣으면 이미지 피커를 Rx로 사용할 수 있음
// 이걸 통해서 원하는 델리게이트를 Rx로 바꿀 수 있을거같음 ㅇㅇ 프레임화 완료

// 이미지 피커는 델리게이트 이거 두개를 씀
public typealias RxImagePickerDelegate = UIImagePickerControllerDelegate & UINavigationControllerDelegate

// Rx에서 지원하는 델리게이트 프록시를 사용하기 위한 프레임들. 아직 이해는 못했지만 이케하면 되넹
// https://eunjin3786.tistory.com/28 여기 참고함.
class UIImagePickerControllerDelegateProxy: DelegateProxy<UIImagePickerController, RxImagePickerDelegate>, DelegateProxyType, RxImagePickerDelegate {
    static func registerKnownImplementations() {
        self.register { (imagePickerController)->UIImagePickerControllerDelegateProxy in
            UIImagePickerControllerDelegateProxy(parentObject: imagePickerController, delegateProxy: self)
        }
    }
    
    static func currentDelegate(for object: UIImagePickerController) -> RxImagePickerDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: RxImagePickerDelegate?, to object: UIImagePickerController) {
        object.delegate = delegate
    }
}

// 이제 Rx로 바꾸고 싶은 메소드를 여기서 입맛대로 다룰수있음.
extension Reactive where Base: UIImagePickerController {
    // 얘는 Rx에서 지원하는 프레임이고
    var delegate_ : DelegateProxy<UIImagePickerController, RxImagePickerDelegate> {
        return UIImagePickerControllerDelegateProxy.proxy(for: self.base)
    }
    
    // 여기부터 내가 원하는 구현부들임
    // 이미지 피커가 받아오는 이미지는 didFinishPickingMediaWithInfo 얘를 통해 가져옴.
    // 우리가 원하는 값 즉, didFinishPickingMediaWithInfo를 리턴해주는 옵저버블을 선언하는거임!
    // 원하는 값을 뱉어내는 메소드를 메소드를 방출하는 옵저버블로 바꿔버리고,(즉 메소드를 옵저버블로 감싸는 느낌이네 ㅇㅈ 감사합니다 배동연선임님 ^^7)
    // 그 옵저버블을 통해 원하는 값을 뽑아냄. 무려 파라미터를 뽑아낼수가있음! 와 대박!
    var didFinishPickingMediaWithInfo : Observable<[UIImagePickerController.InfoKey : Any]> {
        return
            delegate_ // 위에서 선언한놈이고 잘몰러
            .methodInvoked(#selector(RxImagePickerDelegate // 내가 원하는 메소드를 넣으면 그 메소드를 방출하는 옵저버블로 리턴해주는 착한녀석
            .imagePickerController(_:didFinishPickingMediaWithInfo:))) // 그래서 넣어주고, 옵저버블을 뽑음.
            .map{ (paramaters) in // 메소드를 방출하는 옵저버블을, 파라미터를 방출하는 옵저버블로 바꿀수가있지! ㅁㅊ 개사기;
                return paramaters[1] as! [UIImagePickerController.InfoKey : Any]
            } //그렇게 최종 완성된 옵저버블을 리턴해주면서 Rx완성 뭐 자세한건 아직 모르겠누..
    }
}

