//
//  MoreSeeViewModel.swift
//  UPlusAR
//
//  Created by baedy on 2020/03/06.
//  Copyright © 2020 최성욱. All rights reserved.
//

import RxCocoa
import RxFlow
import RxSwift
import UIKit

class MoreSeeViewModel: ViewModelType, Stepper {
    let disposeBag = DisposeBag()

    // MARK: Stepper
    var steps = PublishRelay<Step>()

    // MARK: ViewModelType Protocol
    typealias ViewModel = MoreSeeViewModel

    struct Input {
    }

    struct Output {
    }

    func transform(req: ViewModel.Input) -> ViewModel.Output {
//        let single1: Single<[FDPopup]> = FDClient.getData(.popups)
//        single1.subscribe(onSuccess: { data in
//            print(data)
//        }, onError: { err in
//            print(err)
//        }).disposed(by: disposeBag)
//
//        let single2: Single<[FDQuestions]> = FDClient.getData(.queries)
//        single2.subscribe(onSuccess: { data in
//            print(data)
//        }, onError: { err in
//            print(err)
//        }).disposed(by: disposeBag)
//
//        let single3: Single<[FDVersion]> = FDClient.getData(.versions)
//        single3.subscribe(onSuccess: { data in
//            print(data)
//        }, onError: { err in
//            print(err)
//        }).disposed(by: disposeBag)

//        let single4: Single<[FDNotices]> = FDClient.getData(.notices)
//        single4.subscribe(onSuccess: { data in
//            print(data)
//        }, onError: { err in
//            print(err)
//        }).disposed(by: disposeBag)

//        let single5: Single<[FDTerms]> = FDClient.getData(.terms)
//        single5.subscribe(onSuccess: { data in
//            print(data)
//        }, onError: { err in
//            print(err)
//        }).disposed(by: disposeBag)
//
//        let single6: Single<[FDPushs]> = FDClient.getData(.pushs)
//        single6.subscribe(onSuccess: { data in
//            print(data)
//        }, onError: { err in
//            print(err)
//        }).disposed(by: disposeBag)
//
//        let single7: Single<[FDEvent]> = FDClient.getData(.events)
//        single7.subscribe(onSuccess: { data in
//            print(data)
//        }, onError: { err in
//            print(err)
//        }).disposed(by: disposeBag)
//
//        let single8: Single<[FDFAQ]> = FDClient.getData(.faqs)
//        single8.subscribe(onSuccess: { data in
//            print(data)
//        }, onError: { err in
//            print(err)
//        }).disposed(by: disposeBag)

        return Output()
    }
}
