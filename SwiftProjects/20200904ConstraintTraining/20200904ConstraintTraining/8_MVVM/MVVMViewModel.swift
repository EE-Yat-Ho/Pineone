//
//  RxSwifViewModel.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/10/06.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxFlow
import SnapKit
import Then
import NSObject_Rx

// 갖가지 유저 입력들을 액션타입으로 한번에 들고오기 위한 enum 선언
enum Action {
    case tapPlusButton
    case tapCompleteButton
    case questionImagePickerSelect(UIImage)
    case explanationImagePickerSelect(UIImage)
    case questionTextChange(String)
    case explanationTextChange(String)
    case answerTextChange(String, Int)
    case tapXButton(Int)
    case tapCameraButton(String)
}



class MVVMViewModel: ViewModelType { //주석달기 이 소스가 이런 역할을 한다
    
    // MARK: - Properties
    // 테이블과 콜렉션을 위한 릴레이들.
    // 이전 데이터가 필요한가 싶어서 Publish로 바꿨었는데,
    // 테이블이랑 콜렉션은 얘내들이 가지고 있는 데이터를 가지고 리로드하는 경우가 있어서 Behavior로 해야함
    let answerRelay = BehaviorRelay<[String]>(value: [])
    let questionImageRelay = BehaviorRelay<[UIImage]>(value: [])
    let explanationImageRelay = BehaviorRelay<[UIImage]>(value: [])

    // 카메라 액션에 대해 어떤 이미지피커를 띄울지 정하는데,
    // 그 결과를 넘겨주기위한 서브젝트들.
    // 그저 관찰 당하기만해서 옵저버블로 바꿔봤는데, 옵저ㅂ
    let questionCameraObb = PublishSubject<Void>()
    let explanationCameraObb = PublishSubject<Void>()

    let disposeBag = DisposeBag()

    // "저장"과 "삭제시 업데이트"의 용이성을 위해 현재 TextField들, 셀들의 정보를 가지고있어야함.
    var nowSceneData = DataForScene()
    
    // MARK: - Action
    // Plus버튼을 누를시,
    func tapPlusButton(){
        nowSceneData.answerList.append("")
        answerRelay.accept(nowSceneData.answerList)
    }
    
    func tapXButton(_ index: Int) {
        print("tapXButton, index : \(index)")
        if index < nowSceneData.answerList.count {
            nowSceneData.answerList.remove(at: index)
            answerRelay.accept(nowSceneData.answerList)
        }
    }
    
    func tapCompleteButton(){
        print("complete")
        MainRepository.shared.dataForScene = nowSceneData
    }
    
    func tapCameraButton(_ kind: String){
        switch kind {
        case "question":
            questionCameraObb.onNext(())
        case "explanation":
            explanationCameraObb.onNext(())
        default:
            print("cameraButton Kind Error!!")
        }
    }
    
    func questionImagePickerSelected(_ img: UIImage){
        nowSceneData.questionImageList.append(img)
        questionImageRelay.accept(nowSceneData.questionImageList)
    }
    
    func explanationImagePickerSelected(_ img: UIImage){
        nowSceneData.explanationImageList.append(img)
        explanationImageRelay.accept(nowSceneData.explanationImageList)
    }
    
    /// "저장"과 "셀 삭제시 업데이트"의 용이성을 위해 매 입력마다 현재 데이터를 저장함
    func questionTextChange(_ text: String){
        nowSceneData.question = text
    }
    func explanationTextChange(_ text: String){
        nowSceneData.explanation = text
    }
    func answerTextChange(_ text: String, _ index: Int){
        print("answerTextChange, index : \(index), text : \(text)")
        if index < nowSceneData.answerList.count {
            nowSceneData.answerList[index] = text
        }
    }
    
    
    
    // MARK: - ViewModelType Protocol
    typealias ViewModel = MVVMViewModel
    
    struct Input { // 한번 그리면서, 바인드를 쫘아악?
        let action: Observable<Action>
    }
    
    struct Output {
        let answerList: Observable<[String]>
        let questionImageList: Observable<[UIImage]>
        let explanationImageList: Observable<[UIImage]>
        let questionCameraObb: Observable<Void>
        let explanationCameraObb: Observable<Void>
    }
    
    func transform(req: ViewModel.Input) -> ViewModel.Output {
        req.action.subscribe(onNext: { [weak self] action in
            self?.actionProcess(action: action)
        }).disposed(by: disposeBag)
        
        loadData()
        
        return Output(answerList: answerRelay.asObservable(),
                      questionImageList: questionImageRelay.asObservable(),
                      explanationImageList: explanationImageRelay.asObservable(),
                      questionCameraObb: questionCameraObb.asObservable(),
                      explanationCameraObb: explanationCameraObb.asObservable())
    }
    
    func actionProcess(action: Action) {
        switch action {
        case .tapPlusButton:
            self.tapPlusButton()
        case .tapCompleteButton:
            self.tapCompleteButton()
        case .questionImagePickerSelect(let img):
            self.questionImagePickerSelected(img)
        case .explanationImagePickerSelect(let img):
            self.explanationImagePickerSelected(img)
        case .questionTextChange(let text):
            self.questionTextChange(text) // 알트누르고 설명 나오는거. 함수의 역할, 파라미터, 결과값 뭐 이런거까지는 아니더라도 함수의 역할은 꼭 쓰자
        case .explanationTextChange(let text):
            self.explanationTextChange(text)
        case .answerTextChange(let text, let index):
            self.answerTextChange(text, index)
        case .tapXButton(let index):
            self.tapXButton(index)
        case .tapCameraButton(let kind):
            self.tapCameraButton(kind)
        }
    }
    
    // MARK: - Load Data
    func loadData() {
        nowSceneData = MainRepository.shared.dataForScene
        answerRelay.accept(nowSceneData.answerList)
        questionImageRelay.accept(nowSceneData.questionImageList)
        explanationImageRelay.accept(nowSceneData.explanationImageList)
    }
    deinit {
        print("VM deinit")
    }
}
