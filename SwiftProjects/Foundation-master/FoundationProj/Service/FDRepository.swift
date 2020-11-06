////
////  FDRpository.swift
////  UPlusAR
////
////  Created by baedy on 2020/03/26.
////  Copyright © 2020 최성욱. All rights reserved.
////
//
//import FirebaseFirestore
//import FirebaseFirestoreSwift
//import RxSwift
//import UIKit
//
//protocol FDRepositoryType {
//    func loadEvents(_ name: String?) -> Single<[FDEvent]>
//    func getMoreSeeDetailList(type: MoreSeeDetail) -> Single<[MoreSeeCellModel]>
//    func getTerm(type: TermType) -> Single<[FDTerms]>
//    func getPrivacy() -> Single<[FDTerms]>
//    func eventsImages() -> Single<[FDEventImage]>
//    func getVersion() -> Single<[FDVersion]>
//}
//
//struct FDRepository: FDRepositoryType {
//    func getVersion() -> Single<[FDVersion]> {
//        FDClient.getData(.versions)
//    }
//
//    func loadEvents(_ documentId: String? = nil) -> Single<[FDEvent]> {
//        FDClient.getData(.events, documentID: documentId)
//    }
//
//    func getMoreSeeDetailList(type: MoreSeeDetail) -> Single<[MoreSeeCellModel]> {
//        switch type {
//        case .etc:
//            var result = MoreSeeList.etcList
//
//            if !AuthManager.current.isGuest { // 로그인 되어 있는 경우에만 휴대폰 번호 인증 타이틀을 없엠.
//                result.remove(at: 10)
//            }
//            if !AuthManager.current.isUserAdult() { // 성인이 아닌경우 19금 콘텐츠 숨김, 잠금, 비밀번호변경등 19금 관련 내용 제공하지 않음
//                result.remove(at: 3)
//                result.remove(at: 2)
//                result.remove(at: 1)
//            } else {
//                // 비밀번호 설정이 되어 있으면 "비밀번호 변경" 표시
//                if ContentLockManager.current.isSettingPassword() {
//                    if let block = ContentLockManager.current.currentBlockState, block == true { // 19금 콘텐츠 숨김이 되어있으면 "19금 콘텐츠 잠금"은 제거
//                        result.remove(at: 3)
//                    }
//                } else { // 비밀번호 설정이 되어 있지 않으면 "비밀번호 변경" 제거
//                    result.remove(at: 1)
//                }
//            }
//            if AuthManager.current.isGuest || (!AuthManager.current.isUplusMember) { // 로그인 되어 있지 않는 경우엔 닉네임 변경을 제거.
//                result.remove(at: 0)
//            }
//            return Single.just(result)
//        case .question:
//            return Single.just(MoreSeeList.directQuestionList)
//        default:
//            return Single.just([])
//        }
//    }
//
//    func getTerm(type: TermType) -> Single<[FDTerms]> {
//        let data: Single<[FDTerms]> = FDClient.getData(.terms)
//        let correctType = data.map {
//            $0.filter {
//                $0.type == type
//            }
//        }
//
//        let nilCheck = correctType.map {
//            $0.filter {
//                $0.createdAt != nil
//            }
//        }
//
//        let sorted = nilCheck.map {
//            $0.sorted(by: {
//                $0.createdAt!.compare($1.createdAt!) == .orderedAscending//.orderedDescending
//                })
//        }
//
//        return sorted
//
////        return Single<[FDTerms]>.create{ single in
////            let observable = sorted.subscribe(onSuccess: {
////                if let first = $0.first{
////                    single(.success(first))
////                }else{
////                    single(.error(FDRepository.Error.notfound))
////                }
////            }, onError: {
////                single(.error($0))
////            })
////
////            return Disposables.create {
////                observable.dispose()
////            }
////        }
//
//    }
//
//    func getPrivacy() -> Single<[FDTerms]> {
//        let data: Single<[FDTerms]> = FDClient.getData(.privacyPolicy)
//
//        return data.map {
//            $0.map {
//               $0.setType(type: .privacyPolicy)
//            }
//        }
//    }
//
//    func eventsImages() -> Single<[FDEventImage]> {
//        let data: Single<[FDEventImage]> = FDClient.getData(.eventImages)
//        return data
//    }
//
//    func addQuestion(data: FDQuestions) {
//        FDClient.addQuestion(.questions, data: data)
//    }
//}
//
//extension FDRepository {
//    enum Error: Swift.Error {
//        case notfound
//    }
//}
